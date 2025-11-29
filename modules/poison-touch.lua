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
            local targetHumanoid = hit.Parent:FindFirstChild("Humanoid")
            if targetHumanoid then
                pcall(function()
                    targetHumanoid:TakeDamage(2)
                end)
                
                -- Poison effect
                local poison = Instance.new("Part")
                poison.Size = Vector3.new(1, 1, 1)
                poison.Position = hit.Position
                poison.Anchored = true
                poison.CanCollide = false
                poison.Material = Enum.Material.Neon
                poison.Color = Color3.fromRGB(0, 128, 0)
                poison.Transparency = 0.5
                poison.Shape = Enum.PartType.Ball
                poison.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 10 do
                        poison.Transparency = poison.Transparency + 0.05
                        task.wait(0.1)
                    end
                    poison:Destroy()
                end)
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
