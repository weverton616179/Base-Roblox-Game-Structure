local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CameraUtil = require(ReplicatedStorage.Shared.Utils.CameraUtil)
local UIComponents = ReplicatedStorage.Shared.UIComponents
local Store = require(UIComponents.Site.StateStore)

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local function ExitButton(scope, _props)
	local isPressed = scope:Value(false)

	local shadowColor = scope:Computed(function(use)
		return use(isPressed) and Color3.fromRGB(120, 120, 120) or Color3.fromRGB(160, 160, 160)
	end)

	local iconColor = scope:Computed(function(use)
		return use(isPressed) and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(71, 71, 71)
	end)

	local gradientColors = scope:Computed(function(use)
		if use(isPressed) then
			return ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 170, 170)),
				ColorSequenceKeypoint.new(0.7, Color3.fromRGB(210, 210, 210)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 210, 210)),
			})
		else
			return ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 210, 210)),
				ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})
		end
	end)

	return scope:New("Frame")({
		Name = "ExitButtonFrame",
		BackgroundColor3 = shadowColor, -- Color3.fromRGB(160, 160, 160),
		Size = UDim2.fromScale(0.1, 0.6),
		Position = UDim2.fromScale(0.8, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("UICorner")({
				CornerRadius = UDim.new(0.3, 0),
			}),

			scope:New("Frame")({
				BackgroundColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(1, -3, 1, -3),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				[Children] = {
					scope:New("ImageLabel")({
						ZIndex = 2,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(0.8, 0.8),
						SizeConstraint = "RelativeYY",
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),

						Image = "rbxassetid://6264845452",
						ImageColor3 = iconColor, -- Color3.fromRGB(71, 71, 71),
					}),

					scope:New("ImageButton")({
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 3,

						[OnEvent("Activated")] = function()
							print("sair")
							scope:doCleanup()
							CameraUtil:Restore(1)
							task.wait(1)
							Store.IsOpen = false
						end,

						[OnEvent("MouseButton1Down")] = function()
							isPressed:set(true)
						end,

						[OnEvent("MouseButton1Up")] = function()
							isPressed:set(false)
						end,

						[OnEvent("MouseLeave")] = function()
							isPressed:set(false)
						end,
					}),

					scope:New("UICorner")({
						CornerRadius = UDim.new(0.3, 0),
					}),

					scope:New("UIGradient")({
						Color = gradientColors,
						Rotation = -90,
					}),
				},
			}),
		},
	})
end

return ExitButton
