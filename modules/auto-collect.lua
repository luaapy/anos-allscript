local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection

local collectKeywords = {
    "coin", "money", "cash", "gem", "diamond", "crystal",
    "fruit", "orb", "token", "star", "point", "reward",
    "chest", "box", "crate", "pickup", "collectible"
}

local function shouldCollect(obj)
    local name = obj.Name:lower()
    for _, keyword in ipairs(collectKeywords) do
        if name:find(keyword) then
            return true
        end
    end
    return false
end

local function collectNearbyItems()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and shouldCollect(obj) then
                local distance = (humanoidRootPart.Position - obj.Position).Magnitude
                if distance < 200 then
                    obj.CFrame = humanoidRootPart.CFrame
                    task.wait(0.05)
                end
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        collectNearbyItems()
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
