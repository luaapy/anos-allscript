local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalSize

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    
    originalSize = head.Size
    head.Size = Vector3.new(10, 10, 10)
end

function Module.stop()
    local character = LocalPlayer.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head and originalSize then
            head.Size = originalSize
        end
    end
end

return Module
