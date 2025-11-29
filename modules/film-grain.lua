local Lighting = game:GetService("Lighting")

local Module = {}
local grain

function Module.start()
    grain = Instance.new("ColorCorrectionEffect")
    grain.Brightness = -0.1
    grain.Contrast = 0.3
    grain.Parent = Lighting
end

function Module.stop()
    if grain and grain.Parent then
        grain:Destroy()
        grain = nil
    end
end

return Module
