# 定義變數
DB_DSN="root:kenmec123@tcp(127.0.0.1:3306)/kenmec"
MIG_DIR=migrations

.PHONY: up down status

up:
	goose mysql $(DB_DSN) -dir $(MIG_DIR) up

down:
	goose mysql $(DB_DSN) -dir $(MIG_DIR) down

status:
	goose mysql $(DB_DSN) -dir $(MIG_DIR) status