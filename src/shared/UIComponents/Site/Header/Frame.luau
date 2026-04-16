local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIComponents = ReplicatedStorage.Shared.UIComponents
local ExitButton = require(UIComponents.Site.Header.ExitButton)
local HomeButton = require(UIComponents.Site.Header.HomeButton)
local TextBar = require(UIComponents.Site.Header.TextBar)

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local function Frame(scope, _props)
	return scope:New("Frame")({
		Name = "HeaderFrame",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 0.08),
		Position = UDim2.fromScale(0, 0),
		AnchorPoint = Vector2.new(0, 0),

		[Children] = {
			TextBar(scope, {}),
			ExitButton(scope, {}),
			HomeButton(scope, {}),

			scope:New("UIGradient")({
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(205, 205, 205)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 235, 235)),
				}),
				Rotation = -90,
			}),
		},
	})
end

return Frame
