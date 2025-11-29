local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local sliding = false

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid and humanoid.MoveDirection.Magnitude > 0 then
            rootPart.Velocity = rootPart.CFrame.LookVector * 30
            
            -- Create slide particles
            if math.random() > 0.7 then
                local part = Instance.new("Part")
                part.Size = Vector3.new(0.5, 0.1, 0.5)
                part.Position = rootPart.Position - Vector3.new(0, 2, 0)
                part.Anchored = true
                part.CanCollide = false
                part.Material = Enum.Material.Ice
                part.Color = Color3.fromRGB(135, 206, 250)
                part.Transparency = 0.5
                part.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 10 do
                        part.Transparency = part.Transparency + 0.05
                        task.wait(0.05)
                    end
                    part:Destroy()
                end)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
