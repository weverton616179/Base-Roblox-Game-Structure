local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BaseProfileService = require(ReplicatedStorage.Shared.Classes.BaseProfileService)
local ProfileStoreConfig = require(ServerScriptService.Server.Configs.ProfileStoreConfig)

local GarageProfileService =
	BaseProfileService.new("GarageProfileService", "Garage", ProfileStoreConfig.GarageProfileTemplate)

--------------------------------------------------
-- Escrever novos métodos a partir daqui, podendo
-- até mesmo sobre escrever métodos erdados da classe "BaseProfileService"
--------------------------------------------------

-- metodo de adicionar carro
-- metodo de remover carro por indice

function GarageProfileService:AddCar(player: Player, carName: string, config)
	local profileGarage = self:GetProfile(player)
	profileGarage[carName] = config
end

function GarageProfileService:RemoveCar(player: Player, carName: string)
	local profileGarage = self:GetProfile(player)
	profileGarage[carName] = nil
end

type GarageProfileService = typeof(GarageProfileService)

return GarageProfileService
