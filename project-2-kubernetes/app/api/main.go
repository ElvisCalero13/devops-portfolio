package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/redis/go-redis/v9"
)

var ctx = context.Background()

type Job struct {
	ID   string `json:"id"`
	Task string `json:"task"`
}

var (
	httpRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "project2_http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"method", "path", "status"},
	)

	httpRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "project2_http_request_duration_seconds",
			Help:    "HTTP request duration in seconds",
			Buckets: prometheus.DefBuckets,
		},
		[]string{"method", "path"},
	)

	jobsQueuedTotal = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "project2_jobs_queued_total",
			Help: "Total number of queued jobs",
		},
	)
)

func init() {
	prometheus.MustRegister(httpRequestsTotal)
	prometheus.MustRegister(httpRequestDuration)
	prometheus.MustRegister(jobsQueuedTotal)
}

func main() {
	redisAddr := getEnv("REDIS_ADDR", "localhost:6379")

	rdb := redis.NewClient(&redis.Options{
		Addr: redisAddr,
	})

	mux := http.NewServeMux()

	mux.HandleFunc("/", instrumentHandler("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" {
			http.NotFound(w, r)
			return
		}

		w.WriteHeader(http.StatusOK)
		w.Write([]byte("API running"))
	}))

	mux.HandleFunc("/health", instrumentHandler("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("ok"))
	}))

	mux.HandleFunc("/jobs", instrumentHandler("/jobs", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusOK)
			w.Write([]byte("use POST to create job"))
			return
		}

		var job Job
		if err := json.NewDecoder(r.Body).Decode(&job); err != nil {
			http.Error(w, "invalid request body", http.StatusBadRequest)
			return
		}

		data, err := json.Marshal(job)
		if err != nil {
			http.Error(w, "failed to serialize job", http.StatusInternalServerError)
			return
		}

		if err := rdb.LPush(ctx, "jobs", data).Err(); err != nil {
			http.Error(w, "failed to enqueue job", http.StatusInternalServerError)
			return
		}

		jobsQueuedTotal.Inc()
		w.WriteHeader(http.StatusAccepted)
		w.Write([]byte("job queued"))
	}))

	mux.Handle("/metrics", promhttp.Handler())

	log.Println("API listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", mux))
}

func instrumentHandler(path string, handler http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		rw := &statusRecorder{
			ResponseWriter: w,
			statusCode:     http.StatusOK,
		}

		handler(rw, r)

		duration := time.Since(start).Seconds()

		httpRequestsTotal.WithLabelValues(
			r.Method,
			path,
			http.StatusText(rw.statusCode),
		).Inc()

		httpRequestDuration.WithLabelValues(
			r.Method,
			path,
		).Observe(duration)
	}
}

type statusRecorder struct {
	http.ResponseWriter
	statusCode int
}

func (rw *statusRecorder) WriteHeader(code int) {
	rw.statusCode = code
	rw.ResponseWriter.WriteHeader(code)
}

func getEnv(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}
