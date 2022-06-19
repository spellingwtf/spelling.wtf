repeat task.wait() until game:IsLoaded() == true
local injected = true
local customdir = shared.lazerPrivate and "lazerprivate/" or "lazer/"
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local function GetURL(scripturl)
    if shared.lazerDeveloper then
        if not betterisfile("lazer/"..scripturl) then
            error("File not found : lazer/"..scripturl)
        end
        return readfile("lazer/"..scripturl)
    else
        local res = game:HttpGet("https://spelling.wtf/scripts/lazer/"..scripturl, true)
        assert(res ~= "404: Not Found", "File not found")
        return res
    end
end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 

local function checkassetversion()
	local req = requestfunc({
		Url = "https://spelling.wtf/scripts/lazer/assetsversion.dat",
		Method = "GET"
	})
	if req.StatusCode == 200 then
		return req.Body
	else
		return nil
	end
end

if not (getasset and requestfunc and queueteleport) then
	print("lazer is not supported with your exploit.")
	return
end

if shared.lazerExecuted then
	error("lazer Already Injected")
	return
else
	shared.lazerExecuted = true
end

if isfolder(customdir:gsub("/", "")) == false then
	makefolder(customdir:gsub("/", ""))
end
if isfolder("lazer") == false then
	makefolder("lazer")
end
if not betterisfile("lazer/assetsversion.dat") then
	writefile("lazer/assetsversion.dat", "1")
end
if isfolder(customdir.."CustomModules") == false then
	makefolder(customdir.."CustomModules")
end
if isfolder(customdir.."Profiles") == false then
	makefolder(customdir.."Profiles")
end
local assetver = checkassetversion()
if assetver and assetver > readfile("lazer/assetsversion.dat") then
	if shared.lazerDeveloper == nil then
		if isfolder("lazer/assets") then
			if delfolder then
				delfolder("lazer/assets")
			end
		end
		writefile("lazer/assetsversion.dat", assetver)
	end
end
if isfolder("lazer/assets") == false then
	makefolder("lazer/assets")
end

local GuiLibrary = loadstring(GetURL("lazer!UI.lua"))()

local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function(id)
	local suc, req = pcall(function() return requestfunc({
		Url = "https://spelling.wtf/scripts/lazer/CustomModules/lazer!"..id..".lua",
		Method = "GET"
	}) end)
	if not suc then
		checkpublicreponum = checkpublicreponum + 1
		coroutine.wrap(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Loading CustomModule Failed!, Attempts : "..checkpublicreponum
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			task.wait(2)
			textlabel:Destroy()
		end)()
		task.wait(2)
		return checkpublicrepo(id)
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end

shared.GuiLibrary = GuiLibrary
local SelfDestructSave = coroutine.create(function()
	while task.wait(10) do
		if GuiLibrary and injected then
			if not injected then return end
			GuiLibrary["SaveSettings"]()
		else
			break
		end
	end
end)

local GUI = GuiLibrary.CreateMainWindow({
    Title = "testing",
    Description = "this is a test GUI"
})
GuiLibrary.CreateTab({
    Title = "Combat",
    Color = "Blue"
})
GuiLibrary.CreateTab({
    Title = "Blatant",
    Color = "Red"
})
GuiLibrary.CreateTab({
    Title = "Render",
    Color = "Lime"
})
GuiLibrary.CreateTab({
    Title = "Utilities",
    Color = "Lime"
})
GuiLibrary.CreateTab({
    Title = "Miscellaneous",
    Color = "Orange"
})
GuiLibrary.CreateTab({
    Title = "World",
    Color = "Lime"
})

local teleportfunc = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started and not shared.lazerIndependent then
		local teleportstr = 'shared.lazerSwitchServers = true if shared.lazerDeveloper then loadstring(readfile("lazer/lazer.lua"))() else loadstring(game:HttpGet("https://spelling.wtf/scripts/lazer/lazer.lua", true))() end'
		if shared.lazerDeveloper then
			teleportstr = 'shared.lazerDeveloper = true '..teleportstr
		end
		if shared.lazerPrivate then
			teleportstr = 'shared.lazerPrivate = true '..teleportstr
		end
		if shared.lazerCustomProfile then 
			teleportstr = "shared.lazerCustomProfile = '"..shared.lazerCustomProfile.."'"..teleportstr
		end
		GuiLibrary["SaveSettings"]()
		queueteleport(teleportstr)
    end
end)

GuiLibrary["SelfDestruct"] = function()
	coroutine.wrap(function()
		coroutine.close(SelfDestructSave)
	end)()
	injected = false
	game:GetService("UserInputService").OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
	for i,v in pairs(GuiLibrary["SaveableObjects"]) do
		if (v["Type"] == "Button" or v["Type"] == "OptionsButton") and v["Api"]["Enabled"] then
			v["Api"]["ToggleButton"](false)
		end
	end
	GuiLibrary["SelfDestructEvent"]:Fire()
	shared.lazerExecuted = nil
	shared.lazerPrivate = nil
	shared.lazerFullyLoaded = nil
	shared.lazerSwitchServers = nil
	shared.GuiLibrary = nil
	shared.lazerIndependent = nil
	shared.lazerManualLoad = nil
	shared.CustomSavelazer = nil
    GuiLibrary["KeyInputHandler"]:Disconnect()
	GuiLibrary["KeyInputHandler2"]:Disconnect()
	teleportfunc:Disconnect()
	GuiLibrary["MainGui"]:Destroy()
	GuiLibrary["MainBlur"]:Destroy()
end

loadstring(GetURL("CustomModules/lazer!Universal.lua"))()
if betterisfile("lazer/CustomModules/lazer!"..game.PlaceId..".lua") then
	loadstring(readfile("lazer/CustomModules/lazer!"..game.PlaceId..".lua"))()
else
	local publicrepo = checkpublicrepo(game.PlaceId)
	if publicrepo then
		loadstring(publicrepo)()
	end
end
if shared.lazerPrivate then
	if pcall(function() readfile("lazerprivate/CustomModules/lazer!"..game.PlaceId..".lua") end) then
		loadstring(readfile("lazerprivate/CustomModules/lazer!"..game.PlaceId..".lua"))()
	end	
end
GuiLibrary["LoadSettings"](shared.lazerCustomProfile)
local profiles = {}
for i,v in pairs(GuiLibrary["Profiles"]) do 
	table.insert(profiles, i)
end
table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
if not shared.lazerSwitchServers then
	--GuiLibrary["LoadedAnimation"](true)
	print("lazer loaded")
else
	shared.lazerSwitchServers = nil
end
if shared.lazerOpenGui then
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
	GuiLibrary["MainBlur"].Enabled = true	
	shared.lazerOpenGui = nil
end

coroutine.resume(SelfDestructSave)
shared.lazerFullyLoaded = true