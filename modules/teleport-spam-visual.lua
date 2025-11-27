local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() if math.random() > 0.95 then local e = Instance.new("Part") e.Size = Vector3.new(5,5,5) e.Transparency = 0.7 e.Anchored = true e.CanCollide = false e.Material = Enum.Material.Neon e.Color = Color3.fromHSV(math.random(),1,1) e.Position = char:WaitForChild("HumanoidRootPart").Position e.Parent = workspace game:GetService("Debris"):AddItem(e,0.5) end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
