local VERSION = "1"..(shared.lazerPrivate and " PRIVATE" or "")
local customdir = (shared.lazerPrivate and "lazer/" or "lazer/")

local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
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
local betterisfile = function(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil
end
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local loadedsuccessfully = false
local api = {
    ["Settings"] = {["GUIObject"] = {["Type"] = "Custom", ["Color"] = 0.64}, ["SearchObject"] = {["Type"] = "Custom", ["List"] = {}}},
    ["Profiles"] = {
        ["default"] = {["Keybind"] = "", ["Selected"] = true}
    },
    ["GUIKeybind"] = "RightShift",
    ["KeybindCaptured"] = false,
    ["PressedKeybindKey"] = "",
    ["SaveableObjects"] = {},
}

local function getprofile()
    for i,v in pairs(api["Profiles"]) do
        if v["Selected"] then
            api["CurrentProfile"] = i
        end
    end
end

local holdingshift = false
local capturedslider = nil
local clickgui = {["Visible"] = true}

local function randomString()
    local randomlength = math.random(10,100)
    local array = {}

    for i = 1, randomlength do
        array[i] = string.char(math.random(32, 126))
    end

    return table.concat(array)
end

api.findObjectInTable = function(temp, object)
    for i,v in pairs(temp) do
        if i == object or v == object then
            return true
        end
    end
    return false
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not is_sirhurt_closure and syn and syn.protect_gui then
    local gui = Instance.new("ScreenGui")
    gui.Name = randomString()
    gui.DisplayOrder = 999
    syn.protect_gui(gui)
    gui.Parent = game:GetService("CoreGui")
    api.MainGui = gui
elseif gethui then
    local gui = Instance.new("ScreenGui")
    gui.Name = randomString()
    gui.DisplayOrder = 999
    --gui.Parent = gethui()
    gui.Parent = game:GetService("CoreGui")
    api.MainGui = gui
elseif game:GetService("CoreGui"):FindFirstChild('RobloxGui') then
    api.MainGui = game:GetService("CoreGui").RobloxGui
end

local cachedassets = {}

local function makepath(path, justFolders) 
    local folders = path:split("/")
    local pathCreating=""
    for i,v in next, folders do 
        if not (#folders==i and not justFolders) then
            pathCreating = pathCreating..v.."/"
            if not isfolder(pathCreating) then 
                makefolder(pathCreating)
            end
        end
    end
end

local function getfile(path)
    local actualpath = path:gsub("lazer/assets", "assets")
    local req = requestfunc({
        Url = "https://spelling.wtf/scripts/lazer/"..actualpath,
        Method = "GET"
    })
    makepath(path)
    if not betterisfile(path) then --if file doesnt exist
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
            textlabel.Parent = api.MainGui
            repeat wait() until betterisfile(path)
            textlabel:Remove()
        end)()
        writefile(path, req.Body)
        repeat task.wait() until betterisfile(path)
        repeat task.wait() until readfile(path) == req.Body --wait until its fully downloaded
    elseif betterisfile(path) then
        if readfile(path) ~= req.Body then --if outdated file
            coroutine.wrap(function()
                local textlabel = Instance.new("TextLabel")
                textlabel.Size = UDim2.new(1, 0, 0, 36)
                textlabel.Text = "Updating "..path
                textlabel.BackgroundTransparency = 1
                textlabel.TextStrokeTransparency = 0
                textlabel.TextSize = 30
                textlabel.Font = Enum.Font.SourceSans
                textlabel.TextColor3 = Color3.new(1, 1, 1)
                textlabel.Position = UDim2.new(0, 0, 0, -36)
                textlabel.Parent = api.MainGui
                repeat wait() until betterisfile(path)
                textlabel:Remove()
            end)()
            writefile(path, req.Body)
            repeat task.wait() until betterisfile(path)
            repeat task.wait() until readfile(path) == req.Body
        end
    end
end

local function getcustomassetfunc(path)
    getfile(path)
    if cachedassets[path] == nil then
        cachedassets[path] = getasset(path) 
    end
    return cachedassets[path]
end

api.UpdateHudEvent = Instance.new("BindableEvent")
api.SelfDestructEvent = Instance.new("BindableEvent")
api.LoadSettingsEvent = Instance.new("BindableEvent")

api["MainBlur"] = Instance.new("BlurEffect")
api["MainBlur"].Size = 25
api["MainBlur"].Parent = game:GetService("Lighting")
api["MainBlur"].Enabled = false

api["RemoveObject"] = function(objname)
    api["SaveableObjects"][objname]["Object"]:Remove()
    if api["SaveableObjects"][objname]["Type"] == "OptionsButton" then 
        api["SaveableObjects"][objname]["ChildrenObject"].Name = "RemovedChildren"
    end
    api["SaveableObjects"][objname] = nil
end

api["SaveSettings"] = function()
    if loadedsuccessfully then
        writefile(customdir.."Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt", game:GetService("HttpService"):JSONEncode(api["Profiles"]))
        local WindowTable = {}
        for i,v in pairs(api["SaveableObjects"]) do
            if v["Type"] == "Window" then
                WindowTable[i] = {["Type"] = "Window", ["Visible"] = v["Object"].Visible, ["Expanded"] = v["ChildrenObject"].Visible, ["Position"] = {v["Object"].Position.X.Scale, v["Object"].Position.X.Offset, v["Object"].Position.Y.Scale, v["Object"].Position.Y.Offset}}
            end
            if v["Type"] == "CustomWindow" then
                if v["Api"]["Bypass"] then
                    api["Settings"][i] = {["Type"] = "CustomWindow", ["Visible"] = v["Object"].Visible, ["Pinned"] = v["Api"]["Pinned"], ["Position"] = {v["Object"].Position.X.Scale, v["Object"].Position.X.Offset, v["Object"].Position.Y.Scale, v["Object"].Position.Y.Offset}}
                else
                    WindowTable[i] = {["Type"] = "CustomWindow", ["Visible"] = v["Object"].Visible, ["Pinned"] = v["Api"]["Pinned"], ["Position"] = {v["Object"].Position.X.Scale, v["Object"].Position.X.Offset, v["Object"].Position.Y.Scale, v["Object"].Position.Y.Offset}}
                end
            end
            if (v["Type"] == "ButtonMain" or v["Type"] == "ToggleMain") then
                WindowTable[i] = {["Type"] = "ButtonMain", ["Enabled"] = v["Api"]["Enabled"], ["Keybind"] = v["Api"]["Keybind"]}
            end
            if v["Type"] == "ColorSliderMain" then
                WindowTable[i] = {["Type"] = "ColorSliderMain", ["Value"] = v["Api"]["Value"], ["RainbowValue"] = v["Api"]["RainbowValue"]}
            end
            if v["Type"] == "SliderMain" then
                WindowTable[i] = {["Type"] = "SliderMain", ["Value"] = v["Api"]["Value"]}
            end
            if (v["Type"] == "Button" or v["Type"] == "Toggle" or v["Type"] == "ExtrasButton" or v["Type"] == "TargetButton") then
                api["Settings"][i] = {["Type"] = "Button", ["Enabled"] = v["Api"]["Enabled"], ["Keybind"] = v["Api"]["Keybind"]}
            end
            if (v["Type"] == "OptionsButton" or v["Type"] == "ExtrasButton") then
                api["Settings"][i] = {["Type"] = "OptionsButton", ["Enabled"] = v["Api"]["Enabled"], ["Keybind"] = v["Api"]["Keybind"]}
            end
            if v["Type"] == "TextList" then
                api["Settings"][i] = {["Type"] = "TextList", ["ObjectTable"] = v["Api"]["ObjectList"]}
            end
            if v["Type"] == "TextCircleList" then
                api["Settings"][i] = {["Type"] = "TextCircleList", ["ObjectTable"] = v["Api"]["ObjectList"], ["ObjectTableEnabled"] = v["Api"]["ObjectListEnabled"]}
            end
            if v["Type"] == "TextBox" then
                api["Settings"][i] = {["Type"] = "TextBox", ["Value"] = v["Api"]["Value"]}
            end
            if v["Type"] == "Dropdown" then
                api["Settings"][i] = {["Type"] = "Dropdown", ["Value"] = v["Api"]["Value"]}
            end
            if v["Type"] == "Slider" then
                api["Settings"][i] = {["Type"] = "Slider", ["Value"] = v["Api"]["Value"], ["OldMax"] = v["Api"]["Max"], ["OldDefault"] = v["Api"]["Default"]}
            end
            if v["Type"] == "TwoSlider" then
                api["Settings"][i] = {["Type"] = "TwoSlider", ["Value"] = v["Api"]["Value"], ["Value2"] = v["Api"]["Value2"], ["SliderPos1"] = (v["Object"]:FindFirstChild("Slider") and v["Object"].Slider.ButtonSlider.Position.X.Scale or 0), ["SliderPos2"] = (v["Object"]:FindFirstChild("Slider") and v["Object"].Slider.ButtonSlider2.Position.X.Scale or 0)}
            end
            if v["Type"] == "ColorSlider" then
                api["Settings"][i] = {["Type"] = "ColorSlider", ["Hue"] = v["Api"]["Hue"], ["Sat"] = v["Api"]["Sat"], ["Value"] = v["Api"]["Value"], ["RainbowValue"] = v["Api"]["RainbowValue"]}
            end
        end
        WindowTable["GUIKeybind"] = {["Type"] = "GUIKeybind", ["Value"] = api["GUIKeybind"]}
        writefile(customdir.."Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt", game:GetService("HttpService"):JSONEncode(api["Settings"]))
        writefile(customdir.."Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt", game:GetService("HttpService"):JSONEncode(WindowTable))
    end
end

api["LoadSettings"] = function(customprofile)
    if identifyexecutor and identifyexecutor():find("ScriptWare") == nil and listfiles then
        for i,v in pairs(listfiles(customdir.."Profiles")) do 
            local newstr = v:gsub(customdir.."Profiles", ""):sub(2, v:len())
            local ext = (v:len() >= 12 and v:sub(v:len() - 12, v:len()))
            if (ext and ext:find("lazerprofile") and ext:find("txt") == nil) then
                writefile(customdir.."Profiles/"..newstr..".txt", readfile(customdir.."Profiles/"..newstr))
                if delfile then
                    delfile(customdir.."Profiles/"..newstr)
                end
            end
        end
    end
    if betterisfile("lazer/Profiles/GUIPositions.lazerprofile.txt") and game.GameId == 2619619496 then
        writefile("lazer/Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt", readfile("lazer/Profiles/GUIPositions.lazerprofile.txt"))
        if delfile then delfile("lazer/Profiles/GUIPositions.lazerprofile.txt") end
    end
    if shared.lazerPrivate then
        if betterisfile("lazerprivate/Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt") == false and betterisfile("lazer/Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt") then
            writefile("lazerprivate/Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt", readfile("lazer/Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt"))
        end
        if betterisfile("lazerprivate/Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt") == false and betterisfile("lazer/Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt") then
            writefile("lazerprivate/Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt", readfile("lazer/Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt"))
        end
        if betterisfile("lazerprivate/Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt") == false and betterisfile("lazer/Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt") then
            writefile("lazerprivate/Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt", readfile("lazer/Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt"))
        end
    end
    local success2, result2 = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(customdir.."Profiles/"..(shared.CustomSavelazer or game.PlaceId)..".lazerprofiles.txt"))
    end)
    if success2 and type(result2) == "table" then
        api["Profiles"] = result2
    end
    getprofile()
    if customprofile then 
        api["Profiles"][api["CurrentProfile"]]["Selected"] = false
        api["Profiles"][customprofile] = api["Profiles"][customprofile] or {["Keybind"] = "", ["Selected"] = true}
        api["CurrentProfile"] = customprofile
    end
    local success3, result3 = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(customdir.."Profiles/"..(game.GameId).."GUIPositions.lazerprofile.txt"))
    end)
    if success3 and type(result3) == "table" then
        for i,v in pairs(result3) do
            local obj = api["SaveableObjects"][i]
            if obj then
                if v["Type"] == "Window" then
                    obj["Object"].Position = UDim2.new(v["Position"][1], v["Position"][2], v["Position"][3], v["Position"][4])
                    obj["Object"].Visible = v["Visible"]
                    if v["Expanded"] then
                        obj["Api"]["ExpandToggle"]()
                    end
                end
                if v["Type"] == "CustomWindow" then
                    obj["Object"].Position = UDim2.new(v["Position"][1], v["Position"][2], v["Position"][3], v["Position"][4])
                    obj["Object"].Visible = v["Visible"]
                    if v["Pinned"] then
                        obj["Api"]["PinnedToggle"]()
                    end
                    obj["Api"]["CheckVis"]()
                end
                if v["Type"] == "ButtonMain" then
                    if obj["Type"] == "ToggleMain" then
                        obj["Api"]["ToggleButton"](v["Enabled"], true)
                        if v["Keybind"] ~= "" then
                            obj["Api"]["Keybind"] = v["Keybind"]
                        end
                    else
                        if v["Enabled"] then
                            obj["Api"]["ToggleButton"](false)
                            if v["Keybind"] ~= "" then
                                obj["Api"]["SetKeybind"](v["Keybind"])
                            end
                        end
                    end
                end
                if v["Type"] == "ColorSliderMain" then
                    obj["Api"]["SetValue"](v["Value"])
                    obj["Api"]["SetRainbow"](v["RainbowValue"])
                --	obj["Object"].Slider.ButtonSlider.Position = UDim2.new(math.clamp(v["Value"], 0.02, 0.95), -7, 0, -7)
                end
                if v["Type"] == "SliderMain" then
                    obj["Api"]["SetValue"](v["Value"])
                --	obj["Object"].Slider.ButtonSlider.Position = UDim2.new(math.clamp(v["Value"], 0.02, 0.95), -7, 0, -7)
                end
            end
            if v["Type"] == "GUIKeybind" then
                api["GUIKeybind"] = v["Value"]
            end
        end
    end
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(customdir.."Profiles/"..(api["CurrentProfile"] == "default" and "" or api["CurrentProfile"])..(shared.CustomSavelazer or game.PlaceId)..".lazerprofile.txt"))
    end)
    if success and type(result) == "table" then
        api["LoadSettingsEvent"]:Fire(result)
        for i,v in pairs(result) do
            if v["Type"] == "Custom" and api["Settings"][i] then
                api["Settings"][i] = v
            end
            local obj = api["SaveableObjects"][i]
            if obj then
                if v["Type"] == "Dropdown" then
                    obj["Api"]["SetValue"](v["Value"])
                end
                if v["Type"] == "CustomWindow" then
                    obj["Object"].Position = UDim2.new(v["Position"][1], v["Position"][2], v["Position"][3], v["Position"][4])
                    obj["Object"].Visible = v["Visible"]
                    if v["Pinned"] then
                        obj["Api"]["PinnedToggle"]()
                    end
                    obj["Api"]["CheckVis"]()
                end
                if v["Type"] == "Button" then
                    if obj["Type"] == "Toggle" then
                        obj["Api"]["ToggleButton"](v["Enabled"], true)
                        if v["Keybind"] ~= "" then
                            obj["Api"]["Keybind"] = v["Keybind"]
                        end
                    elseif obj["Type"] == "TargetButton" then
                        obj["Api"]["ToggleButton"](v["Enabled"], true)
                    else
                        if v["Enabled"] then
                            obj["Api"]["ToggleButton"](false)
                            if v["Keybind"] ~= "" then
                                obj["Api"]["SetKeybind"](v["Keybind"])
                            end
                        end
                    end
                end
                if v["Type"] == "NewToggle" then
                    obj["Api"]["ToggleButton"](v["Enabled"], true)
                    if v["Keybind"] ~= "" then
                        obj["Api"]["Keybind"] = v["Keybind"]
                    end
                end
                if v["Type"] == "Slider" then
                    obj["Api"]["SetValue"](v["OldMax"] ~= obj["Api"]["Max"] and v["Value"] > obj["Api"]["Max"] and obj["Api"]["Max"] or (v["OldDefault"] ~= obj["Api"]["Default"] and v["Value"] == v["OldDefault"] and obj["Api"]["Default"] or v["Value"]))
                end
                if v["Type"] == "TextBox" then
                    obj["Api"]["SetValue"](v["Value"])
                end
                if v["Type"] == "TextList" then
                    obj["Api"]["RefreshValues"]((v["ObjectTable"] or {}))
                end
                if v["Type"] == "TextCircleList" then
                    obj["Api"]["RefreshValues"]((v["ObjectTable"] or {}), (v["ObjectTableEnabled"] or {}))
                end
                if v["Type"] == "TwoSlider" then
                    obj["Api"]["SetValue"](v["Value"] == obj["Api"]["Min"] and 0 or v["Value"])
                    obj["Api"]["SetValue2"](v["Value2"])
                    obj["Object"].Slider.ButtonSlider.Position = UDim2.new(v["SliderPos1"], -8, 1, -9)
                    obj["Object"].Slider.ButtonSlider2.Position = UDim2.new(v["SliderPos2"], -8, 1, -9)
                    obj["Object"].Slider.FillSlider.Size = UDim2.new(0, obj["Object"].Slider.ButtonSlider2.AbsolutePosition.X - obj["Object"].Slider.ButtonSlider.AbsolutePosition.X, 1, 0)
                    obj["Object"].Slider.FillSlider.Position = UDim2.new(obj["Object"].Slider.ButtonSlider.Position.X.Scale, 0, 0, 0)
                    --obj["Object"].Slider.FillSlider.Size = UDim2.new((v["Value"] < obj["Api"]["Max"] and v["Value"] or obj["Api"]["Max"]) / obj["Api"]["Max"], 0, 1, 0)
                end
                if v["Type"] == "ColorSlider" then
                    v["Hue"] = v["Hue"] or 0.44
                    v["Sat"] = v["Sat"] or 1
                    v["Value"] = v["Value"] or 1
                    obj["Api"]["SetValue"](v["Hue"], v["Sat"], v["Value"])
                    obj["Api"]["SetRainbow"](v["RainbowValue"])
                    obj["Object"].Slider.ButtonSlider.Position = UDim2.new(math.clamp(v["Hue"], 0.02, 0.95), -9, 0, -7)
                    pcall(function()
                        obj["Object2"].Slider.ButtonSlider.Position = UDim2.new(math.clamp(v["Sat"], 0.02, 0.95), -9, 0, -7)
                        obj["Object3"].Slider.ButtonSlider.Position = UDim2.new(math.clamp(v["Value"], 0.02, 0.95), -9, 0, -7)
                    end)
                end
            end
        end
        for i,v in pairs(result) do
            local obj = api["SaveableObjects"][i]
            if obj then 
                if v["Type"] == "OptionsButton" then
                    if v["Enabled"] then
                        --print(api["SaveableObjects"][i]["Api"]["ToggleButton"], i, v["Enabled"])
                        --local time = tick()
                        api["SaveableObjects"][i]["Api"]["ToggleButton"](false)
                        --print('Loaded '..i..' in '..tick() - time)
                    end
                    if v["Keybind"] ~= "" then
                        api["SaveableObjects"][i]["Api"]["SetKeybind"](v["Keybind"])
                    end
                end
            end
        end
    end
    loadedsuccessfully = true
end

api["CreateMainWindow"] = function(args)
    local windowapi = {}
    local lazerUI = Instance.new("ScreenGui")
    local ScaledGui = Instance.new("Frame")
    local BottomBar = Instance.new("ImageLabel")
    local Uninject = Instance.new("ImageButton")
    local Text = Instance.new("TextLabel")
    local TopBar = Instance.new("ImageLabel")
    local Description = Instance.new("TextLabel")
    local Title = Instance.new("TextLabel")
    local SearchBarBackgound = Instance.new("ImageLabel")
    local SearchBarBody = Instance.new("ImageLabel")
    local SearchIcon = Instance.new("ImageButton")
    local SearchInput = Instance.new("TextBox")
    api.TabsFrame = Instance.new("ScrollingFrame")
    local UIGridLayout = Instance.new("UIGridLayout")

    lazerUI.Name = "osu!lazerUI"
    lazerUI.Parent = api.MainGui
    lazerUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    ScaledGui.Name = "ScaledGui"
    ScaledGui.Parent = lazerUI
    ScaledGui.AnchorPoint = Vector2.new(0.5, 0.5)
    ScaledGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScaledGui.BackgroundTransparency = 1.000
    ScaledGui.BorderSizePixel = 0
    ScaledGui.Position = UDim2.new(0.5, 0, 0.5, 0)
    ScaledGui.Size = UDim2.new(1, 0, 1, 0)

    BottomBar.Name = "BottomBar"
    BottomBar.Parent = ScaledGui
    BottomBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BottomBar.BackgroundTransparency = 1.000
    BottomBar.Position = UDim2.new(0.245000005, 0, 0.906037033, 0)
    BottomBar.Size = UDim2.new(0.688000023, 0, 0.143037036, 0)
    BottomBar.Image = getcustomassetfunc("lazer/assets/bottombar.png")

    Uninject.Name = "Uninject"
    Uninject.Parent = BottomBar
    Uninject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Uninject.BackgroundTransparency = 1.000
    Uninject.BorderSizePixel = 0
    Uninject.Position = UDim2.new(0.805205405, 0, 0.207081825, 0)
    Uninject.Size = UDim2.new(0.170235306, 0, 0.258933187, 0)
    Uninject.Image = getcustomassetfunc("lazer/assets/BottomBar/bluebutton.png")
    Uninject.MouseButton1Click:Connect(function()
        api["SelfDestruct"]()
    end)

    Text.Name = "Text"
    Text.Parent = Uninject
    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text.BackgroundTransparency = 1.000
    Text.BorderSizePixel = 0
    Text.Position = UDim2.new(0.0210222229, 0, 0.224999994, 0)
    Text.Size = UDim2.new(0.956755579, 0, 0.625, 0)
    Text.Font = Enum.Font.GothamSemibold
    Text.Text = "Uninject"
    Text.TextColor3 = Color3.fromRGB(0, 0, 0)
    Text.TextSize = 16.000

    TopBar.Name = "TopBar"
    TopBar.Parent = ScaledGui
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopBar.BackgroundTransparency = 1.000
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0.0520000011, 0, -0.0481481478, 0)
    TopBar.Size = UDim2.new(0.698000014, 0, 0.226861104, 0)
    TopBar.Image = getcustomassetfunc("lazer/assets/topbar.png")

    Description.Name = "Description"
    Description.Parent = TopBar
    Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Description.BackgroundTransparency = 1.000
    Description.Position = UDim2.new(0.0247535091, 0, 0.856999993, 0)
    Description.Size = UDim2.new(0.565765738, 0, 0.143000007, 0)
    Description.Font = Enum.Font.GothamBold
    Description.Text = args.Description
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 14.000
    Description.TextWrapped = true
    Description.TextXAlignment = Enum.TextXAlignment.Left

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0337480046, 0, 0.70599997, 0)
    Title.Size = UDim2.new(0.267575055, 0, 0.166999996, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = args.Title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 30.000
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left

    SearchBarBackgound.Name = "SearchBarBackgound"
    SearchBarBackgound.Parent = TopBar
    SearchBarBackgound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchBarBackgound.BackgroundTransparency = 1.000
    SearchBarBackgound.BorderSizePixel = 0
    SearchBarBackgound.Position = UDim2.new(0.710982859, 0, 0.708000004, 0)
    SearchBarBackgound.Size = UDim2.new(0.25999999, 0, 0.244887963, 0)
    SearchBarBackgound.Image = getcustomassetfunc("lazer/assets/SearchBar/searchbackground.png")

    SearchBarBody.Name = "SearchBarBody"
    SearchBarBody.Parent = TopBar
    SearchBarBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchBarBody.BackgroundTransparency = 1.000
    SearchBarBody.BorderSizePixel = 0
    SearchBarBody.Position = UDim2.new(0.710982859, 0, 0.708000004, 0)
    SearchBarBody.Size = UDim2.new(0.208081618, 0, 0.245000005, 0)
    SearchBarBody.Image = getcustomassetfunc("lazer/assets/SearchBar/searchbar.png")

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = TopBar
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.BorderSizePixel = 0
    SearchIcon.Position = UDim2.new(0.930999994, 0, 0.784539402, 0)
    SearchIcon.Size = UDim2.new(0.0170000009, 0, 0.0918738022, 0)
    SearchIcon.Image = getcustomassetfunc("lazer/assets/SearchBar/searchicon.png")

    SearchInput.Name = "SearchInput"
    SearchInput.Parent = TopBar
    SearchInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchInput.BackgroundTransparency = 1.000
    SearchInput.BorderSizePixel = 0
    SearchInput.Position = UDim2.new(0.726000011, 0, 0.704052925, 0)
    SearchInput.Size = UDim2.new(0.513999999, 0, 0.240724862, 0)
    SearchInput.Font = Enum.Font.GothamBold
    SearchInput.Text = "Search"
    SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchInput.TextSize = 20.000
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left

    api.TabsFrame.Name = "Tabs"
    api.TabsFrame.Parent = ScaledGui
    api.TabsFrame.Active = true
    api.TabsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    api.TabsFrame.BackgroundTransparency = 1.000
    api.TabsFrame.BorderSizePixel = 0
    api.TabsFrame.Position = UDim2.new(0.0520833321, 0, 0.208000004, 0)
    api.TabsFrame.Size = UDim2.new(1, 0, 0.690999985, 0)
    api.TabsFrame.CanvasSize = UDim2.new(10, 0, 0, 0)
    api.TabsFrame.ScrollBarThickness = 0
    api.TabsFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

    UIGridLayout.Parent = api.TabsFrame
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(-0.00529999984, 0, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0.0286052078, 0, 1, 0)
    api["SaveableObjects"]["GUIWindow"] = {["Object"] = ScaledGui, ["ChildrenObject"] = api.TabsFrame, ["Type"] = "Window", ["Api"] = windowapi}
    return windowapi
end

api["CreateTab"] = function(args)
    local tabapi = {}
    local currentexpandedbutton = nil
    local Tab = Instance.new("ImageLabel")
    local Body = Instance.new("ImageLabel")
    local Title = Instance.new("TextLabel")

    Tab.Name = "Tab"
    Tab.Parent = api.TabsFrame
    Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab.BackgroundTransparency = 1.000
    Tab.BorderSizePixel = 0
    Tab.Position = UDim2.new(0.292601824, 0, 0.359087795, 0)
    Tab.Size = UDim2.new(0, 100, 0, 100)
    Tab.Image = getcustomassetfunc("lazer/assets/Tabs/tabcolor_"..args.Color:lower()..".png")

    Body.Name = "Body"
    Body.Parent = Tab
    Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Body.BackgroundTransparency = 1.000
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(-0.00499999989, 0, 0.0804300308, 0)
    Body.Size = UDim2.new(0.984000027, 0, 0.918926537, 0)
    Body.Image = getcustomassetfunc("lazer/assets/Tabs/tabbackground.png")

    Title.Name = "Title"
    Title.Parent = Tab
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.234999999, 0, 0.0254561044, 0)
    Title.Size = UDim2.new(0.649999976, 0, 0.0549739264, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = args.Title
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.TextSize = 20.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    --tilted grid layout
    Body.ChildAdded:Connect(function(child)
        local buttonscount = Body:GetChildren()
        for i,v in pairs(buttonscount) do
            if not v:IsA("ImageLabel") then
                table.remove(buttonscount, i)
            end
        end
        child.Position = buttonscount[#buttonscount].Position + UDim2.new(-0.0184195992, 0, 0.0948199183, 0)
    end)
    return tabapi
end

api["KeyInputHandler"] = game:GetService("UserInputService").InputBegan:connect(function(input1)
    if game:GetService("UserInputService"):GetFocusedTextBox() == nil then
        if input1.KeyCode == Enum.KeyCode[api["GUIKeybind"]] and api["KeybindCaptured"] == false then
            clickgui.Visible = not clickgui.Visible
            game:GetService("UserInputService").OverrideMouseIconBehavior = (clickgui.Visible and Enum.OverrideMouseIconBehavior.ForceShow or game:GetService("VRService").VREnabled and Enum.OverrideMouseIconBehavior.ForceHide or Enum.OverrideMouseIconBehavior.None)
            api["MainBlur"].Enabled = clickgui.Visible	
        end
        if input1.KeyCode == Enum.KeyCode.LeftShift then
            holdingshift = true
        end
        if api["KeybindCaptured"] and input1.KeyCode ~= Enum.KeyCode.LeftShift then
            local hah = string.gsub(tostring(input1.KeyCode), "Enum.KeyCode.", "")
            api["PressedKeybindKey"] = (hah ~= "Unknown" and hah or "")
        end
        for modules,aapi in pairs(api["SaveableObjects"]) do
            if (aapi["Type"] == "OptionsButton" or aapi["Type"] == "Button") and (aapi["Api"]["Keybind"] ~= nil and aapi["Api"]["Keybind"] ~= "") and api["KeybindCaptured"] == false then
                if input1.KeyCode == Enum.KeyCode[aapi["Api"]["Keybind"]] and aapi["Api"]["Keybind"] ~= api["GUIKeybind"] then
                    aapi["Api"]["ToggleButton"](false)
                end
            end
        end
    end
end)

api["KeyInputHandler2"] = game:GetService("UserInputService").InputEnded:connect(function(input1)
    if input1.KeyCode == Enum.KeyCode.LeftShift then
        holdingshift = false
    end
end)
return api