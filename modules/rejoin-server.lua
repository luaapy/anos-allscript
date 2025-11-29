local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}

function Module.start()
    local placeId = game.PlaceId
    TeleportService:TeleportToPlaceInstance(placeId, game.JobId, LocalPlayer)
end

function Module.stop()
end

return Module
