local Lighting = game:GetService("Lighting")
local Module = {}
local originalSettings = {}

function Module.start()
    originalSettings = {
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness,
        ColorShift_Bottom = Lighting.ColorShift_Bottom,
        ColorShift_Top = Lighting.ColorShift_Top,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        GlobalShadows = Lighting.GlobalShadows
    }
    
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 2
    Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.FogEnd = 100000
    Lighting.FogStart = 0
    Lighting.GlobalShadows = false
    
    pcall(function()
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or 
               effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
                effect.Enabled = false
            end
        end
    end)
end

function Module.stop()
    for property, value in pairs(originalSettings) do
        pcall(function()
            Lighting[property] = value
        end)
    end
    
    pcall(function()
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or 
               effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
                effect.Enabled = true
            end
        end
    end)
end

return Module
