local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local UIComponents = ReplicatedStorage.Shared.UIComponents
local HeadereFrame = require(UIComponents.Site.Header.Frame)
local StateStore = require(UIComponents.Site.StateStore)
local ZeMotorsIndex = require(UIComponents.Site.ZeMotors.Index)
local ZeMotorsCarPage = require(UIComponents.Site.ZeMotors.CarPage.Index)
local PageNotFound = require(UIComponents.Site.PageNotFound)

local function Frame(scope, _props)
	return scope:New("Frame")({
		Name = "Body",
		BackgroundColor3 = _props.BackgroundColor3 or Color3.new(1, 1, 1),
		Size = _props.Size or UDim2.fromScale(1, 1),
		Position = _props.Position or UDim2.fromScale(0, 0),
		AnchorPoint = _props.AnchorPoint or Vector2.new(0, 0),

		[Children] = {
			HeadereFrame(scope, {}),

			scope:New("Frame")({
				Name = "Nav",
				BackgroundColor3 = Color3.fromRGB(210, 210, 210),
				Size = UDim2.fromScale(1, 0.92),
				Position = UDim2.fromScale(0, 0.08),

				[Children] = scope:Computed(function(use, innerScope)
					local currentPage = use(StateStore.CurrentPage)
					if currentPage == "ZeMotors" then
						return { ZeMotorsIndex(innerScope, _props) }
					elseif currentPage == "ZeMotorsCarPage" then
						return { ZeMotorsCarPage(innerScope, _props) }
					end

					return { PageNotFound(innerScope, _props) }
				end),
			}),
		},
	})
end

return Frame
