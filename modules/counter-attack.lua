local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health < humanoid.MaxHealth then
                -- Simple counter mechanic simulation
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetHumanoid = player.Character:FindFirstChild("Humanoid")
                        if targetHumanoid then
                            pcall(function()
                                targetHumanoid:TakeDamage(5)
                            end)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
