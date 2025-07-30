local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Создаем или находим RemoteEvent
local adminEvent = ReplicatedStorage:FindFirstChild("XenoAdminEvent") or Instance.new("RemoteEvent")
adminEvent.Name = "XenoAdminEvent"
adminEvent.Parent = ReplicatedStorage

-- Обработчик команд
adminEvent.OnServerEvent:Connect(function(player, command, ...)
    local args = {...}
    
    -- Проверка прав администратора
    if not player:GetRankInGroup(ADMIN_GROUP_ID) then return end

    if command == "PaintPart" then
        -- Покраска части
        local part = args[1]
        local color = args[2]
        if part and part:IsA("BasePart") then
            part.Color = color
        end
        
    elseif command == "KickPlayer" then
        -- Кик игрока
        local target = Players:FindFirstChild(args[1])
        if target then
            target:Kick("Администратор вас кикнул")
        end
        
    elseif command == "TeleportAll" then
        -- Телепортация всех
        local position = args[1]
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                plr.Character:MoveTo(position)
            end
        end
    end
end)

print("Админ-система Xeno активирована!")
