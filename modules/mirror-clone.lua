local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local mirrorClone

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    mirrorClone = character:Clone()
    mirrorClone.Name = "MirrorClone"
    
    -- Make clone visible but non-collidable
    for _, part in pairs(mirrorClone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Transparency = 0.5
            part.Material = Enum.Material.ForceField
        end
        if part:IsA("Script") or part:IsA("LocalScript") then
            part:Destroy()
        end
    end
    
    mirrorClone.Parent = workspace
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent and mirrorClone then
            local mirrorPos = rootPart.Position + Vector3.new(5, 0, 0)
            if mirrorClone.PrimaryPart then
                mirrorClone:SetPrimaryPartCFrame(CFrame.new(mirrorPos) * rootPart.CFrame.Rotation)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if mirrorClone and mirrorClone.Parent then
        mirrorClone:Destroy()
        mirrorClone = nil
    end
end

return Module
