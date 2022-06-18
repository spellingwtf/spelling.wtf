repeat task.wait() until game:IsLoaded() == true
local injected = true
local customdir = (shared.lazerPrivate and "lazer/" or "lazer/")
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
	print("Vape not supported with your exploit.")
	return
end

if shared.VapeExecuted then
	error("Vape Already Injected")
	return
else
	shared.VapeExecuted = true
end

if isfolder(customdir:gsub("/", "")) == false then
	makefolder(customdir:gsub("/", ""))
end
if isfolder("vape") == false then
	makefolder("vape")
end
if not betterisfile("vape/assetsversion.dat") then
	writefile("vape/assetsversion.dat", "1")
end
if isfolder(customdir.."CustomModules") == false then
	makefolder(customdir.."CustomModules")
end
if isfolder(customdir.."Profiles") == false then
	makefolder(customdir.."Profiles")
end
local assetver = checkassetversion()
if assetver and assetver > readfile("lazer/assetsversion.dat") then
	if shared.VapeDeveloper == nil then
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
		Url = "https://spelling.wtf/scripts/lazer/CustomModules/"..id..".lua",
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
			textlabel:Remove()
		end)()
		task.wait(2)
		return checkpublicrepo(id)
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end

local function getcustomassetfunc(path)
    if not betterisfile(path) then
        coroutine.wrap(function()
            local textlabel = Instance.new("TextLabel")
            textlabel.Size = UDim2.new(1, 0, 0, 36)
            textlabel.Text = "Downloading "..path
            textlabel.BackgroundTransparency = 1
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 30
            textlabel.Font = Enum.Font.SourceSans
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.Position = UDim2.new(0, 0, 0, -36)
            textlabel.Parent = GuiLibrary["MainGui"]
            repeat task.wait() until betterisfile(path)
            textlabel:Destroy()
        end)()
        local req = requestfunc({
            Url = "https://spelling.wtf/scripts/lazer/"..path:gsub("lazer/assets", "assets"),
            Method = "GET"
        })
        writefile(path, req.Body)
        repeat
            task.wait()
        until readfile(path) == req.Body
    end
    return getasset(path)
end

shared.GuiLibrary = GuiLibrary
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local selfdestructsave = coroutine.create(function()
	while task.wait(10) do
		if GuiLibrary and injected then
			if not injected then return end
			--GuiLibrary["SaveSettings"]()
		else
			break
		end
	end
end)

local Gui = GuiLibrary.CreateMainWindow()