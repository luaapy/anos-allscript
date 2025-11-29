local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    connection = RunService.Heartbeat:Connect(function()
        local hue = (tick() * 2) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Color = color
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
