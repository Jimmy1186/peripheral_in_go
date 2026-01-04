package peripheral

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"kenmec/peripheral/jimmy/db"
	"kenmec/peripheral/jimmy/initial"
	stackpb "kenmec/peripheral/jimmy/protoGen"
	"strconv"
	"sync"
)

type YFYStackManager struct {
	infoMap map[string]*YFYStack
	db      *db.Queries
	IsDirty bool //如果有變動 變true時在傳出去

	Mu sync.Mutex
}

func NewStackManager(q *db.Queries) *YFYStackManager {

	ctx := context.Background()
	txt := initial.Rdb.Get(ctx, "current-script-id").Val()

	scriptId, _ := strconv.Unquote(txt)

	defaultMap := make(map[string]*YFYStack)

	dbData, qErr := q.AllStack(ctx, scriptId)

	if qErr != nil {

		panic(qErr)
	}

	// 2. 收集所有 Stack ID
	var stackIds []sql.NullString

	for _, v := range dbData {
		if v.Stackid == "" {
			continue
		}

		stackIds = append(stackIds, sql.NullString{
			String: v.Stackid,
			Valid:  true,
		})
	}

	rawCargos, _ := q.ListCargosByStackIds(ctx, stackIds)

	// 4. 將貨物按 stack_config_id 分組存入 Map
	cargoGroups := make(map[string][]CargoData)
	for _, c := range rawCargos {
		cargoGroups[c.StackConfigID.String] = append(cargoGroups[c.StackConfigID.String], CargoData{
			ID:       c.CargoID,
			Metadata: c.CargoMetadata,
		})
	}

	for _, v := range dbData {
		var heights []int
		_ = json.Unmarshal(v.StackHeights, &heights)

		s := NewStack(YFYStack{
			Name:        v.PeripheralName.String,
			Description: v.PeripheralDesc,
			Disable:     v.StackDisable,
			Booker:      "none",
			Heights:     heights,
			StackCount:  int(v.StackCount),
			// 直接從 Map 拿該 Stack 的貨物列表，沒貨物就是 nil/空 slice
			Cargo: cargoGroups[v.Stackid],
		})

		defaultMap[v.Locationid] = s
	}

	return &YFYStackManager{
		infoMap: defaultMap,
		db:      q,
		IsDirty: true,
	}
}

func (m *YFYStackManager) AddStack(locationId string) {
	m.Mu.Lock()
	defer m.Mu.Unlock()

	ctx := context.Background()
	txt := initial.Rdb.Get(ctx, "current-script-id").Val()

	scriptId, _ := strconv.Unquote(txt)

	dbData, err := m.db.OneStack(ctx, db.OneStackParams{
		ID:         scriptId,
		Locationid: locationId,
	})
	if err != nil {

		return
	}

	var heights []int
	_ = json.Unmarshal(dbData.StackHeights, &heights)

	s := NewStack(YFYStack{
		Name:        dbData.PeripheralName.String,
		Description: dbData.PeripheralDesc,
		Disable:     dbData.StackDisable,
		Booker:      "none",
		Heights:     heights,
		StackCount:  int(dbData.StackCount),
		Cargo:       []CargoData{},
	})

	m.infoMap[locationId] = s
	m.IsDirty = true
}

func (m *YFYStackManager) DeleteStack(locationId string) {
	m.Mu.Lock()
	defer m.Mu.Unlock()

	delete(m.infoMap, locationId)
	m.IsDirty = true
}

func (m *YFYStackManager) UpdatestackConfig(locID string, name string, desc string, disable bool) {
	m.Mu.Unlock()
	defer m.Mu.Unlock()

	s, ok := m.infoMap[locID]

	if ok {
		s.UpdateConfig(name, desc, disable)
		m.IsDirty = true
	}
}

func (m *YFYStackManager) UpdateCargo(locID string, cargo []CargoData) {
	m.Mu.Unlock()
	defer m.Mu.Unlock()

	s, ok := m.infoMap[locID]

	if ok {
		s.UpdateAllCargo(cargo)
		m.IsDirty = true
	}
}

func (m *YFYStackManager) PrintDebug() {

	output, err := json.MarshalIndent(m.infoMap, "", "    ")
	if err != nil {
		fmt.Printf("Error marshaling debug info: %v\n", err)
		return
	}
	fmt.Println("--- Current Stack Manager Data ---")
	fmt.Println(string(output))
	fmt.Println("----------------------------------")
}

// ToProto 將 Manager 內部的 map 轉換為 gRPC 專用的傳輸格式
func (m *YFYStackManager) ToProto() *stackpb.StackMapResponse {
	// 初始化回傳的結構
	protoMap := make(map[string]*stackpb.Stack)

	for locID, s := range m.infoMap {
		// 1. 處理 Cargo 列表
		var pbCargos []*stackpb.Cargo
		for _, c := range s.Cargo {
			pbCargos = append(pbCargos, &stackpb.Cargo{
				Id:       c.ID,
				Metadata: c.Metadata, // []byte 直接對應 bytes
			})
		}

		// 2. 處理 Heights (int 轉 int32)
		var h32 []int32
		for _, h := range s.Heights {
			h32 = append(h32, int32(h))
		}

		// 3. 組裝成生成的 Stack 結構
		protoMap[locID] = &stackpb.Stack{
			Name:        s.Name,
			Description: s.Description,
			Disable:     s.Disable,
			StackCount:  int32(s.StackCount),
			Heights:     h32,
			Cargo:       pbCargos,
		}
	}

	return &stackpb.StackMapResponse{
		InfoMap: protoMap,
	}
}
