-- ====================================
-- PLAYER MANAGER - CLIENT
-- ====================================

local PlayerManager = {}

function PlayerManager:GetPlayerData()
    -- This would be set by server event
    return nil
end

function PlayerManager:AddMoney(amount)
    TriggerServerEvent('tomi-framework:addMoney', amount)
end

function PlayerManager:RemoveMoney(amount)
    TriggerServerEvent('tomi-framework:removeMoney', amount)
end

function PlayerManager:SetJob(job)
    TriggerServerEvent('tomi-framework:setJob', job)
end

function PlayerManager:StartMission(missionType)
    TriggerServerEvent('tomi-framework:startMission', missionType)
end

function PlayerManager:CompleteMission(missionType, reward)
    TriggerServerEvent('tomi-framework:completeMission', missionType, reward)
end

return PlayerManager
