local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local UIS = game:GetService("UserInputService") module.conn = UIS.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Space and input.UserInputState == Enum.UserInputState.Begin then local e = Instance.new("Explosion") e.Position = char:WaitForChild("HumanoidRootPart").Position e.BlastPressure = 0 e.Parent = workspace char.HumanoidRootPart.Velocity = Vector3.new(0,100,0) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
