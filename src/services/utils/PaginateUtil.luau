local PaginateUtil = {}

--[[
	Função para paginar uma tabela.
	Ela recebe uma tabela, o número de itens por página e a página atual.
	Ela retorna uma tabela com os itens da página atual e informações sobre a paginação.
]]
--

function PaginateUtil.Paginate(array: any, PerPage: number?, page: number?)
	local ItemsPerPage = PerPage or 10
	local CurrentPage = page or 1
	local resultado = {}
	local tableSize = #array
	local maxPage = math.ceil(tableSize / ItemsPerPage)

	if CurrentPage > maxPage then
		CurrentPage = maxPage
	elseif CurrentPage < 1 then
		CurrentPage = 1
	end

	local startIndex = (CurrentPage - 1) * ItemsPerPage + 1
	local endIndex = math.min(startIndex + ItemsPerPage - 1, tableSize)

	local items = {}
	for i = startIndex, endIndex do
		if array[i] then
			table.insert(items, array[i])
		end
	end

	resultado["items"] = items
	resultado["maxPage"] = maxPage
	resultado["currentPage"] = CurrentPage
	resultado["itemsPerPage"] = ItemsPerPage
	resultado["tableSize"] = tableSize
	resultado["startIndex"] = startIndex
	resultado["endIndex"] = endIndex
	resultado["allItemsVisible"] = endIndex - startIndex + 1
	resultado["hasPreviousPage"] = CurrentPage > 1
	resultado["hasNextPage"] = CurrentPage < maxPage

	return resultado
end

return PaginateUtil
