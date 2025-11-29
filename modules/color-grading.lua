local Lighting = game:GetService("Lighting")

local Module = {}
local colorCorrection

function Module.start()
    colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Saturation = -0.3
    colorCorrection.Contrast = 0.2
    colorCorrection.Brightness = 0.1
    colorCorrection.TintColor = Color3.fromRGB(255, 200, 150)
    colorCorrection.Parent = Lighting
end

function Module.stop()
    if colorCorrection and colorCorrection.Parent then
        colorCorrection:Destroy()
        colorCorrection = nil
    end
end

return Module
