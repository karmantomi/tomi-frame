-- ====================================
-- MISSION MANAGER MODULE
-- ====================================

local MissionManager = {}
MissionManager.Missions = {}

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'

function MissionManager:CreateMission(missionType, data)
    local mission = {
        type = missionType,
        reward = Config.MissionRewards[missionType],
        data = data,
        createdAt = os.time()
    }
    
    table.insert(self.Missions, mission)
    print("^2[MissionManager] Misszia létrehozva: " .. missionType .. "^7")
    
    return #self.Missions
end

function MissionManager:CompleteMission(source, missionId)
    local mission = self.Missions[missionId]
    
    if not mission then
        return false
    end
    
    if mission.reward then
        PlayerManager:AddMoney(source, mission.reward.money, 'money')
        TriggerClientEvent('tomi-framework:notify', source, 'success', 'Misszia befejezve!', 'Jutalmazás: +' .. mission.reward.money)
    end
    
    return true
end

function MissionManager:GetMission(missionId)
    return self.Missions[missionId]
end

return MissionManager
