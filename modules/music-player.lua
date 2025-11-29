local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local sound

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1838673350" -- Example music ID
    sound.Looped = true
    sound.Volume = 1
    sound.Parent = rootPart
    sound:Play()
end

function Module.stop()
    if sound and sound.Parent then
        sound:Stop()
        sound:Destroy()
        sound = nil
    end
end

return Module
