-- ====================================
-- INVENTORY MANAGER MODULE
-- ====================================

local InventoryManager = {}

local PlayerManager = require 'core.server.modules.player-manager'
local Config = require 'core.shared.config'

function InventoryManager:AddItem(source, item, count)
    count = count or 1
    local player = PlayerManager:GetPlayerData(source)
    
    if not player then return false end
    
    if not player.inventory[item] then
        player.inventory[item] = 0
    end
    
    player.inventory[item] = player.inventory[item] + count
    
    TriggerClientEvent('tomi-framework:updateInventory', source, player.inventory)
    TriggerClientEvent('tomi-framework:notify', source, 'success', 'Tárgy hozzáadva', item .. ' x' .. count)
    
    return true
end

function InventoryManager:RemoveItem(source, item, count)
    count = count or 1
    local player = PlayerManager:GetPlayerData(source)
    
    if not player or not player.inventory[item] or player.inventory[item] < count then
        return false
    end
    
    player.inventory[item] = player.inventory[item] - count
    
    if player.inventory[item] <= 0 then
        player.inventory[item] = nil
    end
    
    TriggerClientEvent('tomi-framework:updateInventory', source, player.inventory)
    
    return true
end

function InventoryManager:GetInventory(source)
    local player = PlayerManager:GetPlayerData(source)
    if player then
        return player.inventory
    end
    return {}
end

function InventoryManager:HasItem(source, item, count)
    count = count or 1
    local inventory = self:GetInventory(source)
    return inventory[item] and inventory[item] >= count
end

return InventoryManager
