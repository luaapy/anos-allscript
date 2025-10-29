local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local originalMaxHealth
local characterConnection

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if not originalMaxHealth then
        originalMaxHealth = humanoid.MaxHealth
    end
    
    if connection then
        connection:Disconnect()
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if character and character.Parent and humanoid and humanoid.Parent then
            pcall(function()
                humanoid.Health = humanoid.MaxHealth
            end)
        end
    end)
    
    pcall(function()
        for _, conn in pairs(getconnections(humanoid.HealthChanged)) do
            conn:Disable()
        end
    end)
    
    pcall(function()
        for _, conn in pairs(getconnections(humanoid.Died)) do
            conn:Disable()
        end
    end)
    
    if characterConnection then
        characterConnection:Disconnect()
    end
    
    characterConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.1)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        
        if not originalMaxHealth then
            originalMaxHealth = humanoid.MaxHealth
        end
        
        if connection then
            connection:Disconnect()
        end
        
        connection = RunService.Heartbeat:Connect(function()
            if character and character.Parent and humanoid and humanoid.Parent then
                pcall(function()
                    humanoid.Health = humanoid.MaxHealth
                end)
            end
        end)
        
        pcall(function()
            for _, conn in pairs(getconnections(humanoid.HealthChanged)) do
                conn:Disable()
            end
        end)
        
        pcall(function()
            for _, conn in pairs(getconnections(humanoid.Died)) do
                conn:Disable()
            end
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if characterConnection then
        characterConnection:Disconnect()
        characterConnection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and originalMaxHealth then
            pcall(function()
                humanoid.MaxHealth = originalMaxHealth
                humanoid.Health = originalMaxHealth
            end)
        end
    end
end

return Module
