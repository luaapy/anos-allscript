local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    local character = LocalPlayer.Character
    if character then
        character:BreakJoints()
    end
end

function Module.stop()
end

return Module
