local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаём GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESP_GUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 50)
Frame.Position = UDim2.new(0, 20, 0, 150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Draggable = true
Frame.Active = true
Frame.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "Включить ESP"
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextSize = 18
Button.Parent = Frame

-- Создаём BillboardGui с текстом
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
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextStrokeTransparency = 0
	textLabel.TextScaled = true
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.Parent = billboard

	RunService.RenderStepped:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
			local distance = math.floor((player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude)
			local health = math.floor(player.Character.Humanoid.Health)
			textLabel.Text = player.Name .. " | Health: " .. health .. " | Distance: " .. distance .. "м"
		end
	end)
end

Button.MouseButton1Click:Connect(function()
	for _, plr in ipairs(Players:GetPlayers()) do
		createESP(plr)
	end

	Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			wait(1)
			createESP(plr)
		end)
	end)

	Button.Text = "ESP включен"
	Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end)
