local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() local scale = 1 + math.sin(tick() * 5) * 0.5 for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.Size = part.Size * scale / (module.lastScale or 1) end end module.lastScale = scale end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
