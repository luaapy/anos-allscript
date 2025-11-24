local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalSizes = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalSizes[part] = part.Size
            part.Size = part.Size * 0.3
        end
    end
    
    if humanoid then
        humanoid.HipHeight = humanoid.HipHeight * 0.3
    end
end

function Module.stop()
    local character = LocalPlayer.Character
    if character then
        for part, size in pairs(originalSizes) do
            if part and part.Parent then
                part.Size = size
            end
        end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.HipHeight = 0
        end
    end
    originalSizes = {}
end

return Module
