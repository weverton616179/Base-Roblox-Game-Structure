local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

-- local UIComponents = ReplicatedStorage.Shared.UIComponents

local function NameAndPrice(scope, _props)
	return scope:New("Frame")({
		Name = "NameAndPrice",
		BackgroundColor3 = Color3.new(0, 0, 0),
		Size = UDim2.fromScale(1, 0.15),
		Position = UDim2.fromScale(0.5, 0.925),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("TextLabel")({
				Text = _props.CarName, --"CARRO MUITO LEGAL LEGAL LEGAL LEGAL",
				TextSize = 16,
				TextXAlignment = "Left",
				TextWrapped = true,
				TextColor3 = Color3.new(1, 1, 1),
				FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),

				BackgroundTransparency = 1,
				Size = UDim2.new(0.7, -15, 1, -3),
				Position = UDim2.fromScale(0.35, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}),

			scope:New("Frame")({
				BackgroundColor3 = _props.CarPurchased and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0),
				Size = UDim2.fromScale(0.35, 1),
				Position = UDim2.fromScale(0.825, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[Children] = {
					scope:New("UICorner")({
						CornerRadius = UDim.new(0.1, 0),
					}),

					scope:New("Frame")({
						Size = UDim2.new(1, -3, 1, -3),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),

						[Children] = {
							scope:New("UIGradient")({
								Color = ColorSequence.new({
									ColorSequenceKeypoint.new(
										0,
										_props.CarPurchased and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
									),
									ColorSequenceKeypoint.new(
										1,
										_props.CarPurchased and Color3.fromRGB(5, 200, 5) or Color3.fromRGB(200, 5, 5)
									),
								}),
								Rotation = -90,
							}),

							scope:New("UICorner")({
								CornerRadius = UDim.new(0.1, 0),
							}),

							scope:New("TextLabel")({
								Size = UDim2.fromScale(1, 1),
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5),

								Text = "$" .. _props.CarPrice, --"$710,000,000",
								TextSize = 16,
								TextColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Bold),
							}),
						},
					}),
				},
			}),
		},
	})
end

return NameAndPrice
