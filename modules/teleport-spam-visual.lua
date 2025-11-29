local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local effects = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                -- Create teleport effect
                local part = Instance.new("Part")
                part.Size = Vector3.new(4, 8, 4)
                part.Position = rootPart.Position
                part.Anchored = true
                part.CanCollide = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromHSV(math.random(), 1, 1)
                part.Transparency = 0.5
                part.Parent = workspace
                
                local sparkles = Instance.new("Sparkles")
                sparkles.SparkleColor = part.Color
                sparkles.Parent = part
                
                table.insert(effects, part)
                
                task.spawn(function()
                    for i = 1, 10 do
                        if part and part.Parent then
                            part.Transparency = part.Transparency + 0.05
                            part.Size = part.Size + Vector3.new(0.5, 0.5, 0.5)
                            task.wait(0.05)
                        end
                    end
                    if part and part.Parent then
                        part:Destroy()
                    end
                end)
                
                -- Clean old effects
                if #effects > 15 then
                    local old = table.remove(effects, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
        task.wait(0.1)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, effect in pairs(effects) do
        if effect and effect.Parent then
            effect:Destroy()
        end
    end
    
    effects = {}
end

return Module
