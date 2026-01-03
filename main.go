package main

import (
	// "database/sql"
	// "kenmec/peripheral/jimmy/infra"
	// "log"
	"database/sql"
	"kenmec/peripheral/jimmy/db"
	_ "kenmec/peripheral/jimmy/initial"
	"kenmec/peripheral/jimmy/peripheral"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func main() {

	dsn := "root:kenmec123@tcp(127.0.0.1:3306)/test_p2?parseTime=true"
	conn, err := sql.Open("mysql", dsn)

	if err != nil {
		log.Fatal("資料庫連線失敗:", err)
	}

	queries := db.New(conn)

	// eb := infra.New()

	peripheral.NewStackManager(queries)

	// m.PrintDebug()
	select {}
}
