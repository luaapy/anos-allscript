local module = {}
local active = false

function module.start()
    active = true
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local emitter = Instance.new("ParticleEmitter") emitter.Parent = char:WaitForChild("HumanoidRootPart") emitter.Texture = "rbxasset://textures/particles/smoke_main.dds" emitter.Rate = 50 emitter.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0)) module.emitter = emitter
end

function module.stop()
    active = false
    if module.conn then module.conn:Disconnect() end if module.emitter then module.emitter:Destroy() end if module.part then module.part:Destroy() end if module.sound then module.sound:Destroy() end if module.clone then module.clone:Destroy() end if module.wing1 then module.wing1:Destroy() end if module.wing2 then module.wing2:Destroy() end
end

return module
