local player = game.Players.LocalPlayer

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Включить ESP"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = screenGui

-- Функция создания ESP
local function createESP(character)
	if character:FindFirstChild("ESPHighlight") then return end
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight"
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Adornee = character
	highlight.Parent = character
end

-- Обработчик нажатия кнопки
button.MouseButton1Click:Connect(function()
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			createESP(plr.Character)
		end
	end

	game.Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function(char)
			createESP(char)
		end)
	end)

	button.Text = "ESP включён"
	button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end)
