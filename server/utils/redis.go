package utils

import (
	"context"
	"fmt"
	"github.com/go-redis/redis/v8"
	"log"
	"os"
	"time"
)

var ctx = context.Background()
var rdb *redis.Client

func InitRedis() {
	redisHost := os.Getenv("REDIS_HOST")
	redisPort := os.Getenv("REDIS_PORT")
	redisUsername := os.Getenv("REDIS_USER")
	redisPassword := os.Getenv("REDIS_PASSWORD")

	rdb = redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:%s", redisHost, redisPort),
		Username: redisUsername,
		Password: redisPassword,
		DB:       0,
	})

	_, err := rdb.Ping(ctx).Result()
	if err != nil {
		log.Fatalf("Erreur de connexion à Redis : %v", err)
	}
	log.Println("Connexion à Redis réussie")
}

func GetValidationCodeFromRedis(key string) string {
	key = fmt.Sprintf("%s:validation", key)
	val, err := rdb.Get(ctx, key).Result()
	if err == redis.Nil {
		return "null"
	} else if err != nil {
		panic(err)
	}
	return val
}

func StoreValidationCodeInRedis(key string, value string, expiration ...int) {
	exp := 60
	if len(expiration) > 0 {
		exp = expiration[0]
	}
	key = fmt.Sprintf("%s:validation", key)
	err := rdb.Set(ctx, key, value, time.Duration(exp)*time.Minute).Err()
	if err != nil {
		panic(err)
	}
}

func DeleteValidationCodeFromRedis(key string) {
	key = fmt.Sprintf("%s:validation", key)
	err := rdb.Del(ctx, key).Err()
	if err != nil {
		panic(err)
	}
}

func GetTokenFromRedis(key string) string {
	key = fmt.Sprintf("%s:token", key)
	val, err := rdb.Get(ctx, key).Result()
	if err == redis.Nil {
		return "null"
	} else if err != nil {
		panic(err)
	}
	return val
}

func StoreTokenInRedis(key string, value string, expiration ...int) {
	exp := 60
	if len(expiration) > 0 {
		exp = expiration[0]
	}
	key = fmt.Sprintf("%s:token", key)
	err := rdb.Set(ctx, key, value, time.Duration(exp)*time.Minute).Err()
	if err != nil {
		panic(err)
	}
}

func DeleteTokenFromRedis(key string) {
	key = fmt.Sprintf("%s:token", key)
	err := rdb.Del(ctx, key).Err()
	if err != nil {
		panic(err)
	}
}
