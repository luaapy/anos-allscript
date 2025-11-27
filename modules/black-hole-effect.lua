local module = {}
local parts = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    for i = 1, 20 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(0.5, 0.5, 2)
        part.Anchored =true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.new(0, 0, 0)
        part.Parent = workspace
        table.insert(parts, part)
    end
    
    module.conn = RunService.Heartbeat:Connect(function()
        if char and hrp and hrp.Parent then
            for i, part in ipairs(parts) do
                local angle = ((tick() * 8) + (i * 18)) % 360
                local rad = math.rad(angle)
                local layer = math.floor((i - 1) / 4)
                local radius = 3 + (layer * 1.5)
                local x = math.cos(rad) * radius
                local z = math.sin(rad) * radius
                local y = layer * 1.5
                part.Position = hrp.Position + Vector3.new(x, y, z)
                part.Orientation = Vector3.new(0, angle, 0)
            end
        end
    end)
end

function module.stop()
    if module.conn then module.conn:Disconnect() end
    for _, part in ipairs(parts) do if part then part:Destroy() end end
    parts = {}
end

return module
