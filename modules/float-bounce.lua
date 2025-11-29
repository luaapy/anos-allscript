local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local bodyPosition

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    
    bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
    bodyPosition.D = 1000
    bodyPosition.P = 10000
    bodyPosition.Parent = rootPart
    
    connection = RunService.Heartbeat:Connect(function()
        if character and rootPart and rootPart.Parent then
            local bounce = math.sin(tick() * 3) * 5
            bodyPosition.Position = rootPart.Position + Vector3.new(0, 10 + bounce, 0)
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if bodyPosition and bodyPosition.Parent then
        bodyPosition:Destroy()
        bodyPosition = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        end
    end
end

return Module
