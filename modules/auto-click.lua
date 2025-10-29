local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Module = {}
local connection
local keybindConnection
local clickSpeed = 0.01
local isRunning = false

function Module.start()
    isRunning = true
    
    connection = RunService.Heartbeat:Connect(function()
        if isRunning then
            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(clickSpeed)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
        end
    end)
    
    keybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local aPressed = UserInputService:IsKeyDown(Enum.KeyCode.A)
        local nPressed = input.KeyCode == Enum.KeyCode.N
        
        if aPressed and nPressed then
            if isRunning then
                isRunning = false
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "🖱️ Auto Click";
                    Text = "Paused! Press A+N to resume";
                    Duration = 2;
                })
            else
                isRunning = true
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "🖱️ Auto Click";
                    Text = "Resumed!";
                    Duration = 2;
                })
            end
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🖱️ Auto Click Active";
        Text = "Press A+N to pause/resume";
        Duration = 3;
    })
end

function Module.stop()
    isRunning = false
    
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if keybindConnection then
        keybindConnection:Disconnect()
        keybindConnection = nil
    end
end

return Module
