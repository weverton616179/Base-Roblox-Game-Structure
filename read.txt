local ServerScriptService = game:GetService("ServerScriptService")
local ServicesFolder = ServerScriptService.Server.Services

local services = {}

--------------------------------------------------------------------------------
-- 1. Carregamento (Require)
--------------------------------------------------------------------------------
-- Carrega todos os ModuleScripts dentro da pasta e armazena na tabela 'services'

local function LoadModules(pasta)
	for _, module in ipairs(pasta:GetChildren()) do
		if module:IsA("ModuleScript") then
			local success, loadedModule = pcall(require, module)

			if success then
				services[module.Name] = loadedModule
			else
				warn(string.format("❌ Falha ao carregar o serviço '%s': %s", module.Name, tostring(loadedModule)))
			end
		elseif module:IsA("Folder") then
			LoadModules(module)
		end
	end
end

LoadModules(ServicesFolder)

--------------------------------------------------------------------------------
-- 2. Inicialização (:Init)
--------------------------------------------------------------------------------
-- O Init geralmente é síncrono para configurar estados antes do jogo começar
for name, service in pairs(services) do
	if type(service.Init) == "function" then
		local success, err = pcall(function()
			service.Services = services
			service:Init()
		end)

		if not success then
			warn(string.format("⚠️ Erro no :Init() do serviço '%s': %s", name, tostring(err)))
		end
	end
end

--------------------------------------------------------------------------------
-- 3. Execução (:Start)
--------------------------------------------------------------------------------
-- O Start é executado em threads separadas (task.spawn) para que um serviço
-- que use loops ou yields não bloqueie os outros.
for name, service in pairs(services) do
	if type(service.Start) == "function" then
		task.spawn(function()
			local success, err = pcall(function()
				service:Start()
			end)

			if not success then
				warn(string.format("⚠️ Erro no :Start() do serviço '%s': %s", name, tostring(err)))
			end
		end)
	end
end

print("✅ Todos os serviços do servidor foram carregados e iniciados.")
