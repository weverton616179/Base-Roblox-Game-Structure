local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local OnEvent = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion.Instances.OnEvent)
local CarPageStore = require(ReplicatedStorage.Shared.UIComponents.Site.ZeMotors.CarPage.CarPageStore)
local ControllersCoreUtil = require(ReplicatedStorage.Shared.Utils.ControllersCoreUtil)
local Children = Fusion.Children

local UIComponents = ReplicatedStorage.Shared.UIComponents
local StateStore = require(UIComponents.Site.StateStore)
local CarContainer = UIComponents.Site.ZeMotors.CarContainer
local CarTitle = require(CarContainer.Title)
local CarImage = require(CarContainer.Image)
local CarNameAndPrice = require(CarContainer.NameAndPrice)

local function Container(scope, _props)
	local carData = _props.CarData
	local transparency = scope:Value(1)
	local animatedTransparency =
		scope:Tween(transparency, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

	task.defer(function()
		transparency:set(0)
	end)

	return scope:New("CanvasGroup")({
		GroupTransparency = animatedTransparency,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("Frame")({
				BackgroundColor3 = Color3.new(1, 1, 1),
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[Children] = {
					scope:New("UICorner")({
						CornerRadius = UDim.new(0, 3),
					}),

					scope:New("UIGradient")({
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 15, 15)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160)),
						}),
						Rotation = 135,
					}),

					scope:New("Frame")({
						BackgroundColor3 = Color3.new(1, 1, 1),
						Size = UDim2.new(1, -3, 1, -3),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),

						[Children] = {
							scope:New("UICorner")({
								CornerRadius = UDim.new(0, 3),
							}),

							scope:New("ImageButton")({
								Name = "CarButton",
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 1),
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5),
								ZIndex = 2,

								[OnEvent("MouseButton1Click")] = function()
									print("Car clicked", carData.Name)
									StateStore.CurrentPage:set("ZeMotorsCarPage")
									StateStore.LinkSite:set("www.zemotorsport.net/" .. carData.Name)

									CarPageStore.Page:set(1)
									local DealershipController = ControllersCoreUtil:Get("DealershipController")
									if DealershipController then
										DealershipController:GetCars(CarPageStore)
									end
								end,
							}),

							CarTitle(scope, {}),
							CarImage(scope, { CarImage = carData.Image }),
							CarNameAndPrice(
								scope,
								{ CarName = carData.Name, CarPrice = carData.Price, CarPurchased = carData.Purchased }
							),
						},
					}),
				},
			}),
		},
	})
end

return Container
