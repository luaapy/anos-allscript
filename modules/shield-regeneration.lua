local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local shield = 0
local maxShield = 100

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        if shield < maxShield then
            shield = shield + 1
        end
        task.wait(0.5)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    shield = 0
end

return Module
