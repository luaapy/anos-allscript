local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local att0 = Instance.new("Attachment") att0.Parent = char:WaitForChild("Head") for i = 1, 8 do local part = Instance.new("Part") part.Size = Vector3.new(1,1,1) part.Anchored = true part.Transparency = 1 part.Position = char.HumanoidRootPart.Position + Vector3.new(math.random(-20,20), 0, math.random(-20,20)) part.Parent = workspace local att1 = Instance.new("Attachment") att1.Parent = part local beam = Instance.new("Beam") beam.Attachment0 = att0 beam.Attachment1 = att1 beam.Width0 = 1 beam.Width1 = 1 beam.Color = ColorSequence.new(Color3.fromHSV(i/8,1,1)) beam.Parent = att0 end
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
