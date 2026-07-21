-- ====================================
-- TOMI FRAMEWORK - CLIENT MAIN
-- ====================================

print("^2[Tomi Framework] Client inicializálva...^7")

local Config = require 'core.shared.config'
local UIManager = require 'core.client.modules.ui-manager'
local PlayerManager = require 'core.client.modules.player-manager'

local playerLoaded = false
local playerData = nil

-- Player loaded event
RegisterNetEvent('tomi-framework:playerLoaded')
AddEventHandler('tomi-framework:playerLoaded', function(data)
    playerData = data
    playerLoaded = true
    print("^2[Framework] Játékos betöltve! ✓^7")
    UIManager:UpdateHUD(data)
end)

-- Update HUD event
RegisterNetEvent('tomi-framework:updateHUD')
AddEventHandler('tomi-framework:updateHUD', function(data)
    playerData = data
    UIManager:UpdateHUD(data)
end)

-- Notification event
RegisterNetEvent('tomi-framework:notify')
AddEventHandler('tomi-framework:notify', function(type, title, message)
    UIManager:Notify(title, message, type)
end)

-- Update inventory
RegisterNetEvent('tomi-framework:updateInventory')
AddEventHandler('tomi-framework:updateInventory', function(inventory)
    playerData.inventory = inventory
end)

-- Keybind for inventory
RegisterKeyMapping('openInventory', 'Tárgy megnyitása', 'keyboard', Config.Keybinds.openInventory)
RegisterCommand('openInventory', function()
    if playerLoaded then
        UIManager:OpenInventory(playerData)
    end
end, false)

-- Keybind for job menu
RegisterKeyMapping('openJob', 'Munka menü', 'keyboard', Config.Keybinds.openJob)
RegisterCommand('openJob', function()
    if playerLoaded then
        UIManager:OpenJobMenu()
    end
end, false)

print("^2[Tomi Framework] Client modul betöltve ✓^7")
