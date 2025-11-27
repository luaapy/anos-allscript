local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() if tick() % 2 < 0.03 then for i = 1, 10 do local part = Instance.new("Part") part.Shape = Enum.PartType.Ball part.Size = Vector3.new(i*2,i*2,i*2) part.Anchored = true part.CanCollide = false part.Material = Enum.Material.Neon part.Transparency = 0.7 part.Color = Color3.fromRGB(0,200,255) part.Position = char:WaitForChild("HumanoidRootPart").Position part.Parent = workspace game:GetService("Debris"):AddItem(part,0.5) end end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
