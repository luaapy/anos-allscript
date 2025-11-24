local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    LocalPlayer.DevEnableMouseLock = true
    LocalPlayer.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
end

function Module.stop()
    LocalPlayer.DevEnableMouseLock = false
end

return Module
