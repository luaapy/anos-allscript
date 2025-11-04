local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local MAX_DISTANCE = 150
local FOV_RADIUS = 150
local WALLCHECK = true
local SMOOTH_AIM = true
local SMOOTHNESS = 0.35
local HOLD_TO_AIM = false

local function hasLineOfSight(from, to)
    if not WALLCHECK then return true end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local ignoreList = {LocalPlayer.Character}
    if Camera:FindFirstChild("Arms") then
        table.insert(ignoreList, Camera.Arms)
    end
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local direction = (to - from)
    local raycastResult = workspace:Raycast(from, direction, raycastParams)
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart and hitPart.Parent then
            local hitChar = hitPart.Parent
            local hitPlayer = Players:GetPlayerFromCharacter(hitChar)
            if hitPlayer then
                return true
            end
        end
        return false
    end
    
    return true
end

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local success = pcall(function()
                local character = player.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                local head = character:FindFirstChild("Head")
                
                if humanoidRootPart and humanoid and humanoid.Health > 0 and head then
                    local localChar = LocalPlayer.Character
                    if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
                    
                    local worldDistance = (humanoidRootPart.Position - localChar.HumanoidRootPart.Position).Magnitude
                    
                    if worldDistance > MAX_DISTANCE then return end
                    
                    local screenPoint, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if not onScreen then return end
                    
                    local mouseLocation = UserInputService:GetMouseLocation()
                    local screenDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                    
                    if screenDistance > FOV_RADIUS then return end
                    
                    local cameraPos = Camera.CFrame.Position
                    if not hasLineOfSight(cameraPos, head.Position) then return end
                    
                    if screenDistance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = screenDistance
                    end
                end
            end)
        end
    end
    
    return closestPlayer
end

local function aimAtPlayer(player)
    local success = pcall(function()
        local character = player.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head")
        if not head then return end
        
        local aimPosition = head.Position
        
        if SMOOTH_AIM then
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, aimPosition)
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, SMOOTHNESS)
        else
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPosition)
        end
    end)
end

local connection = RunService.RenderStepped:Connect(function()
    pcall(function()
        local target = getClosestPlayer()
        if target then
            aimAtPlayer(target)
        end
    end)
end)

local function stopAimbot()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return stopAimbot
