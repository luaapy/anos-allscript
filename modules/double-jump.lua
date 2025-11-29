local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local canDoubleJump = false

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Landed then
            canDoubleJump = false
        elseif new == Enum.HumanoidStateType.Freefall then
            canDoubleJump = true
        end
    end)
    
    connection = UserInputService.JumpRequest:Connect(function()
        if canDoubleJump and humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.AssemblyLinearVelocity = Vector3.new(
                    rootPart.AssemblyLinearVelocity.X,
                    50,
                    rootPart.AssemblyLinearVelocity.Z
                )
                canDoubleJump = false
                
                -- Visual effect
                local part = Instance.new("Part")
                part.Size = Vector3.new(3, 0.5, 3)
                part.Position = rootPart.Position
                part.Anchored = true
                part.CanCollide = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(0, 191, 255)
                part.Transparency = 0.5
                part.Shape = Enum.PartType.Cylinder
                part.Orientation = Vector3.new(0, 0, 90)
                part.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 10 do
                        part.Size = part.Size + Vector3.new(0.3, 0.3, 0.3)
                        part.Transparency = part.Transparency + 0.05
                        task.wait(0.03)
                    end
                    part:Destroy()
                end)
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
