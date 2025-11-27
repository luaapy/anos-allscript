local module = {}
local emitter

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    emitter.Rate = 100
    emitter.Lifetime = NumberRange.new(2, 3)
    emitter.Speed = NumberRange.new(10, 20)
    emitter.SpreadAngle = Vector2.new(180, 180)
    emitter.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 193)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 105, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
    }
    emitter.Size = NumberSequence.new(2, 0)
    emitter.Parent = humanoidRootPart
end

function module.stop()
    if emitter then
        emitter:Destroy()
    end
end

return module
