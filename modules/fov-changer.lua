local Camera = workspace.CurrentCamera

local Module = {}
local originalFOV

function Module.start()
    originalFOV = Camera.FieldOfView
    Camera.FieldOfView = 120
end

function Module.stop()
    Camera.FieldOfView = originalFOV or 70
end

function Module.setFOV(fov)
    Camera.FieldOfView = fov
end

return Module
