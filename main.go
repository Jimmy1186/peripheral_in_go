package main

import (
	// "database/sql"
	// "kenmec/peripheral/jimmy/infra"
	// "log"
	_ "kenmec/peripheral/jimmy/initial"
	"kenmec/peripheral/jimmy/peripheral"

	_ "github.com/go-sql-driver/mysql"
)

func main() {

	// dsn := "root:kenmec123@tcp(127.0.0.1:3306)/corning?parseTime=true"
	// conn, err := sql.Open("mysql", dsn)

	// if err != nil {
	// 	log.Fatal("資料庫連線失敗:", err)
	// }

	// eb := infra.New()

	testLocationId := []string{"1", "2"}

	peripheral.NewStackManager(testLocationId)

	select {}
}
