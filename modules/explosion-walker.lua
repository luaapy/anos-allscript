local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid and humanoid.MoveDirection.Magnitude > 0 then
            local explosion = Instance.new("Explosion")
            explosion.Position = rootPart.Position - Vector3.new(0, 2, 0)
            explosion.BlastRadius = 5
            explosion.BlastPressure = 0
            explosion.Parent = workspace
            
            task.spawn(function()
                task.wait(0.1)
                if explosion and explosion.Parent then
                    explosion:Destroy()
                end
            end)
        end
        task.wait(0.2)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
