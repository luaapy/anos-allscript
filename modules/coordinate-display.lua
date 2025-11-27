local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local gui = Instance.new("ScreenGui") gui.Parent = player.PlayerGui local label = Instance.new("TextLabel") label.Size = UDim2.new(0,200,0,50) label.Position = UDim2.new(0,10,0,10) label.BackgroundTransparency = 0.5 label.TextColor3 = Color3.fromRGB(255,255,255) label.Parent = gui module.conn = game:GetService("RunService").Heartbeat:Connect(function() local pos = char:WaitForChild("HumanoidRootPart").Position label.Text = string.format("X:%.1f Y:%.1f Z:%.1f",pos.X,pos.Y,pos.Z) end) module.gui = gui
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
