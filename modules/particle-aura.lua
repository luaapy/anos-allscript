local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local emitters = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    emitter.Rate = 100
    emitter.Lifetime = NumberRange.new(1, 2)
    emitter.Speed = NumberRange.new(5, 10)
    emitter.SpreadAngle = Vector2.new(360, 360)
    emitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255))
    emitter.Size = NumberSequence.new(0.5)
    emitter.Parent = rootPart
    
    table.insert(emitters, emitter)
end

function Module.stop()
    for _, emitter in pairs(emitters) do
        if emitter and emitter.Parent then
            emitter:Destroy()
        end
    end
    emitters = {}
end

return Module
