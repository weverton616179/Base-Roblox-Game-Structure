local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local UIComponents = ReplicatedStorage.Shared.UIComponents

local BackgroundFrame = require(UIComponents.Site.ZeMotors.Background)
local ElementsContainer = require(UIComponents.Site.ZeMotors.ElementsContainer)

local function Index(scope, _props)
	return scope:New("ScrollingFrame")({
		BackgroundColor3 = Color3.fromRGB(210, 210, 210),
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0),
		AnchorPoint = Vector2.new(0, 0),
		ScrollBarThickness = 7,
		CanvasSize = UDim2.fromScale(0, 3),

		[Children] = {
			BackgroundFrame(scope, _props),
			ElementsContainer(scope, _props),
		},
	})
end

return Index
