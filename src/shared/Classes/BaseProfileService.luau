local BaseProfileService = {}
BaseProfileService.__index = BaseProfileService

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

function BaseProfileService.new(serviceName: string, dataKey: string, template)
	local self = setmetatable({}, BaseProfileService)

	self.Name = serviceName
	self.DataKey = dataKey
	self.Template = template

	return self
end

function BaseProfileService:Init()
	print("Carregando serviço:", self.Name)
end

function BaseProfileService:Start()
	self.ProfileService = self.Services.ProfileService

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			self:CreateProfileIfNotExist(player)
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		self:CreateProfileIfNotExist(player)
	end)
end

function BaseProfileService:ResetProfile(player: Player)
	local profile = self.ProfileService:WaitForProfile(player)

	if profile and profile.Data then
		local CloneTemplate = HttpService:JSONDecode(self.Template)
		profile.Data[self.DataKey] = CloneTemplate
		print("garage from player ", player, " created")

		return profile.Data[self.DataKey]
	else
		print("Erro ao carregar o profile ou data em:", self.Name)
		return
	end
end

function BaseProfileService:CreateProfileIfNotExist(player: Player)
	local profile = self.ProfileService:WaitForProfile(player)

	if profile and profile.Data then
		if not profile.Data[self.DataKey] then
			self:ResetProfile(player)
			print(self.DataKey .. " created")
		else
			print(self.DataKey .. " just exist")
		end

		return profile.Data[self.DataKey]
	end

	return
end

function BaseProfileService:DeleteProfile(player: Player)
	local profile = self.ProfileService:WaitForProfile(player)
	if profile and profile.Data then
		profile.Data[self.DataKey] = nil
		print(self.DataKey .. " removed", player)
	end
end

function BaseProfileService:GetProfile(player: Player)
	local profile = self.ProfileService:WaitForProfile(player)
	if profile and profile.Data then
		if profile.Data[self.DataKey] then
			return profile.Data[self.DataKey]
		else
			print("Ainda não tem o profile garage, criando...")
			return self:ResetProfile(player)
		end
	else
		print("Profile ou data não existe")
		return false
	end
end

return BaseProfileService
