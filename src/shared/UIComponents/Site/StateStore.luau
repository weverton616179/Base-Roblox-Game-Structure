local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)

local StoreScope = Fusion.scoped(Fusion)

return {
	ValorTeste = StoreScope:Value(1),
	LinkSite = StoreScope:Value("www.none.site"),
	IsOpen = StoreScope:Value(false),
	CurrentPage = StoreScope:Value("None"),

	-- array de todos os carros
	--valores dos carros para serem exibidos, usar array
	-- pagina, e quantia por pagina, e o filtro
}
