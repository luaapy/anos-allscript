local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Module = {}
local connection

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            pcall(function()
                local character = player.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if humanoidRootPart and humanoid and humanoid.Health > 0 then
                    local screenPoint = Camera:WorldToScreenPoint(humanoidRootPart.Position)
                    local mouseLocation = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                    
                    if distance < shortestDistance and distance < 300 then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end)
        end
    end
    
    return closestPlayer
end

local function aimAtPlayer(player)
    pcall(function()
        local character = player.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head")
        if not head then return end
        
        local localCharacter = LocalPlayer.Character
        if not localCharacter then return end
        
        local humanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local aimPart = head
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPart.Position)
    end)
end

function Module.start()
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            pcall(function()
                local target = getClosestPlayer()
                if target then
                    aimAtPlayer(target)
                end
            end)
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
