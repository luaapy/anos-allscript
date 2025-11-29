local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local lastJump = 0
local jumpCooldown = 2

function Module.start()
    connection = UserInputService.JumpRequest:Connect(function()
        if tick() - lastJump > jumpCooldown then
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                
                if rootPart then
                    -- Rocket boost
                    rootPart.AssemblyLinearVelocity = Vector3.new(0, 100, 0)
                    
                    lastJump = tick()
                    
                    -- Explosion effect
                    local explosion = Instance.new("Explosion")
                    explosion.Position = rootPart.Position - Vector3.new(0, 3, 0)
                    explosion.BlastRadius = 5
                    explosion.BlastPressure = 0
                    explosion.Parent = workspace
                    
                    -- Smoke trail
                    for i = 1, 10 do
                        task.spawn(function()
                            task.wait(i * 0.05)
                            local part = Instance.new("Part")
                            part.Size = Vector3.new(2, 2, 2)
                            part.Position = rootPart.Position - Vector3.new(0, i, 0)
                            part.Anchored = true
                            part.CanCollide = false
                            part.Material = Enum.Material.Neon
                            part.Color = Color3.fromRGB(255, 69, 0)
                            part.Transparency = 0.5
                            part.Shape = Enum.PartType.Ball
                            part.Parent = workspace
                            
                            for j = 1, 10 do
                                part.Transparency = part.Transparency + 0.05
                                part.Size = part.Size * 1.1
                                task.wait(0.03)
                            end
                            part:Destroy()
                        end)
                    end
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
