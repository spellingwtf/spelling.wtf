--[[
        Thank you for using Dex SaveInstance.
        You are recommended to save the game (if you used saveplace) right away to take advantage of the binary format (if you didn't save in binary).
        If your player cannot spawn into the game, please move the scripts in StarterPlayer elsewhere. (This is done by default)
        If the chat system does not work, please use the explorer and delete everything inside the Chat service. (Or run game:GetService("Chat"):ClearAllChildren())
        
        If union and meshpart collisions don't work, first run this script in the Studio command bar:
        local list = {}
        local coreGui = game:GetService("CoreGui")

        for i,v in pairs(game:GetDescendants()) do
            local s,e = pcall(function() return v:IsA("UnionOperation") or v:IsA("MeshPart") end)
            if s and e and not v:IsDescendantOf(coreGui) then
                list[#list+1] = v
            end
        end

        game.Selection:Set(list)
        
        After running it, go to the Properties window and change CollisionFidelity from "Box" to "Default".

        
        This file was generated with the following settings:
        
    	Binary = true
	Decompile = true
	ShowStatus = true
	IgnoreDefaultProps = true
	RemovePlayerCharacters = true
	DecompileTimeout = 10
	DecompileIgnore = { "Chat", "CoreGui", "CorePackages" }
	IsolateStarterPlayer = true
	SavePlayers = false
	MaxThreads = 3
	NilInstances = true
]]