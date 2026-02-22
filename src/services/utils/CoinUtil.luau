local CoinFormatter = {}

-- Função para formatar números grandes (ex: 1500 -> 1.5k)
function CoinFormatter.Format(amount: number): string
	if amount >= 1000 then
		return string.format("%.1fk", amount / 1000)
	else
		return tostring(amount)
	end
end

return CoinFormatter
