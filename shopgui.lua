local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("Shop GUI loading...") 

local PRODUCTS = {
    SpeedBoost = 3415059343, 
    JumpPower = 3415059550,   
    CheckpointSkip = 3415059700, 
    AntiFall = 3415059882     
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopGui"
screenGui.Parent = playerGui

local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopFrame"
shopFrame.Size = UDim2.new(0, 300, 0, 400)
shopFrame.Position = UDim2.new(1, -320, 0, 20) -- Top right corner
shopFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
shopFrame.BorderSizePixel = 0
shopFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = shopFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🛒 OBBY SHOP"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
title.BorderSizePixel = 0
title.Parent = shopFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.Position = UDim2.new(1, -80, 0, 50)
toggleButton.Text = "SHOP"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextScaled = true
toggleButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 5)
toggleCorner.Parent = toggleButton

local itemsFrame = Instance.new("Frame")
itemsFrame.Size = UDim2.new(1, -20, 1, -60)
itemsFrame.Position = UDim2.new(0, 10, 0, 50)
itemsFrame.BackgroundTransparency = 1
itemsFrame.Parent = shopFrame

local items = {
    {name = "⚡ Speed Boost", price = "25 R$", desc = "Run faster!", product = PRODUCTS.SpeedBoost, color = Color3.new(1, 1, 0)},
    {name = "🦘 Jump Power", price = "50 R$", desc = "Jump higher!", product = PRODUCTS.JumpPower, color = Color3.new(0, 1, 0)},
    {name = "⏭️ Skip Checkpoint", price = "15 R$", desc = "Skip ahead!", product = PRODUCTS.CheckpointSkip, color = Color3.new(0, 0.5, 1)},
    {name = "🛡️ Anti-Fall", price = "75 R$", desc = "No fall damage!", product = PRODUCTS.AntiFall, color = Color3.new(1, 0, 1)}
}

for i, item in ipairs(items) do
    local itemFrame = Instance.new("Frame")
    itemFrame.Size = UDim2.new(1, 0, 0, 70)
    itemFrame.Position = UDim2.new(0, 0, 0, (i-1) * 80)
    itemFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    itemFrame.BorderSizePixel = 0
    itemFrame.Parent = itemsFrame
    
    local itemCorner = Instance.new("UICorner")
    itemCorner.CornerRadius = UDim.new(0, 8)
    itemCorner.Parent = itemFrame
    
  local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.Text = item.name
    nameLabel.TextColor3 = item.color
    nameLabel.TextScaled = true
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = itemFrame
    
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
    descLabel.Position = UDim2.new(0, 10, 0.5, 0)
    descLabel.Text = item.desc
    descLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    descLabel.TextScaled = true
    descLabel.BackgroundTransparency = 1
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = itemFrame
    
    local buyButton = Instance.new("TextButton")
    buyButton.Size = UDim2.new(0.35, 0, 0.8, 0)
    buyButton.Position = UDim2.new(0.6, 0, 0.1, 0)
    buyButton.Text = item.price
    buyButton.TextColor3 = Color3.new(1, 1, 1)
    buyButton.TextScaled = true
    buyButton.BackgroundColor3 = Color3.new(0, 0.7, 0)
    buyButton.BorderSizePixel = 0
    buyButton.Parent = itemFrame
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 5)
    buyCorner.Parent = buyButton
    

    buyButton.MouseButton1Click:Connect(function()
        MarketplaceService:PromptProductPurchase(player, item.product)
    end)
    
  
    buyButton.MouseEnter:Connect(function()
        buyButton.BackgroundColor3 = Color3.new(0, 0.9, 0)
    end)
    
    buyButton.MouseLeave:Connect(function()
        buyButton.BackgroundColor3 = Color3.new(0, 0.7, 0)
    end)
end


local shopVisible = true
toggleButton.MouseButton1Click:Connect(function()
    shopVisible = not shopVisible
    if shopVisible then
        shopFrame:TweenPosition(UDim2.new(1, -320, 0, 20), "Out", "Quad", 0.3, true)
        toggleButton.Text = "SHOP"
    else
        shopFrame:TweenPosition(UDim2.new(1, 10, 0, 20), "Out", "Quad", 0.3, true)
        toggleButton.Text = "<<"
    end
end)


wait(3)
if shopVisible then
    toggleButton.MouseButton1Click:Fire()
end
