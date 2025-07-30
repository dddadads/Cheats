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
    
    -- Ложные "способности" (только визуал)
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        -- Быстрая ходьба (только для тебя)
        humanoid.WalkSpeed = 50
        
        -- Бесконечные прыжки (обход ограничений)
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        game:GetService("UserInputService").JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
        
        -- Фейковые сообщения
        warn("⚠ ВИРУС: ДОСТУП К СИЛЕ ОТКРЫТ")
    end
    
    -- Эффект "заражения" (красные неоновые части)
    for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Color = Color3.new(1, 0, 0)
            part.Material = Enum.Material.Neon
        end
    end
end)
