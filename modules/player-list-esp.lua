local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local gui = Instance.new("ScreenGui") gui.Parent = player.PlayerGui local frame = Instance.new("Frame") frame.Size = UDim2.new(0,200,0,400) frame.Position = UDim2.new(1,-210,0,10) frame.BackgroundTransparency = 0.5 frame.Parent = gui module.gui = gui
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
