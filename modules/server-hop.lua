local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local Module = {}

function Module.start()
    local placeId = game.PlaceId
    TeleportService:Teleport(placeId)
end

function Module.stop()
end

return Module
