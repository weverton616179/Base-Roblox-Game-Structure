local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)

local StoreScope = Fusion.scoped(Fusion)

return {
	-- paginate e filter
	SortBy = StoreScope:Value("Price"),
	SortByAscending = StoreScope:Value(true),
	Page = StoreScope:Value(1),
	PerPage = StoreScope:Value(10),

	MaxPage = StoreScope:Value(0),
	HasPreviousPage = StoreScope:Value(false),
	HasNextPage = StoreScope:Value(false),
	Items = StoreScope:Value({}),
}
