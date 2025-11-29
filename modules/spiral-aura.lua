local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local parts = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create spiral particles
    for i = 1, 20 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(1, 1, 1)
        part.Shape = Enum.PartType.Ball
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(138, 43, 226)
        part.Anchored = true
        part.CanCollide = false
        part.Parent = workspace
        table.insert(parts, part)
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent then
            local t = tick() * 2
            for i, part in pairs(parts) do
                if part and part.Parent then
                    local angle = (i / #parts) * math.pi * 2 + t
                    local radius = 5 + math.sin(t + i) * 2
                    local height = math.sin(t * 2 + i) * 3
                    
                    local offset = Vector3.new(
                        math.cos(angle) * radius,
                        height,
                        math.sin(angle) * radius
                    )
                    
                    part.Position = rootPart.Position + offset
                    part.Color = Color3.fromHSV((tick() + i / #parts) % 1, 1, 1)
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
    
    for _, part in pairs(parts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    
    parts = {}
end

return Module
