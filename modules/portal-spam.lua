local module = {}
local parts = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    for i = 1, 8 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(2, 12, 0.5)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromHSV(i / 8, 1, 1)
        part.Transparency = 0.3
        part.Parent = workspace
        table.insert(parts, part)
    end
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if char and humanoidRootPart and humanoidRootPart.Parent then
            for i, part in ipairs(parts) do
                local angle = ((tick() * 2) + (i * 45)) % 360
                local rad = math.rad(angle)
                local radius = 8
                local x = math.cos(rad) * radius
                local z = math.sin(rad) * radius
                part.Position = humanoidRootPart.Position + Vector3.new(x, 0, z)
                part.Orientation = Vector3.new(0, angle, 0)
            end
        end
    end)
    
    module.connection = connection
end

function module.stop()
    if module.connection then
        module.connection:Disconnect()
    end
    for _, part in ipairs(parts) do
        if part then
            part:Destroy()
        end
    end
    parts = {}
end

return module
