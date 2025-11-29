local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local sphere

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    sphere = Instance.new("Part")
    sphere.Size = Vector3.new(6, 6, 6)
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Material = Enum.Material.Neon
    sphere.Color = Color3.fromRGB(0, 255, 255)
    sphere.Transparency = 0.5
    sphere.Shape = Enum.PartType.Ball
    sphere.Parent = workspace
    
    local sparkles = Instance.new("Sparkles")
    sparkles.SparkleColor = Color3.fromRGB(0, 255, 255)
    sparkles.Parent = sphere
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent and sphere then
            sphere.CFrame = rootPart.CFrame * CFrame.new(0, 3, 0)
            
            local pulse = 1 + math.sin(tick() * 5) * 0.3
            sphere.Size = Vector3.new(6, 6, 6) * pulse
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if sphere and sphere.Parent then
        sphere:Destroy()
        sphere = nil
    end
end

return Module
