-- Этот код будет загружен через HttpGet
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Создаём кнопку
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Нажми меня"
button.Parent = screenGui

button.MouseButton1Click:Connect(function()
    print("Кнопка нажата!")
end)
