local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local parts = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                for i = 1, 3 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(math.random(1, 3), math.random(1, 3), math.random(1, 3))
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-10, 10),
                        math.random(5, 15),
                        math.random(-10, 10)
                    )
                    part.Anchored = false
                    part.CanCollide = true
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromHSV(math.random(), 1, 1)
                    part.Parent = workspace
                    
                    table.insert(parts, part)
                    
                    task.spawn(function()
                        task.wait(5)
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #parts > 50 then
                    local old = table.remove(parts, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
        task.wait(0.3)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, part in pairs(parts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    parts = {}
end

return Module
