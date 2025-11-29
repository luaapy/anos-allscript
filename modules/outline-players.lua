local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Module = {}
local outlines = {}

function Module.start()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local outline = Instance.new("SelectionBox")
                    outline.Adornee = part
                    outline.LineThickness = 0.05
                    outline.Color3 = Color3.fromRGB(0, 255, 255)
                    outline.Parent = part
                    table.insert(outlines, outline)
                end
            end
        end
    end
end

function Module.stop()
    for _, outline in pairs(outlines) do
        if outline and outline.Parent then
            outline:Destroy()
        end
    end
    outlines = {}
end

return Module
