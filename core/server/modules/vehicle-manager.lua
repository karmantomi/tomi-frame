-- ====================================
-- VEHICLE MANAGER MODULE
-- ====================================

local VehicleManager = {}
VehicleManager.Vehicles = {}

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'

function VehicleManager:BuyVehicle(source, vehicleModel)
    local player = PlayerManager:GetPlayerData(source)
    local price = Config.VehiclePrices[vehicleModel]
    
    if not player or not price then
        return false
    end
    
    if player.money >= price then
        PlayerManager:RemoveMoney(source, price, 'money')
        
        local vehicleId = #self.Vehicles + 1
        
        self.Vehicles[vehicleId] = {
            id = vehicleId,
            owner = source,
            model = vehicleModel,
            price = price,
            boughtAt = os.time()
        }
        
        table.insert(player.vehicles, vehicleId)
        
        TriggerClientEvent('tomi-framework:notify', source, 'success', 'Járművet vásároltál!', 'Modell: ' .. vehicleModel)
        return true
    else
        TriggerClientEvent('tomi-framework:notify', source, 'error', 'Nincs elég pénz', 'Szükséges: ' .. price)
        return false
    end
end

function VehicleManager:GetPlayerVehicles(source)
    local player = PlayerManager:GetPlayerData(source)
    if player then
        return player.vehicles
    end
    return {}
end

function VehicleManager:GetVehicleInfo(vehicleId)
    return self.Vehicles[vehicleId]
end

return VehicleManager
