local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = UserInputService.JumpRequest:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                rootPart.AssemblyLinearVelocity = rootPart.AssemblyLinearVelocity + Vector3.new(0, 80, 0)
                
                -- Create jump effect
                local part = Instance.new("Part")
                part.Size = Vector3.new(4, 0.5, 4)
                part.Position = rootPart.Position - Vector3.new(0, 2.5, 0)
                part.Anchored = true
                part.CanCollide = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(255, 140, 0)
                part.Transparency = 0.3
                part.Parent = workspace
                
                task.spawn(function()
                    for i = 1, 15 do
                        part.Size = part.Size + Vector3.new(0.5, 0, 0.5)
                        part.Transparency = part.Transparency + 0.04
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
