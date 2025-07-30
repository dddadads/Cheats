-- Создаем интерфейс
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "RainbowGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.5, -25)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, 0, 1, 0)
button.Text = "ВКЛ / ВЫКЛ (Радуга + Скорость)"
button.TextScaled = true

-- Ищем парт или создаем новый
local part = workspace:FindFirstChild("RainbowPart") or Instance.new("Part")
part.Name = "RainbowPart"
part.Size = Vector3.new(5, 1, 5)
part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0, -3, 0)
part.Anchored = true
part.Parent = workspace

-- Эффекты
local enabled = false
local speedBoost = 50 -- Ускорение игрока

button.MouseButton1Click:Connect(function()
    enabled = not enabled
    
    if enabled then
        -- Ускоряем игрока
        player.Character.Humanoid.WalkSpeed += speedBoost
        
        -- Мерцающий радужный эффект
        spawn(function()
            while enabled do
                for hue = 0, 1, 0.01 do
                    if not enabled then break end
                    part.Color = Color3.fromHSV(hue, 1, 1)
                    wait(0.05)
                end
            end
        end)
    else
        -- Возвращаем стандартную скорость и цвет
        player.Character.Humanoid.WalkSpeed -= speedBoost
        part.Color = Color3.new(1, 1, 1)
    end
end)
