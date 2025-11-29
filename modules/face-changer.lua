local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local faces = {263959004, 7074749, 28118994, 42070987, 20418658, 58559070}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    local face = head:FindFirstChildOfClass("Decal")
    
    if face then
        connection = RunService.Heartbeat:Connect(function()
            face.Texture = "rbxassetid://" .. faces[math.random(1, #faces)]
            task.wait(0.5)
        end)
    end
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
