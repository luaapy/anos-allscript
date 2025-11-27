local module = {}
local connection

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    local discoFloor = Instance.new("Part")
    discoFloor.Name = "DiscoFloor"
    discoFloor.Size = Vector3.new(20, 0.5, 20)
    discoFloor.Anchored = true
    discoFloor.CanCollide = false
    discoFloor.Material = Enum.Material.Neon
    discoFloor.Parent = workspace
    
    connection = RunService.Heartbeat:Connect(function()
        if char and humanoidRootPart and humanoidRootPart.Parent then
            discoFloor.Position = humanoidRootPart.Position - Vector3.new(0, 3, 0)
            local hue = (tick() * 2) % 1
            discoFloor.Color = Color3.fromHSV(hue, 1, 1)
        end
    end)
end

function module.stop()
    if connection then
        connection:Disconnect()
    end
    for _, part in pairs(workspace:GetChildren()) do
        if part.Name == "DiscoFloor" then
            part:Destroy()
        end
    end
end

return module
