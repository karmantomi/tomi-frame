-- ====================================
-- ECONOMY MANAGER MODULE
-- ====================================

local EconomyManager = {}

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'

function EconomyManager:DepositMoney(source, amount)
    local player = PlayerManager:GetPlayerData(source)
    
    if not player or player.money < amount then
        return false
    end
    
    player.money = player.money - amount
    player.bank = player.bank + amount
    
    TriggerClientEvent('tomi-framework:updateHUD', source, player)
    TriggerClientEvent('tomi-framework:notify', source, 'success', 'Pénz befizetése', 'Befizetés: +' .. amount)
    
    return true
end

function EconomyManager:WithdrawMoney(source, amount)
    local player = PlayerManager:GetPlayerData(source)
    
    if not player or player.bank < amount then
        return false
    end
    
    player.bank = player.bank - amount
    player.money = player.money + amount
    
    TriggerClientEvent('tomi-framework:updateHUD', source, player)
    TriggerClientEvent('tomi-framework:notify', source, 'success', 'Pénz felvétele', 'Felvétel: +' .. amount)
    
    return true
end

function EconomyManager:TransferMoney(sourcePlayer, targetPlayer, amount)
    local source = PlayerManager:GetPlayerData(sourcePlayer)
    local target = PlayerManager:GetPlayerData(targetPlayer)
    
    if not source or not target or source.money < amount then
        return false
    end
    
    source.money = source.money - amount
    target.money = target.money + amount
    
    TriggerClientEvent('tomi-framework:notify', sourcePlayer, 'success', 'Pénz átutalása', 'Küldtél: -' .. amount)
    TriggerClientEvent('tomi-framework:notify', targetPlayer, 'success', 'Pénz átutalása', 'Kaptál: +' .. amount)
    
    return true
end

return EconomyManager
