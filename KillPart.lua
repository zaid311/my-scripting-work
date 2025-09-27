local killPart = script.Parent
local TweenService = game:GetService("TweenService")

killPart.BrickColor = BrickColor.new("Really red")
killPart.Material = Enum.Material.Neon

spawn(function()
    while true do
        local tween1 = TweenService:Create(
            killPart,
            TweenInfo.new(1, Enum.EasingStyle.Sine),
            {Transparency = 0.3}
        )
        local tween2 = TweenService:Create(
            killPart,
            TweenInfo.new(1, Enum.EasingStyle.Sine),
            {Transparency = 0}
        )
        
        tween1:Play()
        wait(1)
        tween2:Play()
        wait(1)
    end
end)

killPart.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Death effect
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxasset://sounds/impact_water.mp3"
        sound.Volume = 0.8
        sound.Parent = killPart
        sound:Play()
        
      local explosion = Instance.new("Explosion")
        explosion.Position = hit.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 0 -- No physics effect
        explosion.Parent = workspace
        
        humanoid.Health = 0
        
        game:GetService("Debris"):AddItem(sound, 2)
    end
end)
