local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    for _, plr in pairs(game.Players:GetPlayers()) do if plr.Character then for _, part in pairs(plr.Character:GetDescendants()) do if part:IsA("BasePart") then local sel = Instance.new("SelectionBox") sel.Adornee = part sel.Parent = part end end end end
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.part then module.part:Destroy() end if module.cc then module.cc:Destroy() end if module.blur then module.blur:Destroy() end if module.dof then module.dof:Destroy() end if module.gui then module.gui:Destroy() end
end

return module
