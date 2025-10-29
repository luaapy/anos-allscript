local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Module = {}
local connection
local reachDistance = 25
local originalToolSizes = {}

local function extendReach()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                local handle = tool:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    if not originalToolSizes[tool] then
                        originalToolSizes[tool] = handle.Size
                    end
                    
                    handle.Size = Vector3.new(0.5, 0.5, reachDistance)
                    handle.Transparency = 1
                    handle.Massless = true
                end
            end
        end
        
        if LocalPlayer:FindFirstChild("Backpack") then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local handle = tool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        if not originalToolSizes[tool] then
                            originalToolSizes[tool] = handle.Size
                        end
                        
                        handle.Size = Vector3.new(0.5, 0.5, reachDistance)
                        handle.Transparency = 1
                        handle.Massless = true
                    end
                end
            end
        end
    end)
end

function Module.start()
    connection = RunService.Heartbeat:Connect(function()
        extendReach()
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        extendReach()
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🎯 Reach Extender";
        Text = "Reach extended to " .. reachDistance .. " studs!";
        Duration = 3;
    })
end

function Module.stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    for tool, originalSize in pairs(originalToolSizes) do
        pcall(function()
            if tool and tool:FindFirstChild("Handle") then
                tool.Handle.Size = originalSize
                tool.Handle.Transparency = 0
            end
        end)
    end
    
    originalToolSizes = {}
end

return Module
