-- estrutura padrão de um service, essa estrutura deve ser usada nos services (servidor) e controllers (cliente)
-- no caso dos Utils (replicated storage), essa estrutura não é necessária, o Util pode ser apenas um module normal.
local TesteService = {}

-- lógica para carregar o serviço, preparando suas estruturas internas para o Start
function TesteService.Init(self: TesteService)
	print("carregando serviço")
	self.nome = "teste"
end

-- lógica que dá o start ao serviço, esse método apenas será chamado quando todos os services executarem seus inits
-- caso o serviço utilize outros serviços, eles devem ser carregados a partir daqui
function TesteService:Start()
	-- como importar outros services/controllers
	local AlgumService = self.Services.AlgumService
	local AlgumController = self.Controllers.AlgumController
	-- outra maneira de importar
	self.AlgumService = self.Services.AlgumService

	print("serviço carregou")
end

-- A estrutura do typeof, e com o init com "." ao invés de ":" é interessante pois facilita no auto complete, mas ao mesmo tempo mão é obrigatorio
type TesteService = typeof(TesteService)

return TesteService
