local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local part = Instance.new("Part") part.Size = Vector3.new(10,1,10) part.Transparency = 1 part.Anchored = true part.CanCollide = true part.Parent = workspace module.conn = game:GetService("RunService").Heartbeat:Connect(function() part.Position = char:WaitForChild("HumanoidRootPart").Position - Vector3.new(0,3.5,0) end) module.part = part
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
