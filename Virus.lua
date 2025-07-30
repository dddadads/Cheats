-- Создаем прозрачный интерфейс
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
gui.Name = "RainbowVirusFX"

-- Прозрачная кнопка активации
local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "АКТИВИРОВАТЬ РАДУГУ"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundTransparency = 1
button.Font = Enum.Font.GothamBlack
button.TextSize = 18

-- Эффекты при активации
button.MouseButton1Click:Connect(function()
    button:Destroy() -- Удаляем кнопку
    
    -- Улучшения персонажа
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    humanoid.WalkSpeed = 50 -- Скорость
    
    -- Бесконечные прыжки
    game:GetService("UserInputService").JumpRequest:Connect(function()
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
    
    -- Радужный эффект для всех объектов
    spawn(function()
        while true do
            local hue = tick() % 6 / 6 -- Цикл цветов радуги
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(hue, 1, 1)
                    part.Material = Enum.Material.Neon
                end
            end
            wait(2.5) -- Скорость смены цветов
        end
    end)
end)
