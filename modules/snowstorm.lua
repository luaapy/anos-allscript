local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local snowflakes = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                for i = 1, 5 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(0.3, 0.3, 0.3)
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-15, 15),
                        math.random(10, 20),
                        math.random(-15, 15)
                    )
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(255, 255, 255)
                    part.Transparency = 0.3
                    part.Shape = Enum.PartType.Ball
                    part.Parent = workspace
                    
                    table.insert(snowflakes, part)
                    
                    task.spawn(function()
                        for j = 1, 100 do
                            if part and part.Parent then
                                part.Position = part.Position - Vector3.new(0, 0.2, 0)
                                task.wait(0.05)
                            end
                        end
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #snowflakes > 100 then
                    local old = table.remove(snowflakes, 1)
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
    
    for _, snow in pairs(snowflakes) do
        if snow and snow.Parent then
            snow:Destroy()
        end
    end
    snowflakes = {}
end

return Module
