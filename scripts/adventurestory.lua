local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()

if syn then syn.queue_on_teleport('loadstring(game:HttpGet("https://spelling.wtf/scripts/adventurestory.lua"))()')
end

Notification.WallNotification("Changelog", "fixed dungeon utility bundle", {
    Duration = 3,
    TitleSettings = {
        Enabled = true
    }
});

wait(3)

--leave when mod/admin joins
game.Players.PlayerAdded:Connect(function(Player)
    if Player:GetRankInGroup(3596833) == 253 or Player:GetRankInGroup(3596833) == 254 or Player:GetRankInGroup(3596833) == 255 then
    
    Notification.WallNotification("admin joined", "admin name:" .. Player.Name, {
    Duration = 3,
    TitleSettings = {
        Enabled = true
    }
});
    end
end)  
--leave if mod/admin in server
for i,v in pairs(game.Players:GetPlayers()) do
	spawn(function()
		local success, result = pcall(function()
			if v:GetRankInGroup(3596833) == 253 or v:GetRankInGroup(3596833) == 254 or v:GetRankInGroup(3596833) == 255 then
				game.Players.LocalPlayer:Kick("There was a admin in your game?")
				Notification.WallNotification("admin in ur game", "admin name:" .. v.Name, {
    Duration = 3,
    TitleSettings = {
        Enabled = true
    }
});
			end
		end)
		if not success then
			warn("Error: "..result)
		end
	end)
end


local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/y4eeFHp0"))()

local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.T)

local Rage = FinityWindow:Category("Adventure Story")

local Sas = Rage:Sector("Main Functions")


local speaker = game.Players.LocalPlayer
local char = speaker.Character


Sas:Cheat("Slider", "WalkSpeed", function(Value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end, {min = 30, max = 100, suffix = " ws"})



Sas:Cheat("Checkbox", "GodMode", function()
local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod
    local args = {...}
      
    if tostring(self) == "AttackFX" and args[2] ~= game.Players.LocalPlayer.Character then --Attack Remote
            return warn("blocked enemy attack");
        end
return namecall(self, table.unpack(args))
    end)
end)



Sas:Cheat("Checkbox", "Anti Enemy Chase", function()

local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod
    local args = {...}
      
    if tostring(self) == "MoveNPC" then 
        return warn("froze enemy");
    end
return namecall(self, table.unpack(args))
end)

end)

Sas:Cheat("Checkbox", "Coin Autofarm", function(state)
state = true
while state do
wait()
local plr = game.Workspace[game.Players.LocalPlayer.Name].HumanoidRootPart
for i,v in pairs(game.Workspace.Map:GetDescendants()) do
if v.Name == "SingleCent" then
v.CFrame = plr.CFrame
wait()
end
end
end
end)

Sas:Cheat("Checkbox", "Right Click Kill Enemies", function()
    
    Notification.WallNotification("note", "Right click kill activated, note: you won't get battle rewards if you use it", {
    Duration = 3,
    TitleSettings = {
        Enabled = false
    }
});


    local function clickify(character)
local ClickDetector = Instance.new('ClickDetector', character)
ClickDetector.MaxActivationDistance = math.huge
ClickDetector.RightMouseClick:connect(function(p)
        for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Locked = false
		end
	end
if p == game.Players.LocalPlayer then
character:BreakJoints() --break joints cuz if i used delete head and it broke then broken
end
end)
end

repeat
for i,v in pairs(game.Workspace.Enemies:children'') do
if v:IsA'Model' and v:FindFirstChild'Humanoid' and v:FindFirstChild'Torso' and v:FindFirstChild'ClickDetector' == nil then
clickify(v)
end
end
wait(1)
until nil == true
end)

Sas:Cheat("Checkbox", "Kill Aura", function()
    while true do
for i,v in pairs(game.Workspace.Enemies:children'') do
if v:IsA"Model" and v:FindFirstChild"Humanoid" and v:FindFirstChild"Torso" then
v:BreakJoints()
end
end
wait()
end
end)

Sas:Cheat("Button", "Kill All Enemies (need kill aura)", function()
    local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod
    local args = {...}
      
    if tostring(self) == "MoveNPC" then 
        return warn("froze enemy");
    end
return namecall(self, table.unpack(args))
end)

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local char = game.Players.LocalPlayer.Character

local part = char.HumanoidRootPart
local ti = TweenInfo.new(1, Enum.EasingStyle.Linear)
--noclip
local speaker = game.Players.LocalPlayer
Clip = false
	wait(0.1)
	local function NoclipLoop()
		if Clip == false and speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)

-- Yes
while true do
    local stuff = workspace.Enemies:GetDescendants()
    for i = 1, #stuff do local v = stuff[i]
        local model = v.Parent.Parent
        local attributes = v.Parent
        if v:IsA("BoolValue") and v.Name == "InBattle" and model:FindFirstChild("HumanoidRootPart") then
            local modelcframe = model.HumanoidRootPart.CFrame
            -- Engage
            repeat
                pcall(function()
                    model:BreakJoints()
                    local tp1 = {CFrame = modelcframe*CFrame.new(1,1,11)}
                    ts:Create(part, ti, tp1):Play()
                    model:BreakJoints()
                end)
                wait()
                
            until model.Humanoid.Health == 0 or model:FindFirstChild("Ragdoll")
        end
    end
    wait(.1)
end
print("done")
end)

Sas:Cheat("Button", "Hide Identity", function()

for i,v in pairs(speaker.Character:GetDescendants())do
        if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            v:Destroy()
        end
    end
    local function charPartAdded(part)
        if part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
            wait()
            part:Destroy()
        end
    end
    charPartTrigger = speaker.Character.DescendantAdded:Connect(charPartAdded)
speaker:ClearCharacterAppearance()    
end)

Sas:Cheat("Button", "Reset/End Battle", function()
    speaker.Character:BreakJoints()
end)

Sas:Cheat("Button", "Heal (Need 5 coins)", function()
    local pos = char.HumanoidRootPart.CFrame
    pos = pos and pos.Position
    local RP = pos
    local PBH = RP --position before heal
    print(PBH)
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(235, 113, -1639)
    wait(0.5)
    local args = {
        [1] = workspace.NPCs.Hopella
    }
    game:GetService("ReplicatedStorage").RS.Remotes.INC:FireServer(unpack(args))
    wait(2)
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(PBH)
    print("teleported to PBH")
end)

Sas:Cheat("Button", "Join Random Battle", function()
local args = {
    [1] = workspace.BattleCage
}

game:GetService("ReplicatedStorage").RS.Remotes.JoinBattle3:FireServer(unpack(args))
end)

Sas:Cheat("Checkbox", "Old OST (pre v.1.3.0 update)", function()
    local AudioFolder = game.Players.LocalPlayer.PlayerGui.Music
    for i,v in pairs(AudioFolder:GetDescendants()) do
		if v:IsA("PitchShiftSoundEffect") then --eww
			v:Destroy()
		end
	end
    AudioFolder.Battle.SoundId = "rbxassetid://2319829430"
    --AudioFolder.Battle.PlaybackSpeed = 1.04 --audio not right pitch lol
    AudioFolder.DruidGrove.SoundId = "rbxassetid://314425542"
    AudioFolder.FrogvilleRoad.SoundId = "rbxassetid://205049224"
    AudioFolder.Mapleburg.SoundId = "rbxassetid://169480328"
    AudioFolder.Minigame.SoundId = "rbxassetid://1243471427"
    AudioFolder.HiddenWoods.SoundId = "rbxassetid://5723812539"
    AudioFolder.Frogville.SoundId = "rbxassetid://7050451761"
    AudioFolder.MellowMeadows.SoundId = "rbxassetid://7050444349"
    AudioFolder.Minigame.SoundId = "rbxassetid://7050457260"
    AudioFolder.MapleburgWay.SoundId = "rbxassetid://7050456716"
    AudioFolder.DungeonBattle.SoundId = "rbxassetid://7056269587"
end)


Sas:Cheat("Button", "Destroy GUI", function()
    game.CoreGui.FinityUI:Destroy()
end)

Sas:Cheat("Label", "Join the Discord: discord.gg/jTNeAznHQw")

local Teleports = FinityWindow:Category("Teleports")
local TeleportsSector = Teleports:Sector("Teleport Locations")

TeleportsSector:Cheat("Button", "Mapleburg", function()
local args = {
    [1] = "Mapleburg"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
local args = {
    [1] = workspace.Map:FindFirstChild("1_Mapleburg").Areas.NewArea
}
game:GetService("ReplicatedStorage").RS.Remotes.USA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(-99, 54, -271)
end)
TeleportsSector:Cheat("Button", "Mellow Meadows", function()
local args = {
    [1] = "Mellow Meadows",
    [2] = 2
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(-252, 123, -1610)
end)
TeleportsSector:Cheat("Button", "Hoagie Obby", function()
local args = {
    [1] = "Minigame"
}

game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))

    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(-1707, 176, -883)
end)
TeleportsSector:Cheat("Button", "Frogville", function()
local args = {
    [1] = "Frogville"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(113, 113, -1622)
end)
TeleportsSector:Cheat("Button", "Hidden Woods", function()
local args = {
    [1] = "Hidden Woods"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(431, 113, -1578)
end)
TeleportsSector:Cheat("Button", "Frogville Road", function()
local args = {
    [1] = "Frogville Road"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(769, 113, -1491)
end)
TeleportsSector:Cheat("Button", "Dungeon", function()
local args = {
    [1] = "Frogville Road"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(977, 113, -1550)
end)
TeleportsSector:Cheat("Button", "Druid Grove", function()
local args = {
    [1] = "Druid Grove"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(1491, 96, -991)
end)
TeleportsSector:Cheat("Button", "Bedrock", function()
local args = {
    [1] = "Druid Grove"
}
game:GetService("ReplicatedStorage").RS.Remotes.ULODA:FireServer(unpack(args))
    speaker.Character.HumanoidRootPart.CFrame = CFrame.new(1297, 143, -645)
end)

local DungeonCategory = FinityWindow:Category("Dungeon Utilities")
local DungeonSector = DungeonCategory:Sector("Dungeon")


DungeonSector:Cheat("Button", "Pass Loop", function()
--[[while true do
local BattleGUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("BattleGui")
local OptionsGUI = BattleGUI:WaitForChild("Options") 
OptionsFrame = Pass:WaitForChild("Frame")
FramePass = OptionsFrame:WaitForChild("Pass")
--]]
--loadstring(game:HttpGet("https://gist.githubusercontent.com/luatsuki/c75a272fb67bccc22bd1b6add92ee267/raw/56375f8536aeca0cc84b44032312efb0fa5b7fa0/Spy"))()
while true do
-- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = workspace.BattleCage,
    [2] = "Pass"
}

game:GetService("ReplicatedStorage").RS.Remotes.SBO:FireServer(unpack(args))

wait()
end
end)

DungeonSector:Cheat("Label", "bundle includes: float, walkspeed, godmode, right click kill")

DungeonSector:Cheat("Checkbox", "bundle", function()
    Players = game:GetService("Players")
local speaker = Players.LocalPlayer
local pchar = speaker.Character
IYMouse = Players.LocalPlayer:GetMouse()
function r15(plr)
	if plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
		return true
	end
end
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local HumanModCons = {}
function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end
local speed = 75
	if isNumber(speed) then
		local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		local function WalkSpeedChange()
			if Char and Human then
				Human.WalkSpeed = speed
			end
		end
		WalkSpeedChange()
		HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		HumanModCons.wsCA = (HumanModCons.wsCA and HumanModCons.wsCA:Disconnect() and false) or speaker.CharacterAdded:Connect(function(nChar)
			Char, Human = nChar, nChar:WaitForChild("Humanoid")
			WalkSpeedChange()
			HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		end)
	end

floatName = randomString()

Floating = true
	if speaker.Character and not speaker.Character:FindFirstChild(floatName) then
		spawn(function()
			local Float = Instance.new('Part')
			Float.Name = floatName
			Float.Parent = speaker.Character
			Float.Transparency = 1
			Float.Size = Vector3.new(6,1,6)
			Float.Anchored = true
			local FloatValue = -3.5
			if r15(speaker) then FloatValue = -3.65 end
			Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0,FloatValue,0)
			qUp = IYMouse.KeyUp:Connect(function(KEY)
				if KEY == 'q' then
					FloatValue = FloatValue + 0.5
				end
			end)
			eUp = IYMouse.KeyUp:Connect(function(KEY)
				if KEY == 'e' then
					FloatValue = FloatValue - 0.5
				end
			end)
			qDown = IYMouse.KeyDown:Connect(function(KEY)
				if KEY == 'q' then
					FloatValue = FloatValue - 0.5
				end
			end)
			eDown = IYMouse.KeyDown:Connect(function(KEY)
				if KEY == 'e' then
					FloatValue = FloatValue + 0.5
				end
			end)
			floatDied = speaker.Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
				FloatingFunc:Disconnect()
				Float:Destroy()
				qUp:Disconnect()
				eUp:Disconnect()
				qDown:Disconnect()
				eDown:Disconnect()
				floatDied:Disconnect()
			end)
			local function FloatPadLoop()
				if speaker.Character:FindFirstChild(floatName) and getRoot(speaker.Character) then
					Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0,FloatValue,0)
				else
					FloatingFunc:Disconnect()
					Float:Destroy()
					qUp:Disconnect()
					eUp:Disconnect()
					qDown:Disconnect()
					eDown:Disconnect()
					floatDied:Disconnect()
				end
			end			
			FloatingFunc = game:GetService('RunService').Heartbeat:Connect(FloatPadLoop)
		end)
	end
	
local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod
    local args = {...}
      
    if tostring(self) == "AttackFX" and args[2] ~= game.Players.LocalPlayer.Character then --Attack Remote
            return warn("blocked enemy attack");
        end
return namecall(self, table.unpack(args))
end)

    local function clickify(character)
local ClickDetector = Instance.new('ClickDetector', character)
ClickDetector.MaxActivationDistance = math.huge
ClickDetector.RightMouseClick:connect(function(p)
        for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Locked = false
		end
	end
if p == game.Players.LocalPlayer then
character:BreakJoints() --break joints cuz if i used delete head and it broke then broken
end
end)
end

repeat
for i,v in pairs(game.Workspace.Enemies:children'') do
if v:IsA'Model' and v:FindFirstChild'Humanoid' and v:FindFirstChild'Torso' and v:FindFirstChild'ClickDetector' == nil then
clickify(v)
end
end
wait(1)
until nil == true
end)

DungeonSector:Cheat("Button", "Remove Spikes", function()
    for i,v in pairs(workspace.Map:GetDescendants()) do
		if v.Name == "EasyObstacle" then --eww
			v:Destroy()
		end
	end
end)

DungeonSector:Cheat("Button", "Teleport Back to The Woodlands", function()
    wait()
    game:GetService("TeleportService"):Teleport(2927149681, LocalPlayer)
end)

local CreditsCategory = FinityWindow:Category("Credits")
local CreditsCreator = CreditsCategory:Sector("Script Creator")
local Codef = CreditsCategory:Sector("Some code from")

CreditsCreator:Cheat("Label", "Vincent127292 @ v3rmillion.net")
CreditsCreator:Cheat("Label", "SPELLING#4664 on discord")
Codef:Cheat("Label", "Infinite Yield")
Codef:Cheat("Label", "FunTrat0r (Coin Farm)")

local HiddenCategory = FinityWindow:Category(" ")
local HiddenSector = HiddenCategory:Sector("secret menu")
HiddenSector:Cheat("Label", "good job finding me")
HiddenSector:Cheat("Label", "dm me on discord if u found this :)")
HiddenSector:Cheat("Textbox", "Password", function(Value)
    if Value == "nivek" then
        HiddenSector:Cheat("Label", "password successful, here's hidden options")
    elseif Value ~= "nivek" then
        HiddenSector:Cheat("Label", "only owner allowed here :)")
    end
end)
