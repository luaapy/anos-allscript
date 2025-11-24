local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connections = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local connection = part.Touched:Connect(function(hit)
                if hit.Parent and hit.Parent ~= character then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = hit.Position
                    explosion.BlastRadius = 10
                    explosion.BlastPressure = 500000
                    explosion.Parent = workspace
                end
            end)
            table.insert(connections, connection)
        end
    end
end

function Module.stop()
    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
    connections = {}
end

return Module
