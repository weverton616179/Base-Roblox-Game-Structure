local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages[".pesde"]["elttob_fusion@0.3.0"].fusion)
local Children = Fusion.Children

local function PageNotFound(scope, _props)
	return scope:New("Frame")({
		Name = "PageNotFound",
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BorderSizePixel = 0,

		[Children] = {
			scope:New("UIGradient")({
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(205, 205, 205)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 235, 235)),
				}),
				Rotation = -90,
			}),

			-- Centraliza os itens na tela
			scope:New("UIListLayout")({
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0.02, 0),
			}),

			-- Ícone pequeno no meio em cima
			scope:New("ImageLabel")({
				Name = "ErrorIcon",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.12, 0.12),
				Image = "rbxassetid://403653614",
				ImageColor3 = Color3.fromRGB(71, 71, 71),
				LayoutOrder = 1,

				[Children] = {
					scope:New("UIAspectRatioConstraint")({
						AspectRatio = 1,
					}),
				},
			}),

			-- Título de Erro 404
			scope:New("TextLabel")({
				Name = "Title404",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.6, 0.15),
				TextScaled = true,
				Font = Enum.Font.GothamBlack,
				Text = "404",
				TextColor3 = Color3.fromRGB(71, 71, 71),
				LayoutOrder = 2,

				[Children] = {
					scope:New("UITextSizeConstraint")({
						MaxTextSize = 100,
					}),
				},
			}),

			-- Subtítulo
			scope:New("TextLabel")({
				Name = "Subtitle",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.8, 0.05),
				TextScaled = true,
				Font = Enum.Font.GothamMedium,
				Text = "Página não encontrada",
				TextColor3 = Color3.fromRGB(71, 71, 71),
				LayoutOrder = 3,

				[Children] = {
					scope:New("UITextSizeConstraint")({
						MaxTextSize = 24,
					}),
				},
			}),

			-- Descrição
			scope:New("TextLabel")({
				Name = "Description",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.9, 0.05),
				TextScaled = true,
				Font = Enum.Font.Gotham,
				Text = "O conteúdo que você está procurando não existe ou não está disponível.",
				TextColor3 = Color3.fromRGB(71, 71, 71),
				LayoutOrder = 4,

				[Children] = {
					scope:New("UITextSizeConstraint")({
						MaxTextSize = 16,
					}),
					scope:New("UIPadding")({
						PaddingTop = UDim.new(0.01, 0),
					}),
				},
			}),
		},
	})
end

return PageNotFound
