local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.target = nil module.conn = game:GetService("RunService").Heartbeat:Connect(function() local closest = math.huge local target = nil for _, plr in pairs(game.Players:GetPlayers()) do if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then local dist = (plr.Character.HumanoidRootPart.Position - char:WaitForChild("HumanoidRootPart").Position).Magnitude if dist < closest then closest = dist target = plr.Character end end end module.target = target end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
