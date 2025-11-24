local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        Camera.CFrame = Camera.CFrame * CFrame.Angles(0, math.rad(1), 0)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
