local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local ControllersCoreUtil = require(ReplicatedStorage.Shared.Utils.ControllersCoreUtil)
local Children = Fusion.Children

local UIComponents = ReplicatedStorage.Shared.UIComponents
local CarPageStore = require(UIComponents.Site.ZeMotors.CarPage.CarPageStore)
local FilterButton = require(UIComponents.Site.ZeMotors.CarPage.FilterButton)
local PaginateContainer = require(UIComponents.Site.ZeMotors.CarPage.PaginateContainer)
local CarContainer = require(UIComponents.Site.ZeMotors.CarContainer.Container)

local function ElementsContainer(scope, _props)
	local DealershipController = ControllersCoreUtil:Get("DealershipController")
	if DealershipController then
		DealershipController:GetCars(CarPageStore)
	end

	return scope:New("Frame")({
		ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(60, 15, 15),
		Name = "ElementsContainerFrame",
		Size = UDim2.fromScale(0.85, 0.8),
		Position = UDim2.fromScale(0.5, 0.51),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BorderColor3 = Color3.fromRGB(200, 0, 0),
		BorderSizePixel = 1,

		[Children] = {

			-- scope:New("UIListLayout")({
			-- 	FillDirection = "Vertical",
			-- 	Wraps = true,
			-- 	Padding = UDim.new(0.01, 0),
			-- 	HorizontalAlignment = "Center",
			-- 	VerticalAlignment = "Top",
			-- }),

			scope:New("Frame")({
				BackgroundColor3 = Color3.fromRGB(200, 0, 0),
				SizeConstraint = "RelativeXX",
				Size = UDim2.fromScale(0.95, 0.75),
				Position = UDim2.fromScale(0.5, 0.02),
				AnchorPoint = Vector2.new(0.5, 0),

				[Children] = {
					scope:New("Frame")({
						Name = "InfoFrame",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.fromScale(1, 0.1),
						Position = UDim2.fromScale(0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0),

						[Children] = {
							scope:New("Frame")({
								Name = "MarcaFrame",
								BackgroundColor3 = Color3.fromRGB(255, 255, 0),
								Size = UDim2.fromScale(0.3, 1),
								Position = UDim2.fromScale(0, 0.5),
								AnchorPoint = Vector2.new(0, 0.5),

								[Children] = {
									scope:New("ImageLabel")({
										Name = "MarcaImage",
										Image = "rbxassetid://403653614",
										-- BackgroundTransparency = 1,
										BackgroundColor3 = Color3.fromRGB(0, 0, 0),
										Size = UDim2.fromScale(0.3, 1),
										Position = UDim2.fromScale(0, 0.5),
										AnchorPoint = Vector2.new(0, 0.5),
									}),

									scope:New("TextLabel")({
										Name = "MarcaText",
										Text = "Marca",
										TextXAlignment = "Left",
										BackgroundColor3 = Color3.fromRGB(0, 255, 255),
										Size = UDim2.fromScale(0.6, 1),
										Position = UDim2.fromScale(1, 0.5),
										AnchorPoint = Vector2.new(1, 0.5),
									}),
								},
							}),

							scope:New("TextLabel")({
								Name = "PrecoLabel",
								Text = "$100.000",
								TextXAlignment = "Right",
								BackgroundColor3 = Color3.fromRGB(0, 255, 255),
								Size = UDim2.fromScale(0.3, 1),
								Position = UDim2.fromScale(1, 0.5),
								AnchorPoint = Vector2.new(1, 0.5),
							}),
						},
					}),

					scope:New("Frame")({
						Name = "CarConfigsAndDetailsFrame",
						BackgroundColor3 = Color3.fromRGB(255, 100, 255),
						Size = UDim2.fromScale(0.4, 0.9),
						Position = UDim2.fromScale(0, 0.1),
						AnchorPoint = Vector2.new(0, 0),

						[Children] = {
							scope:New("UIListLayout")({
								FillDirection = "Vertical",
								Wraps = true,
								Padding = UDim.new(0.01, 0),
								HorizontalAlignment = "Center",
								VerticalAlignment = "Top",
							}),

							scope:New("TextLabel")({
								Name = "1CarDescriptionText",
								Text = "Currus modernus est vehiculum velocitatis et elegantiae, ex metallis robustis et materiis levibus constructum. Lineae eius aerodynamicae sunt, ad resistentiam aeris minuendam et efficientiam augendam. Intra, sedilia commoda et technologiae provectae inveniuntur, quae iter iucundum ac securum praestant. Motor potentiam magnam generat, dum systemata tutelae vitam vectorum defendunt. Ita currus non solum instrumentum transportationis est, sed etiam symbolum progressionis et ingenii humani.",
								TextXAlignment = "Left",
								TextWrapped = true,
								BackgroundColor3 = Color3.fromRGB(0, 255, 255),
								Size = UDim2.fromScale(1, 0.4),
							}),

							scope:New("Frame")({
								Name = "2CarColorFrame",
								BackgroundColor3 = Color3.fromRGB(0, 255, 255),
								Size = UDim2.fromScale(1, 0.2),
							}),

							scope:New("Frame")({
								Name = "3CarStatsFrame",
								BackgroundColor3 = Color3.fromRGB(0, 255, 255),
								Size = UDim2.fromScale(1, 0.2),
							}),

							scope:New("Frame")({
								Name = "4CarBuyButtonFrame",
								BackgroundColor3 = Color3.fromRGB(0, 255, 255),
								Size = UDim2.fromScale(1, 0.1),
							}),
						},
					}),

					scope:New("Frame")({
						Name = "CarImagesFrame",
						BackgroundColor3 = Color3.fromRGB(0, 255, 100),
						Size = UDim2.fromScale(0.6, 0.9),
						Position = UDim2.fromScale(0.4, 0.1),
						AnchorPoint = Vector2.new(0, 0),

						[Children] = {
							scope:New("UIListLayout")({
								FillDirection = "Horizontal",
								Wraps = true,
								Padding = UDim.new(0.01, 0),
								HorizontalAlignment = "Center",
								VerticalAlignment = "Top",
							}),

							scope:New("ImageLabel")({
								Name = "CarImage",
								Image = "rbxassetid://20693027",
								SizeConstraint = "RelativeXX",
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								Size = UDim2.fromScale(0.95, 0.534375), -- 0,5625 16:9
							}),

							scope:New("ImageLabel")({
								Name = "CarImage",
								Image = "rbxassetid://6529144534",
								SizeConstraint = "RelativeXX",
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								Size = UDim2.fromScale(0.475, 0.475),
							}),

							scope:New("ImageLabel")({
								Name = "CarImage",
								Image = "rbxassetid://128812549",
								SizeConstraint = "RelativeXX",
								BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								Size = UDim2.fromScale(0.475, 0.475),
							}),
						},
					}),
				},
			}),

			scope:New("TextLabel")({
				BackgroundTransparency = 1,
				Text = "NEW ARRIVALS",
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),

				SizeConstraint = "RelativeXX",
				Size = UDim2.fromScale(0.25, 0.09),
				Position = UDim2.fromScale(0.025, 0.53),
				AnchorPoint = Vector2.new(0, 0),
			}),

			FilterButton(scope, {}),

			scope:New("Frame")({
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.98, 0.4),
				Position = UDim2.fromScale(0.5, 1),
				AnchorPoint = Vector2.new(0.5, 1),

				[Children] = {
					scope:New("UIGridLayout")({
						CellSize = UDim2.fromScale(0.31, 0.37),
						HorizontalAlignment = "Center",
						CellPadding = UDim2.fromScale(0.02, 0.035),
					}),

					scope:ForValues(CarPageStore.Items, function(_use, innerScope, car)
						return CarContainer(innerScope, { CarData = car })
					end),
				},
			}),

			PaginateContainer(scope, {}),
		},
	})
end

return ElementsContainer
