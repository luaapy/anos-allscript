local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local cracks = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                for i = 1, 3 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(math.random(1, 3), 0.2, math.random(1, 3))
                    part.Position = rootPart.Position + Vector3.new(
                        math.random(-10, 10),
                        -3,
                        math.random(-10, 10)
                    )
                    part.Orientation = Vector3.new(0, math.random(0, 360), 0)
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Slate
                    part.Color = Color3.fromRGB(139, 69, 19)
                    part.Parent = workspace
                    
                    table.insert(cracks, part)
                    
                    task.spawn(function()
                        task.wait(3)
                        for j = 1, 10 do
                            if part and part.Parent then
                                part.Transparency = j * 0.1
                                task.wait(0.1)
                            end
                        end
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end)
                end
                
                if #cracks > 30 then
                    local old = table.remove(cracks, 1)
                    if old and old.Parent then
                        old:Destroy()
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
    
    for _, crack in pairs(cracks) do
        if crack and crack.Parent then
            crack:Destroy()
        end
    end
    cracks = {}
end

return Module
