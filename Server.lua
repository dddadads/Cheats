local ADMIN_IDS = {8963792989} -- Только ваш ID

game.ReplicatedStorage.XenoAdminEvent.OnServerEvent:Connect(function(player, cmd, ...)
    -- Проверка прав
    if not table.find(ADMIN_IDS, player.UserId) then
        player:Kick("⛔ Недостаточно прав!")
        return
    end

    -- Обработка команд
    if cmd == "Paint" then
        local partName, color = ...
        local part = game.Workspace:FindFirstChild(partName)
        if part then
            part.Color = Color3.fromRGB(unpack(color))
        end
        
    elseif cmd == "TeleportAll" then
        local position = ...
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character then
                plr.Character:MoveTo(position)
            end
        end
    end
end)
