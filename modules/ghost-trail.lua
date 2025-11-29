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
                local clone = Instance.new("Part")
                clone.Size = Vector3.new(4, 6, 2)
                clone.Position = rootPart.Position
                clone.Anchored = true
                clone.CanCollide = false
                clone.Material = Enum.Material.ForceField
                clone.Color = Color3.fromRGB(200, 200, 255)
                clone.Transparency = 0.5
                clone.Parent = workspace
                
                table.insert(trails, clone)
                
                task.spawn(function()
                    for i = 1, 15 do
                        if clone and clone.Parent then
                            clone.Transparency = clone.Transparency + 0.033
                            task.wait(0.05)
                        end
                    end
                    if clone and clone.Parent then
                        clone:Destroy()
                    end
                end)
                
                if #trails > 20 then
                    local old = table.remove(trails, 1)
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
    
    for _, trail in pairs(trails) do
        if trail and trail.Parent then
            trail:Destroy()
        end
    end
    
    trails = {}
end

return Module
