local SortByUtil = {}

function SortByUtil.Name(array: any, ascending: boolean?)
	local arraySorted = {}

	if ascending == nil then
		ascending = true
	end

	for _, value in ipairs(array) do
		table.insert(arraySorted, value)
	end

	table.sort(arraySorted, function(a, b)
		local nameA = typeof(a) == "Instance" and a.Name or tostring(a)
		local nameB = typeof(b) == "Instance" and b.Name or tostring(b)

		if ascending then
			return string.lower(nameA) < string.lower(nameB)
		else
			return string.lower(nameA) > string.lower(nameB)
		end
	end)

	return arraySorted
end

local function extractValue(element: any, valueName: string)
	if typeof(element) == "Instance" then
		local child = element:FindFirstChild(valueName)

		if child and child:IsA("ValueBase") then
			return child.Value
		end
	elseif type(element) == "table" then
		return element[valueName]
	end

	return nil
end

--[[
	Função para ordenar uma tabela por um valor.
	Ela recebe uma tabela ou instancia, o nome do valor e se a ordenação é ascendente.
    Retorna uma tabela com os itens ordenados.

    No caso de instancia ele procura com um FindFirstChild o nome do valor, e funcionara
    somente se o filho for da classe ValueBase. ou seja, ele tem que ter uma propriedade
    Value, como NumberValue, StringValue, etc.

    No caso de tabela, ele procura a chave com o nome do valor dentro da tabela apenas na primeira camada.
]]
--

function SortByUtil.Value(array: any, valueName: string, ascending: boolean?)
	local arraySorted = {}

	if ascending == nil then
		ascending = true
	end

	for _, value in ipairs(array) do
		table.insert(arraySorted, value)
	end

	table.sort(arraySorted, function(a, b)
		local valA = extractValue(a, valueName)
		local valB = extractValue(b, valueName)

		if valA == nil then
			valA = ""
		end
		if valB == nil then
			valB = ""
		end

		if type(valA) ~= type(valB) then
			valA = tostring(valA)
			valB = tostring(valB)
		end

		if type(valA) == "string" then
			if ascending then
				return string.lower(valA) < string.lower(valB)
			else
				return string.lower(valA) > string.lower(valB)
			end
		end

		if ascending then
			return valA < valB
		else
			return valA > valB
		end
	end)

	return arraySorted
end

return SortByUtil
