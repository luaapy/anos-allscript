local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do
        anim:AdjustSpeed(3)
    end
    
    humanoid.WalkSpeed = humanoid.WalkSpeed * 3
end

function Module.stop()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do
                anim:AdjustSpeed(1)
            end
        end
    end
end

return Module
