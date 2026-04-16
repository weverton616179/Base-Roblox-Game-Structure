local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ControllersCoreUtil = require(ReplicatedStorage.Shared.Utils.ControllersCoreUtil)

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local peek = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion.State.peek)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local UIComponents = ReplicatedStorage.Shared.UIComponents
local CarPageStore = require(UIComponents.Site.ZeMotors.CarPage.CarPageStore)

local function FilterButton(scope, _props)
	return scope:New("Frame")({
		BackgroundColor3 = Color3.fromRGB(100, 0, 0),
		SizeConstraint = "RelativeXX",
		Size = UDim2.fromScale(0.25, 0.055),
		Position = UDim2.fromScale(0.975, 0.545),
		AnchorPoint = Vector2.new(1, 0),

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
							ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 0, 0)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 5, 5)),
						}),
						Rotation = -90,
					}),

					scope:New("UICorner")({
						CornerRadius = UDim.new(0.1, 0),
					}),

					scope:New("TextLabel")({
						Size = UDim2.fromScale(0.6, 0.8),
						Position = UDim2.fromScale(0.1, 0.5),
						AnchorPoint = Vector2.new(0, 0.5),

						Text = scope:Computed(function(use)
							return "Filter by " .. tostring(use(CarPageStore.SortBy))
						end),

						TextSize = 27,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
					}),

					scope:New("TextLabel")({
						Size = UDim2.fromScale(0.3, 0.8),
						Position = UDim2.fromScale(0.9, 0.45),
						AnchorPoint = Vector2.new(0.5, 0.5),

						Text = scope:Computed(function(use)
							return use(CarPageStore.SortByAscending) and "↑" or "↓"
						end),

						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
					}),

					scope:New("ImageButton")({
						Size = UDim2.fromScale(1, 1),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),

						BackgroundTransparency = 1,
						ZIndex = 2,

						[OnEvent("MouseButton1Click")] = function()
							print("clicado", peek(CarPageStore.SortBy), peek(CarPageStore.SortByAscending))
							if peek(CarPageStore.SortBy) == "Name" and peek(CarPageStore.SortByAscending) == true then
								CarPageStore.SortByAscending:set(false)
							elseif
								peek(CarPageStore.SortBy) == "Name"
								and peek(CarPageStore.SortByAscending) == false
							then
								CarPageStore.SortBy:set("Price")
								CarPageStore.SortByAscending:set(true)
							elseif
								peek(CarPageStore.SortBy) == "Price"
								and peek(CarPageStore.SortByAscending) == true
							then
								CarPageStore.SortByAscending:set(false)
							elseif
								peek(CarPageStore.SortBy) == "Price"
								and peek(CarPageStore.SortByAscending) == false
							then
								CarPageStore.SortBy:set("Name")
								CarPageStore.SortByAscending:set(true)
							end

							local DealershipController = ControllersCoreUtil:Get("DealershipController")
							if DealershipController then
								DealershipController:GetCars(CarPageStore)
							end
						end,
					}),
				},
			}),
		},
	})
end

return FilterButton
