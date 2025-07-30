-- Вставьте этот код в Xeno (Executor)
local function LoadAdminSystem()
    -- URL вашего серверного скрипта
    local serverScriptUrl = "https://raw.githubusercontent.com/dddadads/Cheats/main/Server.lua"
    
    -- Создаем RemoteEvent для управления
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local labEvent = Instance.new("RemoteEvent")
    labEvent.Name = "XenoAdminEvent"
    labEvent.Parent = ReplicatedStorage

    -- Функция отправки команд на сервер
    local function SendCommand(command, ...)
        labEvent:FireServer(command, ...)
    end

    -- Загрузка серверного скрипта
    local success, err = pcall(function()
        loadstring(game:HttpGet(serverScriptUrl, true))()
    end)

    if not success then
        warn("Ошибка загрузки:", err)
        -- Минимальный функционал
        SendCommand("InitBasicAdmin")
    end

    -- Примеры команд для Xeno
    local Admin = {
        PaintPart = function(part, color)
            SendCommand("PaintPart", part, Color3.fromHex(color))
        end,
        
        Kick = function(player)
            SendCommand("KickPlayer", player.Name)
        end,
        
        TeleportAll = function(position)
            SendCommand("TeleportAll", position)
        end
    }

    -- Возвращаем интерфейс для управления
    return Admin
end

-- Инициализация системы
local XenoAdmin = LoadAdminSystem()

-- Пример использования:
XenoAdmin.PaintPart(game.Workspace.Part, "FF0000") -- Красим часть в красный
