local module = {}
local parts = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    for i = 1, 12 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(1, 15, 1)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Transparency = 0.3
        part.Parent = workspace
        table.insert(parts, part)
    end
    
    module.conn = RunService.Heartbeat:Connect(function()
        if char and hrp and hrp.Parent then
            for i, part in ipairs(parts) do
                local angle = ((tick() * 5) + (i * 30)) % 360
                local rad = math.rad(angle)
                local radius = 5 + math.sin(tick() * 2) * 2
                local x = math.cos(rad) * radius
                local z = math.sin(rad) * radius
                part.Position = hrp.Position + Vector3.new(x, 0, z)
                part.Color = Color3.fromHSV((tick() + i * 0.1) % 1, 1, 1)
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
