local Lighting = game:GetService("Lighting")

local Module = {}
local originalBrightness
local originalAmbient
local originalOutdoorAmbient

function Module.start()
    originalBrightness = Lighting.Brightness
    originalAmbient = Lighting.Ambient
    originalOutdoorAmbient = Lighting.OutdoorAmbient
    
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end

function Module.stop()
    Lighting.Brightness = originalBrightness or 1
    Lighting.Ambient = originalAmbient or Color3.new(0, 0, 0)
    Lighting.OutdoorAmbient = originalOutdoorAmbient or Color3.new(0.5, 0.5, 0.5)
end

return Module
