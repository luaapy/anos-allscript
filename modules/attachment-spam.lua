local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local attachments = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character then
                for i = 1, 5 do
                    local randomPart = character:GetDescendants()[math.random(1, #character:GetDescendants())]
                    if randomPart:IsA("BasePart") then
                        local att = Instance.new("Attachment")
                        att.Position = Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
                        att.Parent = randomPart
                        
                        table.insert(attachments, att)
                    end
                end
                
                if #attachments > 100 then
                    for i = 1, 20 do
                        local old = table.remove(attachments, 1)
                        if old and old.Parent then
                            old:Destroy()
                        end
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
    
    for _, att in pairs(attachments) do
        if att and att.Parent then
            att:Destroy()
        end
    end
    attachments = {}
end

return Module
