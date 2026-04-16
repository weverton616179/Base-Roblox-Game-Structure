local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local scope = scoped({
	New = Fusion.New,
	Value = Fusion.Value,
})

local function ViewportButton(props)
	return scope:New("ViewportFrame")({

		Size = UDim2.fromScale(0.5, 0.5),

		[Children] = {
			scope:New("ImageButton")({

				Size = UDim2.fromScale(1, 1),

				[OnEvent("Activated")] = function()
					print("Botão com Viewporta ativo")
				end,
			}),
		},
	})
end

return ViewportButton
