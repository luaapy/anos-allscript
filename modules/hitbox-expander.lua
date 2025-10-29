local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local originalSizes = {}
local hitboxSize = 20

local function expandHitbox(player)
    if player == LocalPlayer then return end
    
    pcall(function()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        if not originalSizes[player] then
            originalSizes[player] = humanoidRootPart.Size
        end
        
        humanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        humanoidRootPart.Transparency = 0.7
        humanoidRootPart.CanCollide = false
        humanoidRootPart.Massless = true
    end)
end

local function restoreHitbox(player)
    pcall(function()
        if originalSizes[player] then
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.Size = originalSizes[player]
                    humanoidRootPart.Transparency = 1
                    humanoidRootPart.CanCollide = false
                end
            end
            originalSizes[player] = nil
        end
    end)
end

function Module.start()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            expandHitbox(player)
            
            player.CharacterAdded:Connect(function()
                task.wait(0.5)
                expandHitbox(player)
            end)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            expandHitbox(player)
        end)
    end)
    
    connection = RunService.Heartbeat:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                expandHitbox(player)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        restoreHitbox(player)
    end
    
    originalSizes = {}
end

return Module
