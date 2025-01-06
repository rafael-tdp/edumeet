package utils

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/go-redis/redis/v8"
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

func GetValidationCodeFromRedis(key string) (string, error) {
	key = fmt.Sprintf("%s:validation", key)
	val, err := rdb.Get(ctx, key).Result()
	if err == redis.Nil {
		return "null", nil
	} else if err != nil {
		return "", err
	}
	return val, nil
}

func StoreValidationCodeInRedis(key string, value string, expiration ...int) error {
	exp := 60
	if len(expiration) > 0 {
		exp = expiration[0]
	}
	key = fmt.Sprintf("%s:validation", key)
	err := rdb.Set(ctx, key, value, time.Duration(exp)*time.Minute).Err()
	if err != nil {
		return err
	}
	return nil
}

func DeleteValidationCodeFromRedis(key string) error {
	key = fmt.Sprintf("%s:validation", key)
	err := rdb.Del(ctx, key).Err()
	if err != nil {
		return err
	}
	return nil
}

func GetTokenFromRedis(key string) (string, error) {
	key = fmt.Sprintf("%s:token", key)
	val, err := rdb.Get(ctx, key).Result()
	if err == redis.Nil {
		return "null", nil
	} else if err != nil {
		return "", err
	}
	return val, nil
}

func StoreTokenInRedis(key string, value string, expiration ...int) error {
	exp := 60
	if len(expiration) > 0 {
		exp = expiration[0]
	}
	key = fmt.Sprintf("%s:token", key)
	err := rdb.Set(ctx, key, value, time.Duration(exp)*time.Minute).Err()
	if err != nil {
		return err
	}
	return nil
}

func DeleteTokenFromRedis(key string) error {
	key = fmt.Sprintf("%s:token", key)
	err := rdb.Del(ctx, key).Err()
	if err != nil {
		return err
	}
	return nil
}
