local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local forcefield

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    forcefield = Instance.new("ForceField")
    forcefield.Visible = true
    forcefield.Parent = character
end

function Module.stop()
    if forcefield and forcefield.Parent then
        forcefield:Destroy()
        forcefield = nil
    end
end

return Module
