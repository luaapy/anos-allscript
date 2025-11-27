local module = {}
local trail

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = humanoidRootPart
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = humanoidRootPart
    attachment1.Position = Vector3.new(0, -2, 0)
    
    trail = Instance.new("Trail")
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Lifetime = 2
    trail.MinLength = 0
    trail.WidthScale = NumberSequence.new(10)
    trail.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
    }
    trail.Parent = humanoidRootPart
end

function module.stop()
    if trail then
        trail:Destroy()
    end
end

return module
