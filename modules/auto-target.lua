local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local currentTarget

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local nearestPlayer = nil
        local nearestDistance = math.huge
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local distance = (rootPart.Position - targetRoot.Position).Magnitude
                    if distance < nearestDistance and distance < 50 then
                        nearestDistance = distance
                        nearestPlayer = player
                    end
                end
            end
        end
        
        currentTarget = nearestPlayer
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    currentTarget = nil
end

return Module
