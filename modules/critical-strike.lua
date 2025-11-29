local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Critical Strike";
        Text = "Higher critical hit chance active!";
        Duration = 3;
    })
end

function Module.stop()
end

return Module
