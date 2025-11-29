local Lighting = game:GetService("Lighting")

local Module = {}
local depthOfField

function Module.start()
    depthOfField = Instance.new("DepthOfFieldEffect")
    depthOfField.FocusDistance = 10
    depthOfField.FarIntensity = 0.5
    depthOfField.NearIntensity = 0.3
    depthOfField.InFocusRadius = 30
    depthOfField.Parent = Lighting
end

function Module.stop()
    if depthOfField and depthOfField.Parent then
        depthOfField:Destroy()
        depthOfField = nil
    end
end

return Module
