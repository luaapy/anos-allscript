local Lighting = game:GetService("Lighting")

local Module = {}
local originalShadowSoftness
local originalGlobalShadows

function Module.start()
    originalGlobalShadows = Lighting.GlobalShadows
    originalShadowSoftness = Lighting.ShadowSoftness
    
    Lighting.GlobalShadows = false
    Lighting.ShadowSoftness = 0
end

function Module.stop()
    Lighting.GlobalShadows = originalGlobalShadows or true
    Lighting.ShadowSoftness = originalShadowSoftness or 0.2
end

return Module
