local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local function createWing(side) local wing = Instance.new("Part") wing.Size = Vector3.new(0.5,5,3) wing.Anchored = false wing.CanCollide = false wing.Material = Enum.Material.Neon wing.Color = Color3.fromRGB(255,255,255) wing.Parent = workspace local weld = Instance.new("WeldConstraint") weld.Part0 = char:WaitForChild("Torso") or char:WaitForChild("UpperTorso") weld.Part1 = wing weld.Parent = wing wing.Position = char.HumanoidRootPart.Position + Vector3.new(side*3,0,0) return wing end module.wing1 = createWing(-1) module.wing2 = createWing(1)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
