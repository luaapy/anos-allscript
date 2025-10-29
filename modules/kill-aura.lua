local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local auraRange = 20

local function attackNearbyPlayers()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local tool = character:FindFirstChildOfClass("Tool")
        if not tool then
            tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                character.Humanoid:EquipTool(tool)
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = player.Character:FindFirstChild("Humanoid")
                
                if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                    local distance = (humanoidRootPart.Position - targetRoot.Position).Magnitude
                    
                    if distance <= auraRange then
                        if tool and tool:FindFirstChild("Handle") then
                            tool:Activate()
                        end
                        
                        for _, remote in pairs(game:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (
                                remote.Name:lower():find("damage") or 
                                remote.Name:lower():find("hit") or 
                                remote.Name:lower():find("attack")
                            ) then
                                pcall(function()
                                    remote:FireServer(targetHumanoid, 50)
                                    remote:FireServer(player, 50)
                                    remote:FireServer(targetRoot, 50)
                                end)
                            end
                        end
                        
                        task.wait(0.1)
                    end
                end
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        attackNearbyPlayers()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ Kill Aura";
        Text = "Auto attacking in " .. auraRange .. " studs!";
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
