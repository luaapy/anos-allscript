local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Module = {}
local connection
local hue = 0
local colorCorrection

function Module.start()
    colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Parent = Lighting
    
    connection = RunService.Heartbeat:Connect(function()
        hue = (hue + 0.01) % 1
        colorCorrection.TintColor = Color3.fromHSV(hue, 1, 1)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if colorCorrection and colorCorrection.Parent then
        colorCorrection:Destroy()
        colorCorrection = nil
    end
end

return Module
