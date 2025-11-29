local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local beams = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart and rootPart.Parent then
                local att0 = Instance.new("Attachment")
                att0.Position = Vector3.new(0, 2, 0)
                att0.Parent = rootPart
                
                local att1 = Instance.new("Attachment")
                att1.Position = Vector3.new(math.random(-20, 20), math.random(-5, 20), math.random(-20, 20))
                att1.Parent = workspace.Terrain
                
                local beam = Instance.new("Beam")
                beam.Attachment0 = att0
                beam.Attachment1 = att1
                beam.Color = ColorSequence.new(Color3.fromHSV(math.random(), 1, 1))
                beam.Width0 = 0.5
                beam.Width1 = 0.5
                beam.FaceCamera = true
                beam.Parent = rootPart
                
                table.insert(beams, {beam = beam, att0 = att0, att1 = att1})
                
                task.spawn(function()
                    task.wait(1)
                    if beam and beam.Parent then beam:Destroy() end
                    if att0 and att0.Parent then att0:Destroy() end
                    if att1 and att1.Parent then att1:Destroy() end
                end)
                
                if #beams > 10 then
                    local old = table.remove(beams, 1)
                    if old.beam and old.beam.Parent then old.beam:Destroy() end
                    if old.att0 and old.att0.Parent then old.att0:Destroy() end
                    if old.att1 and old.att1.Parent then old.att1:Destroy() end
                end
            end
        end)
        task.wait(0.2)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, item in pairs(beams) do
        if item.beam and item.beam.Parent then item.beam:Destroy() end
        if item.att0 and item.att0.Parent then item.att0:Destroy() end
        if item.att1 and item.att1.Parent then item.att1:Destroy() end
    end
    beams = {}
end

return Module
