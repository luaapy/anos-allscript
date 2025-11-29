local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local platform

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 1, 10)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Material = Enum.Material.ForceField
    platform.Color = Color3.fromRGB(135, 206, 250)
    platform.Transparency = 0.3
    platform.Parent = workspace
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent and platform then
            platform.Position = rootPart.Position - Vector3.new(0, 4, 0)
            platform.Orientation = Vector3.new(0, (tick() * 50) % 360, 0)
            
            local hue = (tick() % 5) / 5
            platform.Color = Color3.fromHSV(hue, 0.5, 1)
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if platform and platform.Parent then
        platform:Destroy()
        platform = nil
    end
end

return Module
