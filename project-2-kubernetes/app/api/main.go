package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/redis/go-redis/v9"
)

var ctx = context.Background()

type Job struct {
	ID   string `json:"id"`
	Task string `json:"task"`
}

func main() {
	redisAddr := getEnv("REDIS_ADDR", "localhost:6379")

	rdb := redis.NewClient(&redis.Options{
		Addr: redisAddr,
	})

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("API running"))
	})

	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("ok"))
	})

	http.HandleFunc("/jobs", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodPost {
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

			w.WriteHeader(http.StatusAccepted)
			w.Write([]byte("job queued"))
			return
		}

		w.Write([]byte("use POST to create job"))
	})

	log.Println("API listening on :8080")
	http.ListenAndServe(":8080", nil)
}

func getEnv(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}