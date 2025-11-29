local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local sparks = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                for i = 1, 3 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(0.3, 0.3, 2)
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-4, 4),
                        math.random(-3, 3),
                        math.random(-4, 4)
                    )
                    part.Orientation = Vector3.new(
                        math.random(0, 360),
                        math.random(0, 360),
                        math.random(0, 360)
                    )
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(255, 255, 0)
                    part.Parent = workspace
                    
                    table.insert(sparks, part)
                    
                    task.spawn(function()
                        task.wait(0.1)
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #sparks > 20 then
                    local old = table.remove(sparks, 1)
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
    
    for _, spark in pairs(sparks) do
        if spark and spark.Parent then
            spark:Destroy()
        end
    end
    
    sparks = {}
end

return Module
