local module = {}
local shield

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    shield = Instance.new("Part")
    shield.Shape = Enum.PartType.Ball
    shield.Size = Vector3.new(12, 12, 12)
    shield.Anchored = false
    shield.CanCollide = false
    shield.Material = Enum.Material.ForceField
    shield.Transparency = 0.7
    shield.Color = Color3.fromRGB(0, 200, 255)
    shield.Parent = workspace
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = hrp
    weld.Part1 = shield
    weld.Parent = shield
    
    shield.Position = hrp.Position
end

function module.stop()
    if shield then shield:Destroy() end
end

return module
