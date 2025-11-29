local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local connection
local characters = {}

function Module.start()
    local camera = workspace.CurrentCamera
    
    connection = RunService.Heartbeat:Connect(function()
        pcall(function()
            -- Create falling characters
            if math.random(1, 3) == 1 then
                local char = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
                local randomChar = char[math.random(1, #char)]
                
                local gui = Instance.new("BillboardGui")
                gui.Size = UDim2.new(0, 20, 0, 20)
                gui.StudsOffset = Vector3.new(math.random(-50, 50), math.random(40, 60), math.random(-50, 50))
                gui.AlwaysOnTop = true
                gui.Parent = workspace.Terrain
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = randomChar
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.TextStrokeTransparency = 0
                label.TextSize = 14
                label.Font = Enum.Font.Code
                label.Parent = gui
                
                table.insert(characters, gui)
                
                task.spawn(function()
                    for i = 1, 100 do
                        if gui and gui.Parent then
                            gui.StudsOffset = gui.StudsOffset - Vector3.new(0, 0.5, 0)
                            task.wait(0.05)
                        end
                    end
                    if gui and gui.Parent then
                        gui:Destroy()
                    end
                end)
            end
            
            -- Clean old characters
            if #characters > 50 then
                local old = table.remove(characters, 1)
                if old and old.Parent then
                    old:Destroy()
                end
            end
        end)
    end)
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for _, gui in pairs(characters) do
        if gui and gui.Parent then
            gui:Destroy()
        end
    end
    
    characters = {}
end

return Module
