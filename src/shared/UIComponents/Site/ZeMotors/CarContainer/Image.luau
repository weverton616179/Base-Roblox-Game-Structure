local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

-- local UIComponents = ReplicatedStorage.Shared.UIComponents

local function Image(scope, _props)
	return scope:New("Frame")({
		Name = "ImageCarFrame",
		BackgroundColor3 = Color3.new(0.5, 0.5, 0.5),
		Size = UDim2.fromScale(1, 0.65),
		Position = UDim2.fromScale(0.5, 0.525),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Children] = {
			scope:New("ImageLabel")({
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				Image = _props.CarImage, --"http://www.roblox.com/asset/?id=7790518248",
			}),
		},
	})
end

return Image
