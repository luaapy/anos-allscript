local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local lastDash = 0
local dashCooldown = 1

function Module.start()
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.Q and tick() - lastDash > dashCooldown then
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if rootPart and humanoid then
                    local dashDirection = humanoid.Move Direction.Magnitude > 0 and humanoid.MoveDirection or rootPart.CFrame.LookVector
                    rootPart.AssemblyLinearVelocity = dashDirection * 100
                    
                    lastDash = tick()
                    
                    -- Dash trail
                    for i = 1, 5 do
                        local part = Instance.new("Part")
                        part.Size = Vector3.new(2, 5, 1)
                        part.Position = rootPart.Position - dashDirection * i
                        part.Anchored = true
                        part.CanCollide = false
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(135, 206, 250)
                        part.Transparency = 0.3 + (i * 0.1)
                        part.Parent = workspace
                        
                        task.spawn(function()
                            task.wait(0.3)
                            part:Destroy()
                        end)
                    end
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
