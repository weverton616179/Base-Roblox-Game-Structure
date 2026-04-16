local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ZeMotorsStore = require(script.Parent.ZeMotorsStore)
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local UIComponents = ReplicatedStorage.Shared.UIComponents
local CarContainer = require(UIComponents.Site.ZeMotors.CarContainer.Container)
local FilterButton = require(UIComponents.Site.ZeMotors.FilterButton)
local PaginateContainer = require(UIComponents.Site.ZeMotors.PaginateContainer)

local function ElementsContainer(scope, _props)
	return scope:New("Frame")({
		ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(60, 15, 15),
		Name = "ElementsContainerFrame",
		Size = UDim2.fromScale(0.85, 0.75),
		Position = UDim2.fromScale(0.5, 0.54),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BorderColor3 = Color3.fromRGB(200, 0, 0),
		BorderSizePixel = 1,

		[Children] = {
			scope:New("TextLabel")({
				BackgroundTransparency = 1,
				Text = "NEW ARRIVALS",
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),

				SizeConstraint = "RelativeXX",
				Size = UDim2.fromScale(0.25, 0.09),
				Position = UDim2.fromScale(0.025, 0),
				AnchorPoint = Vector2.new(0, 0),
			}),

			FilterButton(scope, {}),

			scope:New("Frame")({
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.98, 0.93),
				Position = UDim2.fromScale(0.5, 1),
				AnchorPoint = Vector2.new(0.5, 1),

				[Children] = {
					scope:New("UIGridLayout")({
						CellSize = UDim2.fromScale(0.31, 0.17),
						HorizontalAlignment = "Center",
						CellPadding = UDim2.fromScale(0.02, 0.015),
					}),

					scope:ForValues(ZeMotorsStore.Items, function(use, innerScope, car)
						return CarContainer(innerScope, { CarData = car })
					end),
				},
			}),

			PaginateContainer(scope, {}),
		},
	})
end

return ElementsContainer
