local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    module.conn = game:GetService("RunService").Heartbeat:Connect(function() for _, plr in pairs(game.Players:GetPlayers()) do if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then if (plr.Character.HumanoidRootPart.Position - char:WaitForChild("HumanoidRootPart").Position).Magnitude < 10 then pcall(function() plr.Character.Humanoid:TakeDamage(0.5) char.Humanoid.Health = math.min(char.Humanoid.Health + 0.5, char.Humanoid.MaxHealth) end) end end end end)
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
