local module = {}
local connection

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        if char and humanoidRootPart and humanoidRootPart.Parent and math.random() > 0.9 then
            local firework = Instance.new("Part")
            firework.Size = Vector3.new(1, 1, 1)
            firework.Position = humanoidRootPart.Position + Vector3.new(math.random(-10, 10), math.random(10, 20), math.random(-10, 10))
            firework.Anchored = true
            firework.CanCollide = false
            firework.Material = Enum.Material.Neon
            firework.Color = Color3.fromHSV(math.random(), 1, 1)
            firework.Parent = workspace
            
            local sparkle = Instance.new("Sparkles")
            sparkle.Parent = firework
            
            local fire = Instance.new("Fire")
            fire.Parent = firework
            fire.Color = firework.Color
            fire.SecondaryColor = firework.Color
            
            game:GetService("Debris"):AddItem(firework, 2)
        end
    end)
end

function module.stop()
    if connection then
        connection:Disconnect()
    end
end

return module
