local ControllersCoreUtil = {
	_controllers = {},
}

-- Método para registrar os controllers usado apenas pelo Loader (init.client.luau)
function ControllersCoreUtil:Register(name, module)
	self._controllers[name] = module
end

-- Método para buscar um controller (usado pela UI do Fusion)
function ControllersCoreUtil:Get(name)
	local controller = self._controllers[name]
	if not controller then
		warn(`--- ERRO --- O Controller '{name}' não foi encontrado ou ainda não foi carregado.`)
	end
	return controller
end

return ControllersCoreUtil
