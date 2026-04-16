local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ControllersCoreUtil = require(ReplicatedStorage.Shared.Utils.ControllersCoreUtil)

local CarPageStore = require(ReplicatedStorage.Shared.UIComponents.Site.ZeMotors.CarPage.CarPageStore)
local StateStore = require(ReplicatedStorage.Shared.UIComponents.Site.StateStore)
local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children
local peek = Fusion.peek
local OnEvent = Fusion.OnEvent

local _UIComponents = ReplicatedStorage.Shared.UIComponents

local function PaginateContainer(scope, _props)
	local VisiblePages = scope:Computed(function(use)
		local maxPage = use(CarPageStore.MaxPage)
		local currentPage = use(CarPageStore.Page)
		local hasPreviousPage = use(CarPageStore.HasPreviousPage)
		local hasNextPage = use(CarPageStore.HasNextPage)
		local pages = {}

		if hasPreviousPage and currentPage > 2 then
			table.insert(pages, currentPage - 1)
		end

		table.insert(pages, currentPage)

		if hasNextPage and currentPage < maxPage - 1 then
			table.insert(pages, currentPage + 1)
		end

		return pages
	end)

	local TextSizeValue = scope:Value(14)
	local TextScaledValue = scope:Value(true)

	return scope:New("Frame")({

		BackgroundTransparency = 1,
		SizeConstraint = "RelativeXX",
		Size = UDim2.fromScale(1, 0.1),
		Position = UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),

		[Children] = {
			scope:New("UIListLayout")({
				FillDirection = "Horizontal",
				HorizontalAlignment = "Center",
				VerticalAlignment = "Center",
				Padding = UDim.new(0, 0),
				SortOrder = "LayoutOrder",
			}),

			scope:New("TextButton")({
				LayoutOrder = 0,
				Text = "<",
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.1, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[OnEvent("Activated")] = function()
					if peek(CarPageStore.HasPreviousPage) then
						CarPageStore.Page:set(peek(CarPageStore.Page) - 1)
						-- StateStore.LinkSite:set("www.zemotorsport.net/" .. peek(CarPageStore.Page))

						local DealershipController = ControllersCoreUtil:Get("DealershipController")
						if DealershipController then
							DealershipController:GetCars(CarPageStore)
						end

						print("Voltando a página...")
					end
				end,
			}),

			scope:New("TextButton")({
				LayoutOrder = 1,
				Text = "1",
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = scope:Computed(function(use)
					return use(CarPageStore.Page) == 1 and Color3.fromRGB(150, 150, 150)
						or Color3.fromRGB(255, 255, 255)
				end),
				BackgroundTransparency = 1,
				Visible = scope:Computed(function(use)
					return use(CarPageStore.Page) > 1
				end),

				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[OnEvent("Activated")] = function()
					CarPageStore.Page:set(1)
					-- StateStore.LinkSite:set("www.zemotorsport.net/" .. peek(CarPageStore.Page))

					local DealershipController = ControllersCoreUtil:Get("DealershipController")
					if DealershipController then
						DealershipController:GetCars(CarPageStore)
					end

					print("Voltando a página...")
				end,
			}),

			scope:New("TextLabel")({
				LayoutOrder = 2,
				Text = "...",
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Visible = scope:Computed(function(use)
					return use(CarPageStore.Page) > 3
				end),

				BackgroundTransparency = 1,
				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.1, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}),

			scope:ForValues(VisiblePages, function(use, innerScope, pageNumber)
				local isCurrentPage = use(CarPageStore.Page) == pageNumber

				return innerScope:New("TextButton")({
					LayoutOrder = pageNumber,
					Text = pageNumber,
					TextSize = TextSizeValue,
					TextScaled = TextScaledValue,
					TextColor3 = isCurrentPage and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					SizeConstraint = "RelativeYY",
					Size = UDim2.fromScale(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),

					[OnEvent("Activated")] = function()
						CarPageStore.Page:set(pageNumber)
						-- StateStore.LinkSite:set("www.zemotorsport.net/" .. peek(CarPageStore.Page))

						local DealershipController = ControllersCoreUtil:Get("DealershipController")
						if DealershipController then
							DealershipController:GetCars(CarPageStore)
						end

						print("Voltando a página...")
					end,
				})
			end),

			scope:New("TextLabel")({
				LayoutOrder = scope:Computed(function(use)
					return use(CarPageStore.MaxPage) - 1
				end),
				Text = "...",
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = scope:Computed(function(use)
					return use(CarPageStore.Page) == 1 and Color3.fromRGB(150, 150, 150)
						or Color3.fromRGB(255, 255, 255)
				end),
				BackgroundTransparency = 1,
				Visible = scope:Computed(function(use)
					return use(CarPageStore.Page) < use(CarPageStore.MaxPage) - 2
				end),

				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.1, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}),

			scope:New("TextButton")({
				LayoutOrder = scope:Computed(function(use)
					return use(CarPageStore.MaxPage)
				end),
				Text = CarPageStore.MaxPage,
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = scope:Computed(function(use)
					return use(CarPageStore.Page) == use(CarPageStore.MaxPage) and Color3.fromRGB(150, 150, 150)
						or Color3.fromRGB(255, 255, 255)
				end),
				BackgroundTransparency = 1,
				Visible = scope:Computed(function(use)
					return use(CarPageStore.Page) < use(CarPageStore.MaxPage)
				end),
				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[OnEvent("Activated")] = function()
					CarPageStore.Page:set(peek(CarPageStore.MaxPage))
					-- StateStore.LinkSite:set("www.zemotorsport.net/" .. peek(CarPageStore.Page))

					local DealershipController = ControllersCoreUtil:Get("DealershipController")
					if DealershipController then
						DealershipController:GetCars(CarPageStore)
					end

					print("Voltando a página...")
				end,
			}),

			scope:New("TextButton")({
				LayoutOrder = scope:Computed(function(use)
					return use(CarPageStore.MaxPage) + 1
				end),
				Text = ">",
				TextSize = TextSizeValue,
				TextScaled = TextScaledValue,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				SizeConstraint = "RelativeYY",
				Size = UDim2.fromScale(0.5, 0.5),
				Position = UDim2.fromScale(0.9, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[OnEvent("Activated")] = function()
					if peek(CarPageStore.HasNextPage) then
						CarPageStore.Page:set(peek(CarPageStore.Page) + 1)
						-- StateStore.LinkSite:set("www.zemotorsport.net/" .. peek(CarPageStore.Page))

						local DealershipController = ControllersCoreUtil:Get("DealershipController")
						if DealershipController then
							DealershipController:GetCars(CarPageStore)
						end

						print("Voltando a página...")
					end
				end,
			}),
		},
	})
end

return PaginateContainer
