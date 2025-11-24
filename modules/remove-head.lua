local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalHead

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    
    originalHead = head
    head.Transparency = 1
    
    for _, child in pairs(head:GetChildren()) do
        if child:IsA("Decal") then
            child.Transparency = 1
        end
    end
end

function Module.stop()
    if originalHead and originalHead.Parent then
        originalHead.Transparency = 0
        for _, child in pairs(originalHead:GetChildren()) do
            if child:IsA("Decal") then
                child.Transparency = 0
            end
        end
    end
end

return Module
