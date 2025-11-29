local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local guis = {}

function Module.start()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            gui.Enabled = false
            table.insert(guis, gui)
        end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Screenshot Mode";
        Text = "UI hidden for clean screenshots";
        Duration = 2;
    })
end

function Module.stop()
    for _, gui in pairs(guis) do
        if gui then
            gui.Enabled = true
        end
    end
    guis = {}
end

return Module
