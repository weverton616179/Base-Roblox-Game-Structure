local Players = game:GetService("Players")

-- estrutura padrão de um service, essa estrutura deve ser usada nos services (servidor) e controllers (cliente)
-- no caso dos Utils (replicated storage), essa estrutura não é necessária, o Util pode ser apenas um module normal.
local TesteDataService = {}

-- lógica para carregar o serviço, preparando suas estruturas internas para o Start
function TesteDataService.Init(self: TesteDataService)
	print("carregando serviço")
	self.nome = "teste"
end

-- lógica que dá o start ao serviço, esse método apenas será chamado quando todos os services executarem seus inits
-- caso o serviço utilize outros serviços, eles devem ser carregados a partir daqui
function TesteDataService:Start()
	print("serviço carregou", self.nome)
	local ProfileService = self.Services.ProfileService
	local GarageProfileService = self.Services.GarageProfileService

	local function TestePrintData(Player)
		task.spawn(function()
			local num = 0
			while true do
				task.wait(1)

				if num == 6 then
					GarageProfileService:DeleteProfile(Player)
					num = 0
				else
					num += 1
				end

				local profile = ProfileService:WaitForProfile(Player)

				if profile and profile["Data"] then
					local Data = profile["Data"]
					Data["Cash"] += 1
					Data["testezim"] = "testezim"
					print(Player, profile["Data"])
				else
					TesteDataService:Print("ainda sem data")
				end
			end
		end)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		TestePrintData(player)
	end

	Players.PlayerAdded:Connect(TestePrintData)
end

function TesteDataService:Print(variavel)
	print("--TESTE--", variavel, "--TESTE--")
end

-- A estrutura do typeof, e com o init com "." ao invés de ":" é interessante pois facilita no auto complete, mas ao mesmo tempo mão é obrigatorio
type TesteDataService = typeof(TesteDataService)

return TesteDataService
