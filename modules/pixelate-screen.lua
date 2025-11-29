local Lighting = game:GetService("Lighting")

local Module = {}
local pixelation

function Module.start()
    pixelation = Instance.new("BlurEffect")
    pixelation.Size = 10
    pixelation.Parent = Lighting
end

function Module.stop()
    if pixelation and pixelation.Parent then
        pixelation:Destroy()
        pixelation = nil
    end
end

return Module
