local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local charAddedConnection

local function preventRagdoll()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        humanoid.PlatformStand = false
        humanoid.Sit = false
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if part ~= humanoidRootPart then
                    part.Anchored = false
                    part.CanCollide = true
                end
            end
            
            if part:IsA("BodyVelocity") or part:IsA("BodyAngularVelocity") or
               part:IsA("BodyPosition") or part:IsA("BodyGyro") or 
               part:IsA("BodyThrust") or part:IsA("BodyForce") then
                part:Destroy()
            end
            
            if part:IsA("Motor6D") then
                if part.Name ~= "Root" and part.Name ~= "RootJoint" then
                    part.Enabled = true
                end
            end
            
            if part:IsA("Weld") or part:IsA("WeldConstraint") then
                local name = part.Name:lower()
                if name:find("ragdoll") or name:find("knockout") then
                    part:Destroy()
                end
            end
        end
        
        for _, effect in pairs(character:GetDescendants()) do
            if effect:IsA("BoolValue") or effect:IsA("StringValue") or effect:IsA("IntValue") then
                local name = effect.Name:lower()
                if name:find("ragdoll") or name:find("stun") or name:find("knocked") or 
                   name:find("ko") or name:find("downed") or name:find("disabled") then
                    if effect:IsA("BoolValue") then
                        effect.Value = false
                    end
                    task.wait()
                    effect:Destroy()
                end
            end
        end
        
        local ragdollScript = character:FindFirstChild("RagdollScript", true)
        if ragdollScript then
            ragdollScript.Disabled = true
            ragdollScript:Destroy()
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        preventRagdoll()
    end)
    
    charAddedConnection = LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        preventRagdoll()
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if charAddedConnection then
        charAddedConnection:Disconnect()
        charAddedConnection = nil
    end
end

return Module
