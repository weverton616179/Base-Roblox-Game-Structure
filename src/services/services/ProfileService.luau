local ServerScriptService = game:GetService("ServerScriptService")
local ProfileStoreConfig = require(ServerScriptService.Server.Configs.ProfileStoreConfig)
local ProfileStore = require(ServerScriptService.ServerPackages.profilestore)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- local JsonProfileTemplate = HttpService:JSONEncode(ProfileStoreConfig.ProfileTemplate)
local CloneProfileTemplate = HttpService:JSONDecode(ProfileStoreConfig.ProfileTemplate)

local PlayerStore = ProfileStore.New(ProfileStoreConfig.DataId, CloneProfileTemplate)
local Profiles: { [Player]: typeof(PlayerStore:StartSessionAsync()) } = {}

local ProfileService = {}

local function PlayerAdded(player)
	local profile = PlayerStore:StartSessionAsync(`{player.UserId}`, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile.OnSessionEnd:Connect(function()
			Profiles[player] = nil
			player:Kick("Sessão de dados encerrada. Por favor, reconecte.")
		end)

		if player:IsDescendantOf(Players) then
			Profiles[player] = profile
			print("Perfil carregado para: " .. player.Name)
		else
			profile:EndSession()
		end
	else
		player:Kick("Não foi possível carregar seus dados. Tente novamente.")
	end
end

local function PlayerRemoving(player)
	local profile = Profiles[player]
	if profile then
		profile:EndSession()
	end
end

--------------------------------------------------
-- Retorna o profile com todos os dados do player
--------------------------------------------------
function ProfileService:GetProfile(player)
	return Profiles[player]
end

--------------------------------------------------
-- Retorna o profile de TODOS os players
--------------------------------------------------
function ProfileService:GetAllProfile()
	return Profiles
end

--------------------------------------------------
-- Tenta pegar os dados do player, assim como o GetProfile,
-- porém caso o resultado for nil ele continua aguardando por um tempo, até que seja true
-- o campo timeout é opcional, e caso não esteja preenchido o padrão é 15 segundos
--------------------------------------------------
function ProfileService:WaitForProfile(player: Player, timeout: number?)
	local maxWaitTime = timeout or 25
	local elapsedTime = 0
	local pollRate = 0.1

	while not Profiles[player] do
		if not player:IsDescendantOf(Players) then
			return nil
		end

		if elapsedTime >= maxWaitTime then
			warn("Tempo limite excedido ao esperar pelos dados do jogador: " .. player.Name)
			return nil
		end

		elapsedTime += task.wait(pollRate)
	end

	return Profiles[player]
end

--------------------------------------------------
-- Resetar data do player
--------------------------------------------------
function ProfileService:ResetProfile(player)
	local profile = ProfileService:WaitForProfile(player)
	profile["Data"] = HttpService:JSONDecode(ProfileStoreConfig.ProfileTemplate)
	return profile
end

function ProfileService.Init(self: ProfileService)
	print("carregando Data")
	self.nome = "teste"
end

function ProfileService:Start()
	print("Data Carregado")
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(PlayerAdded, player)
	end

	Players.PlayerAdded:Connect(PlayerAdded)
	Players.PlayerRemoving:Connect(PlayerRemoving)
end

type ProfileService = typeof(ProfileService)

return ProfileService
