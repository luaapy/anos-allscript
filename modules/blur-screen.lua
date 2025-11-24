local Lighting = game:GetService("Lighting")

local Module = {}
local blur

function Module.start()
    blur = Instance.new("BlurEffect")
    blur.Size = 20
    blur.Parent = Lighting
end

function Module.stop()
    if blur and blur.Parent then
        blur:Destroy()
        blur = nil
    end
end

return Module
