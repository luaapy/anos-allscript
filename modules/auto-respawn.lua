local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = LocalPlayer.Character.Humanoid.Died:Connect(function()
        wait(0.1)
        LocalPlayer.Character:BreakJoints()
        LocalPlayer:LoadCharacter()
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
