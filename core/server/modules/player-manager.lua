-- ====================================
-- PLAYER MANAGER MODULE
-- ====================================

local PlayerManager = {}
PlayerManager.Players = {}

local Config = require 'core.shared.config'

function PlayerManager:InitializePlayer(source)
    local identifier = GetPlayerIdentifier(source, 0)
    local name = GetPlayerName(source)
    
    local player = {
        id = source,
        identifier = identifier,
        username = name,
        job = "unemployed",
        money = Config.StartingMoney,
        bank = Config.StartingBank,
        health = 200,
        armor = 0,
        inventory = {},
        house = nil,
        vehicles = {},
        playtime = 0,
        joinedAt = os.time()
    }
    
    self.Players[source] = player
    
    -- Send to client
    TriggerClientEvent('tomi-framework:playerLoaded', source, player)
    
    -- Update HUD
    TriggerClientEvent('tomi-framework:updateHUD', source, {
        money = player.money,
        bank = player.bank,
        job = player.job,
        health = player.health,
        armor = player.armor
    })
    
    print("^2[PlayerManager] Játékos betöltve: " .. name .. " (" .. identifier .. ")^7")
end

function PlayerManager:RemovePlayer(source)
    if self.Players[source] then
        local player = self.Players[source]
        print("^3[PlayerManager] Játékos eltávolítva: " .. player.username .. "^7")
        self.Players[source] = nil
    end
end

function PlayerManager:GetPlayerData(source)
    return self.Players[source]
end

function PlayerManager:AddMoney(source, amount, type)
    type = type or "money"
    if self.Players[source] then
        self.Players[source][type] = self.Players[source][type] + amount
        TriggerClientEvent('tomi-framework:updateHUD', source, self.Players[source])
        print("^2[PlayerManager] " .. source .. " kapott " .. amount .. " " .. type .. "^7")
    end
end

function PlayerManager:RemoveMoney(source, amount, type)
    type = type or "money"
    if self.Players[source] and self.Players[source][type] >= amount then
        self.Players[source][type] = self.Players[source][type] - amount
        TriggerClientEvent('tomi-framework:updateHUD', source, self.Players[source])
        print("^2[PlayerManager] " .. source .. " elvett " .. amount .. " " .. type .. "^7")
        return true
    end
    return false
end

function PlayerManager:SetPlayerJob(source, job)
    if self.Players[source] then
        self.Players[source].job = job
        TriggerClientEvent('tomi-framework:updateHUD', source, self.Players[source])
        TriggerClientEvent('tomi-framework:notify', source, 'success', 'Munka módosítva', 'Új munkád: ' .. job)
    end
end

function PlayerManager:GetAllPlayers()
    return self.Players
end

return PlayerManager
