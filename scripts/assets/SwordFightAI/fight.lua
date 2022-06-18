local Filter = Instance.new("Folder", workspace)
Filter.Name = "Filter"

local AI = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/SwordFightAI/Ai.lua"))()

AI(game.Players.LocalPlayer.Character)