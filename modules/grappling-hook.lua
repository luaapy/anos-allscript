local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local grappling = false

function Module.start()
    local mouse = LocalPlayer:GetMouse()
    
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.E and not grappling then
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                
                if rootPart and mouse.Target then
                    grappling = true
                    local targetPos = mouse.Hit.Position
                    
                    -- Create rope visual
                    local rope = Instance.new("Part")
                    rope.Size = Vector3.new(0.2, (rootPart.Position - targetPos).Magnitude, 0.2)
                    rope.Position = (rootPart.Position + targetPos) / 2
                    rope.CFrame = CFrame.lookAt(rootPart.Position, targetPos)
                    rope.Anchored = true
                    rope.CanCollide = false
                    rope.Material = Enum.Material.Neon
                    rope.Color = Color3.fromRGB(128, 128, 128)
                    rope.Parent = workspace
                    
                    -- Pull character
                    local direction = (targetPos - rootPart.Position).Unit
                    rootPart.AssemblyLinearVelocity = direction * 80
                    
                    task.wait(0.5)
                    rope:Destroy()
                    grappling = false
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
end

return Module
