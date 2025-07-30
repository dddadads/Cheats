local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- === 1. Создаём RemoteEvent (если его ещё нет) ===
local labEvent = ReplicatedStorage:FindFirstChild("LabEvent")
if not labEvent then
    labEvent = Instance.new("RemoteEvent")
    labEvent.Name = "LabEvent"
    labEvent.Parent = ReplicatedStorage
end

print("[СЕРВЕР] RemoteEvent LabEvent создан!")

-- === 2. Обработка команд от клиента ===
labEvent.OnServerEvent:Connect(function(sender, action, target)
    if action == "KillPlayer" then
        local targetPlayer = Players:FindFirstChild(target)
        if targetPlayer and targetPlayer.Character then
            targetPlayer.Character:BreakJoints()
            print("[СЕРВЕР] ".. sender.Name .." убил ".. targetPlayer.Name)
        else
            warn("[СЕРВЕР] Не найден игрок: ".. tostring(target))
        end
    elseif action == "KillSelf" then
        if sender.Character then
            sender.Character:BreakJoints()
            print("[СЕРВЕР] ".. sender.Name .." убил сам себя")
        end
    end
end)

-- === 3. Загрузка Client.lua при входе игрока ===
Players.PlayerAdded:Connect(function(plr)
    -- Ждём, пока у игрока появится PlayerGui
    plr:WaitForChild("PlayerGui")
    
    -- Загружаем клиентский скрипт
    local clientScriptUrl = ""https://raw.githubusercontent.com/dddadads/Client.lua/main/Client.lua""  -- Убедись, что URL правильный!
    local success, source = pcall(function()
        return game:HttpGet(clientScriptUrl)
    end)

    if success then
        local localScript = Instance.new("LocalScript")
        localScript.Name = "ScienceClient"
        localScript.Source = source
        localScript.Parent = plr.PlayerGui
        print("[СЕРВЕР] Client.lua загружен для " .. plr.Name)
    else
        warn("[СЕРВЕР] Ошибка загрузки Client.lua: " .. source)
    end
end)
