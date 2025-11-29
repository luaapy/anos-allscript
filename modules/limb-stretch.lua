local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local originalSizes = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name:find("Arm") or part.Name:find("Leg")) then
            originalSizes[part] = part.Size
        end
    end
    
    connection = RunService.Heartbeat:Connect(function()
        for part, originalSize in pairs(originalSizes) do
            if part and part.Parent then
                local stretch = 1 + math.sin(tick() * 3) * 2
                part.Size = Vector3.new(
                    originalSize.X,
                    originalSize.Y * stretch,
                    originalSize.Z
                )
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
