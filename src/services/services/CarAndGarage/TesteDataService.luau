local _HttpService = game:GetService("HttpService")
local _Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local _ProfileStoreConfig = require(ServerScriptService.Server.Configs.ProfileStoreConfig)

-- estrutura padrão de um service, essa estrutura deve ser usada nos services (servidor) e controllers (cliente)
-- no caso dos Utils (replicated storage), essa estrutura não é necessária, o Util pode ser apenas um module normal.
local TesteDataService = {}

-- lógica para carregar o serviço, preparando suas estruturas internas para o Start
function TesteDataService.Init(self: TesteDataService)
	print("carregando serviço")
	self.nome = "teste"
end

-- lógica que dá o start ao serviço, esse método apenas será chamado quando todos os services executarem seus inits
-- caso o serviço utilize outros serviços, eles devem ser carregados a partir daqui
function TesteDataService:Start()
	print("serviço carregou", self.nome)
	task.wait(3)
	-- local DealershipService = self.Services.DealershipService
	-- local player = Players:FindFirstChild("WevertonBRBOOM")
	-- local cars = DealershipService:GetCars(player, 3, 10, "Name", true)
	-- print(cars)
	-- local ProfileService = self.Services.ProfileService
	-- local GarageProfileService = self.Services.GarageProfileService
	-- local CarManagerService = self.Services.CarManagerService
	-- local DealershipService = self.Services.DealershipService

	-- local function printaProfile(player)
	-- 	local profile = ProfileService:ResetProfile(player)

	-- 	task.spawn(function()
	-- 		while true do
	-- 			print(profile["Data"])
	-- 			task.wait(1)
	-- 		end
	-- 	end)

	-- 	task.wait(3)
	-- 	print("--TESTE-- comprando carro --TESTE--")
	-- 	local tabelinha = HttpService:JSONDecode(ProfileStoreConfig.CarTemplate)
	-- 	tabelinha.paint1.r = 0
	-- 	tabelinha.paint1.g = 0
	-- 	tabelinha.paint1.b = 0
	-- 	DealershipService:BuyCar(player, "Uno", tabelinha)

	-- 	task.wait(3)
	-- 	print("--TESTE-- spawnando carro --TESTE--")
	-- 	local posicao = Vector3.new(10, 5, 0)
	-- 	local orientacao = CFrame.Angles(0, math.rad(90), 0)
	-- 	CarManagerService:SpawnCar(player.Name, "Uno", nil, posicao, orientacao)

	-- 	task.wait(3)
	-- 	print("--TESTE-- vendendo e destruindo carro --TESTE--")
	-- 	DealershipService:SellCar(player, "Uno")
	-- 	CarManagerService:DestroyCar(player.Name)
	-- end

	-- for _, player in ipairs(Players:GetPlayers()) do
	-- 	printaProfile(player)
	-- end

	-- Players.PlayerAdded:Connect(function(player: Player)
	-- 	printaProfile(player)
	-- end)
end

function TesteDataService:Print(variavel)
	print("--TESTE--", variavel, "--TESTE--")
end

-- A estrutura do typeof, e com o init com "." ao invés de ":" é interessante pois facilita no auto complete, mas ao mesmo tempo mão é obrigatorio
type TesteDataService = typeof(TesteDataService)

return TesteDataService
