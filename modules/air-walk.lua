local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local platforms = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    connection = RunService.Heartbeat:Connect(function()
        if character and humanoid and humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- Create invisible platform
                    local platform = Instance.new("Part")
                    platform.Size = Vector3.new(6, 0.5, 6)
                    platform.Position = rootPart.Position - Vector3.new(0, 3, 0)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Transparency = 0.7
                    platform.Material = Enum.Material.ForceField
                    platform.Color = Color3.fromRGB(173, 216, 230)
                    platform.Parent = workspace
                    
                    table.insert(platforms, platform)
                    
                    task.spawn(function()
                        task.wait(2)
                        if platform and platform.Parent then
                            for i = 1, 10 do
                                platform.Transparency = platform.Transparency + 0.03
                                task.wait(0.05)
                            end
                            platform:Destroy()
                        end
                    end)
                end
            end
        end
        
        -- Clean old platforms
        if #platforms > 5 then
            local old = table.remove(platforms, 1)
            if old and old.Parent then
                old:Destroy()
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, platform in pairs(platforms) do
        if platform and platform.Parent then
            platform:Destroy()
        end
    end
    platforms = {}
end

return Module
