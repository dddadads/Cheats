local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESP_GUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = false -- ручное перетаскивание
Frame.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "Включить ESP"
Button.TextColor3 = Color3.new(1,1,1)
Button.TextStrokeTransparency = 0
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextSize = 18
Button.Font = Enum.Font.SourceSansBold
Button.Parent = Frame

-- Перетаскивание вручную
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- ESP логика
local ESPEnabled = false
local Connections = {}

local function removeESP()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("ESP") then
			player.Character.ESP:Destroy()
		end
	end
	for _, conn in pairs(Connections) do
		if typeof(conn) == "RBXScriptConnection" then
			conn:Disconnect()
		end
	end
	Connections = {}
end

local function createESP(player)
	if player == LocalPlayer then return end
	if not player.Character or not player.Character:FindFirstChild("Head") then return end
	if player.Character:FindFirstChild("ESP") then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP"
	billboard.Adornee = player.Character.Head
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.Parent = player.Character

	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextStrokeTransparency = 0
	textLabel.TextScaled = true
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.Parent = billboard

	local conn = RunService.RenderStepped:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
			local distance = math.floor((player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude)
			local health = math.floor(player.Character.Humanoid.Health)
			textLabel.Text = player.Name .. " | HP: " .. health .. " | " .. distance .. "м"
		end
	end)

	table.insert(Connections, conn)
end

local function enableESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		createESP(plr)
	end

	local conn1 = Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			wait(1)
			createESP(plr)
		end)
	end)

	table.insert(Connections, conn1)
end

-- Кнопка
Button.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled

	if ESPEnabled then
		Button.Text = "Выключить ESP"
		Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		enableESP()
	else
		Button.Text = "Включить ESP"
		Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		removeESP()
	end
end)
