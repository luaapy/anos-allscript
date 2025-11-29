local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local forcefields = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                local ff = Instance.new("ForceField")
                ff.Parent = character
                table.insert(forcefields, ff)
                
                task.spawn(function()
                    task.wait(0.5)
                    if ff and ff.Parent then
                        ff:Destroy()
                    end
                end)
                
                if #forcefields > 10 then
                    local old = table.remove(forcefields, 1)
                    if old and old.Parent then
                        old:Destroy()
                    end
                end
            end
        end)
        task.wait(0.1)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, ff in pairs(forcefields) do
        if ff and ff.Parent then
            ff:Destroy()
        end
    end
    forcefields = {}
end

return Module
