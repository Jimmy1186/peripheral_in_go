package peripheral

import (
	"encoding/json"
)

type YFYStack struct {
	Name        string
	Description string

	Disable bool
	Booker  string

	StackCount int //堆堆疊數量
	heights    []int
	Cargo      []json.RawMessage `json:"cargo"`
}

func NewStack(data YFYStack) *YFYStack {

	return &YFYStack{
		Name:        data.Name,
		Description: data.Description,
		Disable:     data.Disable,
		Booker:      "none",

		heights:    data.heights,
		StackCount: data.StackCount,
		Cargo:      data.Cargo,
	}

}

func (ns *YFYStack) UpdateConfig(name string, desc string, disable bool) {
	ns.Name = name
	ns.Description = desc
	ns.Disable = disable
}
