local module = {}
local clones = {}

function module.start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    
    for i = 1, 5 do
        local clone = char:Clone()
        for _, part in pairs(clone:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
                part.CanCollide = false
                part.Transparency = 0.5
            end
        end
        clone.Parent = workspace
        table.insert(clones, clone)
    end
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if char and char:FindFirstChild("HumanoidRootPart") then
            for i, clone in ipairs(clones) do
                if clone and clone:FindFirstChild("HumanoidRootPart") then
                    local angle = (i * 72) + (tick() * 30)
                    local rad = math.rad(angle)
                    local radius = 8
                    local x = math.cos(rad) * radius
                    local z = math.sin(rad) * radius
                    clone.HumanoidRootPart.Position = char.HumanoidRootPart.Position + Vector3.new(x, 0, z)
                end
            end
        end
    end)
    
    module.connection = connection
end

function module.stop()
    if module.connection then
        module.connection:Disconnect()
    end
    for _, clone in ipairs(clones) do
        if clone then
            clone:Destroy()
        end
    end
    clones = {}
end

return module
