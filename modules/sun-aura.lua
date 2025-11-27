local module = {}
local sun

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    sun = Instance.new("Part")
    sun.Shape = Enum.PartType.Ball
    sun.Size = Vector3.new(10, 10, 10)
    sun.Anchored = false
    sun.CanCollide = false
    sun.Material = Enum.Material.Neon
    sun.Color = Color3.fromRGB(255, 255, 0)
    sun.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Brightness = 5
    light.Range = 60
    light.Color = Color3.fromRGB(255, 255, 0)
    light.Parent = sun
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = hrp
    weld.Part1 = sun
    weld.Parent = sun
    
    sun.Position = hrp.Position
end

function module.stop()
    if sun then sun:Destroy() end
end

return module
