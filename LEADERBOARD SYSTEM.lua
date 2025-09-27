
local Players = game:GetService("Players")


local completionTimes = {}


local function createLeaderboard(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    
    local bestTime = Instance.new("IntValue")
    bestTime.Name = "Best Time"
    bestTime.Value = 0
    bestTime.Parent = leaderstats
    
    local completions = Instance.new("IntValue")
    completions.Name = "Completions"
    completions.Value = 0
    completions.Parent = leaderstats
end


local function recordWin(player, timeInSeconds)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local bestTime = leaderstats:FindFirstChild("Best Time")
        local completions = leaderstats:FindFirstChild("Completions")
        
        if completions then
            completions.Value = completions.Value + 1
        end
        
        if bestTime and (bestTime.Value == 0 or timeInSeconds < bestTime.Value) then
            bestTime.Value = timeInSeconds
        end
    end
end


Players.PlayerAdded:Connect(createLeaderboard)


_G.recordWin = recordWin
