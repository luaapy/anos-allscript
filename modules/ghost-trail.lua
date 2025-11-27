local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() if tick() % 0.1 < 0.03 then local clone = char:Clone() for _, p in pairs(clone:GetDescendants()) do if p:IsA("BasePart") then p.Anchored = true p.CanCollide = false p.Transparency = 0.7 end end clone.Parent = workspace game:GetService("Debris"):AddItem(clone, 1) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
