local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    connection = RunService.Heartbeat:Connect(function()
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Glitch effect
                    local glitch = math.random() > 0.7
                    if glitch then
                        part.CFrame = part.CFrame * CFrame.new(
                            math.random(-1, 1) * 0.1,
                            math.random(-1, 1) * 0.1,
                            math.random(-1, 1) * 0.1
                        )
                        part.Color = Color3.fromHSV(math.random(), 1, 1)
                    end
                end
            end
        end
        task.wait(0.05)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
