-- ====================================
-- NPC MANAGER MODULE
-- ====================================

local NPCManager = {}
NPCManager.NPCs = {}

local Config = require 'core.shared.config'

function NPCManager:CreateNPC(model, coords, heading, name)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(100)
    end
    
    local npc = {
        model = model,
        coords = coords,
        heading = heading,
        name = name,
        handle = nil
    }
    
    table.insert(self.NPCs, npc)
    print("^2[NPCManager] NPC létrehozva: " .. name .. "^7")
    
    return #self.NPCs
end

function NPCManager:GetNPC(npcId)
    return self.NPCs[npcId]
end

function NPCManager:RemoveNPC(npcId)
    if self.NPCs[npcId] then
        self.NPCs[npcId] = nil
        print("^2[NPCManager] NPC eltávolítva^7")
    end
end

return NPCManager
