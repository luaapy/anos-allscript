local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local mouse = LocalPlayer:GetMouse()
            if mouse.Target and mouse.Target.Parent then
                local explosion = Instance.new("Explosion")
                explosion.Position = mouse.Hit.Position
                explosion.BlastRadius = 20
                explosion.BlastPressure = 1000000
                explosion.Parent = workspace
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
