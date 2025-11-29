local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                local ray = Ray.new(rootPart.Position, rootPart.CFrame.RightVector * 5)
                local hit, position, normal = workspace:FindPartOnRay(ray, character)
                
                if hit then
                    rootPart.AssemblyLinearVelocity = Vector3.new(
                        rootPart. AssemblyLinearVelocity.X,
                        50,
                        rootPart.AssemblyLinearVelocity.Z
                    ) + normal * 30
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
end

return Module
