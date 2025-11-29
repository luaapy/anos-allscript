local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local waypoints = {}
local connection

function Module.start()
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.K then
            -- Set waypoint
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local pos = character.HumanoidRootPart.Position
                table.insert(waypoints, pos)
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Waypoint Set";
                    Text = "Waypoint #" .. #waypoints .. " saved";
                    Duration = 2;
                })
            end
        elseif input.KeyCode == Enum.KeyCode.L and #waypoints > 0 then
            -- Teleport to last waypoint
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(waypoints[#waypoints])
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    waypoints = {}
end

return Module
