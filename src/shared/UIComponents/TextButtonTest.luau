local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
-- local scoped = Fusion.scoped
local peek = Fusion.peek

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- local scope = scoped({
-- 	New = Fusion.New,
-- 	Value = Fusion.Value,
-- })

local function TextButtonTest(
	scope,
	props: { -- tipagem não é realmente necessária
		BackgroundColor3: Color3?,
		Counter: Fusion.Value<number>?,
		Size: UDim2?,
	}
)
	local counter = props.Counter or scope:Value(0)

	return scope:New("TextButton")({
		Text = counter,
		TextScaled = true,
		BackgroundColor3 = props.BackgroundColor3 or Color3.new(0, 1, 0),

		Size = props.Size or UDim2.fromScale(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[OnEvent("Activated")] = function()
			counter:set(peek(counter) + 1)
		end,

		[Children] = {
			scope:New("UICorner")({
				CornerRadius = UDim.new(0, 10),
			}),
		},
	})
end

return TextButtonTest
