local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("Tool") or obj:IsA("Accessory") then local bill = Instance.new("BillboardGui") bill.Size =  UDim2.new(0,50,0,50) bill.Adornee = obj bill.AlwaysOnTop = true local frame = Instance.new("Frame") frame.Size = UDim2.new(1,0,1,0) frame.BackgroundColor3 = Color3.fromRGB(255,255,0) frame.Parent = bill bill.Parent = obj end end
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
