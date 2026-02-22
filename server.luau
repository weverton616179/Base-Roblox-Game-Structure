local StarterPlayer = game:GetService("StarterPlayer")
local ControllersFolder = StarterPlayer.StarterPlayerScripts.Client.Controller

local controllers = {}

--------------------------------------------------------------------------------
-- 1. Carregamento (Require)
--------------------------------------------------------------------------------
-- Carrega todos os ModuleScripts dentro da pasta e armazena na tabela 'controller'

local function LoadModules(pasta)
	for _, module in ipairs(pasta:GetChildren()) do
		if module:IsA("ModuleScript") then
			local success, loadedModule = pcall(require, module)

			if success then
				controllers[module.Name] = loadedModule
			else
				warn(string.format("❌ Falha ao carregar o controller '%s': %s", module.Name, tostring(loadedModule)))
			end
		elseif module:IsA("Folder") then
			LoadModules(module)
		end
	end
end

LoadModules(ControllersFolder)

--------------------------------------------------------------------------------
-- 2. Inicialização (:Init)
--------------------------------------------------------------------------------
-- O Init geralmente é síncrono para configurar estados antes do jogo começar
for name, controller in pairs(controllers) do
	if type(controller.Init) == "function" then
		local success, err = pcall(function()
			controller.Controllers = controllers
			controller:Init()
		end)

		if not success then
			warn(string.format("⚠️ Erro no :Init() do controller '%s': %s", name, tostring(err)))
		end
	end
end

--------------------------------------------------------------------------------
-- 3. Execução (:Start)
--------------------------------------------------------------------------------
-- O Start é executado em threads separadas (task.spawn) para que um serviço
-- que use loops ou yields não bloqueie os outros.
for name, controller in pairs(controllers) do
	if type(controller.Start) == "function" then
		task.spawn(function()
			local success, err = pcall(function()
				controller:Start()
			end)

			if not success then
				warn(string.format("⚠️ Erro no :Start() do serviço '%s': %s", name, tostring(err)))
			end
		end)
	end
end

print("✅ Todos os controllers do servidor foram carregados e iniciados.")
