
local Players = game:GetService("Players")


local function createJumpEffect(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    
    humanoid.Jumping:Connect(function()
        -- Create particle effect
        local attachment = Instance.new("Attachment")
        attachment.Parent = rootPart
        
        local particles = Instance.new("ParticleEmitter")
        particles.Parent = attachment
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Lifetime = NumberRange.new(0.5, 1.5)
        particles.Rate = 50
        particles.SpreadAngle = Vector2.new(45, 45)
        particles.Speed = NumberRange.new(5, 10)
        particles.Color = ColorSequence.new(Color3.new(0, 1, 1), Color3.new(0, 0.5, 1))
        
      
        wait(0.2)
        particles.Enabled = false
        
       
        game:GetService("Debris"):AddItem(attachment, 3)
    end)
end


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        createJumpEffect(character)
    end)
end)
