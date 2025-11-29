local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = rootPart.Touched:Connect(function(hit)
        if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= character then
            local targetParts = hit.Parent:GetDescendants()
            for _, part in pairs(targetParts) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                    part.Material = Enum.Material.Ice
                    part.Color = Color3.fromRGB(100, 200, 255)
                    
                    task.spawn(function()
                        task.wait(3)
                        part.Anchored = false
                    end)
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
end

return Module
