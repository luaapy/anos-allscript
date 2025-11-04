local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {}
local connection

-- SETTINGS - Bisa diubah sesuai kebutuhan
local MAX_DISTANCE = 200 -- Jarak maksimal target (studs)
local FOV_RADIUS = 150 -- Radius FOV di layar (pixels)
local WALLCHECK = true -- Check tembok atau tidak

-- Fungsi untuk check apakah ada tembok menghalangi
local function hasLineOfSight(from, to)
    if not WALLCHECK then return true end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    
    local direction = (to - from)
    local raycastResult = workspace:Raycast(from, direction, raycastParams)
    
    if raycastResult then
        -- Check apakah yang kena raycast adalah target player
        local hitPlayer = Players:GetPlayerFromCharacter(raycastResult.Instance.Parent)
        if hitPlayer then
            return true
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
            pcall(function()
                local character = player.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                local head = character:FindFirstChild("Head")
                
                if humanoidRootPart and humanoid and humanoid.Health > 0 and head then
                    -- Check jarak 3D (jarak sebenarnya di dunia)
                    local localChar = LocalPlayer.Character
                    if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
                    
                    local worldDistance = (humanoidRootPart.Position - localChar.HumanoidRootPart.Position).Magnitude
                    
                    -- Skip kalau terlalu jauh
                    if worldDistance > MAX_DISTANCE then return end
                    
                    -- Check line of sight (apakah ada tembok)
                    local cameraPos = Camera.CFrame.Position
                    if not hasLineOfSight(cameraPos, head.Position) then return end
                    
                    -- Check jarak di layar (FOV check)
                    local screenPoint, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if not onScreen then return end
                    
                    local mouseLocation = UserInputService:GetMouseLocation()
                    local screenDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                    
                    -- Check FOV radius
                    if screenDistance < FOV_RADIUS and screenDistance < shortestDistance then
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
    pcall(function()
        local character = player.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head")
        if not head then return end
        
        local localCharacter = LocalPlayer.Character
        if not localCharacter then return end
        
        local humanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        -- Aim ke head
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
    end)
end

function Module.start()
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then -- Ubah ke RMB (klik kanan)
            pcall(function()
                local target = getClosestPlayer()
                if target then
                    aimAtPlayer(target)
                end
            end)
        end
    end)
    print("Aimbot started - Max Distance:", MAX_DISTANCE, "FOV:", FOV_RADIUS)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
        print("Aimbot stopped")
    end
end

-- Optional: Fungsi untuk update settings
function Module.setMaxDistance(distance)
    MAX_DISTANCE = distance
end

function Module.setFOV(fov)
    FOV_RADIUS = fov
end

function Module.setWallCheck(enabled)
    WALLCHECK = enabled
end

return Module
