local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local jumpHeight = 500
local originalJumpPower = 50

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    originalJumpPower = humanoid.JumpPower
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid then
            humanoid.JumpPower = jumpHeight
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = originalJumpPower
        end
    end
end

function Module.setHeight(height)
    jumpHeight = height
end

return Module
