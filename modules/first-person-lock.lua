local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
end

function Module.stop()
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
end

return Module
