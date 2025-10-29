local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local healThreshold = 70

local function autoHeal()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        if humanoid.Health < healThreshold and humanoid.Health > 0 then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                local toolName = tool.Name:lower()
                if toolName:find("heal") or toolName:find("potion") or 
                   toolName:find("medkit") or toolName:find("bandage") or
                   toolName:find("food") then
                    
                    humanoid:EquipTool(tool)
                    task.wait(0.1)
                    tool:Activate()
                    task.wait(0.3)
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "💚 Auto Heal";
                        Text = "Used " .. tool.Name;
                        Duration = 2;
                    })
                    return
                end
            end
            
            for _, remote in pairs(game:GetDescendants()) do
                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                    local remoteName = remote.Name:lower()
                    if remoteName:find("heal") or remoteName:find("regenerate") or
                       remoteName:find("restore") then
                        pcall(function()
                            if remote:IsA("RemoteEvent") then
                                remote:FireServer(humanoid.MaxHealth)
                                remote:FireServer("heal", humanoid.MaxHealth)
                                remote:FireServer(LocalPlayer, humanoid.MaxHealth)
                            end
                        end)
                    end
                end
            end
            
            humanoid.Health = math.min(humanoid.Health + 5, humanoid.MaxHealth)
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        autoHeal()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "💚 Auto Heal";
        Text = "Auto healing when HP < " .. healThreshold .. "%";
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
