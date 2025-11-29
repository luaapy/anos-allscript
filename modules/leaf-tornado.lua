local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local leaves = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create spinning leaves
    for i = 1, 15 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(0.5, 0.1, 0.8)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(0, 128, 0)
        part.Parent = workspace
        table.insert(leaves, part)
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent then
            local t = tick() * 3
            for i, leaf in pairs(leaves) do
                if leaf and leaf.Parent then
                    local angle = (i / #leaves) * math.pi * 2 + t
                    local radius = 5 + math.sin(t + i) * 2
                    local height = math.sin(t * 2 + i) * 4
                    
                    local offset = Vector3.new(
                        math.cos(angle) * radius,
                        height,
                        math.sin(angle) * radius
                    )
                    
                    leaf.CFrame = CFrame.new(rootPart.Position + offset) * CFrame.Angles(t, t * 2, 0)
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
    
    for _, leaf in pairs(leaves) do
        if leaf and leaf.Parent then
            leaf:Destroy()
        end
    end
    leaves = {}
end

return Module
