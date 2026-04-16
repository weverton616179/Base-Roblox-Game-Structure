local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CarsFolder = ReplicatedStorage.teste -- Shared.Assets.Cars
local DealershipNetwork = require(ReplicatedStorage.Shared.Network.dealership.server)

-- Utils
local SortByUtil = require(ReplicatedStorage.Shared.Utils.SortByUtil)
local PaginateUtil = require(ReplicatedStorage.Shared.Utils.PaginateUtil)

local DealershipService = {}

function DealershipService.Init(self: DealershipService)
	print("carregando DealershipService")
	self.nome = "teste"
end

function DealershipService:Start()
	self.GarageProfileService = self.Services.GarageProfileService
	self.ProfileService = self.Services.ProfileService -- até o momento o cash está salvo na raiz do profile, por conta disto estou puxando o profile. Certamente isso vai ser alterado, portanto lembre-se de alterar aqui também! incluindo os metodos de compra e venda

	task.spawn(function()
		DealershipNetwork.GetCars.On(function(Player, Data)
			return self:GetCars(Player, Data.Page, Data.PerPage, Data.SortBy, Data.SortByAscending)
		end)
	end)

	print("DealershipService carregou")
end

function DealershipService:BuyCar(player, carName, config)
	local profile = self.ProfileService:WaitForProfile(player)
	local cash = profile["Data"]["Cash"]
	local garageProfile = self.GarageProfileService:GetProfile(player)
	local car = ReplicatedStorage.Shared.Assets.Cars:FindFirstChild(carName)
	local price = car:FindFirstChild("Price")

	if not garageProfile or not profile then
		print(player, "sem profile")
		return
	end
	if garageProfile[carName] then
		print(player, "já tem o carro", carName)
		return
	end
	if not car then
		print("carro", carName, "não existe")
		return
	end
	if not price then
		print("carro", carName, "sem preço")
		price = 0
	else
		price = price.Value
		print("preço do carro", price)
	end
	if not cash then
		price(player, "não tem o atributo Cash em sua data")
		return
	end
	if cash < price then
		price(player, "não tem o dinheiro necessário para o carro")
		return
	end

	profile["Data"]["Cash"] -= price
	self.GarageProfileService:AddCar(player, carName, config)
	return true
end

-- metodo de comprar, recebendo o nome do carro e player como parametro, verificar se ele já tem o carro, verificar se o carro realmente existe
-- lembrar de fazer o metodo de compra do carro com o parametro opcional de cor, para que passo a pessoa queira passar a cor ela possa

function DealershipService:SellCar(player, carName)
	local profile = self.ProfileService:WaitForProfile(player)
	local cash = profile["Data"]["Cash"]
	local garageProfile = self.GarageProfileService:GetProfile(player)
	local car = ReplicatedStorage.Shared.Assets.Cars:FindFirstChild(carName)
	local price = car:FindFirstChild("Price")

	if not garageProfile or not profile then
		print(player, "sem profile")
		return
	end
	if not garageProfile[carName] then
		print(player, "Não tem este carro", carName, ", Por tanto não pode vende-lo")
		return
	end
	if not car then
		print("carro", carName, "não existe")
		return
	end
	if not price then
		print("carro", carName, "sem preço")
		price = 0
	else
		price = price.Value
		print("preço do carro", price)
	end
	if not cash then
		price(player, "não tem o atributo Cash em sua data")
		return
	end

	profile["Data"]["Cash"] += (price * 0.75)
	self.GarageProfileService:RemoveCar(player, carName)
end

-- fazer novo método que retorne uma array com todos os carros e suas informações
-- fazer paginate no servidor

function DealershipService:GetCars(
	player: Player?,
	page: number?,
	perPage: number?,
	sortBy: string?,
	sortByAscending: boolean?
)
	local cars = {}
	local garageProfile = self.GarageProfileService:GetProfile(player)
	print("garageProfile", garageProfile)

	-- cria a array de carros
	for _, child in ipairs(CarsFolder:GetChildren()) do
		local car = {
			Name = child.Name,
			Price = child.Price.Value,
			Image = child.Image.Value,
			Purchased = garageProfile[child.Name] ~= nil,
		}
		table.insert(cars, car)
	end

	if sortBy then
		if sortByAscending == nil then
			sortByAscending = true
		end
		cars = SortByUtil.Value(cars, sortBy, sortByAscending)
	end
	if page and perPage then
		cars = PaginateUtil.Paginate(cars, perPage, page)
	end

	return cars
end

type DealershipService = typeof(DealershipService)

return DealershipService
