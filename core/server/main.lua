-- ====================================
-- TOMI FRAMEWORK - SERVER MAIN
-- ====================================

print("^2[Tomi Framework] Server inicializálva...^7")

local Config = require 'core.shared.config'

-- Load all server modules
local PlayerManager = require 'core.server.modules.player-manager'
local JobManager = require 'core.server.modules.job-manager'
local InventoryManager = require 'core.server.modules.inventory-manager'
local HousingManager = require 'core.server.modules.housing-manager'
local VehicleManager = require 'core.server.modules.vehicle-manager'
local EconomyManager = require 'core.server.modules.economy-manager'
local NPCManager = require 'core.server.modules.npc-manager'
local MissionManager = require 'core.server.modules.mission-manager'
local Database = require 'core.server.modules.database'

-- Initialize database
Database:Initialize()

print("^2[Tomi Framework] " .. Config.ServerName .. " - v1.0.0^7")
print("^2[Tomi Framework] Maximális játékosok: " .. Config.MaxPlayers .. "^7")
print("^2[Tomi Framework] Szerver készen áll! ✓^7")
