local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIComponents = ReplicatedStorage.Shared.UIComponents
local Store = require(UIComponents.Site.StateStore)

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local function TextBar(scope, _props)
	return scope:New("Frame")({
		Name = "LinkBarFrame",
		BackgroundColor3 = Color3.fromRGB(160, 160, 160),
		Size = UDim2.fromScale(0.4, 0.6),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("UICorner")({
				CornerRadius = UDim.new(0.3, 0),
			}),

			scope:New("Frame")({
				Name = "LinkBarFrame",
				BackgroundColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(1, -3, 1, -3),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[Children] = {
					scope:New("TextLabel")({
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(0.95, 0.8),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),

						TextXAlignment = "Left",
						TextScaled = true,
						Text = Store.LinkSite or "No link",
						TextColor3 = Color3.fromRGB(71, 71, 71),

						[Children] = {
							scope:New("Frame")({
								Name = "BottomBorder",
								BackgroundColor3 = Color3.fromRGB(160, 160, 160),
								Size = UDim2.fromScale(1, 0.05),
								Position = UDim2.fromScale(0, 0.95),
							}),
						},
					}),

					scope:New("UICorner")({
						CornerRadius = UDim.new(0.3, 0),
					}),

					scope:New("UIGradient")({
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(248, 248, 248)),
							ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
						}),
						Rotation = -90,
					}),
				},
			}),
		},
	})
end

return TextBar
