local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local trails = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                local part = Instance.new("Part")
                part.Size = Vector3.new(1, 3, 1)
                part.Position = rootPart.Position
                part.Anchored = true
                part.CanCollide = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromHSV((tick() % 3) / 3, 1, 1)
                part.Transparency = 0.3
                part.Parent = workspace
                
                table.insert(trails, part)
                
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
                
                if #trails > 30 then
                    local old = table.remove(trails, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
        task.wait(0.05)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, trail in pairs(trails) do
        if trail and trail.Parent then
            trail:Destroy()
        end
    end
    trails = {}
end

return Module
