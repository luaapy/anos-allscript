local Lighting = game:GetService("Lighting")

local Module = {}
local bloom

function Module.start()
    bloom = Instance.new("BloomEffect")
    bloom.Intensity = 1
    bloom.Size = 24
    bloom.Threshold = 0.5
    bloom.Parent = Lighting
end

function Module.stop()
    if bloom and bloom.Parent then
        bloom:Destroy()
        bloom = nil
    end
end

return Module
