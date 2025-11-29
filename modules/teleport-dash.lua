local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local lastDash = 0
local dashCooldown = 0.5

function Module.start()
    local mouse = LocalPlayer:GetMouse()
    
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.R and tick() - lastDash > dashCooldown then
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                
                if rootPart then
                    local camera = workspace.CurrentCamera
                    local targetPos = rootPart.Position + camera.CFrame.LookVector * 15
                    
                    -- Teleport effect at start
                    local startEffect = Instance.new("Part")
                    startEffect.Size = Vector3.new(4, 8, 4)
                    startEffect.Position = rootPart.Position
                    startEffect.Anchored = true
                    startEffect.CanCollide = false
                    startEffect.Material = Enum.Material.Neon
                    startEffect.Color = Color3.fromRGB(138, 43, 226)
                    startEffect.Transparency = 0.3
                    startEffect.Parent = workspace
                    
                    -- Teleport
                    rootPart.CFrame = CFrame.new(targetPos)
                    
                    -- Teleport effect at end
                    local endEffect = startEffect:Clone()
                    endEffect.Position = targetPos
                    endEffect.Parent = workspace
                    
                    lastDash = tick()
                    
                    task.spawn(function()
                        for i = 1, 10 do
                            startEffect.Transparency = startEffect.Transparency + 0.07
                            startEffect.Size = startEffect.Size + Vector3.new(0.5, 0.5, 0.5)
                            endEffect.Transparency = endEffect.Transparency + 0.07
                            endEffect.Size = endEffect.Size + Vector3.new(0.5, 0.5, 0.5)
                            task.wait(0.03)
                        end
                        startEffect:Destroy()
                        endEffect:Destroy()
                    end)
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
