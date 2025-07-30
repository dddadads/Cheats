local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- 1. Создаем RemoteEvent для общения клиент↔сервер
local labEvent = Instance.new("RemoteEvent")
labEvent.Name = "LabEvent"
labEvent.Parent = ReplicatedStorage

-- 2. Обработка команд (убийство игрока/себя)
labEvent.OnServerEvent:Connect(function(sender, action, target)
    if action == "KillPlayer" then
        local targetPlayer = Players:FindFirstChild(target)
        if targetPlayer and targetPlayer.Character then
            targetPlayer.Character:BreakJoints()
            print(sender.Name .. " убил " .. targetPlayer.Name)
        end
    elseif action == "KillSelf" and sender.Character then
        sender.Character:BreakJoints()
        print(sender.Name .. " убил себя")
    end
end)

-- 3. Загружаем Client.lua при входе игрока
Players.PlayerAdded:Connect(function(plr)
    -- Ждем создание PlayerGui (на всякий случай)
    if not plr:FindFirstChild("PlayerGui") then
        plr.CharacterAdded:Wait()
    end
    
    -- Загрузка клиентского скрипта
    local clientUrl = "https://raw.githubusercontent.com/dddadads/Client.lua/main/Client.lua"
    local success, source = pcall(game.HttpGet, game, clientUrl)
    
    if success then
        local script = Instance.new("LocalScript")
        script.Name = "ScienceClient"
        script.Source = source
        script.Parent = plr:WaitForChild("PlayerGui")
        print("Client.lua загружен для", plr.Name)
    else
        warn("Ошибка загрузки Client.lua:", source)
    end
end)
