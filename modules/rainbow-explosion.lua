local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                local explosion = Instance.new("Explosion")
                explosion.Position = rootPart.Position
                explosion.BlastRadius = 5
                explosion.BlastPressure = 0
                
                -- Rainbow color
                local hue = (tick() % 3) / 3
                explosion.BlastRadius = 10
                explosion.Parent = workspace
                
                task.wait(0.1)
                if explosion and explosion.Parent then
                    explosion:Destroy()
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
end

return Module
