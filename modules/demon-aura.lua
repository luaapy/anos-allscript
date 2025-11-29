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
                for i = 1, 5 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(0.8, 0.8, 0.8)
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-4, 4),
                        math.random(-2, 2),
                        math.random(-4, 4)
                    )
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(139, 0, 0)
                    part.Transparency = 0.3
                    part.Shape = Enum.PartType.Ball
                    part.Parent = workspace
                    
                    local fire = Instance.new("Fire")
                    fire.Color = Color3.fromRGB(139, 0, 0)
                    fire.SecondaryColor = Color3.fromRGB(0, 0, 0)
                    fire.Size = 3
                    fire.Parent = part
                    
                    table.insert(particles, part)
                    
                    task.spawn(function()
                        for j = 1, 10 do
                            if part and part.Parent then
                                part.Transparency = part.Transparency + 0.07
                                task.wait(0.05)
                            end
                        end
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #particles > 50 then
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
    
    for _, particle in pairs(particles) do
        if particle and particle.Parent then
            particle:Destroy()
        end
    end
    particles = {}
end

return Module
