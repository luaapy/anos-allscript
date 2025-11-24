local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local tween

function Module.start()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    local goal = {CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)}
    
    tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, goal)
    tween:Play()
end

function Module.stop()
    if tween then
        tween:Cancel()
        tween = nil
    end
end

return Module
