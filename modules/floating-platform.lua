local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local part = Instance.new("Part") part.Size = Vector3.new(10, 1, 10) part.Anchored = true part.Material = Enum.Material.Glass part.Transparency = 0.5 part.Parent = workspace part.Position = char:WaitForChild("HumanoidRootPart").Position - Vector3.new(0, 3.5, 0) module.part = part
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
