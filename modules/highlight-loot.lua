local Module = {}
local highlights = {}

function Module.start()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or 
           obj.Name:lower():find("loot") or obj.Name:lower():find("item") then
            if obj:IsA("BasePart") then
                local highlight = Instance.new("SelectionBox")
                highlight.Adornee = obj
                highlight.LineThickness = 0.1
                highlight.Color3 = Color3.fromRGB(255, 215, 0)
                highlight.Parent = obj
                table.insert(highlights, highlight)
            end
        end
    end
end

function Module.stop()
    for _, highlight in pairs(highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    highlights = {}
end

return Module
