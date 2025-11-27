local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.waypoint = char:WaitForChild("HumanoidRootPart").Position local UIS = game:GetService("UserInputService") module.conn = UIS.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Z then module.waypoint = char.HumanoidRootPart.Position elseif input.KeyCode == Enum.KeyCode.X then char.HumanoidRootPart.CFrame = CFrame.new(module.waypoint) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
