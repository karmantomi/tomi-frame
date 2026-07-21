-- ====================================
-- JOB MANAGER MODULE
-- ====================================

local JobManager = {}

local Config = require 'core.shared.config'
local PlayerManager = require 'core.server.modules.player-manager'

function JobManager:GetAvailableJobs()
    return Config.Jobs
end

function JobManager:SetPlayerJob(source, job)
    if Config.Jobs[job] then
        PlayerManager:SetPlayerJob(source, job)
        print("^2[JobManager] " .. source .. " munkahelye: " .. job .. "^7")
    else
        TriggerClientEvent('tomi-framework:notify', source, 'error', 'Hiba', 'Ilyen munka nem létezik!')
    end
end

function JobManager:PaySalaries()
    local players = PlayerManager:GetAllPlayers()
    for source, player in pairs(players) do
        local jobData = Config.Jobs[player.job]
        if jobData and jobData.salary > 0 then
            PlayerManager:AddMoney(source, jobData.salary, 'bank')
            TriggerClientEvent('tomi-framework:notify', source, 'success', 'Fizetés', 'Kaptál: +' .. jobData.salary)
        end
    end
    print("^2[JobManager] Fizetések kifizetésre kerültek ✓^7")
end

function JobManager:GetJobInfo(job)
    return Config.Jobs[job]
end

return JobManager
