local Workspace = game:GetService("Workspace")

local Module = {}
local originalParts = {}

function Module.start()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "Terrain" then
            originalParts[obj] = obj.Transparency
            obj.Transparency = 1
        end
    end
end

function Module.stop()
    for obj, transparency in pairs(originalParts) do
        if obj and obj.Parent then
            obj.Transparency = transparency
        end
    end
    originalParts = {}
end

return Module
