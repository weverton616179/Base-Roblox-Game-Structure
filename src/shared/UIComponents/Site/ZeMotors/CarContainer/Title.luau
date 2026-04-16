local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

-- local UIComponents = ReplicatedStorage.Shared.UIComponents

local function Title(scope, _props)
	return scope:New("Frame")({
		Name = "Title",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 0.2),
		Position = UDim2.fromScale(0.5, 0.1),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("UIGradient")({
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(233, 233, 233)),
					ColorSequenceKeypoint.new(0.49, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.51, Color3.fromRGB(230, 230, 230)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 210, 210)),
				}),
				Rotation = 90,
			}),

			scope:New("TextLabel")({
				Text = "CARRO DA COLEÇÃO INICIAL MUITO MUITO GRANDE",
				TextSize = 16,
				TextXAlignment = "Left",
				TextYAlignment = "Top",
				TextWrapped = true,
				FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),

				BackgroundTransparency = 1,
				Size = UDim2.new(0.8, -3, 1, 0),
				Position = UDim2.fromScale(0.4, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}),
		},
	})
end

return Title
