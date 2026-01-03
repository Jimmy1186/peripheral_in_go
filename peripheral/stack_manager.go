package peripheral

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"kenmec/peripheral/jimmy/db"
	"kenmec/peripheral/jimmy/initial"

	"strconv"
)

type YFYStackManager struct {
	infoMap map[string]*YFYStack
	db      *db.Queries
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
	}
}

func (m *YFYStackManager) AddStack(locationId string) {
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
}

func (m *YFYStackManager) DeleteStack(locationId string) {
	delete(m.infoMap, locationId)
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
