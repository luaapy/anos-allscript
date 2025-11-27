local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() local ray = Ray.new(char:WaitForChild("HumanoidRootPart").Position, char.HumanoidRootPart.CFrame.LookVector * 3) local hit = workspace:FindPartOnRay(ray, char) if hit and char.Humanoid.MoveVector.Magnitude > 0 then char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 30, char.HumanoidRootPart.Velocity.Z) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
