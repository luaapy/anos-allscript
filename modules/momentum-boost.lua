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
            local currentVelocity = rootPart.AssemblyLinearVelocity
            local boost = humanoid.MoveDirection * 1.5
            
            rootPart.AssemblyLinearVelocity = currentVelocity + boost
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
