-- Server.lua (должен лежать в репозитории Cheats)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Создаем RemoteEvent
local labEvent = Instance.new("RemoteEvent")
labEvent.Name = "LabEvent"
labEvent.Parent = ReplicatedStorage

-- Обработка команд от клиента
labEvent.OnServerEvent:Connect(function(player, action, target)
    if action == "KillPlayer" then
        local targetPlayer = Players:FindFirstChild(target)
        if targetPlayer and targetPlayer.Character then
            targetPlayer.Character:BreakJoints()
            print(player.Name .. " убил " .. targetPlayer.Name)
        end
    elseif action == "KillSelf" then
        if player.Character then
            player.Character:BreakJoints()
            print(player.Name .. " убил себя")
        end
    end
end)

print("Серверный скрипт запущен!")
