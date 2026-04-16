local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.promise)
local StarterPlayer = game:GetService("StarterPlayer")
local ControllersFolder = StarterPlayer.StarterPlayerScripts.Client.Controller

local ControllersCoreUtil = require(ReplicatedStorage.Shared.Utils.ControllersCoreUtil)

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
				ControllersCoreUtil:Register(module.Name, loadedModule)
			else
				warn(
					string.format(
						"--- ERRO --- Falha ao carregar o controller '%s': %s --- ERRO ---",
						module.Name,
						tostring(loadedModule)
					)
				)
			end
		elseif module:IsA("Folder") then
			LoadModules(module)
		end
	end
end

LoadModules(ControllersFolder)

--------------------------------------------------------------------------------
-- 2. Inicialização (:Init) — Paralela + Espera todos terminarem
--------------------------------------------------------------------------------
local initPromises = {} -- array para Promise.allSettled (conforme API oficial)

for name, controller in pairs(controllers) do
	if type(controller.Init) == "function" then
		controller.Controllers = controllers

		-- Esse padrão permite que :Init() retorne uma Promise ou nada
		local initPromise = Promise.try(function()
			local result = controller:Init() -- pode ser valor ou Promise
			return result
		end)
			:andThen(function(result)
				-- Se retornou Promise, encadeia automaticamente
				if Promise.is(result) then
					return result
				end
				return Promise.resolve(result)
			end)
			:catch(function(err)
				warn(`--- ERRO --- Erro crítico no :Init() do controller '{name}': {err} --- ERRO ---`)
			end)

		table.insert(initPromises, initPromise)
	end
end

-- Aguarda TODOS os Inits terminarem (paralelo!) antes de rodar qualquer Start
Promise.allSettled(initPromises):andThen(function()
	print("Todos os controllers tiveram seu :Init() concluído.")

	--------------------------------------------------------------------------------
	-- 3. Execução :Start

	-- O promise.defer basicamente substitui o task.spawn
	--------------------------------------------------------------------------------
	for name, controller in pairs(controllers) do
		if type(controller.Start) == "function" then
			Promise.defer(function()
				local success, err = pcall(controller.Start, controller)
				if not success then
					warn(`--- ERRO --- Erro no :Start() do controller '{name}': {err} --- ERRO ---`)
				end
			end)
		end
	end

	print("Todos os controllers foram iniciados (:Start).")
end)
