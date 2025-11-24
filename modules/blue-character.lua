local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Color = Color3.new(0, 0, 1)
        end
    end
end

function Module.stop()
    -- Color remains
end

return Module
