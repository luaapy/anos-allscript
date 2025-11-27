local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    char:WaitForChild("HumanoidRootPart").Touched:Connect(function(hit) if hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char then pcall(function() local bv = Instance.new("BodyVelocity") bv.Velocity = (hit.Position - char.HumanoidRootPart.Position).Unit * 100 bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge) bv.Parent = hit.Parent.HumanoidRootPart task.wait(0.5) bv:Destroy() end) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
