return function(args)
    if shared.lazerExecuted == true then 
        return
    end

    local VERSION = "1"..(shared.lazerPrivate and " PRIVATE" or "")
    local customdir = (shared.lazerPrivate and "lazer/" or "lazer/")

    local cam = game:GetService("Workspace").CurrentCamera
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
        ["ObjectsThatCanBeSaved"] = {},
    }

    local function GetURL(scripturl)
        if shared.lazerDeveloper then
            if not betterisfile("lazer/"..scripturl) then
                error("File not found : lazer/"..scripturl)
            end
            return readfile("lazer/"..scripturl)
        else
            local res = game:HttpGet("https://pelling.wtf/scripts/lazer/"..scripturl, true)
            assert(res ~= "404: Not Found", "File not found")
            return res
        end
    end

    local function getprofile()
        for i,v in pairs(api.Profiles) do
            if v.Selected == true then
                api.CurrentProfile = i
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

    local function RelativeXY(GuiObject, location)
        local x, y = location.X - GuiObject.AbsolutePosition.X, location.Y - GuiObject.AbsolutePosition.Y
        local x2 = 0
        local xm, ym = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
        x2 = math.clamp(x, 4, xm - 6)
        x = math.clamp(x, 0, xm)
        y = math.clamp(y, 0, ym)
        return x, y, x/xm, y/ym, x2/xm
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
    local function getcustomassetfunc(path)
        if not betterisfile(path) then
            spawn(function()
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
            end)
            local req = requestfunc({
                Url = "https://pelling.wtf/scripts/lazer/"..path:gsub("lazer/assets", "assets"),
                Method = "GET"
            })
            writefile(path, req.Body)
            repeat
                task.wait()
            until readfile(path) == req.Body
        end
        if cachedassets[path] == nil then
            cachedassets[path] = getasset(path) 
        end
        return cachedassets[path]
    end

    api.UpdateHudEvent = Instance.new("BindableEvent")
    api.SelfDestructEvent = Instance.new("BindableEvent")
    api.LoadSettingsEvent = Instance.new("BindableEvent")

    -- Instances:
    local osulazerUI = Instance.new("ScreenGui")
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

    --Properties:
    osulazerUI.Name = "osu!lazerUI"
    osulazerUI.Parent = api.MainGui
    osulazerUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    ScaledGui.Name = "ScaledGui"
    ScaledGui.Parent = osulazerUI
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
    BottomBar.Image = "rbxassetid://9646319664"

    Uninject.Name = "Uninject"
    Uninject.Parent = BottomBar
    Uninject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Uninject.BackgroundTransparency = 1.000
    Uninject.BorderSizePixel = 0
    Uninject.Position = UDim2.new(0.805205405, 0, 0.207081825, 0)
    Uninject.Size = UDim2.new(0.170235306, 0, 0.258933187, 0)
    Uninject.Image = "rbxassetid://9678316823"

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
    TopBar.Image = "rbxassetid://9646312621"

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
    SearchBarBackgound.Image = "rbxassetid://9655815668"

    SearchBarBody.Name = "SearchBarBody"
    SearchBarBody.Parent = TopBar
    SearchBarBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchBarBody.BackgroundTransparency = 1.000
    SearchBarBody.BorderSizePixel = 0
    SearchBarBody.Position = UDim2.new(0.710982859, 0, 0.708000004, 0)
    SearchBarBody.Size = UDim2.new(0.208081618, 0, 0.245000005, 0)
    SearchBarBody.Image = "rbxassetid://9655850526"

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = TopBar
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.BorderSizePixel = 0
    SearchIcon.Position = UDim2.new(0.930999994, 0, 0.784539402, 0)
    SearchIcon.Size = UDim2.new(0.0170000009, 0, 0.0918738022, 0)
    SearchIcon.Image = "rbxassetid://9655861165"

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
end