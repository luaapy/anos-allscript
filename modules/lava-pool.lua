local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local lavaPool

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    lavaPool = Instance.new("Part")
    lavaPool.Size = Vector3.new(15, 0.5, 15)
    lavaPool.Anchored = true
    lavaPool.CanCollide = false
    lavaPool.Material = Enum.Material.Neon
    lavaPool.Color = Color3.fromRGB(255, 100, 0)
    lavaPool.Parent = workspace
    
    local fire = Instance.new("Fire")
    fire.Size = 10
    fire.Heat = 15
    fire.Color = Color3.fromRGB(255, 100, 0)
    fire.SecondaryColor = Color3.fromRGB(255, 69, 0)
    fire.Parent = lavaPool
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent and lavaPool then
            lavaPool.Position = rootPart.Position - Vector3.new(0, 3, 0)
            lavaPool.Color = Color3.fromHSV((tick() % 0.5) / 0.5, 1, 1)
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if lavaPool and lavaPool.Parent then
        lavaPool:Destroy()
        lavaPool = nil
    end
end

return Module
