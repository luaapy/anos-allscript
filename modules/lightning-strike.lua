local module = {}
local connection

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        if char and humanoidRootPart and humanoidRootPart.Parent and math.random() > 0.95 then
            local lightning = Instance.new("Part")
            lightning.Size = Vector3.new(0.5, 20, 0.5)
            lightning.Position = humanoidRootPart.Position + Vector3.new(math.random(-15, 15), 10, math.random(-15, 15))
            lightning.Anchored = true
            lightning.CanCollide = false
            lightning.Material = Enum.Material.Neon
            lightning.Color = Color3.fromRGB(255, 255, 255)
            lightning.Transparency = 0.3
            lightning.Parent = workspace
            
            game:GetService("Debris"):AddItem(lightning, 0.1)
        end
    end)
end

function module.stop()
    if connection then
        connection:Disconnect()
    end
end

return module
