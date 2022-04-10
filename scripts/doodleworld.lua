local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Client = require(LocalPlayer.Packer.Client)
local CurrentRoute
local AutoFarmConnection
local UninjectConnection
local InABattle = false
local KeyBind = "RightShift"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
for i,v in pairs(workspace:GetChildren()) do
    if v:IsA("Model") and string.find(v.Name, "_") and v ~= LocalPlayer.Character then
        CurrentRoute = v
    end
end

--// PREVENT REEXECUTES
if getgenv().executed == true then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Already Executed",
        Text = "Uninject first by pressing comma!",
        Duration = 3,
    })
    return
end
getgenv().executed = true

if type(getgenv().autofarm_settings) ~="table" then getgenv().autofarm_settings = {} end

local function notify(title, text)
    local configTable = {
        Title = title,
        Text = text,
        Duration = 3,
    }
    game:GetService("StarterGui"):SetCore("SendNotification", configTable)
end
local function validatesettings()
    if getgenv().autofarm_settings.catch_when_shiny == getgenv().autofarm_settings.kill_when_shiny then
        notify("Shiny Settings Anomaly", "You can't have catch and kill set to true")
        return false
    end
    if getgenv().autofarm_settings.catch_when_skin == getgenv().autofarm_settings.kill_when_skin then
        notify("Skin Settings Anomaly", "You can't have catch and kill set to true")
        return false
    end
    if getgenv().autofarm_settings.catch_when_tint == getgenv().autofarm_settings.kill_when_tint then
        notify("Tint Settings Anomaly", "You can't have catch and kill set to true")
        return false
    end
    if getgenv().autofarm_settings.catch_when_havent_caught_before == getgenv().autofarm_settings.kill_when_havent_caught_before then
        notify("Doodles Not Caught Before Settings Anomaly", "You can't have catch and kill set to true")
        return false
    end
    if getgenv().autofarm_settings.catch_when_specific_doodle == getgenv().autofarm_settings.kill_when_specific_doodle then
        notify("Specific Doodle Settings Anomaly", "You can't have catch and kill set to true")
        return false
    end
    if type(getgenv().autofarm_settings.catch_when_shiny) ~= "boolean" or type(getgenv().autofarm_settings.catch_when_shiny) ~= "boolean" then
        notify("Invalid Shiny Settings")
        return false
    end
    if type(getgenv().autofarm_settings.catch_when_skin) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_tint) ~= "boolean" then
        notify("Invalid Skin Settings")
        return false
    end
    if type(getgenv().autofarm_settings.catch_when_tint) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_tint) ~= "boolean" then
        notify("Invalid Tint Settings")
        return false
    end
    if type(getgenv().autofarm_settings.catch_when_havent_caught_before) ~= "boolean" or type(getgenv().autofarm_settings.catch_when_havent_caught_before) ~= "boolean" then
        notify("Invalid Doodle that hasn't been caught before Settings")
        return false
    end
    if type(getgenv().autofarm_settings.catch_when_specific_doodle) ~= "boolean" or type(getgenv().autofarm_settings.catch_when_specific_doodle) ~= "boolean" then
        notify("Invalid Specific Doodle Settings")
        return false
    end
    return true
end

local Window = Library.CreateLib("Doodle World AutoFarm", "DarkTheme")
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")
local WarningLabel = MainSection:NewLabel("Don't forget to set your settings before enabling\n  (everything is off by default)")
local Enabled = MainSection:NewToggle("Enabled", "", function(state)
    local validsettings = validatesettings()
    if validsettings == true then
        if state == true then
            getgenv().autofarm_settings.enabled = true
        elseif state == false then
            getgenv().autofarm_settings.enabled = false
        end
    else
        notify("unable to enable", "invalid settings")
    end
end)
local SettingsTab = Window:NewTab("Settings")
local Shiny = SettingsTab:NewSection("Shiny")
Shiny:NewDropdown("Mode", "", {"Catch", "Kill"}, function(mode)
    if mode == "Catch" then
        getgenv().autofarm_settings.kill_when_shiny = false
        getgenv().autofarm_settings.catch_when_shiny = true
    elseif mode == "Kill" then
        getgenv().autofarm_settings.catch_when_shiny = false
        getgenv().autofarm_settings.kill_when_shiny = true
    end
end)
local Skin = SettingsTab:NewSection("Skin")
Skin:NewDropdown("Mode", "", {"Catch", "Kill"}, function(mode)
    if mode == "Catch" then
        getgenv().autofarm_settings.kill_when_skin = false
        getgenv().autofarm_settings.catch_when_skin = true
    elseif mode == "Kill" then
        getgenv().autofarm_settings.catch_when_skin = false
        getgenv().autofarm_settings.kill_when_skin = true
    end
end)
local Tint = SettingsTab:NewSection("Tint")
Tint:NewDropdown("Mode", "", {"Catch", "Kill"}, function(mode)
    if mode == "Catch" then
        getgenv().autofarm_settings.kill_when_tint = false
        getgenv().autofarm_settings.catch_when_tint = true
    elseif mode == "Kill" then
        getgenv().autofarm_settings.catch_when_tint = false
        getgenv().autofarm_settings.kill_when_tint = true
    end
end)
local DoodlesThatHaventBeenCaughtBefore = SettingsTab:NewSection("Doodles that haven't been caught before")
DoodlesThatHaventBeenCaughtBefore:NewDropdown("Mode", "", {"Catch", "Kill"}, function(mode)
    if mode == "Catch" then
        getgenv().autofarm_settings.kill_when_havent_caught_before = false
        getgenv().autofarm_settings.catch_when_havent_caught_before = true
    elseif mode == "Kill" then
        getgenv().autofarm_settings.catch_when_havent_caught_before = false
        getgenv().autofarm_settings.kill_when_havent_caught_before = true
    end
end)
local SpecificDoodles = SettingsTab:NewSection("Specific Doodle")
SpecificDoodles:NewDropdown("Mode", "", {"Catch", "Kill"}, function(mode)
    if mode == "Catch" then
        getgenv().autofarm_settings.kill_when_specific_doodle = false
        getgenv().autofarm_settings.catch_when_specific_doodle = true
    elseif mode == "Kill" then
        getgenv().autofarm_settings.catch_when_specific_doodle = false
        getgenv().autofarm_settings.kill_when_specific_doodle = true
    end
end)
local GUISettings = Window:NewTab("GUI Settings")
local GUISettingsSection = GUISettings:NewSection("Settings")
local KeybindChoose = GUISettingsSection:NewTextBox("Toggle GUI Keybind", "", function(txt)
    KeyBind = txt
    game:GetService("UserInputService").InputBegan:Connect(function(key)
        if (string.len(txt)) and key.KeyCode == Enum.KeyCode[txt:upper()] then
            Library:ToggleUI()
        end
    end)
end)

local function run()
    repeat
        repeat
            task.wait()
            if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^You r") then return end
        until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Run.MouseButton1Click)[1] ~= nil
        getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Run.MouseButton1Click)[1]:Fire()
        print("ran")
        task.wait(2)
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^You r")
end
local function catch()
    repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Visible == true
    local bagbutton = LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Items
    VirtualInputManager:SendMouseMoveEvent(bagbutton.AbsolutePosition.X + bagbutton.AbsoluteSize.X / 2, bagbutton.AbsolutePosition.Y + bagbutton.AbsoluteSize.Y / 2, bagbutton)
    VirtualInputManager:SendMouseButtonEvent(bagbutton.AbsolutePosition.X + bagbutton.AbsoluteSize.X / 2, bagbutton.AbsolutePosition.Y + bagbutton.AbsoluteSize.Y / 2, 1, true, bagbutton, 1)
    VirtualInputManager:SendMouseButtonEvent(bagbutton.AbsolutePosition.X + bagbutton.AbsoluteSize.X / 2, bagbutton.AbsolutePosition.Y + bagbutton.AbsoluteSize.Y / 2, 1, false, bagbutton, 1)
end
local function kill()
    local notsupereffectivemoves = {}
    local foundeffective = false
    repeat
        repeat
            task.wait()
            if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") then return end
        until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil
        for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
            getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1]:Fire()
            if v.Effective.Visible == true and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) and v.Effective.Image ~= 4597964542 and v.Effective.Image ~= 4597964185 then
                getconnections(v.MouseButton1Click)[1]:Fire()
                foundeffective = true
                break
            elseif v.Effective.Visible == false and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) then
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Switch.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.PartyUI.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyUI.Party1.Activated)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui:FindFirstChild("PartyChoice")
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyChoice.Stats.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.Stats.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.Stats.Tabs.Moves.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.Visible == true
                local movebutton
                for i2,v2 in pairs(LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.Holder:GetChildren()) do
                    if v2:IsA("ImageButton") and v2:FindFirstChild("MoveName") and v2.MoveName.Text == v.MoveName.Text then
                        movebutton = v2
                        break
                    end
                end
                repeat
                    task.wait()
                    VirtualInputManager:SendMouseMoveEvent(movebutton.AbsolutePosition.X + movebutton.AbsoluteSize.X / 2, movebutton.AbsolutePosition.Y + movebutton.AbsoluteSize.Y / 2, movebutton)
                until LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.MoveName.Label.Text == v.MoveName.Text
                local movepower = LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.StatHolder.Power.Desc.Label.Text
                if movepower == "--" or movepower == "Varies" then movepower = 0 end
                movepower = tonumber(movepower)
                local movename = LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.MoveName.Label.Text
                notsupereffectivemoves[movename] = movepower
                getconnections(LocalPlayer.PlayerGui.MainGui.Stats.Close.MouseButton1Click)[1]:Fire()
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyUI.CloseBar.Cancel.MouseButton1Click)[1]:Fire()
            end
        end
        if foundeffective == false then
            local strongestmove 
            local num = 0
            for i,v in pairs(notsupereffectivemoves) do
                if v > num then
                    num = v
                    strongestmove = i
                end
            end
            getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1]:Fire()
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                if v.MoveName.Text == strongestmove then
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    break
                end
            end
        end
        print("attacked")
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted")
end

notify("AutoFarm Loaded", "Press comma to uninject")

getgenv().autofarm_settings.enabled = false

AutoFarmConnection = RunService.RenderStepped:Connect(function()
    if InABattle == true or getgenv().autofarm_settings.enabled == false then return end
    if getgenv().autofarm_settings.enabled == true then
        InABattle = true
        print("healing")
        Client.Network:post("PlayerData", "Heal")
        print("starting battle")
        if CurrentRoute.Name == "007_Lakewood" then
            Client.Network:post("RequestWild", CurrentRoute.Name, "Lake")
        elseif CurrentRoute.Name == "011_Sewer" then
            Client.Network:post("RequestWild", "011_RealSewer", "Sewer")
        else
            Client.Network:post("RequestWild", CurrentRoute.Name, "WildGrass")
        end
        repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == true
        task.wait(1)
        if LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.Shiny.Visible == true then
            print("found shiny doodle")
            notify("AutoFarm Found:", "Shiny Doodle")
            if getgenv().autofarm_settings.kill_when_shiny == true or getgenv().autofarm_settings.kill_all == true then
                kill()
            end
        elseif tostring(LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.UIGradient.Color.Keypoints[1]) ~= "0 1 1 1 0 " then
            print("found skin")
            notify("AutoFarm Found:", "Skin")
            if getgenv().autofarm_settings.kill_when_skin == true or getgenv().autofarm_settings.kill_all == true then
                kill()
            end
        elseif LocalPlayer.PlayerGui.MainGui.MainBattle.DoodleFront.NewSprite:FindFirstChild("ColorChanger") then
            print("found tint")
            notify("AutoFarm Found:", "Tint")
            if getgenv().autofarm_settings.kill_when_tint == true or getgenv().autofarm_settings.kill_all == true then
                kill()
            end
        elseif LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.AlreadyCaught.Visible == false then
            print("found doodle that hasnt been caught before")
            notify("AutoFarm Found:", "Doodle that hasn't been caught before")
            if getgenv().autofarm_settings.kill_when_havent_caught_before == true or getgenv().autofarm_settings.kill_all == true then
                kill()
            end
        elseif table.find(getgenv().autofarm_settings.specific_doodles, LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text) then
            print("found specific doodle")
            notify("AutoFarm Found:", "Specific Doodle")
            if getgenv().autofarm_settings.kill_when_specific_doodle == true or getgenv().autofarm_settings.kill_all == true then
                kill()
            end
        else
            if getgenv().autofarm_settings.kill_all == true then
                kill()
            else
                run()
            end
        end
        repeat
            task.wait()
        until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false
    end
    InABattle = false
end)

--// UNINJECT
UninjectConnection = UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Comma then
        notify("AutoFarm", "Uninjecting...")
        UninjectConnection:Disconnect()
        getgenv().executed = false
        notify("AutoFarm", "Uninjected") 
        AutoFarmConnection:Disconnect()  
        for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
            function isNumeric(value)
                if value == tostring(tonumber(value)) then
                    return true
                else
                    return false
                end
            end
            if isNumeric(v.Name) then
                v:Destroy()
            end
        end
    end
end)
