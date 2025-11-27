local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local part = Instance.new("Part") part.Shape = Enum.PartType.Ball part.Size = Vector3.new(8,8,8) part.Anchored = false part.CanCollide = false part.Material = Enum.Material.Neon part.Transparency = 0.5 part.Color = Color3.fromRGB(0,255,255) part.Parent = workspace local weld = Instance.new("WeldConstraint") weld.Part0 = char:WaitForChild("HumanoidRootPart") weld.Part1 = part weld.Parent = part part.Position = char.HumanoidRootPart.Position module.part = part
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
