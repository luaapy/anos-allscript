local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local highlights = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local highlight = Instance.new("SelectionBox")
            highlight.LineThickness = 0.1
            highlight.Adornee = part
            highlight.Color3 = Color3.fromRGB(0, 255, 255)
            highlight.Parent = part
            table.insert(highlights, highlight)
        end
    end
    
    connection = RunService.Heartbeat:Connect(function()
        local hue = (tick() % 3) / 3
        local color = Color3.fromHSV(hue, 1, 1)
        
        for _, highlight in pairs(highlights) do
            if highlight and highlight.Parent then
                highlight.Color3 = color
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, highlight in pairs(highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    
    highlights = {}
end

return Module
