local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local Mouse = player:GetMouse() module.conn = Mouse.Button1Down:Connect(function() local target = Mouse.Hit.Position local bp = Instance.new("BodyPosition") bp.Position = target bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge) bp.Parent = char:WaitForChild("HumanoidRootPart") task.wait(1) bp:Destroy() end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
