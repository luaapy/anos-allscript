local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalTransparency = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalTransparency[part] = part.Transparency
            part.Transparency = 1
        elseif part:IsA("Decal") then
            originalTransparency[part] = part.Transparency
            part.Transparency = 1
        end
    end
end

function Module.stop()
    local character = LocalPlayer.Character
    if character then
        for part, transparency in pairs(originalTransparency) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
    end
    originalTransparency = {}
end

return Module
