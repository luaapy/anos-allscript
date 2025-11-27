local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local att = Instance.new("Attachment") att.Parent = char:WaitForChild("HumanoidRootPart") local emitter = Instance.new("ParticleEmitter") emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds" emitter.Rate = 100 emitter.Lifetime = NumberRange.new(2) emitter.Speed = NumberRange.new(5) emitter.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,100,255))} emitter.Parent = att module.emitter = emitter
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
