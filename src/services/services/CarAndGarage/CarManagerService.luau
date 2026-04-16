local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Car = require(ReplicatedStorage.Shared.Classes.Car)
local CarsPlayersTable = {}

local CarManagerService = {}

function CarManagerService.Init(self: CarManagerService)
	print("carregando Car Manager")
	self.nome = "teste"
end

function CarManagerService:Start()
	print("serviço CarManagerService")
	self.GarageProfileService = self.Services.GarageProfileService

	game.Players.PlayerRemoving:Connect(function(player)
		self:DestroyCar(player)
	end)
end

function CarManagerService:SpawnCar(player: string, carName: string, part: Part, position: Vector3, orientation: CFrame)
	local playerInstance = Players:FindFirstChild(player)
	if not player then
		print("Player inexistente")
		return
	end

	local profile = self.GarageProfileService:GetProfile(playerInstance) -- passar o profile como parametro em Car.new para utilizar as config do car na hora de spawnar o carro
	if not profile[carName] then
		print("player", player, "não tem o carro", carName)
		return
	end

	if CarsPlayersTable[player] then
		CarsPlayersTable[player]:Destroy()
	end

	local car = Car.new(player, carName, profile[carName])
	car:Spawn(part, position, orientation)

	CarsPlayersTable[player] = car
end

function CarManagerService:GetCar(player)
	print(CarsPlayersTable[player])
	return CarsPlayersTable[player]
end

function CarManagerService:DestroyCar(player)
	if CarsPlayersTable[player] then
		CarsPlayersTable[player]:Destroy()
		CarsPlayersTable[player] = nil
	end
end

type CarManagerService = typeof(CarManagerService)

return CarManagerService
