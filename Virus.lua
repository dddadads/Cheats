-- 1. Создаем интерфейс
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
gui.Name = "FakeVirusUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.3, 0)
button.Position = UDim2.new(0.1, 0, 0.35, 0)
button.Text = "АКТИВИРОВАТЬ ВИРУС"
button.TextColor3 = Color3.new(1, 0, 0)
button.Font = Enum.Font.GothamBold

-- 2. Эффекты при нажатии
button.MouseButton1Click:Connect(function()
    button.Text = "ВИРУС АКТИВЕН!"
    wait(1)
    frame:Destroy() -- Удаляем кнопку после нажатия
    
    -- Ложные "способности"
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 50 -- Быстрая ходьба
        
        -- Бесконечные прыжки
        game:GetService("UserInputService").JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
    
    -- Радужное мерцание ВСЕХ партов в Workspace
    spawn(function()
        while true do
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1) -- Меняем цвет по времени
                    part.Material = Enum.Material.Neon
                end
            end
            wait(0.1)
        end
    end)
    
    -- Фейковые сообщения в консоль
    warn("⚠ ВИРУС: ЗАРАЖЕНИЕ АКТИВНО")
end)
