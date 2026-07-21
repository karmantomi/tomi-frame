-- ====================================
-- HOUSING MANAGER MODULE
-- ====================================

local HousingManager = {}
HousingManager.Houses = {}

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'

function HousingManager:BuyHouse(source, houseId, houseType)
    local player = PlayerManager:GetPlayerData(source)
    local price = Config.HousingPrices[houseType]
    
    if not player then return false end
    
    if player.money >= price then
        PlayerManager:RemoveMoney(source, price, 'money')
        player.house = houseId
        
        self.Houses[houseId] = {
            id = houseId,
            owner = source,
            type = houseType,
            price = price,
            boughtAt = os.time()
        }
        
        TriggerClientEvent('tomi-framework:notify', source, 'success', 'Házat vásároltál!', 'Típus: ' .. houseType .. ', Ár: ' .. price)
        return true
    else
        TriggerClientEvent('tomi-framework:notify', source, 'error', 'Nincs elég pénz', 'Szükséges: ' .. price)
        return false
    end
end

function HousingManager:SellHouse(source, houseId)
    local house = self.Houses[houseId]
    
    if not house or house.owner ~= source then
        return false
    end
    
    local refund = house.price * 0.8 -- 80% refund
    PlayerManager:AddMoney(source, refund, 'money')
    
    self.Houses[houseId] = nil
    
    local player = PlayerManager:GetPlayerData(source)
    if player then
        player.house = nil
    end
    
    TriggerClientEvent('tomi-framework:notify', source, 'success', 'Házat eladtál!', 'Kapott: +' .. refund)
    return true
end

function HousingManager:GetHouseInfo(houseId)
    return self.Houses[houseId]
end

return HousingManager
