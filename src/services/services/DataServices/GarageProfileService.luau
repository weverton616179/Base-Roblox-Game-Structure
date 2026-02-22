local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BaseProfileService = require(ReplicatedStorage.Shared.Classes.BaseProfileService)
local ProfileStoreConfig = require(ServerScriptService.Server.Configs.ProfileStoreConfig)

local GarageProfileService =
	BaseProfileService.new("GarageProfileService", "Garage", ProfileStoreConfig.GarageProfileTemplate)

--------------------------------------------------
-- Escrever novos métodos a partir daqui, podendo até mesmo sobre escrever métodos
--------------------------------------------------

type GarageProfileService = typeof(GarageProfileService)

return GarageProfileService
