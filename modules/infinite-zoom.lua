local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    LocalPlayer.CameraMaxZoomDistance = math.huge
    LocalPlayer.CameraMinZoomDistance = 0.5
end

function Module.stop()
    LocalPlayer.CameraMaxZoomDistance = 128
    LocalPlayer.CameraMinZoomDistance = 0.5
end

return Module
