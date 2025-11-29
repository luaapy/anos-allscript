local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local gui

function Module.start()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    gui = Instance.new("ScreenGui")
    gui.Name = "PlayerListESP"
    gui.Parent = PlayerGui
    
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(0, 200, 0, 300)
    frame.Position = UDim2.new(1, -210, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = frame
    
    connection = RunService.Heartbeat:Connect(function()
        frame:ClearAllChildren()
        layout.Parent = frame
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 20)
                label.BackgroundTransparency = 1
                label.Text = player.Name
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.TextSize = 12
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = frame
            end
        end
        
        frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        
        task.wait(1)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if gui and gui.Parent then
        gui:Destroy()
        gui = nil
    end
end

return Module
