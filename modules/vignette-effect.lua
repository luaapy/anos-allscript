local Lighting = game:GetService("Lighting")

local Module = {}
local vignette

function Module.start()
    vignette = Instance.new("ColorCorrectionEffect")
    vignette.Brightness = -0.3
    vignette.Parent = Lighting
    
    -- Create dark overlay
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "VignetteEffect"
    gui.Parent = PlayerGui
    gui.DisplayOrder = 999
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = gui
    
    local gradient = Instance.new("UIGradient")
    gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(1, 0.5)
    }
    gradient.Parent = frame
    
    Module.gui = gui
end

function Module.stop()
    if vignette and vignette.Parent then
        vignette:Destroy()
        vignette = nil
    end
    
    if Module.gui and Module.gui.Parent then
        Module.gui:Destroy()
        Module.gui = nil
    end
end

return Module
