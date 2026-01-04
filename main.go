package main

import (
	// "database/sql"
	// "kenmec/peripheral/jimmy/infra"
	// "log"

	"context"
	"database/sql"
	"kenmec/peripheral/jimmy/db"
	_ "kenmec/peripheral/jimmy/initial"
	"kenmec/peripheral/jimmy/peripheral"
	stackpb "kenmec/peripheral/jimmy/proto"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {

	dsn := "root:kenmec123@tcp(127.0.0.1:3306)/test_p2?parseTime=true"
	dbconn, err := sql.Open("mysql", dsn)

	if err != nil {
		log.Fatal("資料庫連線失敗:", err)
	}

	queries := db.New(dbconn)

	// eb := infra.New()

	psm := peripheral.NewStackManager(queries)

	// m.PrintDebug()

	for {
		grpcConn, err := grpc.NewClient("localhost:50051",
			grpc.WithTransportCredentials(insecure.NewCredentials()))

		if err != nil {
			log.Printf("連線失敗，5秒後重試... %v", err)
			time.Sleep(5 * time.Second)
			continue
		}

		gClient := stackpb.NewStackServiceClient(grpcConn)

		stream, err := gClient.PushStacks(context.Background())
		if err != nil {
			log.Printf("建立串流失敗，重試中... %v", err)
			grpcConn.Close()
			time.Sleep(5 * time.Second)
			continue
		}

		err = runSendLoop(stream, psm)

		// 如果 runSendLoop 回傳錯誤，代表串流斷了
		log.Printf("串流中斷: %v，準備重新連線...", err)
		grpcConn.Close()
		time.Sleep(2 * time.Second)

	}

}

func runSendLoop(stream stackpb.StackService_PushStacksClient, m *peripheral.YFYStackManager) error {

	for {
		m.Mu.Lock()
		if m.IsDirty {

			if err := stream.Send(m.ToProto()); err != nil {
				m.Mu.Unlock()
				return err
			}
			m.IsDirty = false
		}
		m.Mu.Unlock()
		time.Sleep(1 * time.Second)
	}
}
