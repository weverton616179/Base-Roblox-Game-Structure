local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Importar o módulo gerado pelo Blink (Versão Client)
local Blink = require(ReplicatedStorage.Shared.Network.coin.client)
local CoinFormatter = require(ReplicatedStorage.Shared.Utils.CoinUtil)

local CoinController = {}

function CoinController.Init()
	print("CoinController Iniciado")

	-- 1. Escutar atualizações vindas do servidor
	Blink.UpdateCoins.On(function(amount)
		CoinController.UpdateUI(amount)
	end)

	-- 2. Pedir dados iniciais assim que carregar
	Blink.RequestCoins.Fire()
end

function CoinController:Start()
	local TesteController = self.Controllers.TesteController

	TesteController:Print("teste print em coins no start cliente")
end

function CoinController.UpdateUI(amount: number)
	local formatted = CoinFormatter.Format(amount)
	print("Cliente recebeu atualização de moedas: " .. formatted)

	-- Exemplo hipotético de atualização de UI
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)
	if playerGui then
		local coinLabel = playerGui:FindFirstChild("CoinLabel", true) -- Busca recursiva
		if coinLabel and coinLabel:IsA("TextLabel") then
			coinLabel.Text = "Coins: " .. formatted
		end
	end
end

return CoinController
