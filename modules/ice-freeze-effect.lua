local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local particles = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                -- Create ice particles
                for i = 1, 2 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(0.5, 0.5, 0.5)
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-5, 5),
                        math.random(-2, 2),
                        math.random(-5, 5)
                    )
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Ice
                    part.Color = Color3.fromRGB(100, 200, 255)
                    part.Transparency = 0.3
                    part.Parent = workspace
                    
                    local sparkle = Instance.new("Sparkles")
                    sparkle.SparkleColor = Color3.fromRGB(100, 200, 255)
                    sparkle.Parent = part
                    
                    table.insert(particles, part)
                    
                    task.spawn(function()
                        for i = 1, 20 do
                            if part and part.Parent then
                                part.Transparency = part.Transparency + 0.035
                                part.Size = part.Size * 1.05
                                task.wait(0.05)
                            end
                        end
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                -- Clean old particles
                if #particles > 30 then
                    local old = table.remove(particles, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, part in pairs(particles) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    
    particles = {}
end

return Module
