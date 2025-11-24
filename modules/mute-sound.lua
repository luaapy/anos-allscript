local SoundService = game:GetService("SoundService")

local Module = {}
local originalVolume

function Module.start()
    originalVolume = SoundService.Volume
    SoundService.Volume = 0
end

function Module.stop()
    SoundService.Volume = originalVolume or 0.5
end

return Module
