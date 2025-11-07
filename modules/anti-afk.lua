local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connections = {}

function Module.start()
    Module.stop()
    
    connections.idled = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        VirtualUser:Button2Down(Vector2.new())
        wait(0.1)
        VirtualUser:Button2Up(Vector2.new())
    end)
    
    connections.heartbeat = RunService.Heartbeat:Connect(function()
        if tick() % 60 < 0.1 then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
    
    connections.movement = RunService.Heartbeat:Connect(function()
        if tick() % 120 < 0.1 and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                humanoid.Jump = true
            end
        end
    end)
    
    task.spawn(function()
        pcall(function()
            for _, conn in pairs(getconnections(LocalPlayer.Idled)) do
                if conn.Function and not table.find(connections, conn) then
                    conn:Disable()
                    table.insert(connections, conn)
                end
            end
        end)
    end)
    
    warn("Anti-AFK Started")
end

function Module.stop()
    for name, conn in pairs(connections) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        elseif conn.Enable then
            pcall(function() conn:Enable() end)
        end
    end
    connections = {}
    warn("Anti-AFK Stopped")
end

if LocalPlayer.Character then
    Module.start()
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    Module.start()
end)

return Module
