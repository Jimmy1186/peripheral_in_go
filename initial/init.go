package initial

import (
	"github.com/redis/go-redis/v9"
)

var Rdb *redis.Client

func init() {
	// 1. 初始化 Redis 客戶端
	Rdb = redis.NewClient(&redis.Options{
		Addr:     "localhost:6379", // Redis 伺服器位址
		Password: "",               // 如果沒有設定密碼就留空
		DB:       0,                // 使用預設的 DB 0
	})

}
