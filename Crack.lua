local pp = game.GameId
local placeId = game.PlaceId
local hah = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Your existing wis table (supports both Game IDs and Place IDs)
local wis = {
    -- Game IDs
    [6325068386] = "https://pandadevelopment.net/virtual/file/94e3c796f43029bf",
    [7028566528] = "https://pandadevelopment.net/virtual/file/a2e5b8e13eea34c2",
    [3808081382] = { g = "https://pandadevelopment.net/virtual/file/71b040a9eb553d68", a = true },
    [7709344486] = "https://pandadevelopment.net/virtual/file/b5628a078056dceb",
    [7008097940] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/InkGameUpd",
    [7326934954] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/99nightsobjuscatedfakeload",
    [7218065222] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/DigNEW",
    [7436755782] = "https://pandadevelopment.net/virtual/file/b1ea71febf6ed719",
    [6331902150] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/Forsaken",
    [66654135] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/Mm2newupdate",
    [6931042565] = "https://pandadevelopment.net/virtual/file/65d3835d1971df6b",
    [4777817887] = "https://pandadevelopment.net/virtual/file/34dfa2a929a3d840",
    [5750914919] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/Fisch",
    [2440500124] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/DOORSupd",
    [7822444776] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/buildaplane.lua",
    [4807308814] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/Breakin2",
    [4019583467] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/BeNpcOrDie",
    [3647333358] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/Evade",
    [7541395924] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/BuildAIsland",
    [8013928798] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/BuildABrainrot",
    [210851291] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/BuildABoat",
    [6764180126] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/GoFishing.lua",
    [111958650] = "https://raw.githubusercontent.com/Souls-dev/yehhevggfwgeggffftewer/refs/heads/main/g", -- Arsenal
    [8316902627] = "https://pandadevelopment.net/virtual/file/05feeb97e78c159b", -- Plant Vs Brainrot
    [1119466531] = "https://pandadevelopment.net/virtual/file/3a73d48de7184a60", -- Legends Of Speed
    [4948814458] = "https://pandadevelopment.net/virtual/file/a6d7efe3621df7b9", -- Fortline
    [2020908522] = "https://raw.githubusercontent.com/stylemakeritosh/Soulshubgames/refs/heads/main/MegaHide%26Seek"
}

-- Supported games list for display
local supportedGames = {
    "⚽ BLUE LOCK RIVALS",
    "🏀 BASKETBALL ZERO", 
    "🏐 VOLLEYBALL LEGENDS",
    "⚔️ FORSAKEN",
    "🔪 MURDER MYSTERY 2",
    "⛏️ DIG",
    "🌱 GROW A GARDEN",
    "💪 THE STRONGEST BATTLEGROUND",
    "🗡️ BLADE BALL",
    "🧠 STEAL A BRAINROT",
    "🎯 UNIVERSAL FPS GAMES",
    "🖋️ INK GAME",
    "🌲 99 NIGHTS IN THE FOREST",
    "✈️ BUILD A PLANE",
    "🛥️ BUILD A BOAT",
    "🎭 Break In 2",
    "👥 Be NPC or DIE",
    "🌞 Evade",
    "🏝 Build A Island",
    "🧠 Build A Brainrot",
    "🚪 Doors",
    "🌊 Fisch",
    "💧 Go Fishing",
    "🔫 Arsenal",
    "🌵 Plant Vs Brainrot",
    "🦵 Legends Of Speed",
    "😺Fortline",
    "👀 Mega Hide & Seek"
}

-- Expensive colors for cycling
local expensiveColors = {
    Color3.fromRGB(255, 255, 255), -- White
    Color3.fromRGB(0, 0, 0), -- Black
    Color3.fromRGB(255, 215, 0), -- Gold
    Color3.fromRGB(192, 192, 192), -- Silver
    Color3.fromRGB(139, 69, 19), -- Bronze
    Color3.fromRGB(128, 0, 128) -- Purple
}

-- Function to get a random expensive color
local function getRandomExpensiveColor()
    return expensiveColors[math.random(1, #expensiveColors)]
end

-- Function to load scripts with retry logic
local function yeet(z, o)
    local maxRetries = 3
    local retryDelay = 1
    local b
    
    for i = 1, maxRetries do
        local success, result = pcall(function()
            return game:HttpGet(z, true)
        end)
        
        if success then
            b = result
            break
        else
            if i == maxRetries then
                return false, "Failed to fetch script after " .. maxRetries .. " attempts: " .. result
            end
            wait(retryDelay)
        end
    end
    
    -- Fixed part: Properly handle loadstring results
    local func, err = loadstring(b)
    if not func then
        return false, "Failed to parse script: " .. tostring(err)
    end
    
    if o then
        local success, error = pcall(function()
            func()
        end)
        return success, error
    else
        return pcall(func)
    end
end

-- Function to check if game is supported (checks both Game ID and Place ID)
local function isGameSupported()
    return wis[pp] or wis[placeId]
end

-- Function to get script URL (checks both Game ID and Place ID)
local function getScriptData()
    return wis[pp] or wis[placeId]
end

-- Create Loading GUI with enhanced animations
local function createLoadingGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SoulsHubLoader"
    screenGui.Parent = game.CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- Enhanced glow effect
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 60, 1, 60)
    glow.Position = UDim2.new(0, -30, 0, -30)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/Glow.png"
    glow.ImageColor3 = Color3.fromRGB(138, 43, 226)
    glow.ImageTransparency = 0.5
    glow.Parent = mainFrame
    
    -- Additional inner glow
    local innerGlow = Instance.new("ImageLabel")
    innerGlow.Name = "InnerGlow"
    innerGlow.Size = UDim2.new(1, 20, 1, 20)
    innerGlow.Position = UDim2.new(0, -10, 0, -10)
    innerGlow.BackgroundTransparency = 1
    innerGlow.Image = "rbxasset://textures/ui/Glow.png"
    innerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    innerGlow.ImageTransparency = 0.7
    innerGlow.Parent = mainFrame
    
    -- Title with color animation
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "SOULS HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 36
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 80)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Loading Scripts..."
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    subtitle.TextSize = 18
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = mainFrame
    
    -- Games scroll frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "GamesFrame"
    scrollFrame.Size = UDim2.new(1, -40, 0, 200)
    scrollFrame.Position = UDim2.new(0, 20, 0, 120)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #supportedGames * 35)
    scrollFrame.Parent = mainFrame
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 10)
    scrollCorner.Parent = scrollFrame
    
    -- Add supported games with animations and glow
    for i, gameName in ipairs(supportedGames) do
        local gameLabel = Instance.new("TextLabel")
        gameLabel.Name = "Game" .. i
        gameLabel.Size = UDim2.new(1, -20, 0, 30)
        gameLabel.Position = UDim2.new(0, 10, 0, (i-1) * 35 + 5)
        gameLabel.BackgroundTransparency = 1
        gameLabel.Text = gameName
        gameLabel.TextColor3 = Color3.fromHSV((i * 0.1) % 1, 0.8, 1)
        gameLabel.TextSize = 16
        gameLabel.Font = Enum.Font.GothamSemibold
        gameLabel.TextXAlignment = Enum.TextXAlignment.Left
        gameLabel.TextTransparency = 1
        gameLabel.Parent = scrollFrame
        
        -- Add glow to game label
        local gameGlow = Instance.new("ImageLabel")
        gameGlow.Name = "GameGlow" .. i
        gameGlow.Size = UDim2.new(1, 20, 1, 10)
        gameGlow.Position = UDim2.new(0, -10, 0, -5)
        gameGlow.BackgroundTransparency = 1
        gameGlow.Image = "rbxasset://textures/ui/Glow.png"
        gameGlow.ImageColor3 = Color3.fromRGB(138, 43, 226)
        gameGlow.ImageTransparency = 0.7
        gameGlow.Parent = gameLabel
        
        -- Animate text and glow appearance
        wait(0.1)
        local fadeIn = TweenService:Create(gameLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0})
        local glowFadeIn = TweenService:Create(gameGlow, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {ImageTransparency = 0.4})
        fadeIn:Play()
        glowFadeIn:Play()
        
        -- Color cycling animation for game labels
        spawn(function()
            while gameLabel.Parent do
                local newColor = getRandomExpensiveColor()
                local colorTween = TweenService:Create(gameLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextColor3 = newColor})
                local glowColorTween = TweenService:Create(gameGlow, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {ImageColor3 = newColor})
                colorTween:Play()
                glowColorTween:Play()
                wait(0.5)
            end
        end)
    end
    
    -- Loading bar background
    local loadBarBG = Instance.new("Frame")
    loadBarBG.Name = "LoadBarBG"
    loadBarBG.Size = UDim2.new(1, -40, 0, 10)
    loadBarBG.Position = UDim2.new(0, 20, 0, 340)
    loadBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    loadBarBG.BorderSizePixel = 0
    loadBarBG.Parent = mainFrame
    
    local loadBarCorner = Instance.new("UICorner")
    loadBarCorner.CornerRadius = UDim.new(0, 5)
    loadBarCorner.Parent = loadBarBG
    
    -- Loading bar fill with color animation
    local loadBar = Instance.new("Frame")
    loadBar.Name = "LoadBar"
    loadBar.Size = UDim2.new(0, 0, 1, 0)
    loadBar.Position = UDim2.new(0, 0, 0, 0)
    loadBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    loadBar.BorderSizePixel = 0
    loadBar.Parent = loadBarBG
    
    local loadBarFillCorner = Instance.new("UICorner")
    loadBarFillCorner.CornerRadius = UDim.new(0, 5)
    loadBarFillCorner.Parent = loadBar
    
    -- Loading bar glow
    local loadBarGlow = Instance.new("ImageLabel")
    loadBarGlow.Name = "LoadBarGlow"
    loadBarGlow.Size = UDim2.new(1, 10, 1, 10)
    loadBarGlow.Position = UDim2.new(0, -5, 0, -5)
    loadBarGlow.BackgroundTransparency = 1
    loadBarGlow.Image = "rbxasset://textures/ui/Glow.png"
    loadBarGlow.ImageColor3 = Color3.fromRGB(138, 43, 226)
    loadBarGlow.ImageTransparency = 0.6
    loadBarGlow.Parent = loadBar
    
    -- Loading percentage text
    local percentText = Instance.new("TextLabel")
    percentText.Name = "PercentText"
    percentText.Size = UDim2.new(1, 0, 0, 25)
    percentText.Position = UDim2.new(0, 0, 0, 360)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
    percentText.TextSize = 14
    percentText.Font = Enum.Font.Gotham
    percentText.Parent = mainFrame
    
    -- Color cycling for title and load bar
    spawn(function()
        while mainFrame.Parent do
            local newColor = getRandomExpensiveColor()
            local titleTween = TweenService:Create(title, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextColor3 = newColor})
            local loadBarTween = TweenService:Create(loadBar, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {BackgroundColor3 = newColor})
            local loadBarGlowTween = TweenService:Create(loadBarGlow, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {ImageColor3 = newColor})
            titleTween:Play()
            loadBarTween:Play()
            loadBarGlowTween:Play()
            wait(0.5)
        end
    end)
    
    return screenGui, loadBar, percentText, scrollFrame, glow, innerGlow
end

-- Create unsupported game dialog
local function createUnsupportedDialog()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UnsupportedDialog"
    screenGui.Parent = game.CoreGui
    
    local blur = Instance.new("Frame")
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blur.BackgroundTransparency = 0.5
    blur.Parent = screenGui
    
    local dialog = Instance.new("Frame")
    dialog.Size = UDim2.new(0, 400, 0, 250)
    dialog.Position = UDim2.new(0.5, -200, 0.5, -125)
    dialog.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    dialog.BorderSizePixel = 0
    dialog.Parent = screenGui
    
    local dialogCorner = Instance.new("UICorner")
    dialogCorner.CornerRadius = UDim.new(0, 15)
    dialogCorner.Parent = dialog
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "Game Is Not Supported!"
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.Parent = dialog
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -40, 0, 80)
    message.Position = UDim2.new(0, 20, 0, 70)
    message.BackgroundTransparency = 1
    message.Text = "We have a universal fps game script,\nclick continue to get it"
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.TextSize = 16
    message.Font = Enum.Font.Gotham
    message.TextWrapped = true
    message.Parent = dialog
    
    local continueBtn = Instance.new("TextButton")
    continueBtn.Size = UDim2.new(0, 120, 0, 40)
    continueBtn.Position = UDim2.new(0, 50, 0, 180)
    continueBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    continueBtn.Text = "Continue"
    continueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    continueBtn.TextSize = 16
    continueBtn.Font = Enum.Font.GothamBold
    continueBtn.BorderSizePixel = 0
    continueBtn.Parent = dialog
    
    local continueBtnCorner = Instance.new("UICorner")
    continueBtnCorner.CornerRadius = UDim.new(0, 8)
    continueBtnCorner.Parent = continueBtn
    
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.new(0, 120, 0, 40)
    cancelBtn.Position = UDim2.new(0, 230, 0, 180)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    cancelBtn.Text = "Cancel"
    cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelBtn.TextSize = 16
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.BorderSizePixel = 0
    cancelBtn.Parent = dialog
    
    local cancelBtnCorner = Instance.new("UICorner")
    cancelBtnCorner.CornerRadius = UDim.new(0, 8)
    cancelBtnCorner.Parent = cancelBtn
    
    return screenGui, continueBtn, cancelBtn
end

-- Main execution
local function main()
    -- Create loading GUI
    local loadingGui, loadBar, percentText, scrollFrame, glow, innerGlow = createLoadingGUI()
    
    -- Animate loading bar and scroll
    local loadTween = TweenService:Create(loadBar, TweenInfo.new(3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)})
    loadTween:Play()
    
    -- Animate scroll
    local scrollTween = TweenService:Create(scrollFrame, TweenInfo.new(2.5, Enum.EasingStyle.Quad), {CanvasPosition = Vector2.new(0, scrollFrame.CanvasSize.Y.Offset)})
    scrollTween:Play()
    
    -- Animate percentage
    spawn(function()
        for i = 0, 100, 2 do
            percentText.Text = i .. "%"
            wait(0.03)
        end
    end)
    
    -- Enhanced glow animations
    spawn(function()
        while loadingGui.Parent do
            local glowTween = TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.2})
            local innerGlowTween = TweenService:Create(innerGlow, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.4})
            glowTween:Play()
            innerGlowTween:Play()
            wait(1.8)
        end
    end)
    
    -- Wait for loading to complete
    loadTween.Completed:Wait()
    wait(0.5)
    
    -- Check if game is supported
    if isGameSupported() then
        -- Game is supported, load script
        loadingGui:Destroy()
        
        local scriptData = getScriptData()
        local url, autoload = type(scriptData) == "table" and scriptData.g or scriptData, type(scriptData) == "table" and scriptData.a
        
        if url then
            local success, error = yeet(url, autoload)
            
            if not success then
                hah:SetCore("SendNotification", {
                    Title = "ERROR",
                    Text = "Failed to load script: " .. tostring(error),
                    Duration = 7
                })
            else
                hah:SetCore("SendNotification", {
                    Title = "SUCCESS",
                    Text = "Script loaded successfully!",
                    Duration = 5
                })
            end
        else
            hah:SetCore("SendNotification", {
                Title = "SOON",
                Text = "Script not yet available",
                Duration = 5
            })
        end
    else
        -- Game not supported, show dialog
        loadingGui:Destroy()
        
        local dialogGui, continueBtn, cancelBtn = createUnsupportedDialog()
        
        continueBtn.MouseButton1Click:Connect(function()
            dialogGui:Destroy()
            hah:SetCore("SendNotification", {
                Title = "UNIVERSAL",
                Text = "Loading universal FPS script...",
                Duration = 5
            })
            
            local success, error = pcall(function()
                yeet("https://pandadevelopment.net/virtual/file/5b20b7fd48e38a3e", true)
            end)
            
            if not success then
                hah:SetCore("SendNotification", {
                    Title = "FAIL",
                    Text = "Failed to load universal script: " .. tostring(error),
                    Duration = 7
                })
            else
                hah:SetCore("SendNotification", {
                    Title = "SUCCESS",
                    Text = "Universal script loaded successfully!",
                    Duration = 5
                })
            end
        end)
        
        cancelBtn.MouseButton1Click:Connect(function()
            dialogGui:Destroy()
        end)
    end
end

-- Start the script
main()
