local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local canDoubleJump = false local UIS = game:GetService("UserInputService") char:WaitForChild("Humanoid").StateChanged:Connect(function(old,new) if new == Enum.HumanoidStateType.Landed then canDoubleJump = true end end) module.conn = UIS.JumpRequest:Connect(function() if canDoubleJump and char.Humanoid:GetState() ~= Enum.HumanoidStateType.Landed then char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X,50,char.HumanoidRootPart.Velocity.Z) canDoubleJump = false end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
