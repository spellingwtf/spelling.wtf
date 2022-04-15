local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Client = require(LocalPlayer.Packer.Client)
local getasset = syn and getsynasset or getcustomasset
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local CurrentRoute
local UI
local AutoFarmConnection
local UninjectConnection
local InABattle = false
local FirstEncounter = true
local KeyBind = "RightShift"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
for i,v in pairs(workspace:GetChildren()) do
    if v:IsA("Model") and string.find(v.Name, "_") and v ~= LocalPlayer.Character then
        CurrentRoute = v
    end
end

--// PREVENT REEXECUTESs
if getgenv().executed == true then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Already Executed",
        Text = "Uninject first by pressing comma!",
        Duration = 3,
    })
    return
end
getgenv().executed = true

if type(getgenv().autofarm_settings) ~= "table" then getgenv().autofarm_settings = {} end

local function notify(title, text)
    local configTable = {
        Title = title,
        Text = text,
        Duration = 3,
    }
    game:GetService("StarterGui"):SetCore("SendNotification", configTable)
end
local function validatesettings()
    if type(getgenv().autofarm_settings.panhandle_mode) ~= "boolean" or type(getgenv().autofarm_settings.wild_mode) ~= "boolean" or type(getgenv().autofarm_settings.trainer_mode) ~= "boolean" then
        notify("Invalid Autofarm Mode Settings", "Setting hasn't been set")
        return false
    end
    --settings where catch and kill or kill and pause or catch and pause are both true (only people who run old script will possibly get this error)
    --checks = {catch and kill, kill and pause, catch and pause}
    if getgenv().autofarm_settings.wild_mode == true then
        if getgenv().autofarm_settings.kill_when_shiny == getgenv().autofarm_settings.catch_when_shiny and getgenv().autofarm_settings.kill_when_shiny == true or getgenv().autofarm_settings.kill_when_shiny == getgenv().autofarm_settings.pause_when_shiny and getgenv().autofarm_settings.kill_when_shiny == true or getgenv().autofarm_settings.pause_when_shiny == getgenv().autofarm_settings.catch_when_shiny and getgenv().autofarm_settings.pause_when_shiny == true then
            notify("Shiny Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_when_skin == getgenv().autofarm_settings.catch_when_skin and getgenv().autofarm_settings.kill_when_skin == true or getgenv().autofarm_settings.kill_when_skin == getgenv().autofarm_settings.pause_when_skin and getgenv().autofarm_settings.kill_when_skin == true or getgenv().autofarm_settings.pause_when_skin == getgenv().autofarm_settings.catch_when_skin and getgenv().autofarm_settings.pause_when_skin == true then
            notify("Skin Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_when_tint == getgenv().autofarm_settings.catch_when_tint and getgenv().autofarm_settings.kill_when_tint == true or getgenv().autofarm_settings.kill_when_tint == getgenv().autofarm_settings.pause_when_tint and getgenv().autofarm_settings.kill_when_tint == true or getgenv().autofarm_settings.pause_when_tint == getgenv().autofarm_settings.catch_when_tint and getgenv().autofarm_settings.pause_when_tint == true then
            notify("Tint Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_when_havent_caught_before == getgenv().autofarm_settings.catch_when_havent_caught_before and getgenv().autofarm_settings.kill_when_havent_caught_before == true or getgenv().autofarm_settings.kill_when_havent_caught_before == getgenv().autofarm_settings.pause_when_havent_caught_before and getgenv().autofarm_settings.kill_when_havent_caught_before == true or getgenv().autofarm_settings.pause_when_havent_caught_before == getgenv().autofarm_settings.catch_when_havent_caught_before and getgenv().autofarm_settings.pause_when_havent_caught_before == true then
            notify("Doodles Not Caught Before Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_when_specific_doodle == getgenv().autofarm_settings.catch_when_specific_doodle and getgenv().autofarm_settings.kill_when_specific_doodle == true or getgenv().autofarm_settings.kill_when_specific_doodle == getgenv().autofarm_settings.pause_when_specific_doodle and getgenv().autofarm_settings.kill_when_specific_doodle == true or getgenv().autofarm_settings.kill_when_specific_doodle == getgenv().autofarm_settings.pause_when_specific_doodle and getgenv().autofarm_settings.kill_when_specific_doodle == true then
            notify("Specific Doodle Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_all == getgenv().autofarm_settings.catch_all and getgenv().autofarm_settings.kill_all == true or getgenv().autofarm_settings.kill_all == getgenv().autofarm_settings.pause_all and getgenv().autofarm_settings.kill_all == true or getgenv().autofarm_settings.pause_all == getgenv().autofarm_settings.catch_all and getgenv().autofarm_settings.pause_all == true then
            notify("Kill/Catch/Pause All Settings Invalid", "You can't have catch and kill set to true")
            return false
        end
        if getgenv().autofarm_settings.kill_when_normal_doodle == getgenv().autofarm_settings.pause_when_normal_doodle and getgenv().autofarm_settings.kill_when_normal_doodle == true then
            notify("Normal Doodle Settings Invalid", "You can't have catch and pause set to true")
            return false
        end
    end
    --mandatory settings that haven't been set
    if getgenv().autofarm_settings.wild_mode == true then
        if getgenv().autofarm_settings.autokill_use_strongest_move == false and type(getgenv().autofarm_settings.autokill_custom_move) ~= "string" then
            notify("Invalid Kill Mode Custom Move", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.kill_when_normal_doodle) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_normal_doodle) ~= "boolean" then
            notify("Invalid Normal Doodle Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.catch_when_shiny) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_shiny) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_shiny) ~= "boolean" then
            notify("Invalid Shiny Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.catch_when_skin) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_skin) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_skin) ~= "boolean" then
            notify("Invalid Skin Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.catch_when_tint) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_tint) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_tint) ~= "boolean" then
            notify("Invalid Tint Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.catch_when_havent_caught_before) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_havent_caught_before) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_havent_caught_before) ~= "boolean" then
            notify("Invalid Doodle that hasn't been caught before Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.catch_when_specific_doodle) ~= "boolean" or type(getgenv().autofarm_settings.kill_when_specific_doodle) ~= "boolean" or type(getgenv().autofarm_settings.pause_when_specific_doodle) ~= "boolean" then
            notify("Invalid Specific Doodle Settings", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.autocatch_capsule) ~= "string" then
            notify("Invalid Capsule Setting", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.autokill_use_strongest_move) ~= "boolean" then
            notify("Invalid Kill Mode Move", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.specific_doodles) ~= "table" then
            notify("Invalid Specific Doodle Table", "Setting hasn't been set")
            return false
        end
    end
    if getgenv().autofarm_settings.trainer_mode == true then
        if type(getgenv().autofarm_settings.autokill_use_strongest_move) ~= "boolean" then
            notify("Invalid Kill Mode Move Setting", "Setting hasn't been set")
            return false
        end
        if type(getgenv().autofarm_settings.trainer_ID) ~= "number" then
            notify("Invalid Trainer ID", "Setting hasn't been set")
            return false
        end
        if getgenv().autofarm_settings.autokill_use_strongest_move == false and type(getgenv().autofarm_settings.autokill_custom_move) ~= "string" then
            notify("Invalid Kill Mode Custom Move", "Setting hasn't been set")
            return false
        end
    end
    return true
end


local function getcustomassetfunc(path)
    if not isfile(path) then
        local req = requestfunc({
            Url = "https://spelling.wtf/scripts/assets/"..path,
            Method = "GET"
        })
        writefile(path, req.Body)
        repeat task.wait() until isfile(path)
    end
    return getasset(path) 
end

local function removeNonUniversalSettings()
    local Non_Universal_Section_Names = {
        [1] = "All Doodles (Bypasses every other setting) (Optional)",
        [2] = "Kill Mode",
        [3] = "Catch Mode",
        [4] = "Specific Doodle",
        [5] = "Doodles that haven't been caught before",
        [6] = "Tint",
        [7] = "Skin",
        [8] = "Shiny/Misprint",
        [9] = "Normal Doodles\n(doodles that didnt pass any of the checks)",
        [10] = "Kill Mode",
    }
    
    local Non_Universal_Button_Names = {
        [1] = "Sound Alerts"
    }
    
    local Non_Universal_Slider_Names = {
        [1] = "Trainer ID (1-39)"
    }

    for i,v in pairs(UI.Main.pages.Pages:GetChildren()) do
        for i2, v2 in pairs(v:GetChildren()) do
            if v2.Name == "sectionFrame" then
                if table.find(Non_Universal_Section_Names, v2.sectionHead.sectionName.Text) then
                    v2:Destroy()
                end
                if v2:FindFirstChild("sectionInners") then
                    for i3, v3 in pairs(v2.sectionInners:GetChildren()) do
                        if v3.Name == "toggleElement" and table.find(Non_Universal_Button_Names, v3.togName.Text) then
                            v3:Destroy()
                        elseif v3.Name == "sliderElement" and table.find(Non_Universal_Slider_Names, v3.togName.Text) then
                            v3:Destroy()
                        end
                    end
                end
            end
        end
    end
end

local Window = Library.CreateLib("Doodle World AutoFarm", "DarkTheme")
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == tostring(tonumber(v.Name)) then
        UI = v
    end
end
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")
local WarningLabel = MainSection:NewLabel("Don't forget to set your settings before enabling\n  (everything is off by default)")
local WarningLabel2 = MainSection:NewLabel("Theres a serversided 4 second cooldown in between\n  wild battles")

local Enabled = MainSection:NewToggle("Enabled", "", function(state)
    print("toggled")
    local validsettings = validatesettings()

    if validsettings == true then
        if state == true then
            getgenv().autofarm_settings.enabled = true
            FirstEncounter = true
        elseif state == false then
            getgenv().autofarm_settings.enabled = false
        end
    else
        print(validsettings)
        notify("unable to enable", "invalid settings")
    end
end)
local SupportSection = MainTab:NewSection("Support")
SupportSection:NewButton("Click to join discord server", "", function()
    task.spawn(function()
        for i = 1, 14 do
            spawn(function()
                local reqbody = {
                    ["nonce"] = game:GetService("HttpService"):GenerateGUID(false),
                    ["args"] = {
                        ["invite"] = {["code"] = "4KaJ2xdJXH"},
                        ["code"] = "4KaJ2xdJXH",
                    },
                    ["cmd"] = "INVITE_BROWSER"
                }
                local newreq = game:GetService("HttpService"):JSONEncode(reqbody)
                requestfunc({
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["Origin"] = "https://discord.com"
                    },
                    Url = "http://127.0.0.1:64"..(53 + i).."/rpc?v=1",
                    Method = "POST",
                    Body = newreq
                })
            end)
        end
    end)
end)
local WarningLabel2 = SupportSection:NewLabel("Discord Server:\n  discord.gg/4KaJ2xdJXH")
local SettingsTab = Window:NewTab("AutoFarm Settings")
local MainSettings = SettingsTab:NewSection("Main")

local TeleportTab = Window:NewTab("Teleports")
local MainTeleportTabSection = TeleportTab:NewSection("Teleport")
MainTeleportTabSection:NewDropdown("Teleport to Location", "", {"The Crossroads", "Graphite Lodge", "Route 4", "Lakewood Sewer", "Route 3", "Lakewood Town", "Route 2", "Route 1", "Sketchvale"}, function(location)
    local LocationsTable = {
        ["The Crossroads"] = "017_Crossroads",
        ["Graphite Lodge"] = "014_GraphiteLodge",
        ["Route 4"] = "013_Route4",
        ["Lakewood Sewer"] = "011_RealSewer",
        ["Route 3"] = "010_Route3",
        ["Lakewood Town"] = "007_Lakewood",
        ["Route 2"] = "006_Route2",
        ["Route 1"] = "Route_1",
        ["Sketchvale"] = "001_Chunk"
    }
    pcall(function()
        Client.DataManager.Chunk.new(Client, LocationsTable[location], "Entrance", true, true)
    end)
    task.wait(0.6)
    LocalPlayer.Character.HumanoidRootPart.Anchored = false
end)

local Misc = SettingsTab:NewSection("Misc")
Misc:NewToggle("AutoHeal", "", function(state)
    if state == true then
        getgenv().autofarm_settings.autoheal = true
    elseif state == false then
        getgenv().autofarm_settings.autoheal = false
    end
end)
local Capsules = {}
local CapsuleSelection
MainSettings:NewDropdown("AutoFarm Mode", "", {"Wild Battle", "Panhandle Money Farm", "Trainer Farm"}, function(state)
    if state == "Wild Battle" then
        if getgenv().autofarm_settings.enabled == true then
            getgenv().autofarm_settings.enabled = false
            notify("AutoFarm", "Disabled")
        end
        getgenv().autofarm_settings.trainer_mode = false
        getgenv().autofarm_settings.panhandle_mode = false
        getgenv().autofarm_settings.wild_mode = true
        removeNonUniversalSettings()
        local NormalDoodles = SettingsTab:NewSection("Normal Doodles\n(doodles that didnt pass any of the checks)")
        NormalDoodles:NewDropdown("Mode", "", {"Kill", "Run", "Pause"}, function(mode)
            if mode == "Kill" then
                getgenv().autofarm_settings.pause_when_normal_doodle = false
                getgenv().autofarm_settings.kill_when_normal_doodle = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_normal_doodle = false
                getgenv().autofarm_settings.kill_when_normal_doodle = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.kill_when_normal_doodle = false
                getgenv().autofarm_settings.pause_when_normal_doodle = true
            end
        end)
        local Shiny = SettingsTab:NewSection("Shiny/Misprint")
        Shiny:NewDropdown("Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.pause_when_shiny = false
                getgenv().autofarm_settings.kill_when_shiny = false
                getgenv().autofarm_settings.catch_when_shiny = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_when_shiny = false
                getgenv().autofarm_settings.catch_when_shiny = false
                getgenv().autofarm_settings.kill_when_shiny = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_shiny = false
                getgenv().autofarm_settings.catch_when_shiny = false
                getgenv().autofarm_settings.kill_when_shiny = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_when_shiny = false
                getgenv().autofarm_settings.kill_when_shiny = false
                getgenv().autofarm_settings.pause_when_shiny = true
            end
        end)
        local Skin = SettingsTab:NewSection("Skin")
        Skin:NewDropdown("Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.kill_when_skin = false
                getgenv().autofarm_settings.pause_when_skin = false
                getgenv().autofarm_settings.catch_when_skin = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_when_skin = false
                getgenv().autofarm_settings.catch_when_skin = false
                getgenv().autofarm_settings.kill_when_skin = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_skin = false
                getgenv().autofarm_settings.catch_when_skin = false
                getgenv().autofarm_settings.kill_when_skin = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_when_skin = false
                getgenv().autofarm_settings.kill_when_skin = false
                getgenv().autofarm_settings.pause_when_skin = true
            end
        end)
        local Tint = SettingsTab:NewSection("Tint")
        Tint:NewDropdown("Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.pause_when_tint = false
                getgenv().autofarm_settings.kill_when_tint = false
                getgenv().autofarm_settings.catch_when_tint = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_when_tint = false
                getgenv().autofarm_settings.catch_when_tint = false
                getgenv().autofarm_settings.kill_when_tint = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_tint = false
                getgenv().autofarm_settings.catch_when_tint = false
                getgenv().autofarm_settings.kill_when_tint = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_when_tint = false
                getgenv().autofarm_settings.kill_when_tint = false
                getgenv().autofarm_settings.pause_when_tint = true
            end
        end)
        local DoodlesThatHaventBeenCaughtBefore = SettingsTab:NewSection("Doodles that haven't been caught before")
        DoodlesThatHaventBeenCaughtBefore:NewDropdown("Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.pause_when_havent_caught_before = false
                getgenv().autofarm_settings.kill_when_havent_caught_before = false
                getgenv().autofarm_settings.catch_when_havent_caught_before = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_when_havent_caught_before = false
                getgenv().autofarm_settings.catch_when_havent_caught_before = false
                getgenv().autofarm_settings.kill_when_havent_caught_before = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_havent_caught_before = false
                getgenv().autofarm_settings.catch_when_havent_caught_before = false
                getgenv().autofarm_settings.kill_when_havent_caught_before = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_when_havent_caught_before = false
                getgenv().autofarm_settings.kill_when_havent_caught_before = false
                getgenv().autofarm_settings.pause_when_havent_caught_before = true
            end
        end)
        local SpecificDoodles = SettingsTab:NewSection("Specific Doodle")
        SpecificDoodles:NewDropdown("Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.pause_when_specific_doodle = false
                getgenv().autofarm_settings.kill_when_specific_doodle = false
                getgenv().autofarm_settings.catch_when_specific_doodle = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_when_specific_doodle = false
                getgenv().autofarm_settings.catch_when_specific_doodle = false
                getgenv().autofarm_settings.kill_when_specific_doodle = true
            elseif mode == "Run" then
                getgenv().autofarm_settings.pause_when_specific_doodle = false
                getgenv().autofarm_settings.catch_when_specific_doodle = false
                getgenv().autofarm_settings.kill_when_specific_doodle = false
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_when_specific_doodle = false
                getgenv().autofarm_settings.kill_when_specific_doodle = false
                getgenv().autofarm_settings.pause_when_specific_doodle = true
            end
        end)

        local AutoCatch = SettingsTab:NewSection("Catch Mode")
        for i,v in pairs(Client.Network:get("PlayerData", "GetItems")["Capsules"]) do
            table.insert(Capsules, i)
        end
        CapsuleSelection = AutoCatch:NewDropdown("Capsule", "choose your capsule", Capsules, function(capsule)
            getgenv().autofarm_settings.autocatch_capsule = capsule
        end)
        AutoCatch:NewToggle("Use Glancing Blow", "", function(state)
            if state == true then
                getgenv().autofarm_settings.autocatch_use_glancing_blow = true
            elseif state == false then
                getgenv().autofarm_settings.autocatch_use_glancing_blow = false
            end
        end)
        local AutoKill = SettingsTab:NewSection("Kill Mode")
        AutoKill:NewDropdown("Which move to use", "", {"Strongest Move", "Custom Move"}, function(mode)
            local custommovedropdown
            if mode == "Strongest Move" then
                getgenv().autofarm_settings.autokill_use_strongest_move = true
            elseif mode == "Custom Move" then
                getgenv().autofarm_settings.autokill_use_strongest_move = false
                local moves = {}
                for i,v in pairs(Client.Network:get("PlayerData", "GetParty")[1]["Moves"]) do
                    table.insert(moves, v.Name)
                end
                custommovedropdown = AutoKill:NewDropdown("Custom Move Choice", "", moves, function(move)
                    getgenv().autofarm_settings.autokill_custom_move = move
                end)
            end
        end)
        local AllDoodles = SettingsTab:NewSection("All Doodles (Bypasses every other setting) (Optional)")
        AllDoodles:NewDropdown("Mode (Optional Setting)", "", {"Catch", "Kill", "Pause"}, function(mode)
            if mode == "Catch" then
                getgenv().autofarm_settings.pause_all = false
                getgenv().autofarm_settings.kill_all = false
                getgenv().autofarm_settings.catch_all = true
            elseif mode == "Kill" then
                getgenv().autofarm_settings.pause_all = false
                getgenv().autofarm_settings.catch_all = false
                getgenv().autofarm_settings.kill_all = true
            elseif mode == "Pause" then
                getgenv().autofarm_settings.catch_all = false
                getgenv().autofarm_settings.kill_all = false
                getgenv().autofarm_settings.pause_all = true
            end
        end)
        Misc:NewToggle("Sound Alerts", "", function(state)
            if state == true then
                getgenv().autofarm_settings.sound_alerts = true
            elseif state == false then
                getgenv().autofarm_settings.sound_alerts = false
            end
        end)
    elseif state == "Panhandle Money Farm" then
        if getgenv().autofarm_settings.enabled == true then
            getgenv().autofarm_settings.enabled = false
            notify("AutoFarm", "Disabled")
        end
        getgenv().autofarm_settings.trainer_mode = false
        getgenv().autofarm_settings.wild_mode = false
        getgenv().autofarm_settings.panhandle_mode = true
        removeNonUniversalSettings()
    elseif state == "Trainer Farm" then
        if getgenv().autofarm_settings.enabled == true then
            getgenv().autofarm_settings.enabled = false
            notify("AutoFarm", "Disabled")
        end
        getgenv().autofarm_settings.wild_mode = false
        getgenv().autofarm_settings.panhandle_mode = false
        getgenv().autofarm_settings.trainer_mode = true
        removeNonUniversalSettings()
        MainSettings:NewSlider("Trainer ID (1-39)", "", 39, 1, function(s)
            getgenv().autofarm_settings.trainer_ID = s
        end)
        local AutoKill = SettingsTab:NewSection("Kill Mode")
        AutoKill:NewDropdown("Which move to use", "", {"Strongest Move", "Custom Move"}, function(mode)
            if mode == "Strongest Move" then
                getgenv().autofarm_settings.autokill_use_strongest_move = true
            elseif mode == "Custom Move" then
                getgenv().autofarm_settings.autokill_use_strongest_move = false
                local moves = {}
                for i,v in pairs(Client.Network:get("PlayerData", "GetParty")[1]["Moves"]) do
                    table.insert(moves, v.Name)
                end
                AutoKill:NewDropdown("Custom Move Choice", "", moves, function(move)
                    getgenv().autofarm_settings.autokill_custom_move = move
                end)
            end
        end)
    end
end)

local MiscTab = Window:NewTab("Misc")
local MainMiscSection = MiscTab:NewSection("Main")
local HideIdentity = MainMiscSection:NewButton("Hide Identity", "Hides player list and overhead name GUI", function()
    LocalPlayer.PlayerGui.MainGui:FindFirstChild(LocalPlayer.Name).Visible = false
    LocalPlayer.PlayerGui.MainGui:FindFirstChild(LocalPlayer.Name):GetPropertyChangedSignal("Visible"):Connect(function(value)
        if LocalPlayer.PlayerGui.MainGui:FindFirstChild(LocalPlayer.Name).Visible == true then
            LocalPlayer.PlayerGui.MainGui:FindFirstChild(LocalPlayer.Name).Visible = false
        end
    end)
    LocalPlayer.PlayerGui.MainGui.PlayerList.Visible = false
    LocalPlayer.Character.Head.Nametag.Username.Visible = false
end)
local FightGlubbie = MainMiscSection:NewButton("Fight Glubbie", "Starts a glubbie fight", function()
    Client.Battle:WildBattle("GenericIndoors", "GlubbieSpecial")
end)

local OpenSection = MiscTab:NewSection("Open UIs")
local OpenShop = OpenSection:NewButton("Open Shop", "Opens the shop GUI", function()
    Client.NormalShop.new()
    repeat task.wait() until LocalPlayer.Character.Humanoid.WalkSpeed == 0
    LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)
local OpenPC = OpenSection:NewButton("Open PC", "Opens the PC GUI", function()
    Client.PC.new()
    repeat task.wait() until LocalPlayer.Character.Humanoid.WalkSpeed == 0
    LocalPlayer.Character.Humanoid.WalkSpeed = 16
    Client.Controls:ToggleWalk(true)
end)


local GUISettings = Window:NewTab("GUI Settings")
local GUISettingsSection = GUISettings:NewSection("Settings")
local ToggleGUIConnection 
local KeybindChoose = GUISettingsSection:NewTextBox("Toggle GUI Keybind", "", function(txt)
    if Enum.KeyCode[txt] ~= nil then
        KeyBind = txt
    elseif Enum.KeyCode[txt:upper()] ~= nil then
        KeyBind = txt:upper()
    else
        notify("Invalid KeyBind", "")
    end
    if ToggleGUIConnection ~= nil then ToggleGUIConnection:Disconnect() end
    ToggleGUIConnection = game:GetService("UserInputService").InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode[KeyBind] then
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

local function panhandle()
    local moneygot = 0
    --1st doodle
    repeat
        local breakrepeat = false
        repeat
            task.wait()
            if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." used Panhandle!") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $") then
                if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $") then
                    local amountgot = LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text:split(" ")[3]
                    moneygot = moneygot + tonumber( string.sub( amountgot, 2, -1 ) )
                end
                breakrepeat = true
                break
            end
        until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil
        if breakrepeat == true then break end
        for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
            if v.MoveName.Text == "Panhandle" then
                repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                getconnections(v.MouseButton1Click)[1]:Fire()
                print("panhandled: doodle".."1")
                break
            end
        end
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $")
    repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true
    --all the other doodles
    for doodlenumber = 2, #Client.Network:get("PlayerData", "GetParty") do
        local Doodle = Client.Network:get("PlayerData", "GetParty")[doodlenumber]
        for i,v in pairs(Doodle.Moves) do
            if v.Name == "Panhandle" then
                print("other doodle has panhandle, switching")
                repeat task.wait() until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Switch.MouseButton1Click)[1] ~= nil
                getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Switch.MouseButton1Click)[1]:Fire()
                for i,v in pairs(LocalPlayer.PlayerGui.MainGui.PartyUI:GetChildren()) do
                    if string.find(v.Name, "Party") and tonumber(string.split(v.Health.HealthNumber.Text, " ")[1]) ~= 0 and v.DoodleName.Label.Text == Doodle.Name then
                        getconnections(v.Activated)[1]:Fire()
                        repeat task.wait() until LocalPlayer.PlayerGui.MainGui:FindFirstChild("PartyChoice")
                        getconnections(LocalPlayer.PlayerGui.MainGui.PartyChoice.Switch.MouseButton1Click)[1]:Fire()
                        repeat
                            local breakrepeat = false
                            repeat
                                task.wait()
                                if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." used Panhandle!") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $") then
                                    if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $") then
                                        local amountgot = LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text:split(" ")[3]
                                        moneygot = moneygot + tonumber( string.sub( amountgot, 2, -1 ) )
                                    end
                                    breakrepeat = true
                                    break
                                end
                            until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil
                            if breakrepeat == true then break end
                            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                                if v.MoveName.Text == "Panhandle" then
                                    repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                                    getconnections(v.MouseButton1Click)[1]:Fire()
                                    print("panhandled: doodle"..doodlenumber)
                                    break
                                end
                            end
                        until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, Client.Battle.CurrentData.Out1[1].Name.." got $")
                        break
                    end
                end
                break
            end
        end
    end
    repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true
    run()
    --notify("Panhandle AutoFarm", "GOT: $"..moneygot)
    --print("got: $"..moneygot)
end

local function catch()
    local noglancingblow = false
    local onehpbutglancingblowdoodledead = false
    local moves = {}
    for i,v in pairs(Client.Battle.CurrentData.Out1[1].Moves) do
        table.insert(moves, v.Name)
    end
    while string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "was caught") ~= "was caught" do
        --if doodle dies
        if Client.Battle.CurrentData.Out1[1].currenthp == 0 then
            repeat task.wait() until LocalPlayer.PlayerGui.MainGui.PartyUI.Visible == true
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.PartyUI:GetChildren()) do
                if string.find(v.Name, "Party") and tonumber(string.split(v.Health.HealthNumber.Text, " ")[1]) ~= 0 then
                    getconnections(v.Activated)[1]:Fire()
                    repeat task.wait() until LocalPlayer.PlayerGui.MainGui:FindFirstChild("PartyChoice")
                    getconnections(LocalPlayer.PlayerGui.MainGui.PartyChoice.Switch.MouseButton1Click)[1]:Fire()
                    repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true
                    moves = {}
                    for i,v in pairs(Client.Battle.CurrentData.Out1[1].Moves) do
                        table.insert(moves, v.Name)
                    end
                    if Client.Battle.CurrentData.EnemyDoodle.currenthp == 1 then
                        onehpbutglancingblowdoodledead = true
                    end
                    break
                end
            end
        end
        if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true then
            if getgenv().autofarm_settings.autocatch_use_glancing_blow == true and table.find(moves, "Glancing Blow") and Client.Battle.CurrentData.EnemyDoodle.currenthp ~= 1 and type(Client.Battle.CurrentData) == "table" then
                for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                    if v.MoveName.Text == "Glancing Blow" then
                        repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                        getconnections(v.MouseButton1Click)[1]:Fire()
                        print("used glancing blow")
                    end
                end
            elseif getgenv().autofarm_settings.autocatch_use_glancing_blow == true and not table.find(moves, "Glancing Blow") and Client.Battle.CurrentData.EnemyDoodle.currenthp ~= 1 then
                notify("AutoFarm Error", "Use glancing blow is on but don't have the move, throwing capsule")
                noglancingblow = true
            end
            if getgenv().autofarm_settings.autocatch_use_glancing_blow == true and table.find(moves, "Glancing Blow") and Client.Battle.CurrentData.EnemyDoodle.currenthp == 1 or noglancingblow == true or getgenv().autofarm_settings.autocatch_use_glancing_blow == false or getgenv().autofarm_settings.autocatch_use_glancing_blow == nil or onehpbutglancingblowdoodledead == true then
                if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true then
                    print("posting battle action")
                    Client.SelectedAction:Fire({
                        ActionType = "Item",
                        Action = getgenv().autofarm_settings.autocatch_capsule,
                        User = Client.Battle.CurrentData.Out1[1].ID
                    })
                    Client.Network:post("BattleAction", {{
                        ActionType = "Item",
                        Action = getgenv().autofarm_settings.autocatch_capsule,
                        User = Client.Battle.CurrentData.Out1[1].ID
                    }})
                    --repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^You used "..getgenv().autofarm_settings.autocatch_capsule)
                    print("capsule thrown")
                    task.wait(1)
                end
            end
        end
        task.wait()
    end
end

local function kill()
    local notsupereffectivemoves = {}
    local noteffectivemoves = {}
    local foundsupereffective = false
    local foundstrongest = false
    local foundnoteffective = false
    repeat
        repeat
            task.wait()
            if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The opposing "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") then return end
        until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil or Client.Battle.CurrentData.Out1[1].currenthp == 0
        --if doodle dies
        if Client.Battle.CurrentData.Out1[1].currenthp == 0 then
            repeat task.wait() until LocalPlayer.PlayerGui.MainGui.PartyUI.Visible == true
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.PartyUI:GetChildren()) do
                if string.find(v.Name, "Party") and tonumber(string.split(v.Health.HealthNumber.Text, " ")[1]) ~= 0 then
                    getconnections(v.Activated)[1]:Fire()
                    repeat task.wait() until LocalPlayer.PlayerGui.MainGui:FindFirstChild("PartyChoice")
                    getconnections(LocalPlayer.PlayerGui.MainGui.PartyChoice.Switch.MouseButton1Click)[1]:Fire()
                    notsupereffectivemoves = {}
                    noteffectivemoves = {}
                    foundsupereffective = false
                    foundstrongest = false
                    foundnoteffective = false
                    repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true
                    break
                end
            end
        end
        if getgenv().autofarm_settings.autokill_use_strongest_move == true then
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                --super effective move
                if v.Effective.Visible == true and v.MoveName.Text ~= "Glancing Blow" and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) and v.Effective.Image ~= "http://www.roblox.com/asset/?id=4597964542" and v.Effective.Image ~= "http://www.roblox.com/asset/?id=4597964185" then
                    repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    print("attacked")
                    foundsupereffective = true
                    foundstrongest = true
                    foundnoteffective = true
                    break
                --normal move
                elseif v.Effective.Visible == false and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) and v.MoveName.Text ~= "Glancing Blow" then
                    if notsupereffectivemoves[v.MoveName.Text] == nil then
                        local movepower = Client.Moves[v.MoveName.Text].Power
                        if movepower == "--" or movepower == "Varies" then movepower = 0 end
                        movepower = tonumber(movepower)
                        local movename = v.MoveName.Text
                        notsupereffectivemoves[movename] = movepower
                    end
                end
            end
            if foundsupereffective == false and notsupereffectivemoves ~= {} then
                local strongestmove 
                local num = 0
                for i,v in pairs(notsupereffectivemoves) do
                    if v > num then
                        num = v
                        strongestmove = i
                    end
                end
                foundstrongest = true
                foundnoteffective = true
                for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                    if v.MoveName.Text == strongestmove then
                        repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                        getconnections(v.MouseButton1Click)[1]:Fire()
                        print("attacked")
                        break
                    end
                end
            end
            --not effective moves
            if notsupereffectivemoves == {} and foundsupereffective == false and foundstrongest == false and foundnoteffective == false then
                for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                    if v.Effective.Visible == true and v.MoveName.Text ~= "Glancing Blow" and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) and v.Effective.Image ~= "http://www.roblox.com/asset/?id=4597964542" then
                        if noteffectivemoves[v.MoveName.Text] == nil then
                            local movepower = Client.Moves[v.MoveName.Text].Power
                            if movepower == "--" or movepower == "Varies" then movepower = 0 end
                            movepower = tonumber(movepower)
                            local movename = v.MoveName.Text
                            noteffectivemoves[movename] = movepower
                        end
                    end
                end
            end
            if notsupereffectivemoves ~= {} and foundsupereffective == false and foundstrongest == false and foundnoteffective == false then
                local strongestmove 
                local num = 0
                for i,v in pairs(notsupereffectivemoves) do
                    if v > num then
                        num = v
                        strongestmove = i
                    end
                end
                foundnoteffective = true
                for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                    if v.MoveName.Text == strongestmove then
                        repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                        getconnections(v.MouseButton1Click)[1]:Fire()
                        print("attacked")
                        break
                    end
                end
            end
        elseif getgenv().autofarm_settings.autokill_use_strongest_move == false then
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                if v.MoveName.Text == getgenv().autofarm_settings.autokill_custom_move then
                    repeat task.wait() until getconnections(v.MouseButton1Click)[1] ~= nil
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    print("attacked")
                    break
                end
            end
        end
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The opposing "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted")
end

notify("AutoFarm Loaded", "Press comma to uninject")

getgenv().autofarm_settings.enabled = false
Client.Network:post("ToggleSettings", "TextSpeed", "Fast")
Client.Network:post("ToggleSettings", "SkipLevelUp", true)

AutoFarmConnection = RunService.RenderStepped:Connect(function()
    if InABattle == true or getgenv().autofarm_settings.enabled == false then return end
    if getgenv().autofarm_settings.enabled == true then
        InABattle = true
        if getgenv().autofarm_settings.autoheal == true then
            print("healing")
            Client.Network:post("PlayerData", "Heal")
        end
        if getgenv().autofarm_settings.wild_mode == true then
            for i,v in pairs(Client.Network:get("PlayerData", "GetItems")["Capsules"]) do
                table.insert(Capsules, i)
            end
            CapsuleSelection:Refresh(Capsules)
        end
        for i,v in pairs(workspace:GetChildren()) do
            if v:IsA("Model") and string.find(v.Name, "_") and v ~= LocalPlayer.Character then
                CurrentRoute = v
            end
        end
        if FirstEncounter == true then
            print("first encounter true")
            if getgenv().autofarm_settings.wild_mode == true or getgenv().autofarm_settings.panhandle_mode == true then
                print("starting wild battle")
                if CurrentRoute.Name == "007_Lakewood" then
                    Client.Battle:WildBattle("RequestWild", "Lake", "Lake")
                elseif CurrentRoute.Name == "011_Sewer" then
                    Client.Battle:WildBattle("RequestWild", "Sewer", "Sewer")
                else
                    Client.Battle:WildBattle("RequestWild", "WildGrass", "WildGrass")
                end
            elseif getgenv().autofarm_settings.trainer_mode == true then
                print("starting trainer battle")
                Client.Battle:TrainerBattle(getgenv().autofarm_settings.trainer_ID, CurrentRoute.NPC:GetChildren()[math.random(1, #CurrentRoute.NPC:GetChildren())])
            end
        elseif FirstEncounter == false then
            if getgenv().autofarm_settings.wild_mode == true or getgenv().autofarm_settings.panhandle_mode == true then
                print("waiting for battle cooldown (5 seconds)")
                repeat task.wait()
                    if CurrentRoute.Name == "007_Lakewood" then
                        Client.Network:post("RequestWild", CurrentRoute.Name, "Lake")
                    elseif CurrentRoute.Name == "011_Sewer" then
                        Client.Network:post("RequestWild", "011_RealSewer", "Sewer")
                    else
                        Client.Network:post("RequestWild", CurrentRoute.Name, "WildGrass")
                    end
                until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == true
                print("starting wild battle")
            elseif getgenv().autofarm_settings.trainer_mode == true then
                print("starting trainer battle")
                Client.Battle:TrainerBattle(getgenv().autofarm_settings.trainer_ID, CurrentRoute.NPC:GetChildren()[math.random(1, #CurrentRoute.NPC:GetChildren())])
            end
            if getgenv().autofarm_settings.wild_mode == true or getgenv().autofarm_settings.panhandle_mode == true then
                coroutine.wrap(function()
                    task.wait(4)
                    if LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false then
                        print("FailSafe Activated")
                        repeat task.wait()
                            if LocalPlayer.PlayerGui.MainGui.Menu.Visible == true then
                                LocalPlayer.PlayerGui.MainGui.Menu.Visible = false
                            else
                                print("FailSafe Activated: restarting battle because something broke")
                                if CurrentRoute.Name == "007_Lakewood" then
                                    Client.Network:post("RequestWild", CurrentRoute.Name, "Lake")
                                elseif CurrentRoute.Name == "011_Sewer" then
                                    Client.Network:post("RequestWild", "011_RealSewer", "Sewer")
                                else
                                    Client.Network:post("RequestWild", CurrentRoute.Name, "WildGrass")
                                end
                            end
                        until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == true
                    end
                end)()
            end
        end
        repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == true and string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will")
        if getgenv().autofarm_settings.wild_mode == true then
            if Client.Battle.CurrentData.EnemyDoodle.Shiny == true and getgenv().autofarm_settings.pause_when_shiny == true or Client.Battle.CurrentData.EnemyDoodle.Shiny == true and getgenv().autofarm_settings.catch_when_shiny == true or Client.Battle.CurrentData.EnemyDoodle.Shiny == true and getgenv().autofarm_settings.kill_when_shiny == true then
                print("found shiny/misprint doodle")
                notify("AutoFarm Found:", "Shiny/Misprint Doodle")
                if getgenv().autofarm_settings.sound_alerts == true then
                    local Sound = Instance.new("Sound")
                    Sound.Volume = 5
                    Sound.SoundId = getcustomassetfunc("SHINY_SOUND.mp3")
                    Sound.Parent = workspace
                    Sound:Play()
                    repeat task.wait() until Sound.Playing == false
                    Sound:Destroy()
                end
                if getgenv().autofarm_settings.kill_when_shiny == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_when_shiny == true then
                    catch()
                end
            elseif Client.Battle.CurrentData.EnemyDoodle.Skin ~= 0 and getgenv().autofarm_settings.pause_when_skin == true or Client.Battle.CurrentData.EnemyDoodle.Skin ~= 0 and getgenv().autofarm_settings.catch_when_skin == true or Client.Battle.CurrentData.EnemyDoodle.Skin ~= 0 and getgenv().autofarm_settings.kill_when_skin == true then
                print("found skin")
                notify("AutoFarm Found:", "Skin")
                if getgenv().autofarm_settings.sound_alerts == true then
                    local Sound = Instance.new("Sound")
                    Sound.Volume = 5
                    Sound.SoundId = getcustomassetfunc("NANI.mp3")
                    Sound.Parent = workspace
                    Sound:Play()
                    repeat task.wait() until Sound.Playing == false
                    Sound:Destroy()
                end
                if getgenv().autofarm_settings.kill_when_skin == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_when_skin == true then
                    catch()
                end
            elseif Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.pause_when_tint == true or Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.catch_when_tint == true or Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.kill_when_tint == true then
                print("found tint")
                notify("AutoFarm Found:", "Tint")
                if getgenv().autofarm_settings.kill_when_tint == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_when_tint == true then
                    catch()
                end
            elseif Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == false and getgenv().autofarm_settings.pause_when_havent_caught_before == true or Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == false and getgenv().autofarm_settings.catch_when_havent_caught_before == true or Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == false and getgenv().autofarm_settings.kill_when_havent_caught_before == true then
                print("found doodle that hasnt been caught before")
                notify("AutoFarm Found:", "Doodle that hasn't been caught before")
                if getgenv().autofarm_settings.kill_when_havent_caught_before == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_when_havent_caught_before == true then
                    catch()
                end
            elseif table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.pause_when_specific_doodle == true or table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.catch_when_specific_doodle == true or table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.kill_when_specific_doodle == true then
                print("found specific doodle")
                notify("AutoFarm Found:", "Specific Doodle")
                if getgenv().autofarm_settings.kill_when_specific_doodle == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_when_specific_doodle == true then
                    catch()
                end
            else
                if getgenv().autofarm_settings.kill_all == true or getgenv().autofarm_settings.kill_when_normal_doodle == true then
                    kill()
                elseif getgenv().autofarm_settings.catch_all == true then
                    catch()
                elseif getgenv().autofarm_settings.pause_all == true or getgenv().autofarm_settings.pause_when_normal_doodle == true then

                else
                    run()
                end
            end
        elseif getgenv().autofarm_settings.panhandle_mode == true then
            print("starting panhandle sequence")
            panhandle()
        elseif getgenv().autofarm_settings.trainer_mode == true then
            for i = 1, #Client.Battle.CurrentData.Player2Party do
                print("killing doodle "..i)
                kill()
                if i ~= #Client.Battle.CurrentData.Player2Party then
                    repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will" and LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Visible == true
                end
            end
        end
        print("waiting till battle gui gone")
        repeat
            task.wait()
            if LocalPlayer.PlayerGui.MainGui.Menu.Visible == true then
                LocalPlayer.PlayerGui.MainGui.Menu.Visible = false
            end
        until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false and LocalPlayer.PlayerGui.MainGui.MenuButton.Visible == true
    end
    FirstEncounter = false
    InABattle = false
end)

--// UNINJECT
UninjectConnection = UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Comma then
        notify("AutoFarm", "Uninjecting...")
        getgenv().executed = false
        notify("AutoFarm", "Uninjected") 
        AutoFarmConnection:Disconnect()  
        local function isNumeric(value)
            if value == tostring(tonumber(value)) then
                return true
            else
                return false
            end
        end
        for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if isNumeric(v.Name) then
                v:Destroy()
            end
        end
        getgenv().autofarm_settings.enabled = false
        UninjectConnection:Disconnect()
    end
end)
