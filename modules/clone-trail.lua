local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local clones = {}

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        for _, clone in pairs(clones) do
            if clone and clone.Parent then
                clone:Destroy()
            end
        end
        clones = {}
        
        local character = LocalPlayer.Character
        if character then
            local clone = character:Clone()
            clone.Parent = workspace
            
            for _, part in pairs(clone:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                    part.CanCollide = false
                    part.Transparency = 0.7
                end
            end
            
            table.insert(clones, clone)
            game:GetService("Debris"):AddItem(clone, 0.5)
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, clone in pairs(clones) do
        if clone and clone.Parent then
            clone:Destroy()
        end
    end
    clones = {}
end

return Module
