local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local targetPlayer

function Module.start()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            targetPlayer = player
            break
        end
    end
    
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character and targetPlayer and targetPlayer.Character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if rootPart and targetRoot then
                local direction = (targetRoot.Position - rootPart.Position).Unit
                rootPart.CFrame = CFrame.new(rootPart.Position + direction * 0.5)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    targetPlayer = nil
end

return Module
