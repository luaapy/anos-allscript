local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    for i = 1, 20 do local part = Instance.new("Part") part.Size = Vector3.new(2,2,2) part.Anchored = true part.Material = Enum.Material.Neon part.Color = Color3.fromHSV(math.random(),1,1) part.Position = char:WaitForChild("HumanoidRootPart").Position + Vector3.new(math.random(-10,10), math.random(0,10), math.random(-10,10)) part.Parent = workspace end
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
