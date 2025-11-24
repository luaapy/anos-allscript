local Lighting = game:GetService("Lighting")

local Module = {}
local originalFogEnd

function Module.start()
    originalFogEnd = Lighting.FogEnd
    Lighting.FogEnd = 100000
end

function Module.stop()
    Lighting.FogEnd = originalFogEnd or 10000
end

return Module
