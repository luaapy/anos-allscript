local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ModuleStates = {}
local ModuleConnections = {}

local GitHubBase = "https://raw.githubusercontent.com/anos-rgb/anos-allscript/main/modules/"

local Modules = {
    {name = "Speed Hack", file = "speed-hack.lua", category = "Movement", icon = "⚡", color = Color3.fromRGB(255, 215, 0)},
    {name = "Jump Power", file = "jump-power.lua", category = "Movement", icon = "🚀", color = Color3.fromRGB(0, 191, 255)},
    {name = "Infinite Jump", file = "infinite-jump.lua", category = "Movement", icon = "🦘", color = Color3.fromRGB(255, 105, 180)},
    {name = "God Mode", file = "god-mode.lua", category = "Character", icon = "🛡️", color = Color3.fromRGB(255, 69, 0)},
    {name = "Fly/Levitate", file = "fly.lua", category = "Movement", icon = "✈️", color = Color3.fromRGB(135, 206, 250)},
    {name = "No Clip", file = "noclip.lua", category = "Movement", icon = "👻", color = Color3.fromRGB(186, 85, 211)},
    {name = "Teleport Spam", file = "teleport-spam.lua", category = "Movement", icon = "🌀", color = Color3.fromRGB(64, 224, 208)},
    {name = "Fling Self", file = "fling-self.lua", category = "Character", icon = "💫", color = Color3.fromRGB(255, 20, 147)},
    {name = "Spin Character", file = "spin-character.lua", category = "Character", icon = "🌪️", color = Color3.fromRGB(0, 255, 255)},
    {name = "Walk on Air", file = "walk-air.lua", category = "Movement", icon = "☁️", color = Color3.fromRGB(173, 216, 230)},
    {name = "Ice Skate", file = "ice-skate.lua", category = "Movement", icon = "⛸️", color = Color3.fromRGB(176, 224, 230)},
    {name = "Moonwalk", file = "moonwalk.lua", category = "Movement", icon = "🌙", color = Color3.fromRGB(255, 255, 224)},
    {name = "Ragdoll Spam", file = "ragdoll-spam.lua", category = "Character", icon = "🤸", color = Color3.fromRGB(255, 140, 0)},
    {name = "Sit Spam", file = "sit-spam.lua", category = "Character", icon = "💺", color = Color3.fromRGB(220, 20, 60)},
    {name = "Climb Boost", file = "climb-boost.lua", category = "Movement", icon = "🧗", color = Color3.fromRGB(34, 139, 34)},
    {name = "Anti Fall Damage", file = "anti-fall.lua", category = "Character", icon = "🪂", color = Color3.fromRGB(30, 144, 255)},
    {name = "Emote Spam", file = "emote-spam.lua", category = "Animation", icon = "💃", color = Color3.fromRGB(255, 182, 193)},
    {name = "Animation Speed", file = "animation-speed.lua", category = "Animation", icon = "⏩", color = Color3.fromRGB(255, 99, 71)},
    {name = "Animation Glitch", file = "animation-glitch.lua", category = "Animation", icon = "🔀", color = Color3.fromRGB(147, 112, 219)},
    {name = "Pose Modes", file = "pose-modes.lua", category = "Animation", icon = "🎭", color = Color3.fromRGB(218, 112, 214)},
    {name = "Animation Freeze", file = "animation-freeze.lua", category = "Animation", icon = "❄️", color = Color3.fromRGB(0, 255, 255)},
    {name = "Rapid Fire", file = "rapid-fire.lua", category = "Combat", icon = "🔫", color = Color3.fromRGB(255, 69, 0)},
    {name = "Aimbot Smooth", file = "aimbot-smooth.lua", category = "Combat", icon = "🎯", color = Color3.fromRGB(255, 0, 127)},
    {name = "Auto Parry", file = "auto-parry.lua", category = "Combat", icon = "🛡️", color = Color3.fromRGB(100, 149, 237)},
    {name = "Damage Multiplier", file = "damage-multiplier.lua", category = "Combat", icon = "💥", color = Color3.fromRGB(255, 69, 0)},
    {name = "Kill Aura", file = "kill-aura.lua", category = "Combat", icon = "⚡", color = Color3.fromRGB(255, 215, 0)},
    {name = "Auto Dodge", file = "auto-dodge.lua", category = "Combat", icon = "💨", color = Color3.fromRGB(135, 206, 250)},
    {name = "Critical Hit Force", file = "critical-hit-force.lua", category = "Combat", icon = "💢", color = Color3.fromRGB(220, 20, 60)},
    {name = "Reach Extender", file = "reach-extender.lua", category = "Combat", icon = "🎯", color = Color3.fromRGB(0, 255, 127)},
    {name = "Auto Heal", file = "auto-heal.lua", category = "Combat", icon = "💚", color = Color3.fromRGB(50, 205, 50)},
    {name = "Weapon Spam", file = "weapon-spam.lua", category = "Combat", icon = "🔥", color = Color3.fromRGB(255, 140, 0)},
    {name = "Anti Ragdoll", file = "anti-ragdoll.lua", category = "Combat", icon = "🚫", color = Color3.fromRGB(220, 20, 60)},
    {name = "Instant Reload", file = "instant-reload.lua", category = "Combat", icon = "🔄", color = Color3.fromRGB(255, 140, 0)},
    {name = "Chat Spam", file = "chat-spam.lua", category = "Social", icon = "💬", color = Color3.fromRGB(100, 149, 237)},
    {name = "Chat Flood", file = "chat-flood.lua", category = "Social", icon = "🌊", color = Color3.fromRGB(65, 105, 225)},
    {name = "Whisper Spam", file = "whisper-spam.lua", category = "Social", icon = "🤫", color = Color3.fromRGB(138, 43, 226)},
    {name = "Fling Player", file = "fling-player.lua", category = "Trolling", icon = "🎯", color = Color3.fromRGB(220, 20, 60)},
    {name = "Push Player", file = "push-player.lua", category = "Trolling", icon = "👊", color = Color3.fromRGB(255, 0, 0)},
    {name = "Attach Player", file = "attach-player.lua", category = "Trolling", icon = "🔗", color = Color3.fromRGB(0, 206, 209)},
    {name = "Spam Nearby", file = "spam-nearby.lua", category = "Trolling", icon = "📢", color = Color3.fromRGB(255, 215, 0)},
    {name = "Body Block", file = "body-block.lua", category = "Trolling", icon = "🚧", color = Color3.fromRGB(255, 165, 0)},
    {name = "Follow Bot", file = "follow-bot.lua", category = "Trolling", icon = "🤖", color = Color3.fromRGB(70, 130, 180)},
    {name = "Anti AFK", file = "anti-afk.lua", category = "Utility", icon = "⏰", color = Color3.fromRGB(32, 178, 170)},
    {name = "Anti Cheat Bypass", file = "anti-cheat-bypass.lua", category = "Utility", icon = "🔓", color = Color3.fromRGB(255, 215, 0)},
    {name = "ESP Wallhack", file = "esp-wallhack.lua", category = "Visual", icon = "👁️", color = Color3.fromRGB(0, 255, 127)},
    {name = "X-Ray Vision", file = "xray-vision.lua", category = "Visual", icon = "🔍", color = Color3.fromRGB(50, 205, 50)},
    {name = "Fullbright", file = "fullbright.lua", category = "Visual", icon = "💡", color = Color3.fromRGB(255, 255, 0)},
    {name = "Auto Farm", file = "auto-farm.lua", category = "Automation", icon = "🌾", color = Color3.fromRGB(34, 139, 34)},
    {name = "Auto Collect", file = "auto-collect.lua", category = "Automation", icon = "💰", color = Color3.fromRGB(255, 215, 0)},
    {name = "Auto Click", file = "auto-click.lua", category = "Automation", icon = "🖱️", color = Color3.fromRGB(169, 169, 169)},
    {name = "Hitbox Expander", file = "hitbox-expander.lua", category = "Combat", icon = "📦", color = Color3.fromRGB(255, 99, 71)},
    {name = "Silent Aim", file = "silent-aim.lua", category = "Combat", icon = "🎯", color = Color3.fromRGB(220, 20, 60)},
    {name = "Infinite Stamina", file = "infinite-stamina.lua", category = "Character", icon = "💪", color = Color3.fromRGB(255, 140, 0)}
}

local HubGui = Instance.new("ScreenGui")
HubGui.Name = "ANOS_PREMIUM_HUB"
HubGui.Parent = PlayerGui
HubGui.ResetOnSpawn = false
HubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "HubBlur"
BlurEffect.Size = 0
BlurEffect.Parent = game.Lighting

local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Parent = HubGui
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.BackgroundTransparency = 1
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.Size = UDim2.new(0, 0, 0, 0)
MainContainer.Visible = false

local LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainContainer
LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
LeftPanel.BackgroundTransparency = 0.1
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 250, 1, 0)

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 20)
LeftCorner.Parent = LeftPanel

local LeftGradient = Instance.new("UIGradient")
LeftGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
}
LeftGradient.Rotation = 45
LeftGradient.Parent = LeftPanel

local LeftStroke = Instance.new("UIStroke")
LeftStroke.Color = Color3.fromRGB(0, 255, 255)
LeftStroke.Thickness = 2
LeftStroke.Transparency = 0.5
LeftStroke.Parent = LeftPanel

local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Parent = LeftPanel
LogoContainer.BackgroundTransparency = 1
LogoContainer.Position = UDim2.new(0, 0, 0, 20)
LogoContainer.Size = UDim2.new(1, 0, 0, 80)

local LogoText = Instance.new("TextLabel")
LogoText.Name = "LogoText"
LogoText.Parent = LogoContainer
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 0, 40)
LogoText.Font = Enum.Font.GothamBold
LogoText.Text = "ANOS"
LogoText.TextColor3 = Color3.fromRGB(0, 255, 255)
LogoText.TextSize = 32
LogoText.TextStrokeTransparency = 0.5

local LogoSubText = Instance.new("TextLabel")
LogoSubText.Name = "LogoSubText"
LogoSubText.Parent = LogoContainer
LogoSubText.BackgroundTransparency = 1
LogoSubText.Position = UDim2.new(0, 0, 0, 40)
LogoSubText.Size = UDim2.new(1, 0, 0, 30)
LogoSubText.Font = Enum.Font.Gotham
LogoSubText.Text = "PREMIUM HUB"
LogoSubText.TextColor3 = Color3.fromRGB(150, 150, 150)
LogoSubText.TextSize = 14

local Divider1 = Instance.new("Frame")
Divider1.Name = "Divider"
Divider1.Parent = LeftPanel
Divider1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Divider1.BackgroundTransparency = 0.7
Divider1.BorderSizePixel = 0
Divider1.Position = UDim2.new(0.1, 0, 0, 110)
Divider1.Size = UDim2.new(0.8, 0, 0, 2)

local CategoryTitle = Instance.new("TextLabel")
CategoryTitle.Name = "CategoryTitle"
CategoryTitle.Parent = LeftPanel
CategoryTitle.BackgroundTransparency = 1
CategoryTitle.Position = UDim2.new(0, 20, 0, 130)
CategoryTitle.Size = UDim2.new(1, -40, 0, 25)
CategoryTitle.Font = Enum.Font.GothamSemibold
CategoryTitle.Text = "CATEGORIES"
CategoryTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
CategoryTitle.TextSize = 12
CategoryTitle.TextXAlignment = Enum.TextXAlignment.Left

local CategoryList = Instance.new("ScrollingFrame")
CategoryList.Name = "CategoryList"
CategoryList.Parent = LeftPanel
CategoryList.BackgroundTransparency = 1
CategoryList.BorderSizePixel = 0
CategoryList.Position = UDim2.new(0, 10, 0, 160)
CategoryList.Size = UDim2.new(1, -20, 1, -230)
CategoryList.CanvasSize = UDim2.new(0, 0, 0, 0)
CategoryList.ScrollBarThickness = 4
CategoryList.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)

local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.Parent = CategoryList
CategoryLayout.Padding = UDim.new(0, 5)
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder

local categories = {
    {name = "All", icon = "📋", count = 44},
    {name = "Movement", icon = "🏃", count = 12},
    {name = "Character", icon = "👤", count = 7},
    {name = "Animation", icon = "🎬", count = 5},
    {name = "Combat", icon = "⚔️", count = 5},
    {name = "Social", icon = "💭", count = 3},
    {name = "Trolling", icon = "😈", count = 6},
    {name = "Utility", icon = "🔧", count = 2},
    {name = "Visual", icon = "👁️", count = 3},
    {name = "Automation", icon = "🤖", count = 3}
}

local selectedCategory = "All"

local function createCategoryButton(category, icon, count, index)
    local btn = Instance.new("TextButton")
    btn.Name = category
    btn.Parent = CategoryList
    btn.BackgroundColor3 = category == "All" and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(20, 20, 30)
    btn.BackgroundTransparency = category == "All" and 0.7 or 0.9
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = ""
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.LayoutOrder = index
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Parent = btn
    iconLabel.BackgroundTransparency = 1
    iconLabel.Position = UDim2.new(0, 15, 0, 0)
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = icon
    iconLabel.TextColor3 = category == "All" and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(150, 150, 150)
    iconLabel.TextSize = 18
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = btn
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 50, 0, 0)
    nameLabel.Size = UDim2.new(1, -90, 1, 0)
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.Text = category
    nameLabel.TextColor3 = category == "All" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    nameLabel.TextSize = 13
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local countLabel = Instance.new("TextLabel")
    countLabel.Parent = btn
    countLabel.BackgroundColor3 = category == "All" and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(40, 40, 50)
    countLabel.BorderSizePixel = 0
    countLabel.Position = UDim2.new(1, -35, 0.5, -10)
    countLabel.Size = UDim2.new(0, 25, 0, 20)
    countLabel.Font = Enum.Font.GothamBold
    countLabel.Text = tostring(count)
    countLabel.TextColor3 = category == "All" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(150, 150, 150)
    countLabel.TextSize = 11
    
    local countCorner = Instance.new("UICorner")
    countCorner.CornerRadius = UDim.new(0, 5)
    countCorner.Parent = countLabel
    
    btn.MouseEnter:Connect(function()
        if selectedCategory ~= category then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(0, 255, 255)}):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if selectedCategory ~= category then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.9}):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        selectedCategory = category
        
        for _, button in pairs(CategoryList:GetChildren()) do
            if button:IsA("TextButton") then
                local bIcon = button:FindFirstChild("TextLabel")
                local bName = button:FindFirstChildOfClass("TextLabel")
                
                TweenService:Create(button, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0.9,
                    BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                }):Play()
                
                if bIcon then
                    TweenService:Create(bIcon, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                end
            end
        end
        
        TweenService:Create(btn, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.7,
            BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        }):Play()
        TweenService:Create(iconLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(0, 255, 255)}):Play()
        TweenService:Create(nameLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(countLabel, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 255),
            TextColor3 = Color3.fromRGB(0, 0, 0)
        }):Play()
        
        updateModuleList()
    end)
    
    return btn
end

for i, cat in ipairs(categories) do
    createCategoryButton(cat.name, cat.icon, cat.count, i)
end

CategoryList.CanvasSize = UDim2.new(0, 0, 0, CategoryLayout.AbsoluteContentSize.Y + 10)

local BottomInfo = Instance.new("Frame")
BottomInfo.Name = "BottomInfo"
BottomInfo.Parent = LeftPanel
BottomInfo.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
BottomInfo.BackgroundTransparency = 0.9
BottomInfo.BorderSizePixel = 0
BottomInfo.Position = UDim2.new(0, 10, 1, -60)
BottomInfo.Size = UDim2.new(1, -20, 0, 50)

local BottomCorner = Instance.new("UICorner")
BottomCorner.CornerRadius = UDim.new(0, 10)
BottomCorner.Parent = BottomInfo

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Parent = BottomInfo
VersionLabel.BackgroundTransparency = 1
VersionLabel.Size = UDim2.new(1, 0, 0.5, 0)
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.Text = "Version 2.0"
VersionLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
VersionLabel.TextSize = 12

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = BottomInfo
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.5, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.5, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "44 Modules Loaded"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 10

local RightPanel = Instance.new("Frame")
RightPanel.Name = "RightPanel"
RightPanel.Parent = MainContainer
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
RightPanel.BackgroundTransparency = 0.1
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 260, 0, 0)
RightPanel.Size = UDim2.new(0, 640, 1, 0)

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 20)
RightCorner.Parent = RightPanel

local RightGradient = Instance.new("UIGradient")
RightGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
RightGradient.Rotation = -45
RightGradient.Parent = RightPanel

local RightStroke = Instance.new("UIStroke")
RightStroke.Color = Color3.fromRGB(138, 43, 226)
RightStroke.Thickness = 2
RightStroke.Transparency = 0.5
RightStroke.Parent = RightPanel

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = RightPanel
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 0, 60)

local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Parent = TopBar
SearchContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SearchContainer.BorderSizePixel = 0
SearchContainer.Position = UDim2.new(0, 20, 0, 15)
SearchContainer.Size = UDim2.new(1, -120, 0, 40)

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 12)
SearchCorner.Parent = SearchContainer

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Color3.fromRGB(138, 43, 226)
SearchStroke.Thickness = 1
SearchStroke.Transparency = 0.7
SearchStroke.Parent = SearchContainer

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Parent = SearchContainer
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(0, 12, 0.5, -10)
SearchIcon.Size = UDim2.new(0, 20, 0, 20)
SearchIcon.Image = "rbxassetid://3926305904"
SearchIcon.ImageColor3 = Color3.fromRGB(138, 43, 226)
SearchIcon.ImageRectOffset = Vector2.new(964, 324)
SearchIcon.ImageRectSize = Vector2.new(36, 36)

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = SearchContainer
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 40, 0, 0)
SearchBox.Size = UDim2.new(1, -50, 1, 0)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search modules..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -80, 0, 15)
CloseBtn.Size = UDim2.new(0, 70, 0, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseBtn

local ModuleScroll = Instance.new("ScrollingFrame")
ModuleScroll.Name = "ModuleScroll"
ModuleScroll.Parent = RightPanel
ModuleScroll.BackgroundTransparency = 1
ModuleScroll.BorderSizePixel = 0
ModuleScroll.Position = UDim2.new(0, 20, 0, 75)
ModuleScroll.Size = UDim2.new(1, -40, 1, -95)
ModuleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ModuleScroll.ScrollBarThickness = 6
ModuleScroll.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)

local ModuleGrid = Instance.new("UIGridLayout")
ModuleGrid.Parent = ModuleScroll
ModuleGrid.CellPadding = UDim2.new(0, 12, 0, 12)
ModuleGrid.CellSize = UDim2.new(0, 190, 0, 110)
ModuleGrid.SortOrder = Enum.SortOrder.LayoutOrder

local function createModuleCard(module, index)
    local card = Instance.new("Frame")
    card.Name = module.file .. "_Card"
    card.Parent = ModuleScroll
    card.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    card.BorderSizePixel = 0
    card.LayoutOrder = index
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 15)
    cardCorner.Parent = card
    
    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = module.color
    cardStroke.Thickness = 2
    cardStroke.Transparency = 0.7
    cardStroke.Parent = card
    
    local glowLine = Instance.new("Frame")
    glowLine.Name = "GlowLine"
    glowLine.Parent = card
    glowLine.BackgroundColor3 = module.color
    glowLine.BorderSizePixel = 0
    glowLine.Size = UDim2.new(1, 0, 0, 3)
    glowLine.Transparency = 0.5
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 15)
    glowCorner.Parent = glowLine
    
    local iconBg = Instance.new("Frame")
    iconBg.Name = "IconBg"
    iconBg.Parent = card
    iconBg.BackgroundColor3 = module.color
    iconBg.BackgroundTransparency = 0.9
    iconBg.BorderSizePixel = 0
    iconBg.Position = UDim2.new(0, 15, 0, 15)
    iconBg.Size = UDim2.new(0, 45, 0, 45)
    
    local iconBgCorner = Instance.new("UICorner")
    iconBgCorner.CornerRadius = UDim.new(0, 10)
    iconBgCorner.Parent = iconBg
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Parent = iconBg
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = module.icon
    iconLabel.TextColor3 = module.color
    iconLabel.TextSize = 24
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.Parent = card
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 70, 0, 15)
    nameLabel.Size = UDim2.new(1, -80, 0, 20)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = module.name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 13
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
    local categoryLabel = Instance.new("TextLabel")
    categoryLabel.Name = "Category"
    categoryLabel.Parent = card
    categoryLabel.BackgroundTransparency = 1
    categoryLabel.Position = UDim2.new(0, 70, 0, 35)
    categoryLabel.Size = UDim2.new(1, -80, 0, 15)
    categoryLabel.Font = Enum.Font.Gotham
    categoryLabel.Text = module.category
    categoryLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
    categoryLabel.TextSize = 10
    categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "Toggle"
    toggleBtn.Parent = card
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Position = UDim2.new(0, 15, 1, -35)
    toggleBtn.Size = UDim2.new(1, -30, 0, 28)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "ACTIVATE"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleBtn.TextSize = 11
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.Parent = card
    statusDot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    statusDot.BorderSizePixel = 0
    statusDot.Position = UDim2.new(1, -25, 0, 25)
    statusDot.Size = UDim2.new(0, 8, 0, 8)
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = statusDot
    
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    end)
    
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    toggleBtn.MouseButton1Click:Connect(function()
        if ModuleStates[module.file] then
            stopModule(module.file, toggleBtn, statusDot, cardStroke)
        else
            loadModule(module.file, toggleBtn, statusDot, cardStroke, module.name, module.color)
        end
    end)
    
    return card
end

function loadModule(fileName, button, statusDot, stroke, moduleName, color)
    local success, result = pcall(function()
        local url = GitHubBase .. fileName
        local scriptContent = game:HttpGet(url)
        
        local moduleFunc = loadstring(scriptContent)
        if moduleFunc then
            local moduleReturn = moduleFunc()
            
            if type(moduleReturn) == "table" and moduleReturn.start then
                ModuleStates[fileName] = true
                ModuleConnections[fileName] = moduleReturn
                moduleReturn.start()
                
                button.Text = "DEACTIVATE"
                TweenService:Create(button, TweenInfo.new(0.3), {
                    BackgroundColor3 = color,
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                TweenService:Create(statusDot, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
                TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "✅ Module Active";
                    Text = moduleName;
                    Duration = 2;
                })
            end
        end
    end)
    
    if not success then
        warn("Failed: " .. fileName)
        button.Text = "ERROR"
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 0, 0)}):Play()
    end
end

function stopModule(fileName, button, statusDot, stroke)
    pcall(function()
        if ModuleConnections[fileName] and ModuleConnections[fileName].stop then
            ModuleConnections[fileName].stop()
        end
    end)
    
    ModuleStates[fileName] = false
    ModuleConnections[fileName] = nil
    
    button.Text = "ACTIVATE"
    TweenService:Create(button, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        TextColor3 = Color3.fromRGB(200, 200, 200)
    }):Play()
    TweenService:Create(statusDot, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 0.7}):Play()
end

function updateModuleList()
    for _, child in pairs(ModuleScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local searchText = SearchBox.Text:lower()
    local index = 1
    
    for _, module in ipairs(Modules) do
        local matchesCategory = selectedCategory == "All" or module.category == selectedCategory
        local matchesSearch = searchText == "" or module.name:lower():find(searchText)
        
        if matchesCategory and matchesSearch then
            createModuleCard(module, index)
            index = index + 1
        end
    end
    
    ModuleScroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil((index - 1) / 3) * 122 + 10)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(updateModuleList)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 70, 100)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 80)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    for fileName, _ in pairs(ModuleStates) do
        pcall(function()
            if ModuleConnections[fileName] and ModuleConnections[fileName].stop then
                ModuleConnections[fileName].stop()
            end
        end)
    end
    
    TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
    TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.5)
    HubGui:Destroy()
end)

local dragToggle = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(MainContainer, TweenInfo.new(0.1), {Position = position}):Play()
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = MainContainer.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragToggle then
            updateInput(input)
        end
    end
end)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = HubGui
ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 80, 0, 80)
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ANOS"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleButton.TextSize = 12
ToggleButton.ZIndex = 100

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 255, 255)
ToggleStroke.Thickness = 3
ToggleStroke.Transparency = 0.3
ToggleStroke.Parent = ToggleButton

local ToggleGradient = Instance.new("UIGradient")
ToggleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
}
ToggleGradient.Rotation = 45
ToggleGradient.Parent = ToggleButton

local OrbitContainer = Instance.new("Frame")
OrbitContainer.Name = "OrbitContainer"
OrbitContainer.Parent = ToggleButton
OrbitContainer.AnchorPoint = Vector2.new(0.5, 0.5)
OrbitContainer.BackgroundTransparency = 1
OrbitContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
OrbitContainer.Size = UDim2.new(1, 20, 1, 20)
OrbitContainer.ZIndex = 99

for i = 1, 3 do
    local orbitDot = Instance.new("Frame")
    orbitDot.Name = "OrbitDot" .. i
    orbitDot.Parent = OrbitContainer
    orbitDot.AnchorPoint = Vector2.new(0.5, 0.5)
    orbitDot.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    orbitDot.BorderSizePixel = 0
    orbitDot.Position = UDim2.new(0.5, 0, 0, 0)
    orbitDot.Size = UDim2.new(0, 8, 0, 8)
    orbitDot.ZIndex = 99
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = orbitDot
    
    local dotGlow = Instance.new("ImageLabel")
    dotGlow.Name = "Glow"
    dotGlow.Parent = orbitDot
    dotGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    dotGlow.BackgroundTransparency = 1
    dotGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    dotGlow.Size = UDim2.new(2, 0, 2, 0)
    dotGlow.ZIndex = 98
    dotGlow.Image = "rbxassetid://6014261993"
    dotGlow.ImageColor3 = Color3.fromRGB(0, 255, 255)
    dotGlow.ImageTransparency = 0.3
    dotGlow.ScaleType = Enum.ScaleType.Slice
    dotGlow.SliceCenter = Rect.new(99, 99, 99, 99)
end

local RingEffect = Instance.new("ImageLabel")
RingEffect.Name = "RingEffect"
RingEffect.Parent = ToggleButton
RingEffect.AnchorPoint = Vector2.new(0.5, 0.5)
RingEffect.BackgroundTransparency = 1
RingEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
RingEffect.Size = UDim2.new(1.4, 0, 1.4, 0)
RingEffect.ZIndex = 98
RingEffect.Image = "rbxassetid://6014261993"
RingEffect.ImageColor3 = Color3.fromRGB(138, 43, 226)
RingEffect.ImageTransparency = 0.7
RingEffect.ScaleType = Enum.ScaleType.Slice
RingEffect.SliceCenter = Rect.new(99, 99, 99, 99)

task.spawn(function()
    while task.wait() do
        pcall(function()
            for i, dot in pairs(OrbitContainer:GetChildren()) do
                if dot:IsA("Frame") then
                    local angle = (tick() * 2 + (i - 1) * (360 / 3)) % 360
                    local rad = math.rad(angle)
                    local distance = 45
                    
                    local x = math.cos(rad) * distance
                    local y = math.sin(rad) * distance
                    
                    dot.Position = UDim2.new(0.5, x, 0.5, y)
                    
                    local hue = (tick() + i * 0.3) % 1
                    local color = Color3.fromHSV(hue, 0.8, 1)
                    dot.BackgroundColor3 = color
                    
                    if dot:FindFirstChild("Glow") then
                        dot.Glow.ImageColor3 = color
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            local hue = tick() % 3 / 3
            local color = Color3.fromHSV(hue, 0.8, 1)
            TweenService:Create(ToggleStroke, TweenInfo.new(0.5), {Color = color}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.5), {TextColor3 = color}):Play()
        end)
    end
end)

task.spawn(function()
    while task.wait(0.02) do
        pcall(function()
            RingEffect.Rotation = (RingEffect.Rotation + 1) % 360
        end)
    end
end)

local guiVisible = false

ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 80, 0, 80)
    }):Play()
    TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {Thickness = 4, Transparency = 0}):Play()
    TweenService:Create(RingEffect, TweenInfo.new(0.3), {
        Size = UDim2.new(1.6, 0, 1.6, 0),
        ImageTransparency = 0.5
    }):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 70, 0, 70)
    }):Play()
    TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {Thickness = 3, Transparency = 0.3}):Play()
    TweenService:Create(RingEffect, TweenInfo.new(0.3), {
        Size = UDim2.new(1.4, 0, 1.4, 0),
        ImageTransparency = 0.7
    }):Play()
end)

local clickDebounce = false

ToggleButton.MouseButton1Click:Connect(function()
    if clickDebounce then return end
    clickDebounce = true
    
    guiVisible = not guiVisible
    
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Elastic), {
        Size = UDim2.new(0, 60, 0, 60)
    }):Play()
    task.wait(0.1)
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
        Size = UDim2.new(0, 70, 0, 70)
    }):Play()
    
    if guiVisible then
        MainContainer.Visible = true
        TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 10}):Play()
        TweenService:Create(MainContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 900, 0, 550)
        }):Play()
    else
        TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
        TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.5)
        MainContainer.Visible = false
    end
    
    task.wait(0.3)
    clickDebounce = false
end)

local toggleDragToggle = nil
local toggleDragStart = nil
local toggleStartPos = nil

local function updateToggleInput(input)
    local delta = input.Position - toggleDragStart
    local position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
    ToggleButton.Position = position
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragToggle = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                toggleDragToggle = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if toggleDragToggle then
            updateToggleInput(input)
        end
    end
end)

task.spawn(function()
    while task.wait(0.03) do
        pcall(function()
            local hue = tick() % 5 / 5
            local color1 = Color3.fromHSV(hue, 0.8, 1)
            local color2 = Color3.fromHSV((hue + 0.5) % 1, 0.8, 1)
            
            TweenService:Create(LeftStroke, TweenInfo.new(0.5), {Color = color1}):Play()
            TweenService:Create(RightStroke, TweenInfo.new(0.5), {Color = color2}):Play()
            TweenService:Create(LogoText, TweenInfo.new(0.5), {TextColor3 = color1}):Play()
        end)
    end
end)

task.wait(0.5)
updateModuleList()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚡ ANOS PREMIUM HUB";
    Text = "Cyberpunk Edition Loaded!";
    Duration = 4;
})

print("╔════════════════════════════════════════╗")
print("║   ⚡ ANOS PREMIUM HUB - CYBERPUNK ⚡   ║")
print("║  GitHub: anos-rgb/anos-allscript      ║")
print("║  Total Modules: 44                    ║")
print("║  UI Version: 3.0 Premium Edition      ║")
print("╚════════════════════════════════════════╝")
