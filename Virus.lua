-- Создаем интерфейс
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
gui.Name = "VirusUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.3, 0)
button.Position = UDim2.new(0.1, 0, 0.35, 0)
button.Text = "АКТИВИРОВАТЬ"
button.TextColor3 = Color3.new(1, 0, 0)
button.Font = Enum.Font.GothamBold

-- Эффекты при нажатии
button.MouseButton1Click:Connect(function()
    button.Text = "АКТИВНО!"
    wait(1)
    frame:Destroy()  -- Удаляем кнопку
    
    -- Ускорение и прыжки
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 50  -- Высокая скорость
        
        -- Бесконечные прыжки
        game:GetService("UserInputService").JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
    
    -- Медленное мерцание объектов (раз в 3 секунды)
    spawn(function()
        while true do
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.new(1, 0, 0)  -- Красный
                    part.Material = Enum.Material.Neon
                end
            end
            wait(3)  -- Интервал мерцания
            
            -- Возвращаем обычный цвет
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.new(1, 1, 1)  -- Белый
                    part.Material = Enum.Material.Plastic
                end
            end
            wait(3)  -- Интервал между сменами
        end
    end)
end)
