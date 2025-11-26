local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection

-- Table untuk menyimpan data orbit setiap player
local playerOrbits = {}

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local centerPos = rootPart.Position
                
                local playerIndex = 0
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            -- Inisialisasi data orbit untuk player baru
                            if not playerOrbits[player.UserId] then
                                playerOrbits[player.UserId] = {
                                    angle = math.random(0, 360) * (math.pi / 180), -- Start angle acak
                                    radius = 10 + (playerIndex * 5), -- Radius berbeda tiap player
                                    speed = 0.03 + (math.random() * 0.04), -- Kecepatan berbeda
                                    heightOffset = math.sin(playerIndex * 2) * 3 -- Variasi ketinggian
                                }
                            end
                            
                            local orbit = playerOrbits[player.UserId]
                            
                            -- Update angle
                            orbit.angle = orbit.angle + orbit.speed
                            
                            -- Hitung posisi orbit
                            local x = centerPos.X + orbit.radius * math.cos(orbit.angle)
                            local z = centerPos.Z + orbit.radius * math.sin(orbit.angle)
                            local y = centerPos.Y + orbit.heightOffset
                            
                            -- Set posisi player
                            targetRoot.CFrame = CFrame.new(x, y, z) * CFrame.Angles(0, orbit.angle + math.pi/2, 0)
                            
                            playerIndex = playerIndex + 1
                        end
                    end
                end
                
                -- Bersihkan data player yang sudah disconnect
                for userId, _ in pairs(playerOrbits) do
                    local playerExists = false
                    for _, player in pairs(Players:GetPlayers()) do
                        if player.UserId == userId then
                            playerExists = true
                            break
                        end
                    end
                    if not playerExists then
                        playerOrbits[userId] = nil
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
    playerOrbits = {}
end

return Module
