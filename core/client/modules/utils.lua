-- ====================================
-- UTILITY FUNCTIONS - CLIENT
-- ====================================

local Utils = {}

function Utils:Distance(coords1, coords2)
    return #(coords1 - coords2)
end

function Utils:DrawText3D(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

function Utils:Notify(message, type)
    type = type or "info"
    
    local color = {255, 255, 255}
    if type == "success" then color = {0, 255, 0}
    elseif type == "error" then color = {255, 0, 0}
    elseif type == "warning" then color = {255, 165, 0}
    end
    
    TriggerEvent('chat:addMessage', {
        color = color,
        multiline = true,
        args = {"System", message}
    })
end

return Utils
