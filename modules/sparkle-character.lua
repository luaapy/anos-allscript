local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local sparkles = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local sparkle = Instance.new("Sparkles")
            sparkle.Parent = part
            table.insert(sparkles, sparkle)
        end
    end
end

function Module.stop()
    for _, sparkle in pairs(sparkles) do
        if sparkle and sparkle.Parent then
            sparkle:Destroy()
        end
    end
    sparkles = {}
end

return Module
