local module = {}
local emojiPart

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local head = char:WaitForChild("Head")
    
    emojiPart = Instance.new("Part")
    emojiPart.Name = "GiantEmoji"
    emojiPart.Size = Vector3.new(5, 5, 0.5)
    emojiPart.Anchored = false
    emojiPart.CanCollide = false
    emojiPart.Material = Enum.Material.Neon
    emojiPart.Color = Color3.fromRGB(255, 255, 0)
    emojiPart.Parent = workspace
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = head
    weld.Part1 = emojiPart
    weld.Parent = emojiPart
    
    emojiPart.Position = head.Position + Vector3.new(0, 7, 0)
    
    local gui = Instance.new("SurfaceGui")
    gui.Face = Enum.NormalId.Front
    gui.Parent = emojiPart
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "😂"
    label.TextScaled = true
    label.Parent = gui
end

function module.stop()
    if emojiPart then
        emojiPart:Destroy()
    end
end

return module
