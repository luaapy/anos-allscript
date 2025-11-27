local module = {}
local connection

function module.start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        camera.CFrame = camera.CFrame * CFrame.Angles(
            math.rad(math.random(-2, 2)),
            math.rad(math.random(-2, 2)),
            math.rad(math.random(-2, 2))
        )
    end)
end

function module.stop()
    if connection then
        connection:Disconnect()
    end
end

return module
