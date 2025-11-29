local Lighting = game:GetService("Lighting")

local Module = {}
local effect

function Module.start()
    effect = Instance.new("ColorCorrectionEffect")
    effect.Contrast = 0.5
    effect.Saturation = 1.5
    effect.Parent = Lighting
end

function Module.stop()
    if effect and effect.Parent then
        effect:Destroy()
        effect = nil
    end
end

return Module
