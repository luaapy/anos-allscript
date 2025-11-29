local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid then
            -- Steal health from nearby players (client-side simulation)
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if targetRoot and rootPart then
                        local distance = (rootPart.Position - targetRoot.Position).Magnitude
                        if distance < 10 then
                            pcall(function()
                                humanoid.Health = math.min(humanoid.Health + 1, humanoid.MaxHealth)
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
