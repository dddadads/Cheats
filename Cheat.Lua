--[[ 
    🔬 НАУЧНЫЙ ЭКСПЕРИМЕНТ: Roblox Лаборатория
    🧪 Функции:
       ✅ Одеть твой скин на Part
       ✅ Убить себя
       ✅ Ускорить/вернуть скорость
       ✅ Сделать все Part красными
       ✅ Включить музыку
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- === 📜 GUI Создание ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.Name = "LabGui"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 230, 0, 270)
Frame.Position = UDim2.new(1, -240, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔬 Лаборатория"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.BorderSizePixel = 0

-- === 🛠 Утилита кнопок ===
local function makeButton(name, posY, color)
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0
    return btn
end

-- === Кнопки и функции ===

-- Убить себя
local KillBtn = makeButton("☠️ УБИТЬ СЕБЯ", 40, Color3.fromRGB(150, 0, 0))
KillBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    if char then
        char:BreakJoints()
    end
end)

-- Ускорить
local SpeedBtn = makeButton("⚡ УСКОРИТЬ (x2)", 85, Color3.fromRGB(0, 100, 200))
local fast = false
SpeedBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if hum then
        if not fast then
            hum.WalkSpeed = 32
            SpeedBtn.Text = "🐌 Вернуть 16"
            fast = true
        else
            hum.WalkSpeed = 16
            SpeedBtn.Text = "⚡ УСКОРИТЬ (x2)"
            fast = false
        end
    end
end)

-- Сделать все Part красными
local RedBtn = makeButton("🎨 Все Part красные", 130, Color3.fromRGB(255, 0, 0))
RedBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Color = Color3.fromRGB(255, 0, 0)
        end
    end
    warn("[НАУЧНО] Все детали стали красными!")
end)

-- Надеть скин на Part
local SkinBtn = makeButton("👕 Скин на Part", 175, Color3.fromRGB(100, 0, 150))
SkinBtn.MouseButton1Click:Connect(function()
    local part = workspace:FindFirstChild("MyPart")
    if not part or not part:IsA("BasePart") then
        warn("[НАУЧНО] Part 'MyPart' не найден!")
        return
    end

    -- Удаляем старые аксессуары с Part
    for _, child in pairs(part:GetChildren()) do
        if child:IsA("Accessory") then
            child:Destroy()
        end
    end

    local char = player.Character or player.CharacterAdded:Wait()

    for _, accessory in pairs(char:GetChildren()) do
        if accessory:IsA("Accessory") then
            local clone = accessory:Clone()
            clone.Parent = part

            local handle = clone:FindFirstChild("Handle")
            if handle then
                -- Создаём WeldConstraint для крепления аксессуара к Part
                local weld = Instance.new("WeldConstraint")
                weld.Part0 = handle
                weld.Part1 = part
                weld.Parent = handle

                -- Подгоняем позицию аксессуара к Part
                handle.CFrame = part.CFrame
            end
        end
    end
    warn("[НАУЧНО] Скин одет на Part 'MyPart'!")
end)

-- Включить / Выключить музыку
local MusicBtn = makeButton("🎵 Включить музыку", 220, Color3.fromRGB(0, 180, 80))
local musicOn = false
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1843521083" -- Весёлая фоновая музыка
sound.Volume = 2
sound.Looped = true
sound.Parent = workspace

MusicBtn.MouseButton1Click:Connect(function()
    if not musicOn then
        sound:Play()
        MusicBtn.Text = "⏸ Остановить музыку"
        musicOn = true
    else
        sound:Stop()
        MusicBtn.Text = "🎵 Включить музыку"
        musicOn = false
    end
end)
