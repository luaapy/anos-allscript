local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then local sel = Instance.new("SelectionBox") sel.LineThickness = 0.2 sel.Color3 = Color3.fromHSV(math.random(),1,1) sel.Adornee = part sel.Parent = part end end
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
