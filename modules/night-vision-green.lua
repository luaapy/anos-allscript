local Lighting = game:GetService("Lighting")

local Module = {}
local effect

function Module.start()
    effect = Instance.new("ColorCorrectionEffect")
    effect.TintColor = Color3.fromRGB(0, 255, 0)
    effect.Saturation = -0.5
    effect.Brightness = 0.3
    effect.Parent = Lighting
end

function Module.stop()
    if effect and effect.Parent then
        effect:Destroy()
        effect = nil
    end
end

return Module
