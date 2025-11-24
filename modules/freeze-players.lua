local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local frozenPlayers = {}

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart and not frozenPlayers[player] then
                    frozenPlayers[player] = rootPart.CFrame
                end
                
                if rootPart and frozenPlayers[player] then
                    rootPart.CFrame = frozenPlayers[player]
                    rootPart.Velocity = Vector3.new(0, 0, 0)
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
    frozenPlayers = {}
end

return Module
