local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local boxes = {}

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        -- Clean old boxes
        for _, box in pairs(boxes) do
            if box and box.Parent then
                box:Destroy()
            end
        end
        boxes = {}
        
        -- Create new boxes
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Size = rootPart.Size + Vector3.new(1, 3, 1)
                    box.Adornee = rootPart
                    box.Color3 = Color3.new(1, 0, 0)
                    box.Transparency = 0.7
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Parent = rootPart
                    
                    table.insert(boxes, box)
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
    
    for _, box in pairs(boxes) do
        if box and box.Parent then
            box:Destroy()
        end
    end
    boxes = {}
end

return Module
