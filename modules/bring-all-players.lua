local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.execute()
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        targetRoot.CFrame = rootPart.CFrame + Vector3.new(5, 0, 0)
                    end
                end
            end
        end
    end
end

function Module.start()
    -- Passive module
end

function Module.stop()
    -- Nothing to stop
end

return Module
