local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local billboards = {}

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                
                if head and not billboards[player] then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = head
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 0.5
                    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
                    textLabel.TextColor3 = Color3.new(1, 1, 1)
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.Parent = billboard
                    
                    billboards[player] = billboard
                end
                
                if billboards[player] then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                    billboards[player].TextLabel.Text = player.Name .. "\n" .. math.floor(distance) .. " studs"
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
    
    for _, billboard in pairs(billboards) do
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
    end
    billboards = {}
end

return Module
