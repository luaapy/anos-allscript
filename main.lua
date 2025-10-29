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
    {name = "Speed Hack", file = "speed-hack.lua", category = "Movement", icon = "⚡"},
    {name = "Jump Power", file = "jump-power.lua", category = "Movement", icon = "🚀"},
    {name = "Infinite Jump", file = "infinite-jump.lua", category = "Movement", icon = "🦘"},
    {name = "God Mode", file = "god-mode.lua", category = "Character", icon = "🛡️"},
    {name = "Fly/Levitate", file = "fly.lua", category = "Movement", icon = "✈️"},
    {name = "No Clip", file = "noclip.lua", category = "Movement", icon = "👻"},
    {name = "Teleport Spam", file = "teleport-spam.lua", category = "Movement", icon = "🌀"},
    {name = "Fling Self", file = "fling-self.lua", category = "Character", icon = "💫"},
    {name = "Spin Character", file = "spin-character.lua", category = "Character", icon = "🌪️"},
    {name = "Walk on Air", file = "walk-air.lua", category = "Movement", icon = "☁️"},
    {name = "Ice Skate", file = "ice-skate.lua", category = "Movement", icon = "⛸️"},
    {name = "Moonwalk", file = "moonwalk.lua", category = "Movement", icon = "🌙"},
    {name = "Ragdoll Spam", file = "ragdoll-spam.lua", category = "Character", icon = "🤸"},
    {name = "Sit Spam", file = "sit-spam.lua", category = "Character", icon = "💺"},
    {name = "Climb Boost", file = "climb-boost.lua", category = "Movement", icon = "🧗"},
    {name = "Anti Fall Damage", file = "anti-fall.lua", category = "Character", icon = "🪂"},
    {name = "Emote Spam", file = "emote-spam.lua", category = "Animation", icon = "💃"},
    {name = "Animation Speed", file = "animation-speed.lua", category = "Animation", icon = "⏩"},
    {name = "Animation Glitch", file = "animation-glitch.lua", category = "Animation", icon = "🔀"},
    {name = "Pose Modes", file = "pose-modes.lua", category = "Animation", icon = "🎭"},
    {name = "Animation Freeze", file = "animation-freeze.lua", category = "Animation", icon = "❄️"},
    {name = "Rapid Fire", file = "rapid-fire.lua", category = "Combat", icon = "🔫"},
    {name = "Instant Reload", file = "instant-reload.lua", category = "Combat", icon = "🔄"},
    {name = "Chat Spam", file = "chat-spam.lua", category = "Social", icon = "💬"},
    {name = "Chat Flood", file = "chat-flood.lua", category = "Social", icon = "🌊"},
    {name = "Whisper Spam", file = "whisper-spam.lua", category = "Social", icon = "🤫"},
    {name = "Fling Player", file = "fling-player.lua", category = "Trolling", icon = "🎯"},
    {name = "Push Player", file = "push-player.lua", category = "Trolling", icon = "👊"},
    {name = "Attach Player", file = "attach-player.lua", category = "Trolling", icon = "🔗"},
    {name = "Spam Nearby", file = "spam-nearby.lua", category = "Trolling", icon = "📢"},
    {name = "Body Block", file = "body-block.lua", category = "Trolling", icon = "🚧"},
    {name = "Follow Bot", file = "follow-bot.lua", category = "Trolling", icon = "🤖"},
    {name = "Anti AFK", file = "anti-afk.lua", category = "Utility", icon = "⏰"},
    {name = "Anti Cheat Bypass", file = "anti-cheat-bypass.lua", category = "Utility", icon = "🔓"},
    {name = "ESP Wallhack", file = "esp-wallhack.lua", category = "Visual", icon = "👁️"},
    {name = "X-Ray Vision", file = "xray-vision.lua", category = "Visual", icon = "🔍"},
    {name = "Fullbright", file = "fullbright.lua", category = "Visual", icon = "💡"},
    {name = "Auto Farm", file = "auto-farm.lua", category = "Automation", icon = "🌾"},
    {name = "Auto Collect", file = "auto-collect.lua", category = "Automation", icon = "💰"},
    {name = "Auto Click", file = "auto-click.lua", category = "Automation", icon = "🖱️"},
    {name = "Hitbox Expander", file = "hitbox-expander.lua", category = "Combat", icon = "📦"},
    {name = "Silent Aim", file = "silent-aim.lua", category = "Combat", icon = "🎯"},
    {name = "Infinite Stamina", file = "infinite-stamina.lua", category = "Character", icon = "💪"},
    {name = "Speed Fly", file = "speed-fly.lua", category = "Movement", icon = "🚁"}
}

local HubGui = Instance.new("ScreenGui")
HubGui.Name = "ANOS_MODERN_HUB"
HubGui.Parent = PlayerGui
HubGui.ResetOnSpawn = false
HubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = HubGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(1, -370, 0, 20)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Active = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local GlowEffect = Instance.new("ImageLabel")
GlowEffect.Name = "Glow"
GlowEffect.Parent = MainFrame
GlowEffect.BackgroundTransparency = 1
GlowEffect.Position = UDim2.new(0, -15, 0, -15)
GlowEffect.Size = UDim2.new(1, 30, 1, 30)
GlowEffect.ZIndex = 0
GlowEffect.Image = "rbxassetid://6014261993"
GlowEffect.ImageColor3 = Color3.fromRGB(138, 43, 226)
GlowEffect.ImageTransparency = 0.7
GlowEffect.ScaleType = Enum.ScaleType.Slice
GlowEffect.SliceCenter = Rect.new(99, 99, 99, 99)

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 0, 50)

local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.Parent = TopBar
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0, 15, 0, 0)
Logo.Size = UDim2.new(0, 200, 1, 0)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "⚡ ANOS"
Logo.TextColor3 = Color3.fromRGB(138, 43, 226)
Logo.TextSize = 20
Logo.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Parent = TopBar
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 85, 0, 0)
SubTitle.Size = UDim2.new(0, 100, 1, 0)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "HUB"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.TextSize = 18
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = TopBar
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(1, -90, 0, 10)
ButtonContainer.Size = UDim2.new(0, 80, 0, 30)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = ButtonContainer
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(0, 0, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 35, 0, 30)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8)
MinimizeCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = ButtonContainer
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(0, 45, 0, 0)
CloseBtn.Size = UDim2.new(0, 35, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Parent = MainFrame
SearchContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SearchContainer.BorderSizePixel = 0
SearchContainer.Position = UDim2.new(0, 15, 0, 60)
SearchContainer.Size = UDim2.new(1, -30, 0, 38)

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 10)
SearchCorner.Parent = SearchContainer

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Parent = SearchContainer
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(0, 12, 0, 0)
SearchIcon.Size = UDim2.new(0, 30, 1, 0)
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(138, 43, 226)
SearchIcon.TextSize = 16

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = SearchContainer
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 40, 0, 0)
SearchBox.Size = UDim2.new(1, -50, 1, 0)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Cari module..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

local CategoryScroll = Instance.new("ScrollingFrame")
CategoryScroll.Name = "CategoryScroll"
CategoryScroll.Parent = MainFrame
CategoryScroll.BackgroundTransparency = 1
CategoryScroll.BorderSizePixel = 0
CategoryScroll.Position = UDim2.new(0, 15, 0, 108)
CategoryScroll.Size = UDim2.new(1, -30, 0, 42)
CategoryScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CategoryScroll.ScrollBarThickness = 0
CategoryScroll.ScrollingDirection = Enum.ScrollingDirection.X

local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.Parent = CategoryScroll
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.Padding = UDim.new(0, 8)
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder

local categories = {
    {name = "All", icon = "📋"},
    {name = "Movement", icon = "🏃"},
    {name = "Character", icon = "👤"},
    {name = "Animation", icon = "🎬"},
    {name = "Combat", icon = "⚔️"},
    {name = "Social", icon = "💭"},
    {name = "Trolling", icon = "😈"},
    {name = "Utility", icon = "🔧"},
    {name = "Visual", icon = "👁️"},
    {name = "Automation", icon = "🤖"}
}

local selectedCategory = "All"

for i, category in ipairs(categories) do
    local catBtn = Instance.new("TextButton")
    catBtn.Name = category.name
    catBtn.Parent = CategoryScroll
    catBtn.BackgroundColor3 = category.name == "All" and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(30, 30, 35)
    catBtn.BorderSizePixel = 0
    catBtn.Size = UDim2.new(0, 100, 0, 36)
    catBtn.Font = Enum.Font.GothamSemibold
    catBtn.Text = category.icon .. " " .. category.name
    catBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    catBtn.TextSize = 12
    catBtn.LayoutOrder = i
    
    local catCorner = Instance.new("UICorner")
    catCorner.CornerRadius = UDim.new(0, 10)
    catCorner.Parent = catBtn
    
    catBtn.MouseEnter:Connect(function()
        if selectedCategory ~= category.name then
            TweenService:Create(catBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
        end
    end)
    
    catBtn.MouseLeave:Connect(function()
        if selectedCategory ~= category.name then
            TweenService:Create(catBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
        end
    end)
    
    catBtn.MouseButton1Click:Connect(function()
        selectedCategory = category.name
        for _, btn in pairs(CategoryScroll:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
            end
        end
        TweenService:Create(catBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
        updateModuleList()
    end)
end

CategoryScroll.CanvasSize = UDim2.new(0, CategoryLayout.AbsoluteContentSize.X, 0, 0)
CategoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    CategoryScroll.CanvasSize = UDim2.new(0, CategoryLayout.AbsoluteContentSize.X, 0, 0)
end)

local ModuleScroll = Instance.new("ScrollingFrame")
ModuleScroll.Name = "ModuleScroll"
ModuleScroll.Parent = MainFrame
ModuleScroll.BackgroundTransparency = 1
ModuleScroll.BorderSizePixel = 0
ModuleScroll.Position = UDim2.new(0, 15, 0, 160)
ModuleScroll.Size = UDim2.new(1, -30, 1, -175)
ModuleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ModuleScroll.ScrollBarThickness = 4
ModuleScroll.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)

local ModuleLayout = Instance.new("UIListLayout")
ModuleLayout.Parent = ModuleScroll
ModuleLayout.Padding = UDim.new(0, 8)
ModuleLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createModuleCard(moduleName, fileName, icon, index)
    local card = Instance.new("Frame")
    card.Name = fileName .. "_Card"
    card.Parent = ModuleScroll
    card.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    card.BorderSizePixel = 0
    card.Size = UDim2.new(1, -8, 0, 60)
    card.LayoutOrder = index
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Parent = card
    iconLabel.BackgroundTransparency = 1
    iconLabel.Position = UDim2.new(0, 15, 0, 0)
    iconLabel.Size = UDim2.new(0, 40, 1, 0)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
    iconLabel.TextSize = 24
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.Parent = card
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 60, 0, 10)
    nameLabel.Size = UDim2.new(1, -140, 0, 20)
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.Text = moduleName
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Parent = card
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.new(0, 60, 0, 32)
    statusLabel.Size = UDim2.new(1, -140, 0, 16)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "Inactive"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "Toggle"
    toggleBtn.Parent = card
    toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -15)
    toggleBtn.Size = UDim2.new(0, 50, 0, 30)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 11
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    local highlight = Instance.new("Frame")
    highlight.Name = "Highlight"
    highlight.Parent = card
    highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    highlight.BorderSizePixel = 0
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.Visible = false
    
    local highlightCorner = Instance.new("UICorner")
    highlightCorner.CornerRadius = UDim.new(1, 0)
    highlightCorner.Parent = highlight
    
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
    end)
    
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
    end)
    
    toggleBtn.MouseButton1Click:Connect(function()
        if ModuleStates[fileName] then
            stopModule(fileName, toggleBtn, statusLabel, highlight)
        else
            loadModule(fileName, toggleBtn, statusLabel, highlight, moduleName)
        end
    end)
    
    return card
end

function loadModule(fileName, button, statusLabel, highlight, moduleName)
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
                
                button.Text = "ON"
                TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(34, 197, 94)}):Play()
                statusLabel.Text = "Active"
                statusLabel.TextColor3 = Color3.fromRGB(34, 197, 94)
                highlight.Visible = true
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "✅ Module Aktif";
                    Text = moduleName;
                    Duration = 2;
                })
            end
        end
    end)
    
    if not success then
        warn("Gagal load: " .. fileName)
        button.Text = "ERR"
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(127, 29, 29)}):Play()
    end
end

function stopModule(fileName, button, statusLabel, highlight)
    pcall(function()
        if ModuleConnections[fileName] and ModuleConnections[fileName].stop then
            ModuleConnections[fileName].stop()
        end
    end)
    
    ModuleStates[fileName] = false
    ModuleConnections[fileName] = nil
    
    button.Text = "OFF"
    TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 38, 38)}):Play()
    statusLabel.Text = "Inactive"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    highlight.Visible = false
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
            createModuleCard(module.name, module.file, module.icon, index)
            index = index + 1
        end
    end
    
    ModuleScroll.CanvasSize = UDim2.new(0, 0, 0, ModuleLayout.AbsoluteContentSize.Y + 8)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(updateModuleList)

ModuleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ModuleScroll.CanvasSize = UDim2.new(0, 0, 0, ModuleLayout.AbsoluteContentSize.Y + 8)
end)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(239, 68, 68)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 38, 38)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    for fileName, _ in pairs(ModuleStates) do
        pcall(function()
            if ModuleConnections[fileName] and ModuleConnections[fileName].stop then
                ModuleConnections[fileName].stop()
            end
        end)
    end
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(1, 0, 0, 250)
    }):Play()
    task.wait(0.4)
    HubGui:Destroy()
end)

MinimizeBtn.MouseEnter:Connect(function()
    TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
end)

MinimizeBtn.MouseLeave:Connect(function()
    TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
end)

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 350, 0, 500)
        }):Play()
        task.wait(0.2)
        SearchContainer.Visible = true
        CategoryScroll.Visible = true
        ModuleScroll.Visible = true
        MinimizeBtn.Text = "−"
        minimized = false
    else
        SearchContainer.Visible = false
        CategoryScroll.Visible = false
        ModuleScroll.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 350, 0, 50)
        }):Play()
        MinimizeBtn.Text = "+"
        minimized = true
    end
end)

local dragToggle = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(MainFrame, TweenInfo.new(0.15), {Position = position}):Play()
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
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

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(1, 0, 0, 250)

task.spawn(function()
    while task.wait(0.05) do
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 0.6, 0.9)
        TweenService:Create(GlowEffect, TweenInfo.new(0.5), {ImageColor3 = color}):Play()
    end
end)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 350, 0, 500),
    Position = UDim2.new(1, -370, 0, 20)
}):Play()

task.wait(0.3)
updateModuleList()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚡ ANOS HUB";
    Text = "Modern UI loaded! " .. #Modules .. " modules ready";
    Duration = 4;
})

print("╔════════════════════════════════════════")
print("║     ⚡ ANOS MODERN SCRIPT HUB ⚡      ")
print("║  GitHub: anos-rgb/anos-allscript       ")
print("║  Total Modules: " .. #Modules .. "     ")
print("║  UI Version: 2.0 Modern Edition        ")
print("╚════════════════════════════════════════")
