local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Настройки
local ADMIN_IDS = {
    8963792989, -- Ваш ID
    -- Можно добавить другие ID через запятую
}

-- Создаем RemoteEvent
local adminEvent = Instance.new("RemoteEvent")
adminEvent.Name = "XenoAdminEvent"
adminEvent.Parent = ReplicatedStorage

-- Проверка прав
local function IsAdmin(player)
    return table.find(ADMIN_IDS, player.UserId) ~= nil
end

-- Обработчик команд
adminEvent.OnServerEvent:Connect(function(player, command, ...)
    if not IsAdmin(player) then
        player:Kick("⚠️ Недостаточно прав!")
        return
    end

    local args = {...}
    
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
    end
end)

print("Админ-система активирована для ID:", ADMIN_IDS)
