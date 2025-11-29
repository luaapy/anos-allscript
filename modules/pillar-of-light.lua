local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local pillar

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    pillar = Instance.new("Part")
    pillar.Size = Vector3.new(3, 100, 3)
    pillar.Anchored = true
    pillar.CanCollide = false
    pillar.Material = Enum.Material.Neon
    pillar.Color = Color3.fromRGB(255, 255, 255)
    pillar.Transparency = 0.5
    pillar.Shape = Enum.PartType.Cylinder
    pillar.Parent = workspace
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent and pillar then
            pillar.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 50, 0)) * CFrame.Angles(0, 0, math.rad(90))
            pillar.Transparency = 0.3 + math.sin(tick() * 3) * 0.2
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if pillar and pillar.Parent then
        pillar:Destroy()
        pillar = nil
    end
end

return Module
