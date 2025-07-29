--[[
    🧪 Научная лаборатория Roblox: Меню функций
    Цель: Изучить, как работают локальные читы
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Создаём GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Создаём основную рамку
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(1, -210, 0, 10) -- ПРАВЫЙ ВЕРХНИЙ угол
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.2

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔬 Лаборатория"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- === 🟥 КНОПКА 1: УБИТЬ СЕБЯ ===
local KillButton = Instance.new("TextButton")
KillButton.Parent = Frame
KillButton.Size = UDim2.new(1, -20, 0, 30)
KillButton.Position = UDim2.new(0, 10, 0, 40)
KillButton.Text = "☠️ УБИТЬ СЕБЯ"
KillButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillButton.TextColor3 = Color3.new(1, 1, 1)
KillButton.Font = Enum.Font.SourceSansBold
KillButton.TextSize = 18

KillButton.MouseButton1Click:Connect(function()
	character:BreakJoints() -- моментально убивает игрока
end)

-- === 🏃‍♂️ КНОПКА 2: УСКОРИТЬ ===
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = Frame
SpeedButton.Size = UDim2.new(1, -20, 0, 30)
SpeedButton.Position = UDim2.new(0, 10, 0, 80)
SpeedButton.Text = "⚡ УСКОРИТЬ (x2)"
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SpeedButton.TextColor3 = Color3.new(1, 1, 1)
SpeedButton.Font = Enum.Font.SourceSansBold
SpeedButton.TextSize = 18

local fast = false
SpeedButton.MouseButton1Click:Connect(function()
	if not fast then
		character.Humanoid.WalkSpeed = 32 -- обычная скорость 16, делаем x2
		SpeedButton.Text = "🐌 Вернуть норм скорость"
		fast = true
	else
		character.Humanoid.WalkSpeed = 16
		SpeedButton.Text = "⚡ УСКОРИТЬ (x2)"
		fast = false
	end
end)

-- === 🛠 ЛЕГКО ДОБАВИТЬ ЕЩЁ КНОПКИ ===
-- Просто копируешь блоки "TextButton" и меняешь функцию
