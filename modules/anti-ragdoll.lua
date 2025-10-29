local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection

local function preventRagdoll()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        humanoid.PlatformStand = false
        humanoid.Sit = false
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
                
                if part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
            
            if part:IsA("BodyVelocity") or part:IsA("BodyAngularVelocity") or
               part:IsA("BodyPosition") or part:IsA("BodyGyro") then
                part:Destroy()
            end
            
            if part:IsA("Motor6D") or part:IsA("Weld") or part:IsA("WeldConstraint") then
                if part.Name ~= "Root" and part.Name ~= "RootJoint" then
                    part.Enabled = true
                end
            end
        end
        
        for _, effect in pairs(character:GetDescendants()) do
            if effect:IsA("BoolValue") or effect:IsA("StringValue") then
                local name = effect.Name:lower()
                if name:find("ragdoll") or name:find("stun") or name:find("knocked") then
                    effect:Destroy()
                end
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        preventRagdoll()
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        preventRagdoll()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🚫 Anti Ragdoll";
        Text = "Ragdoll prevention active!";
        Duration = 3;
    })
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
