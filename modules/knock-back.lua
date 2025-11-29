local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = rootPart.Touched:Connect(function(hit)
        if hit.Parent and hit.Parent:FindFirstChild("HumanoidRootPart") and hit.Parent ~= character then
            local targetRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local knockbackDirection = (targetRoot.Position - rootPart.Position).Unit
                targetRoot.AssemblyLinearVelocity = knockbackDirection * 100 + Vector3.new(0, 50, 0)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
