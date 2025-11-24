local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local savedPosition

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    savedPosition = rootPart.CFrame
    
    connection = RunService.Heartbeat:Connect(function()
        wait(5)
        if character and rootPart then
            rootPart.CFrame = savedPosition
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    savedPosition = nil
end

return Module
