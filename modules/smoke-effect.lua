local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local smokes = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local smoke = Instance.new("Smoke")
    smoke.Size = 10
    smoke.Opacity = 0.5
    smoke.RiseVelocity = 5
    smoke.Parent = rootPart
    
    table.insert(smokes, smoke)
end

function Module.stop()
    for _, smoke in pairs(smokes) do
        if smoke and smoke.Parent then
            smoke:Destroy()
        end
    end
    smokes = {}
end

return Module
