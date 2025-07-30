-- 🌐 SERVER SCRIPT
local src = game:HttpGet("https://raw.githubusercontent.com/dddadads/Cheats/refs/heads/main/Cheat.Lua")
local serverScript = Instance.new("Script")
serverScript.Name = "CheatServer"
serverScript.Source = src
serverScript.Parent = game.ServerScriptService

-- Создаёт RemoteEvent, слушает команды и вставляет LocalScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- === Создаём RemoteEvent (если его ещё нет) ===
local labEvent = ReplicatedStorage:FindFirstChild("LabEvent")
if not labEvent then
    labEvent = Instance.new("RemoteEvent")
    labEvent.Name = "LabEvent"
    labEvent.Parent = ReplicatedStorage
end

print("[СЕРВЕР] RemoteEvent LabEvent создан!")

-- === Обработка команд от клиента ===
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

-- === Когда игрок заходит — загружаем ему Client.lua ===
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        local success, source = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/dddadads/Client.lua/refs/heads/main/Client.lua")
        end)

        if success then
            local localScript = Instance.new("LocalScript")
            localScript.Name = "ScienceClient"
            localScript.Source = source
            localScript.Parent = plr:WaitForChild("PlayerGui")
            print("[СЕРВЕР] Client.lua загружен для " .. plr.Name)
        else
            warn("[СЕРВЕР] Ошибка загрузки Client.lua: ", source)
        end
    end)
end)
