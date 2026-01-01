package peripheral

import (
	"context"
	"fmt"
	"kenmec/peripheral/jimmy/initial"
	"strconv"
)

type YFYStackManager struct {
	infoMap map[string]*YFYStack
}

func NewStackManager(defaultLocationId []string) *YFYStackManager {

	ctx := context.Background()
	txt := initial.Rdb.Get(ctx, "current-script-id").Val()

	scriptId, _ := strconv.Unquote(txt)

	fmt.Println(scriptId)

	defaultMap := make(map[string]*YFYStack)

	for _, v := range defaultLocationId {

		s := NewStack(YFYStack{
			Name:        "test",
			Description: "test",
			Disable:     false,
			Booker:      "none",

			heights:    []int{},
			StackCount: 2,
			Cargo:      nil,
		})

		defaultMap[v] = s
	}

	return &YFYStackManager{
		infoMap: defaultMap,
	}
}
