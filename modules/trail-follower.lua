local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local trails = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = rootPart
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = rootPart
    
    local trail = Instance.new("Trail")
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1))
    trail.Lifetime = 2
    trail.MinLength = 0
    trail.Parent = rootPart
    
    table.insert(trails, trail)
end

function Module.stop()
    for _, trail in pairs(trails) do
        if trail and trail.Parent then
            trail:Destroy()
        end
    end
    trails = {}
end

return Module
