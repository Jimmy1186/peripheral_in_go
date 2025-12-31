package peripheral



type YFYStackManager struct{
	infoMap map[string]*YFYStack

}



func NewStackManager(defaultLocationId []string) *YFYStackManager{
	
	defaultMap := make(map[string]*YFYStack)

	for _,v := range defaultLocationId{

		s := NewStack(YFYStack{
			Name: "test",
			Description: "test",
			Disable: false,
			Booker: "none",

			StackCount: 2,
			Cargo: nil,
		})

		defaultMap[v] = s
	}
	
	return &YFYStackManager{
		infoMap: defaultMap,
	}
}