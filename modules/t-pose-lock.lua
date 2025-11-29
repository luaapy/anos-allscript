local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Stop all animations
    for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do
        anim:Stop()
    end
    
    -- Force T-pose by disabling animations
    for _, anim in pairs(humanoid:GetPlayingAnimationTracks()) do
        anim.Priority = Enum.AnimationPriority.Idle
    end
end

function Module.stop()
    -- Animations will resume normally
end

return Module
