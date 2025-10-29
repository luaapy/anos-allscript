local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Module = {}
local connection
local smoothness = 0.1

local function getClosestPlayerToMouse()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local mouseLocation = UserInputService:GetMouseLocation()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            pcall(function()
                local character = player.Character
                local head = character:FindFirstChild("Head")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if head and humanoid and humanoid.Health > 0 then
                    local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
                    
                    if onScreen then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                        
                        if distance < shortestDistance and distance < 500 then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
            end)
        end
    end
    
    return closestPlayer
end

local function smoothAim(targetPosition)
    pcall(function()
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, targetPosition)
        
        Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothness)
    end)
end

function Module.start()
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            pcall(function()
                local target = getClosestPlayerToMouse()
                if target and target.Character then
                    local head = target.Character:FindFirstChild("Head")
                    if head then
                        smoothAim(head.Position)
                    end
                end
            end)
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🎯 Smooth Aimbot";
        Text = "Hold Right Click to aim";
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
