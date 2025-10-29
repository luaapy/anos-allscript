local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Module = {}
local connection
local clickSpeed = 0.01

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(clickSpeed)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
