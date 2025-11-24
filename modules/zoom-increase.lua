local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local originalMaxZoom

function Module.start()
    originalMaxZoom = LocalPlayer.CameraMaxZoomDistance
    LocalPlayer.CameraMaxZoomDistance = 9999
end

function Module.stop()
    LocalPlayer.CameraMaxZoomDistance = originalMaxZoom or 128
end

return Module
