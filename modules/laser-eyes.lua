local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local beams = {}

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    
    local leftAttachment = Instance.new("Attachment")
    leftAttachment.Position = Vector3.new(-0.3, 0, -0.5)
    leftAttachment.Parent = head
    
    local rightAttachment = Instance.new("Attachment")
    rightAttachment.Position = Vector3.new(0.3, 0, -0.5)
    rightAttachment.Parent = head
    
    connection = RunService.Heartbeat:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local mouse = LocalPlayer:GetMouse()
            local target = mouse.Hit.Position
            
            for _, beam in pairs(beams) do
                if beam then beam:Destroy() end
            end
            beams = {}
            
            for _, attachment in pairs({leftAttachment, rightAttachment}) do
                local targetPart = Instance.new("Part")
                targetPart.Size = Vector3.new(0.1, 0.1, 0.1)
                targetPart.Position = target
                targetPart.Anchored = true
                targetPart.Transparency = 1
                targetPart.Parent = workspace
                
                local targetAttachment = Instance.new("Attachment")
                targetAttachment.Parent = targetPart
                
                local beam = Instance.new("Beam")
                beam.Attachment0 = attachment
                beam.Attachment1 = targetAttachment
                beam.Color = ColorSequence.new(Color3.new(1, 0, 0))
                beam.Width0 = 0.5
                beam.Width1 = 0.5
                beam.Parent = head
                
                table.insert(beams, beam)
                
                game:GetService("Debris"):AddItem(targetPart, 0.1)
            end
        end
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, beam in pairs(beams) do
        if beam then beam:Destroy() end
    end
    beams = {}
end

return Module
