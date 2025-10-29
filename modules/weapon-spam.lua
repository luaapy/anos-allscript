local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local spamSpeed = 0.05

local function spamWeapon()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local tool = character:FindFirstChildOfClass("Tool")
        
        if tool then
            tool:Activate()
            
            for _, remote in pairs(tool:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    pcall(function()
                        remote:FireServer()
                        remote:FireServer("fire")
                        remote:FireServer("shoot")
                        remote:FireServer("attack")
                    end)
                end
            end
            
            if tool:FindFirstChild("Handle") then
                for _, remote in pairs(game:GetDescendants()) do
                    if remote:IsA("RemoteEvent") then
                        local name = remote.Name:lower()
                        if name:find("shoot") or name:find("fire") or 
                           name:find("attack") or name:find("swing") then
                            pcall(function()
                                remote:FireServer(tool)
                                remote:FireServer(tool.Handle)
                            end)
                        end
                    end
                end
            end
            
            task.wait(spamSpeed)
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        spamWeapon()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🔥 Weapon Spam";
        Text = "Spamming equipped weapon!";
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
