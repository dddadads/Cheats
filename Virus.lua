-- 1. Странные GUI-эффекты
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)

local warning = Instance.new("TextLabel", frame)
warning.Text = "⚠ СИСТЕМА ЗАРАЖЕНА ⚠"
warning.TextColor3 = Color3.new(1, 0, 0)
warning.Size = UDim2.new(1, 0, 0, 50)
warning.Font = Enum.Font.GothamBlack

-- 2. Искажение мира (случайные цвета частей)
spawn(function()
    while true do
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and math.random(1, 5) == 1 then
                part.Color = Color3.new(math.random(), math.random(), math.random())
                part.Material = Enum.Material.Neon
            end
        end
        wait(0.5)
    end
end)

-- 3. Ложные "ошибки" в консоли
for i = 1, 10 do
    warn("ОШИБКА #"..i..": Вирусное заражение "..math.random(1, 100).."%")
    wait(0.3)
end
