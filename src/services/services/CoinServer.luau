local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Importar o módulo gerado pelo Blink (Ajuste o caminho conforme seu projeto)
local Blink = require(ReplicatedStorage.Shared.Network.coin.server)
local CoinFormatter = require(ReplicatedStorage.Shared.Utils.CoinUtil)

local CoinService = {}
local playerCoins = {} -- Tabela simples para salvar moedas em memória { [UserId] = amount }

function CoinService.Init()
	print("CoinService Iniciado")

	-- Escutar quando um jogador entra
	Players.PlayerAdded:Connect(function(player)
		-- Carregar dados (aqui seria um DataStore, vamos usar 0 por padrão)
		playerCoins[player.UserId] = 100

		-- Enviar dados iniciais (opcional se usar o RequestCoins)
		task.wait(1) -- Pequeno delay para garantir carregamento
		CoinService.SetCoins(player, 100)
	end)

	Players.PlayerRemoving:Connect(function(player)
		playerCoins[player.UserId] = nil
	end)

	-- Escutar solicitação do cliente via Blink
	Blink.RequestCoins.On(function(player)
		local amount = playerCoins[player.UserId] or 0
		-- Responde apenas para aquele jogador
		Blink.UpdateCoins.Fire(player, amount)
	end)
end

function CoinService:Start()
	print("coin service iniciado")
end

-- Método para alterar moedas
function CoinService.AddCoins(player: Player, amount: number)
	local userId = player.UserId
	local current = playerCoins[userId] or 0
	local newAmount = current + amount

	CoinService.SetCoins(player, newAmount)
end

-- Método interno para setar e replicar
function CoinService.SetCoins(player: Player, amount: number)
	playerCoins[player.UserId] = amount

	print("Novo saldo para " .. player.Name .. ": " .. CoinFormatter.Format(amount))

	-- AQUI O BLINK BRILHA: Envia o dado comprimido e tipado
	Blink.UpdateCoins.Fire(player, amount)
end

return CoinService
