local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local farmConnection

local function findNearestFarmable()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    
    local nearest = nil
    local nearestDistance = math.huge
    
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= character then
                local rootPart = obj:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local distance = (humanoidRootPart.Position - rootPart.Position).Magnitude
                    if distance < nearestDistance and distance < 100 then
                        nearestDistance = distance
                        nearest = obj
                    end
                end
            elseif obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or 
                   obj.Name:lower():find("fruit") or obj.Name:lower():find("orb") then
                if obj:IsA("BasePart") then
                    local distance = (humanoidRootPart.Position - obj.Position).Magnitude
                    if distance < nearestDistance and distance < 150 then
                        nearestDistance = distance
                        nearest = obj
                    end
                end
            end
        end)
    end
    
    return nearest
end

local function farmTarget(target)
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        if target:IsA("Model") then
            local targetRoot = target:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                humanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 5)
            end
        elseif target:IsA("BasePart") then
            humanoidRootPart.CFrame = target.CFrame
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            local target = findNearestFarmable()
            if target then
                farmTarget(target)
            end
        end)
    end)
    
    farmConnection = RunService.Stepped:Connect(function()
        pcall(function()
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid:ChangeState(11)
            end
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if farmConnection then
        farmConnection:Disconnect()
        farmConnection = nil
    end
end

return Module
