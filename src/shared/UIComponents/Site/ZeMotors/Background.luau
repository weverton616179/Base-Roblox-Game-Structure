local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local function Background(scope, _props)
	return scope:New("Frame")({
		Name = "BackgroundFrame",
		BackgroundColor3 = Color3.new(0.55, 0.1, 0.08),
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("ImageLabel")({
				Image = "rbxassetid://17399895115",
				BackgroundTransparency = 1,
				ImageTransparency = 0.8,
				Size = UDim2.fromScale(1, 1),
				ScaleType = "Tile",
				TileSize = UDim2.fromScale(0.04, 0.02),
			}),

			scope:New("UIGradient")({
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100)),
				}),
				Rotation = -90,
			}),

			scope:New("Frame")({
				Name = "CarImageFrame",
				ZIndex = 2,
				SizeConstraint = "RelativeXX",
				Size = UDim2.fromScale(1, 0.28),
				BackgroundColor3 = Color3.fromRGB(164, 16, 11),

				[Children] = {
					scope:New("ImageLabel")({
						Size = UDim2.fromScale(1, 0.97),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Image = "rbxassetid://119332539710907",

						[Children] = {
							[Children] = {
								scope:New("UIGradient")({
									Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
										ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 255)),
										ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 255, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
									}),
								}),
							},
						},
					}),
				},
			}),

			scope:New("Frame")({
				Name = "FooterFrame",
				ZIndex = 2,
				SizeConstraint = "RelativeXX",
				Size = UDim2.fromScale(1, 0.1),
				BackgroundColor3 = Color3.fromRGB(190, 0, 0),
				Position = UDim2.fromScale(0.5, 1),
				AnchorPoint = Vector2.new(0.5, 1),

				[Children] = {
					scope:New("Frame")({
						BackgroundColor3 = Color3.fromRGB(0, 0, 0),
						Size = UDim2.fromScale(1, 0.95),
						Position = UDim2.fromScale(0.5, 0.525),
						AnchorPoint = Vector2.new(0.5, 0.5),

						[Children] = {
							scope:New("Frame")({
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(0.4, 0.6),
								Position = UDim2.fromScale(0.5, 0),
								AnchorPoint = Vector2.new(0.5, 0),

								[Children] = {
									scope:New("ImageLabel")({
										BackgroundTransparency = 1,
										SizeConstraint = "RelativeYY",
										Image = "rbxassetid://96096653298506",
										Size = UDim2.fromScale(1.5, 0.8),
										Position = UDim2.fromScale(0, 0.5),
										AnchorPoint = Vector2.new(0, 0.5),
									}),

									scope:New("TextLabel")({
										BackgroundTransparency = 1,
										TextScaled = true,
										Text = "Fueling your drive.",
										TextColor3 = Color3.fromRGB(255, 255, 255),
										Size = UDim2.fromScale(0.5, 1),
										Position = UDim2.fromScale(1, 0.5),
										AnchorPoint = Vector2.new(1, 0.5),
									}),
								},
							}),

							-- scope:New("ImageLabel")({
							-- 	BackgroundTransparency = 1,
							-- 	SizeConstraint = "RelativeYY",
							-- 	Image = "rbxassetid://96096653298506",
							-- 	Size = UDim2.fromScale(1, 0.6),
							-- 	Position = UDim2.fromScale(0.5, 0),
							-- 	AnchorPoint = Vector2.new(0.5, 0),
							-- }),

							-- scope:New("TextLabel")({
							-- 	BackgroundTransparency = 1,
							-- 	TextScaled = true,
							-- 	Text = "Fueling your drive.",
							-- 	TextColor3 = Color3.fromRGB(255, 255, 255),
							-- 	Size = UDim2.fromScale(0.5, 0.2),
							-- 	Position = UDim2.fromScale(0.5, 0.7),
							-- 	AnchorPoint = Vector2.new(0.5, 0.5),
							-- }),

							scope:New("TextLabel")({
								BackgroundTransparency = 1,
								TextScaled = true,
								Text = "Need help? Email us at contact@zemotorsport.net | © 2026 ZéMotorSport. All rights reserved.",
								TextColor3 = Color3.fromRGB(180, 180, 180),
								Size = UDim2.fromScale(0.8, 0.4),
								Position = UDim2.fromScale(0.5, 1),
								AnchorPoint = Vector2.new(0.5, 1),
							}),
						},
					}),
				},
			}),
		},
	})
end

return Background
