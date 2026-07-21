-- ====================================
-- TOMI FRAMEWORK - SERVER EVENTS
-- ====================================

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'
local JobManager = require 'core.server.modules.job-manager'
local EconomyManager = require 'core.server.modules.economy-manager'
local InventoryManager = require 'core.server.modules.inventory-manager'

-- ====================================
-- PLAYER SPAWN EVENT
-- ====================================

AddEventHandler('playerSpawned', function()
    local source = source
    print("^2[Framework] Játékos spawn: " .. source .. "^7")
    PlayerManager:InitializePlayer(source)
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    deferrals.defer()
    
    local source = source
    local identifier = GetPlayerIdentifier(source, 0)
    
    print("^3[Framework] Játékos csatlakozik: " .. name .. " (" .. identifier .. ")^7")
    
    Wait(500)
    deferrals.done()
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    print("^3[Framework] Játékos lecsatlakozik: " .. source .. " (" .. reason .. ")^7")
    PlayerManager:RemovePlayer(source)
end)

-- ====================================
-- MONEY EVENTS
-- ====================================

RegisterServerEvent('tomi-framework:addMoney')
AddEventHandler('tomi-framework:addMoney', function(amount)
    local source = source
    PlayerManager:AddMoney(source, amount, 'money')
end)

RegisterServerEvent('tomi-framework:removeMoney')
AddEventHandler('tomi-framework:removeMoney', function(amount)
    local source = source
    if PlayerManager:RemoveMoney(source, amount, 'money') then
        TriggerClientEvent('tomi-framework:notify', source, 'success', 'Tranzakció sikeres', 'Pénz elvétele: -' .. amount)
    else
        TriggerClientEvent('tomi-framework:notify', source, 'error', 'Hiba', 'Nincs elég pénzed!')
    end
end)

RegisterServerEvent('tomi-framework:addBank')
AddEventHandler('tomi-framework:addBank', function(amount)
    local source = source
    PlayerManager:AddMoney(source, amount, 'bank')
end)

-- ====================================
-- JOB EVENTS
-- ====================================

RegisterServerEvent('tomi-framework:setJob')
AddEventHandler('tomi-framework:setJob', function(job)
    local source = source
    JobManager:SetPlayerJob(source, job)
end)

RegisterServerEvent('tomi-framework:getJob')
AddEventHandler('tomi-framework:getJob', function()
    local source = source
    local playerData = PlayerManager:GetPlayerData(source)
    if playerData then
        TriggerClientEvent('tomi-framework:jobUpdated', source, playerData.job)
    end
end)

-- ====================================
-- INVENTORY EVENTS
-- ====================================

RegisterServerEvent('tomi-framework:addInventoryItem')
AddEventHandler('tomi-framework:addInventoryItem', function(item, count)
    local source = source
    InventoryManager:AddItem(source, item, count)
end)

RegisterServerEvent('tomi-framework:removeInventoryItem')
AddEventHandler('tomi-framework:removeInventoryItem', function(item, count)
    local source = source
    InventoryManager:RemoveItem(source, item, count)
end)

-- ====================================
-- MISSION EVENTS
-- ====================================

RegisterServerEvent('tomi-framework:startMission')
AddEventHandler('tomi-framework:startMission', function(missionType)
    local source = source
    TriggerClientEvent('tomi-framework:missionStarted', source, missionType)
end)

RegisterServerEvent('tomi-framework:completeMission')
AddEventHandler('tomi-framework:completeMission', function(missionType, reward)
    local source = source
    PlayerManager:AddMoney(source, reward, 'money')
    TriggerClientEvent('tomi-framework:notify', source, 'success', 'Misszia befejezve!', 'Jutalmazás: +' .. reward)
end)

print("^2[Tomi Framework] Server events betöltve ✓^7")
