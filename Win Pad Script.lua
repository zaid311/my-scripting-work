
local winPad = script.Parent
local Players = gameGetService(Players)
local TweenService = gameGetService(TweenService)
local SoundService = gameGetService(SoundService)

local completed = {}
local startTimes = {}


Players.PlayerAddedConnect(function(player)
    player.CharacterAddedConnect(function(character)
        startTimes[player] = tick() -- Record start time
    end)
end)

winPad.TouchedConnect(function(hit)
    local humanoid = hit.ParentFindFirstChildOfClass(Humanoid)
    if humanoid then
        local player = PlayersGetPlayerFromCharacter(hit.Parent)
        if player and not completed[player] then
            completed[player] = true
            
            
            local completionTime = math.floor(tick() - (startTimes[player] or tick()))
            
           
            if _G.recordWin then
                _G.recordWin(player, completionTime)
            end
            

            local winMusic = SoundServiceFindFirstChild(WinMusic)
            if winMusic then
                winMusicPlay()
                wait(2)
                winMusicStop()
            end
            
            
            local gui = Instance.new(ScreenGui)
            local frame = Instance.new(Frame)
            local title = Instance.new(TextLabel)
            local timeLabel = Instance.new(TextLabel)
            local congratsLabel = Instance.new(TextLabel)
            
            gui.Parent = player.PlayerGui
            frame.Parent = gui
            frame.Size = UDim2.new(0, 400, 0, 200)
            frame.Position = UDim2.new(0.5, -200, 0.5, -100)
            frame.BackgroundColor3 = Color3.new(0, 0.8, 0)
            frame.BorderSizePixel = 0
            
            
            local corner = Instance.new(UICorner)
            corner.CornerRadius = UDim.new(0, 15)
            corner.Parent = frame
            
            title.Parent = frame
            title.Size = UDim2.new(1, 0, 0.4, 0)
            title.Text = 🎉 VICTORY! 🎉
            title.TextColor3 = Color3.new(1, 1, 1)
            title.TextScaled = true
            title.BackgroundTransparency = 1
            
            timeLabel.Parent = frame
            timeLabel.Size = UDim2.new(1, 0, 0.3, 0)
            timeLabel.Position = UDim2.new(0, 0, 0.4, 0)
            timeLabel.Text = Time  .. completionTime ..  seconds
            timeLabel.TextColor3 = Color3.new(1, 1, 0)
            timeLabel.TextScaled = true
            timeLabel.BackgroundTransparency = 1
            
            congratsLabel.Parent = frame
            congratsLabel.Size = UDim2.new(1, 0, 0.3, 0)
            congratsLabel.Position = UDim2.new(0, 0, 0.7, 0)
            congratsLabel.Text = Great job,  .. player.Name .. !
            congratsLabel.TextColor3 = Color3.new(1, 1, 1)
            congratsLabel.TextScaled = true
            congratsLabel.BackgroundTransparency = 1
            
           
            frame.Size = UDim2.new(0, 0, 0, 0)
            local tween = TweenServiceCreate(
                frame,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 400, 0, 200)}
            )
            tweenPlay()
            
            wait(5)
            guiDestroy()
            
         
            wait(5)
            completed[player] = nil
        end
    end
end)
