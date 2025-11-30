local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}

local connection
local healthConnection
local stateConnection
local characterConnection
local originalMaxHealth

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if not originalMaxHealth then
        originalMaxHealth = humanoid.MaxHealth
    end
    
    if connection then connection:Disconnect() end
    if healthConnection then healthConnection:Disconnect() end
    if stateConnection then stateConnection:Disconnect() end
    
    pcall(function()
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end)
    
    connection = RunService.Heartbeat:Connect(function()
        if character and character.Parent and humanoid and humanoid.Parent then
            pcall(function()
                humanoid.Health = math.huge
                humanoid.MaxHealth = math.huge
            end)
        end
    end)
    
    healthConnection = humanoid.HealthChanged:Connect(function(health)
        pcall(function()
            if health < math.huge then
                humanoid.Health = math.huge
            end
        end)
    end)
    
    stateConnection = humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Dead or new == Enum.HumanoidStateType.FallingDown then
            pcall(function()
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                humanoid.Health = math.huge
            end)
        end
    end)
    
    pcall(function()
        for _, conn in pairs(getconnections(humanoid.Died)) do
            conn:Disable()
        end
    end)
    
    pcall(function()
        for _, conn in pairs(getconnections(humanoid.HealthChanged)) do
            if conn.Function ~= healthConnection then
                conn:Disable()
            end
        end
    end)
    
    pcall(function()
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    end)
    
    if characterConnection then
        characterConnection:Disconnect()
    end
    
    characterConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.1)
        Module.start()
    end)
end

function Module.stop()
    if connection then connection:Disconnect() connection = nil end
    if healthConnection then healthConnection:Disconnect() healthConnection = nil end
    if stateConnection then stateConnection:Disconnect() stateConnection = nil end
    if characterConnection then characterConnection:Disconnect() characterConnection = nil end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and originalMaxHealth then
            pcall(function()
                humanoid.MaxHealth = originalMaxHealth
                humanoid.Health = originalMaxHealth
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            end)
        end
    end
end

return Module
