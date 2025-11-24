local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        local backpack = LocalPlayer.Backpack
        
        if character and backpack then
            local equippedTool = character:FindFirstChildOfClass("Tool")
            if not equippedTool then
                local tool = backpack:FindFirstChildOfClass("Tool")
                if tool then
                    character.Humanoid:EquipTool(tool)
                end
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
