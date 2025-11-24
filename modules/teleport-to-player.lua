local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.teleport(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if not targetPlayer then
        for _, player in pairs(Players:GetPlayers()) do
            if string.lower(player.Name):find(string.lower(playerName)) then
                targetPlayer = player
                break
            end
        end
    end
    
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localChar = LocalPlayer.Character
        
        if targetRoot and localChar then
            local localRoot = localChar:FindFirstChild("HumanoidRootPart")
            if localRoot then
                localRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end

function Module.start()
    -- Passive module, use Module.teleport(playerName) to teleport
end

function Module.stop()
    -- Nothing to stop
end

return Module
