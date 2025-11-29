local RunService = game:GetService("RunService")

local Module = {}

function Module.start()
    -- Reduce graphics quality for FPS boost
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    -- Disable shadows
    game:GetService("Lighting").GlobalShadows = false
    
    -- Reduce particle count
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
end

function Module.stop()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    game:GetService("Lighting").GlobalShadows = true
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = true
        end
    end
end

return Module
