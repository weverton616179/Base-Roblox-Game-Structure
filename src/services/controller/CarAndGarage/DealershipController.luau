local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.component)
local CameraUtil = require(ReplicatedStorage.Shared.Utils.CameraUtil)
local Player = game.Players.LocalPlayer :: Player
local DealershipNetwork = require(ReplicatedStorage.Shared.Network.dealership.client)

-- fusion
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local SiteFrame = require(ReplicatedStorage.Shared.UIComponents.Site.Frame)
local UIComponents = ReplicatedStorage.Shared.UIComponents
local scoped = Fusion.scoped
local Children = Fusion.Children
local Store = require(UIComponents.Site.StateStore)
local ZeMotorsStore = require(UIComponents.Site.ZeMotors.ZeMotorsStore)
local peek = Fusion.peek

local DealershipController = {}

local DealershipPromptComponent = Component.new({
	Tag = "dealership",
	Ancestors = { workspace },
})

function DealershipPromptComponent:Start()
	local prompt = self.Instance:FindFirstChildWhichIsA("ProximityPrompt", true)
	local cameraPart = self.Instance:FindFirstChild("Camera", true)
	local screenPart = self.Instance

	if not prompt then
		warn("Nenhum ProximityPrompt encontrado na loja: " .. self.Instance.Name)
		return
	end
	if not cameraPart then
		warn("Nenhum ProximityPrompt encontrado na loja: " .. self.Instance.Name)
		return
	end
	if not screenPart then
		warn("Nenhum ProximityPrompt encontrado na loja: " .. self.Instance.Name)
		return
	end

	self.triggerConn = prompt.Triggered:Connect(function(player)
		if Store.IsOpen == true then
			warn("loja ja aberta")
			return
		end

		print("loja aberta pelo jogador: " .. player.Name)
		CameraUtil:Focus(cameraPart, screenPart, 1)

		DealershipController:LoadGui(screenPart)
		-- task.wait(3)
		-- CameraUtil:Restore(1)
	end)
end

function DealershipPromptComponent:Stop()
	if self.triggerConn then
		self.triggerConn:Disconnect()
	end
end

function DealershipController.Init(self: DealershipController)
	print("carregando serviço DealershipController")
	self.nome = "teste"
end

function DealershipController:Start()
	-- task.spawn(function()
	-- 	local contador = 0
	-- 	while true do
	-- 		print(contador)
	-- 		contador += 1
	-- 		task.wait(1)
	-- 		if contador == 6 then
	-- 			contador = 0
	-- 			if peek(ZeMotorsStore.Page) == 1 then
	-- 				ZeMotorsStore.Page:set(2)
	-- 			else
	-- 				ZeMotorsStore.Page:set(1)
	-- 			end
	-- 			self:GetCars()
	-- 			print(ZeMotorsStore)
	-- 		end
	-- 	end
	-- end)

	print("serviço carregou DealershipController")
end

function DealershipController:LoadGui(partSurface)
	local scope = scoped({
		New = Fusion.New,
		Value = Fusion.Value,
		doCleanup = Fusion.doCleanup,
		Computed = Fusion.Computed,
		ForValues = Fusion.ForValues,
		Tween = Fusion.Tween,
	})

	Store.LinkSite:set("www.zemotorsport.net")
	Store.IsOpen = true
	Store.CurrentPage:set("ZeMotors")

	scope:New("SurfaceGui")({
		Parent = Player.PlayerGui,
		Name = "TesteGui",
		Adornee = partSurface,
		PixelsPerStud = 300,

		[Children] = {
			SiteFrame(scope, {}),
		},
	})

	self:GetCars(ZeMotorsStore)
end

function DealershipController:GetCars(StoreModule)
	-- falta fazer a parte de pegar os dados retornados e aplicar no arquivo de STORE
	local sortBy = peek(StoreModule.SortBy)
	local sortByAscending = peek(StoreModule.SortByAscending)
	local page = peek(StoreModule.Page)
	local perPage = peek(StoreModule.PerPage)
	print(sortBy, sortByAscending, page, perPage)

	local response = DealershipNetwork.GetCars.Invoke({
		Page = page,
		PerPage = perPage,
		SortBy = sortBy,
		SortByAscending = sortByAscending,
	})

	StoreModule.Page:set(response.currentPage)
	StoreModule.PerPage:set(response.itemsPerPage)
	StoreModule.MaxPage:set(response.maxPage)
	StoreModule.HasPreviousPage:set(response.hasPreviousPage)
	StoreModule.HasNextPage:set(response.hasNextPage)
	StoreModule.Items:set(response.items)

	return response
end

type DealershipController = typeof(DealershipController)

return DealershipController
