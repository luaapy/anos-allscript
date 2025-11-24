local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local fires = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Parent = part
            table.insert(fires, fire)
        end
    end
end

function Module.stop()
    for _, fire in pairs(fires) do
        if fire and fire.Parent then
            fire:Destroy()
        end
    end
    fires = {}
end

return Module
