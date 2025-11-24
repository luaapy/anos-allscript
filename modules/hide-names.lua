local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalNames = {}

function Module.start()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                originalNames[player] = humanoid.DisplayName
                humanoid.DisplayName = "???"
            end
        end
    end
end

function Module.stop()
    for player, name in pairs(originalNames) do
        if player and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.DisplayName = name
            end
        end
    end
    originalNames = {}
end

return Module
