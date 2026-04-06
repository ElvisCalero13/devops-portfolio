package main

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/redis/go-redis/v9"
)

var ctx = context.Background()

func main() {
	redisAddr := getEnv("REDIS_ADDR", "localhost:6379")

	rdb := redis.NewClient(&redis.Options{
		Addr: redisAddr,
	})

	log.Println("Worker started...")

	for {
		result, err := rdb.BRPop(ctx, 0*time.Second, "jobs").Result()
		if err != nil {
			log.Println("error reading queue:", err)
			continue
		}

		job := result[1]
		log.Println("Processing job:", job)

		time.Sleep(2 * time.Second)

		log.Println("Job done")
	}
}

func getEnv(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}