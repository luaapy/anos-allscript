local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection

local function forceCriticalHits()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        for _, obj in pairs(character:GetDescendants()) do
            if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                local name = obj.Name:lower()
                if name:find("crit") or name:find("critical") then
                    obj.Value = 100
                end
            end
        end
        
        if LocalPlayer:FindFirstChild("Backpack") then
            for _, obj in pairs(LocalPlayer.Backpack:GetDescendants()) do
                if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                    local name = obj.Name:lower()
                    if name:find("crit") or name:find("critical") then
                        obj.Value = 100
                    end
                end
            end
        end
        
        for _, script in pairs(character:GetDescendants()) do
            if script:IsA("LocalScript") or script:IsA("Script") then
                local success = pcall(function()
                    local env = getfenv(script)
                    if env then
                        if env.CritChance then
                            env.CritChance = 100
                        end
                        if env.CriticalChance then
                            env.CriticalChance = 100
                        end
                        if env.critChance then
                            env.critChance = 100
                        end
                    end
                end)
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        forceCriticalHits()
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        forceCriticalHits()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "💢 Critical Hit Force";
        Text = "100% crit chance!";
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
