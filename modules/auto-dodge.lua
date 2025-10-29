local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local dodgeDistance = 12
local dodgeCooldown = 0.5
local lastDodge = 0

local function performDodge(direction)
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
        bodyVelocity.Velocity = direction * 50
        bodyVelocity.Parent = humanoidRootPart
        
        game:GetService("Debris"):AddItem(bodyVelocity, 0.2)
    end)
end

local function detectThreat()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local currentTime = tick()
        if currentTime - lastDodge < dodgeCooldown then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local enemyChar = player.Character
                local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                local enemyHumanoid = enemyChar:FindFirstChild("Humanoid")
                
                if enemyRoot and enemyHumanoid and enemyHumanoid.Health > 0 then
                    local distance = (humanoidRootPart.Position - enemyRoot.Position).Magnitude
                    
                    if distance < dodgeDistance then
                        local direction = (humanoidRootPart.Position - enemyRoot.Position).Unit
                        local rightDirection = direction:Cross(Vector3.new(0, 1, 0))
                        
                        if math.random() > 0.5 then
                            performDodge(rightDirection)
                        else
                            performDodge(-rightDirection)
                        end
                        
                        lastDodge = currentTime
                        
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "💨 Auto Dodge";
                            Text = "Dodged attack!";
                            Duration = 1;
                        })
                        return
                    end
                end
            end
        end
        
        for _, projectile in pairs(workspace:GetDescendants()) do
            if projectile:IsA("BasePart") then
                local name = projectile.Name:lower()
                if name:find("projectile") or name:find("bullet") or 
                   name:find("arrow") or name:find("ball") then
                    
                    local distance = (humanoidRootPart.Position - projectile.Position).Magnitude
                    
                    if distance < dodgeDistance and projectile.Velocity.Magnitude > 5 then
                        local direction = (humanoidRootPart.Position - projectile.Position).Unit
                        local rightDirection = direction:Cross(Vector3.new(0, 1, 0))
                        
                        performDodge(rightDirection)
                        lastDodge = currentTime
                        return
                    end
                end
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        detectThreat()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "💨 Auto Dodge";
        Text = "Auto dodging attacks!";
        Duration = 3;
    })
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return Module
