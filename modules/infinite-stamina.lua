local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid then return end
            
            for _, obj in pairs(character:GetDescendants()) do
                if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                    local name = obj.Name:lower()
                    if name:find("stamina") or name:find("energy") or name:find("sprint") then
                        obj.Value = math.huge
                    end
                end
            end
            
            if LocalPlayer:FindFirstChild("PlayerGui") then
                for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                    if gui:IsA("NumberValue") or gui:IsA("IntValue") then
                        local name = gui.Name:lower()
                        if name:find("stamina") or name:find("energy") or name:find("sprint") then
                            gui.Value = math.huge
                        end
                    end
                end
            end
            
            if LocalPlayer:FindFirstChild("Backpack") then
                for _, tool in pairs(LocalPlayer.Backpack:GetDescendants()) do
                    if tool:IsA("NumberValue") or tool:IsA("IntValue") then
                        local name = tool.Name:lower()
                        if name:find("stamina") or name:find("energy") or name:find("durability") then
                            tool.Value = math.huge
                        end
                    end
                end
            end
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
