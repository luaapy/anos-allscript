local module = {}
local footprints = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local lastPos = hrp.Position
    
    module.conn = RunService.Heartbeat:Connect(function()
        if char and hrp and hrp.Parent and (hrp.Position - lastPos).Magnitude > 3 then
            local footprint = Instance.new("Part")
            footprint.Size = Vector3.new(2, 0.2, 2)
            footprint.Anchored = true
            footprint.CanCollide = false
            footprint.Material = Enum.Material.Neon
            footprint.Color = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
            footprint.Position = hrp.Position - Vector3.new(0, 3, 0)
            footprint.Parent = workspace
            table.insert(footprints, footprint)
            game:GetService("Debris"):AddItem(footprint, 3)
            lastPos = hrp.Position
        end
    end)
end

function module.stop()
    if module.conn then module.conn:Disconnect() end
    for _, fp in ipairs(footprints) do if fp then fp:Destroy() end end
    footprints = {}
end

return module
