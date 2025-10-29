local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local espObjects = {}
local connection

local function createESP(player)
    if player == LocalPlayer then return end
    
    pcall(function()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP_" .. player.Name
        billboardGui.Adornee = humanoidRootPart
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = humanoidRootPart
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = billboardGui
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Parent = billboardGui
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = "0 studs"
        distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.TextSize = 12
        distanceLabel.Font = Enum.Font.Gotham
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        
        espObjects[player] = {
            billboard = billboardGui,
            highlight = highlight,
            distanceLabel = distanceLabel
        }
    end)
end

local function removeESP(player)
    pcall(function()
        if espObjects[player] then
            if espObjects[player].billboard then
                espObjects[player].billboard:Destroy()
            end
            if espObjects[player].highlight then
                espObjects[player].highlight:Destroy()
            end
            espObjects[player] = nil
        end
    end)
end

local function updateDistance()
    pcall(function()
        local localChar = LocalPlayer.Character
        if not localChar then return end
        
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then return end
        
        for player, esp in pairs(espObjects) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (localRoot.Position - player.Character.HumanoidRootPart.Position).Magnitude
                esp.distanceLabel.Text = math.floor(distance) .. " studs"
                
                if distance < 50 then
                    esp.highlight.FillColor = Color3.fromRGB(255, 0, 0)
                elseif distance < 100 then
                    esp.highlight.FillColor = Color3.fromRGB(255, 165, 0)
                else
                    esp.highlight.FillColor = Color3.fromRGB(0, 255, 0)
                end
            end
        end
    end)
end

function Module.start()
    for _, player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            createESP(player)
        end)
    end)
    
    Players.PlayerRemoving:Connect(removeESP)
    
    for _, player in pairs(Players:GetPlayers()) do
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            createESP(player)
        end)
    end
    
    connection = RunService.Heartbeat:Connect(updateDistance)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    
    espObjects = {}
end

return Module
