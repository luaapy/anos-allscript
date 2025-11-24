local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Module = {}
local connection
local customGravity = 50
local originalGravity = 196.2

function Module.start()
    originalGravity = Workspace.Gravity
    
    connection = RunService.Heartbeat:Connect(function()
        Workspace.Gravity = customGravity
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    Workspace.Gravity = originalGravity
end

function Module.setGravity(value)
    customGravity = value
end

return Module
