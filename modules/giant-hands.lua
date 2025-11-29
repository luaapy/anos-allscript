local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local hands = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    pcall(function()
        for _, part in pairs(character:GetDescendants()) do
            if part.Name == "LeftHand" or part.Name == "RightHand" then
                local originalSize = part.Size
                hands[part] = originalSize
                
                connection = RunService.Heartbeat:Connect(function()
                    if part and part.Parent then
                        part.Size = originalSize * 5
                    end
                end)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for part, originalSize in pairs(hands) do
        if part and part.Parent then
            part.Size = originalSize
        end
    end
    
    hands = {}
end

return Module
