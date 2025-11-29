local Lighting = game:GetService("Lighting")

local Module = {}
local effect

function Module.start()
    effect = Instance.new("ColorCorrectionEffect")
    effect.TintColor = Color3.fromRGB(255, 100, 0)
    effect.Saturation = -1
    effect.Brightness = 0.2
    effect.Contrast = 0.5
    effect.Parent = Lighting
end

function Module.stop()
    if effect and effect.Parent then
        effect:Destroy()
        effect = nil
    end
end

return Module
