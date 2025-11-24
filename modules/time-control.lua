local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Module = {}
local connection
local timeSpeed = 100

function Module.start()
    connection = RunService.Heartbeat:Connect(function(deltaTime)
        Lighting.ClockTime = (Lighting.ClockTime + (deltaTime * timeSpeed)) % 24
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

function Module.setTimeSpeed(speed)
    timeSpeed = speed
end

function Module.setTime(time)
    Lighting.ClockTime = time
end

return Module
