local HttpService = game:GetService("HttpService")
local ProfileStoreConfig = {}

--------------------------------------------------
-- Por algum motivo no roblox só existem 2 maneiras de copiar uma tabela para outra variavel. Um dos jeitos é por meio de um scrit extenso de deepcopy (fiquei com preguiça de criar),
-- que é capaz até mesmo de copiar funções e instancias que estão na tabela. O outro jeito seria utilizar "tabelaModeloJson = HttpService:JSONEncode(tabelaModelo)"
-- para trasnformar a tabela em um JSON, depois "novaTabela = HttpService:JSONDecode(tabelaModeloJson)" para transformar o JSON em tabela. A unica desvantagem
-- de utilizar por JSON é que em questão de memória ele é menos otimizado (então trate de limpar as variaveis temporárias depois de usá-las), e ele não aceita funções
-- ou instancias dentro da tabela, funcionando apenas com valores serializaveis como strings, numeros, booleans, etc.
--------------------------------------------------

ProfileStoreConfig.DataId = "dev_1"

ProfileStoreConfig.ProfileTemplate = HttpService:JSONEncode({
	Cash = 1000,
	DataVersion = 1,
})

ProfileStoreConfig.CarTemplate = HttpService:JSONEncode({
	["paint1"] = {
		["r"] = 200,
		["g"] = 200,
		["b"] = 200,
	},
	["paint2"] = {
		["r"] = 200,
		["g"] = 50,
		["b"] = 100,
	},
})

ProfileStoreConfig.GarageProfileTemplate = HttpService:JSONEncode({
	["CatCar"] = {
		["paint1"] = {
			["r"] = 200,
			["g"] = 200,
			["b"] = 200,
		},
		["paint2"] = {
			["r"] = 200,
			["g"] = 50,
			["b"] = 100,
		},
	},
})

--colocar table.frezze depois

return ProfileStoreConfig
