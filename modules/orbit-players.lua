local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local orbitAngle = 0
local orbitRadius = 10

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        orbitAngle = orbitAngle + 0.05
        
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local centerPos = rootPart.Position
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            local x = centerPos.X + orbitRadius * math.cos(orbitAngle)
                            local z = centerPos.Z + orbitRadius * math.sin(orbitAngle)
                            targetRoot.CFrame = CFrame.new(x, centerPos.Y, z)
                        end
                    end
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
