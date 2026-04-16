local Workspace = game:GetService("Workspace")
local CarsModels = game.ReplicatedStorage.Shared.Assets.Cars

local Car = {}
Car.__index = Car

local function LoadColor(modelo: Model, RGB)
	for _, child in ipairs(modelo:GetDescendants()) do
		if child:IsA("Part") or child:IsA("MeshPart") then
			child.Color = Color3.fromRGB(RGB["r"], RGB["g"], RGB["b"])
		end
	end
end

local function LoadConfig(modelo, config)
	if modelo.Body:FindFirstChild("paint1") and config["paint1"] then
		LoadColor(modelo.Body.paint1, config["paint1"])
	end
	if modelo.Body:FindFirstChild("paint2") and config["paint2"] then
		LoadColor(modelo.Body.paint2, config["paint2"])
	elseif modelo.Body:FindFirstChild("paint2") and not config["paint2"] and config["paint1"] then -- se o carro tiver o paint2, mas o player não configurou o paint 2, então ele carrega o paint 2 com a cor do paint1
		LoadColor(modelo.Body.paint2, config["paint1"])
	end
end

function Car.new(player: string, carName: string, carConfig: { [any]: any })
	local self = setmetatable({}, Car)

	self.Player = player
	self.Nome = carName
	self.Model = nil
	self.Config = carConfig

	return self
end

function Car:Spawn(parte: Part, position: Vector3, orientation: CFrame)
	if not CarsModels[self.Nome] then
		print("carro nao encontrado	")
		return
	end
	local modelo = CarsModels[self.Nome]:Clone() :: Model

	-- carregar configurações
	if self.Config then
		LoadConfig(modelo, self.Config)
	end

	-- se posição existir spawna carro na posição, e mesma coisa para orientação. Porém se a orientação existir e posição não ele ignora
	if position then
		local pivotAtual = modelo:GetPivot()
		local newCFrame

		if orientation then
			newCFrame = CFrame.new(position) * orientation.Rotation
		else
			newCFrame = CFrame.new(position) * pivotAtual.Rotation
		end

		modelo:PivotTo(newCFrame)
	end

	-- se a parte existir solda o carro na parte
	if parte then
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = modelo.PrimaryPart
		weld.Part1 = parte
		weld.Parent = modelo.PrimaryPart
	end

	-- procura a pasta de carros, caso não existir ele cria
	local CarsWorkspace
	if workspace:FindFirstChild("Cars") then
		CarsWorkspace = workspace:FindFirstChild("Cars")
	else
		local folderCars = Instance.new("Folder") :: Folder
		folderCars.Name = "Cars"
		folderCars.Parent = Workspace
		CarsWorkspace = folderCars
	end

	modelo.Parent = CarsWorkspace
	modelo:SetAttribute("Owner", self.Player)

	self.Model = modelo
end

function Car:Destroy()
	if self.Model then
		self.Model:Destroy()
		self.Model = nil
	end
end

return Car
