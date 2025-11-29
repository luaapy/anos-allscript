local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local waves = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                for i = 1, 8 do
                    local angle = (i / 8) * math.pi * 2
                    local distance = 5
                    
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(1, 4, 0.5)
                    part.Position = rootPart.Position + Vector3.new(
                        math.cos(angle) * distance,
                        0,
                        math.sin(angle) * distance
                    )
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(0, 191, 255)
                    part.Transparency = 0.3
                    part.Parent = workspace
                    
                    table.insert(waves, part)
                    
                    task.spawn(function()
                        for j = 1, 20 do
                            if part and part.Parent then
                                part.Size = part.Size + Vector3.new(0.5, 0.2, 0.1)
                                part.Transparency = part.Transparency + 0.035
                                task.wait(0.03)
                            end
                        end
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #waves > 100 then
                    for i = 1, 20 do
                        local old = table.remove(waves, 1)
                        if old and old.Parent then
                            old:Destroy()
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, wave in pairs(waves) do
        if wave and wave.Parent then
            wave:Destroy()
        end
    end
    waves = {}
end

return Module
