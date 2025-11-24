local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local platforms = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 1, 10)
    platform.Position = rootPart.Position - Vector3.new(0, 5, 0)
    platform.Anchored = true
    platform.Material = Enum.Material.Neon
    platform.BrickColor = BrickColor.new("Bright blue")
    platform.Parent = workspace
    
    table.insert(platforms, platform)
end

function Module.stop()
    for _, platform in pairs(platforms) do
        if platform and platform.Parent then
            platform:Destroy()
        end
    end
    platforms = {}
end

function Module.createPlatform()
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local platform = Instance.new("Part")
            platform.Size = Vector3.new(10, 1, 10)
            platform.Position = rootPart.Position - Vector3.new(0, 3, 0)
            platform.Anchored = true
            platform.Material = Enum.Material.Neon
            platform.BrickColor = BrickColor.random()
            platform.Parent = workspace
            
            table.insert(platforms, platform)
        end
    end
end

return Module
