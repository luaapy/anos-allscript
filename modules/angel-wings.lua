local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local wings = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create left wing
    for i = 1, 5 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(0.3, 2 + i * 0.5, 1)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(255, 255, 255)
        part.Transparency = 0.3
        part.Parent = workspace
        table.insert(wings, {part = part, offset = Vector3.new(-2 - i * 0.3, 1, -i * 0.2), side = -1})
    end
    
    -- Create right wing
    for i = 1, 5 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(0.3, 2 + i * 0.5, 1)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(255, 255, 255)
        part.Transparency = 0.3
        part.Parent = workspace
        table.insert(wings, {part = part, offset = Vector3.new(2 + i * 0.3, 1, -i * 0.2), side = 1})
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent then
            local flap = math.sin(tick() * 5) * 0.5
            for _, wing in pairs(wings) do
                if wing.part and wing.part.Parent then
                    local offset = wing.offset + Vector3.new(0, flap, 0)
                    wing.part.CFrame = rootPart.CFrame * CFrame.new(offset)
                end
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, wing in pairs(wings) do
        if wing.part and wing.part.Parent then
            wing.part:Destroy()
        end
    end
    wings = {}
end

return Module
