local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local sounds = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://" .. math.random(1000000, 9999999)
                sound.Volume = 0.5
                sound.Parent = rootPart
                sound:Play()
                
                table.insert(sounds, sound)
                
                task.spawn(function()
                    task.wait(2)
                    if sound and sound.Parent then
                        sound:Destroy()
                    end
                end)
                
                if #sounds > 10 then
                    local old = table.remove(sounds, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
        task.wait(0.5)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, sound in pairs(sounds) do
        if sound and sound.Parent then
            sound:Destroy()
        end
    end
    sounds = {}
end

return Module
