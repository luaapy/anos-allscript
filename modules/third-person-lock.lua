local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    LocalPlayer.CameraMinZoomDistance = 128
    LocalPlayer.CameraMaxZoomDistance = 128
end

function Module.stop()
    LocalPlayer.CameraMinZoomDistance = 0.5
    LocalPlayer.CameraMaxZoomDistance = 128
end

return Module
