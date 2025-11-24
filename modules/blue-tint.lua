local Lighting = game:GetService("Lighting")

local Module = {}
local colorCorrection

function Module.start()
    colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.TintColor = Color3.fromRGB(0, 0, 255)
    colorCorrection.Parent = Lighting
end

function Module.stop()
    if colorCorrection and colorCorrection.Parent then
        colorCorrection:Destroy()
        colorCorrection = nil
    end
end

return Module
