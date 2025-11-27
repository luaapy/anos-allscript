local module = {}
local textParts = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    local texts = {"ANOS", "OP", "GG", "LOL", "XD", "EPIC"}
    
    for i = 1, 6 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(4, 2, 0.1)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.Parent = workspace
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(4, 0, 2, 0)
        billboard.Adornee = part
        billboard.AlwaysOnTop = true
        billboard.Parent = part
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = texts[i]
        text.TextScaled = true
        text.TextColor3 = Color3.fromHSV(i / 6, 1, 1)
        text.Font = Enum.Font.GothamBlack
        text.TextStrokeTransparency = 0
        text.Parent = billboard
        
        table.insert(textParts, part)
    end
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if char and humanoidRootPart and humanoidRootPart.Parent then
            for i, part in ipairs(textParts) do
                local angle = ((tick() * 3) + (i * 60)) % 360
                local rad = math.rad(angle)
                local radius = 6
                local height = math.sin(tick() * 2 + i) * 3
                local x = math.cos(rad) * radius
                local z = math.sin(rad) * radius
                part.Position = humanoidRootPart.Position + Vector3.new(x, height + 5, z)
            end
        end
    end)
    
    module.connection = connection
end

function module.stop()
    if module.connection then
        module.connection:Disconnect()
    end
    for _, part in ipairs(textParts) do
        if part then
            part:Destroy()
        end
    end
    textParts = {}
end

return module
