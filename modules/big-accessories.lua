local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            for _, accessory in pairs(character:GetChildren()) do
                if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") then
                    accessory.Handle.Size = Vector3.new(5, 5, 5)
                end
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
