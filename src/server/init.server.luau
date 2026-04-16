local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.promise)
local ServerScriptService = game:GetService("ServerScriptService")
local ServicesFolder = ServerScriptService.Server.Services

local services = {}

--------------------------------------------------
-- 1. Carregamento (Require)
--------------------------------------------------
-- Carrega todos os ModuleScripts dentro da pasta e armazena na tabela 'services'

local function LoadModules(pasta)
	for _, module in ipairs(pasta:GetChildren()) do
		if module:IsA("ModuleScript") then
			local success, loadedModule = pcall(require, module)

			if success then
				services[module.Name] = loadedModule
			else
				warn(
					string.format(
						"--- ERRO --- Falha ao carregar o serviço '%s': %s --- ERRO ---",
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

LoadModules(ServicesFolder)

--------------------------------------------------
-- 2. Inicialização :Init

-- Atualmente o código inicia de forma assincrona todos os init utilizando a biblioteca
-- evaera/Promise, podendo executar varios Init ao mesmo tempo, porém o código só passará
-- para o passo 3 quando todos os inits tiverem terminado de carregar ou dar erro
--------------------------------------------------
local initPromises = {}

for name, service in pairs(services) do
	if type(service.Init) == "function" then
		service.Services = services

		local initPromise = Promise.try(function()
			local result = service:Init()
			return result
		end)
			:andThen(function(result)
				if Promise.is(result) then
					return result
				end
				return Promise.resolve(result)
			end)
			:catch(function(err)
				warn(`--- ERRO --- Erro crítico no :Init() do services '{name}': {err} --- ERRO ---`)
			end)

		table.insert(initPromises, initPromise)
	end
end

Promise.allSettled(initPromises):andThen(function()
	print("Todos os services tiveram seu :Init() concluído.")

	--------------------------------------------------------------------------------
	-- 3. Execução :Start

	-- O promise.defer basicamente substitui o task.spawn
	--------------------------------------------------------------------------------
	for name, service in pairs(services) do
		if type(service.Start) == "function" then
			Promise.defer(function()
				local success, err = pcall(service.Start, service)
				if not success then
					warn(`--- ERRO --- Erro no :Start() do service '{name}': {err} --- ERRO ---`)
				end
			end)
		end
	end

	print("Todos os services foram iniciados (:Start).")
end)
