local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local rope

function Module.start()
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E then
            local character = LocalPlayer.Character
            local mouse = LocalPlayer:GetMouse()
            
            if character and mouse.Hit then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    if rope then
                        rope:Destroy()
                    end
                    
                    local attachment0 = Instance.new("Attachment")
                    attachment0.Parent = rootPart
                    
                    local targetPart = Instance.new("Part")
                    targetPart.Position = mouse.Hit.Position
                    targetPart.Anchored = true
                    targetPart.Transparency = 1
                    targetPart.Size = Vector3.new(1, 1, 1)
                    targetPart.Parent = workspace
                    
                    local attachment1 = Instance.new("Attachment")
                    attachment1.Parent = targetPart
                    
                    rope = Instance.new("RopeConstraint")
                    rope.Attachment0 = attachment0
                    rope.Attachment1 = attachment1
                    rope.Visible = true
                    rope.Length = (rootPart.Position - mouse.Hit.Position).Magnitude
                    rope.Parent = rootPart
                    
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                    bodyVelocity.Velocity = (mouse.Hit.Position - rootPart.Position).Unit * 100
                    bodyVelocity.Parent = rootPart
                    
                    wait(1)
                    bodyVelocity:Destroy()
                    rope:Destroy()
                    targetPart:Destroy()
                end
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if rope then
        rope:Destroy()
    end
end

return Module
