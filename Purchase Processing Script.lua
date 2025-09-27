local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")


local PRODUCTS = {
    SpeedBoost = 3415059343,
    JumpPower = 3415059550, 
    CheckpointSkip = 3415059700,
    AntiFall = 3415059882,
}


local function processReceipt(receiptInfo)
    local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
    if not player then
        return Enum.ProductPurchaseDecision.NotProcessedYet
    end
    
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not humanoid then
        return Enum.ProductPurchaseDecision.NotProcessedYet
    end
    
 
    if receiptInfo.ProductId == PRODUCTS.SpeedBoost then
        humanoid.WalkSpeed = 32 -- Default is 16
        
       
        local gui = Instance.new("ScreenGui")
        local notification = Instance.new("TextLabel")
        gui.Parent = player.PlayerGui
        notification.Parent = gui
        notification.Size = UDim2.new(0, 200, 0, 50)
        notification.Position = UDim2.new(0.5, -100, 0, 50)
        notification.Text = "⚡ Speed Boost Activated!"
        notification.TextColor3 = Color3.new(1, 1, 0)
        notification.TextScaled = true
        notification.BackgroundColor3 = Color3.new(0, 0, 0)
        notification.BackgroundTransparency = 0.3
        
        
        game:GetService("Debris"):AddItem(gui, 3)
        
    elseif receiptInfo.ProductId == PRODUCTS.JumpPower then
        humanoid.JumpPower = 100 -- Default is 50
        
        local gui = Instance.new("ScreenGui")
        local notification = Instance.new("TextLabel")
        gui.Parent = player.PlayerGui
        notification.Parent = gui
        notification.Size = UDim2.new(0, 200, 0, 50)
        notification.Position = UDim2.new(0.5, -100, 0, 50)
        notification.Text = "🦘 Jump Boost Activated!"
        notification.TextColor3 = Color3.new(0, 1, 0)
        notification.TextScaled = true
        notification.BackgroundColor3 = Color3.new(0, 0, 0)
        notification.BackgroundTransparency = 0.3
        
        game:GetService("Debris"):AddItem(gui, 3)
        
    elseif receiptInfo.ProductId == PRODUCTS.CheckpointSkip then
        -- Find next checkpoint and teleport player
        local checkpoints = workspace:GetChildren()
        local currentPos = character.HumanoidRootPart.Position
        local closestCheckpoint = nil
        local closestDistance = math.huge
        
        for _, obj in ipairs(checkpoints) do
            if obj.Name:lower():find("checkpoint") and obj:IsA("Part") then
                local distance = (obj.Position - currentPos).Magnitude
                if distance < closestDistance and obj.Position.Y > currentPos.Y then
                    closestDistance = distance
                    closestCheckpoint = obj
                end
            end
        end
        
        if closestCheckpoint then
            character:MoveTo(closestCheckpoint.Position + Vector3.new(0, 10, 0))
            
            local gui = Instance.new("ScreenGui")
            local notification = Instance.new("TextLabel")
            gui.Parent = player.PlayerGui
            notification.Parent = gui
            notification.Size = UDim2.new(0, 200, 0, 50)
            notification.Position = UDim2.new(0.5, -100, 0, 50)
            notification.Text = "⏭️ Checkpoint Skipped!"
            notification.TextColor3 = Color3.new(0, 0.5, 1)
            notification.TextScaled = true
            notification.BackgroundColor3 = Color3.new(0, 0, 0)
            notification.BackgroundTransparency = 0.3
            
            game:GetService("Debris"):AddItem(gui, 3)
        end
        
    elseif receiptInfo.ProductId == PRODUCTS.AntiFall then
        -- Give them a tool or effect that prevents fall damage
        local antiFallValue = Instance.new("BoolValue")
        antiFallValue.Name = "AntiFall"
        antiFallValue.Value = true
        antiFallValue.Parent = player
        
        local gui = Instance.new("ScreenGui")
        local notification = Instance.new("TextLabel")
        gui.Parent = player.PlayerGui
        notification.Parent = gui
        notification.Size = UDim2.new(0, 200, 0, 50)
        notification.Position = UDim2.new(0.5, -100, 0, 50)
        notification.Text = "🛡️ Anti-Fall Active!"
        notification.TextColor3 = Color3.new(1, 0, 1)
        notification.TextScaled = true
        notification.BackgroundColor3 = Color3.new(0, 0, 0)
        notification.BackgroundTransparency = 0.3
        
        game:GetService("Debris"):AddItem(gui, 3)
        
       
        game:GetService("Debris"):AddItem(antiFallValue, 300)
    end
    
    return Enum.ProductPurchaseDecision.PurchaseGranted
end


MarketplaceService.ProcessReceipt = processReceipt
