local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local originalSizes = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Store original sizes
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalSizes[part] = part.Size
        end
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid and humanoid.Parent then
            local scale = 1 + math.sin(tick() * 5) * 0.5
            
            for part, originalSize in pairs(originalSizes) do
                if part and part.Parent then
                    part.Size = originalSize * scale
                end
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for part, originalSize in pairs(originalSizes) do
        if part and part.Parent then
            part.Size = originalSize
        end
    end
    
    originalSizes = {}
end

return Module
