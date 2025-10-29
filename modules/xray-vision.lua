local Module = {}
local originalTransparencies = {}
local processedParts = {}

local function makeTransparent(object)
    pcall(function()
        if object:IsA("BasePart") and not object.Parent:FindFirstChild("Humanoid") then
            if not processedParts[object] then
                originalTransparencies[object] = object.Transparency
                processedParts[object] = true
            end
            object.Transparency = 0.7
        end
    end)
end

local function processWorkspace()
    for _, obj in pairs(workspace:GetDescendants()) do
        makeTransparent(obj)
    end
end

function Module.start()
    processWorkspace()
    
    workspace.DescendantAdded:Connect(function(obj)
        task.wait(0.1)
        makeTransparent(obj)
    end)
end

function Module.stop()
    for part, originalTransparency in pairs(originalTransparencies) do
        pcall(function()
            if part and part.Parent then
                part.Transparency = originalTransparency
            end
        end)
    end
    
    originalTransparencies = {}
    processedParts = {}
end

return Module
