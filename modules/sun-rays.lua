local Lighting = game:GetService("Lighting")

local Module = {}
local sunRays

function Module.start()
    sunRays = Instance.new("SunRaysEffect")
    sunRays.Intensity = 0.5
    sunRays.Spread = 1
    sunRays.Parent = Lighting
end

function Module.stop()
    if sunRays and sunRays.Parent then
        sunRays:Destroy()
        sunRays = nil
    end
end

return Module
