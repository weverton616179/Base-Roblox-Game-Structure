local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- local player = game.Players.LocalPlayer :: Player
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
-- local scoped = Fusion.scoped
local peek = Fusion.peek
-- local Children = Fusion.Children
-- local OnEvent = Fusion.OnEvent

-- local TextButtonTest = require(ReplicatedStorage.Shared.UIComponents.TextButtonTest)
-- local ViewportButton = require(ReplicatedStorage.Shared.UIComponents.ViewportButton)

local TesteController = {}

function TesteController.Init(_self: TesteController)
	print("carregando controller teste")
	-- self.scope = scoped({
	-- 	New = Fusion.New,
	-- 	Value = Fusion.Value,
	-- })

	-- self.counter = self.scope:Value(0)

	-- self.gui = self.scope:New("ScreenGui")({
	-- 	Name = "TesteGui",
	-- 	Parent = player.PlayerGui,

	-- 	[Children] = {
	-- 		self.scope:New("Frame")({
	-- 			Name = "TesteFrame",
	-- 			Size = UDim2.fromScale(0.5, 0.5),
	-- 			Position = UDim2.fromScale(0.5, 0.5),
	-- 			AnchorPoint = Vector2.new(0.5, 0.5),

	-- 			[Children] = {
	-- 				self.scope:New("UIGridLayout")({}),

	-- 				TextButtonTest({
	-- 					-- BackgroundColor3 = Color3.new(0, 0, 1),
	-- 				}),
	-- 				TextButtonTest({
	-- 					BackgroundColor3 = Color3.new(0, 0, 1),
	-- 					Counter = self.counter,
	-- 				}),
	-- 				ViewportButton({}),
	-- 				ViewportButton({}),
	-- 			},
	-- 		}),
	-- 	},
	-- })
end

function TesteController:Start()
	print("controller teste carregou", self.nome)
	-- task.spawn(function()
	-- 	local store = require(ReplicatedStorage.Shared.UIComponents.Site.StateStore)
	-- 	while true do
	-- 		task.wait(3)
	-- 		if peek(store.CurrentPage) == "ZeMotors" then
	-- 			store.CurrentPage:set("None")
	-- 		else
	-- 			store.CurrentPage:set("ZeMotors")
	-- 		end
	-- 		print("------------------------", peek(store.CurrentPage))
	-- 	end
	-- end)
end

function TesteController:Print(variavel)
	print("--TESTE--", variavel, "--TESTE--")
end

type TesteController = typeof(TesteController)

return TesteController
