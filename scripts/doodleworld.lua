local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Client = require(LocalPlayer.Packer.Client)
local Skins = require(LocalPlayer.Packer.Database.Skins).Sprites
local Tints = require(LocalPlayer.Packer.Database.MiscDB).Tints
local getasset = syn and getsynasset or getcustomasset
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local setthreadidentityfunc = syn and syn.set_thread_identity or setthreadcontext or set_thread_context or setthreadidentity or set_thread_identity or context_set or syn_context_set or nil
local websocketfunc = syn and syn.websocket.connect or Krnl and Krnl.WebSocket.connect or WebSocket and WebSocket.connect or websocket and websocket.connect or nil
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
    StarterGui:SetCore("SendNotification", {
        Title = "Already Executed",
        Text = "Uninject first by pressing comma!",
        Duration = 3,
    })
    return
end
getgenv().executed = true

if type(getgenv().autofarm_settings) ~= "table" then getgenv().autofarm_settings = {} end

local function notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3,
    })
end
local function validatesettings()
    if type(getgenv().autofarm_settings.panhandle_mode) ~= "boolean" or type(getgenv().autofarm_settings.wild_mode) ~= "boolean" or type(getgenv().autofarm_settings.trainer_mode) ~= "boolean" then
        notify("Invalid Autofarm Mode Settings", "Setting hasn't been set")
        return false
    end
    if getgenv().autofarm_settings.webhooks == true and type(getgenv().autofarm_settings.webhook_url) ~= "string" then
        notify("Invalid Webhook URL", "Setting hasn't been set")
        return false
    end
    if getgenv().autofarm_settings.remote_control == true and type(getgenv().autofarm_settings.discord_ID) ~= "string" then
        notify("Invalid Discord ID", "Setting hasn't been set")
        return false
    end
    if type(getgenv().autofarm_settings.discord_ID) == "string" and string.find(getgenv().autofarm_settings.discord_ID, "#") then
        notify("Put your discord ID not username", "Invalid")
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
        if type(getgenv().autofarm_settings.blacklist_doodles) ~= "table" then
            notify("Invalid Blacklist Doodle Table", "get the new script")
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

local function format(num, digits)
    return string.format("%0" .. digits .. "i", num)
end

local function ParseDateTime()
    local osDate = os.date("!*t")
    local year, mon, day = osDate["year"], osDate["month"], osDate["day"]
    local hour, min, sec = osDate["hour"], osDate["min"], osDate["sec"]
    return year .. "-" .. format(mon, 2) .. "-" .. format(day, 2) .. "T" .. format(hour, 2) .. ":" .. format(min, 2) .. ":" .. format(sec, 2) .. "Z"
end

local function AssetIdToThumbnail(assetid)
    local req = HttpService:JSONDecode(requestfunc({
        Url = "https://thumbnails.roblox.com/v1/assets?assetIds="..assetid.."&size=700x700&format=Png&isCircular=false",
        Method = "GET"
    }).Body)
    return req.data[1].imageUrl
end

local function wildbattlewebhook(battletime, action)
    local NumberToTuples = {
        [1] = "",
        [2] = "Double ",
        [3] = "Triple ",
        [4] = "Quadruple ",
        [5] = "Quintuple ",
        [6] = "Sextuple ",
        [7] = "Septuple ",
        [8] = "Octuple ",
        [9] = "Nonuple ",
        [10] = "Decuple ",
        [11] = "Undecuple ",
        [12] = "Duodecuple ",
        [13] = "Tredecuple ",
        [14] = "Quattuordecuple " -- the max number of tints 
    }
    local ChecksTable = {
        Misprint = Client.Battle.CurrentData.EnemyDoodle.Shiny == true and "Misprint " or "",
        Skin = Client.Battle.CurrentData.EnemyDoodle.Skin ~= 0 and "Skin " or "",
        HiddenTrait = Client.Battle.CurrentData.EnemyDoodle.Ability == Client.Battle.CurrentData.EnemyDoodle.Info.HiddenAbility and "Hidden Trait " or "",
        Tint = Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and NumberToTuples[#Client.Battle.CurrentData.EnemyDoodle.Tint].."Tint " or "",
        NotAlreadyCaught = Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == nil and "Not AlreadyCaught " or "",
        SpecificDoodle = table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and "Specific Doodle " or ""
    }
    local fields = {
        {
          ["name"] = "⭐STARS⭐",
          ["value"] = "`"..tostring(Client.Battle.CurrentData.EnemyDoodle.Star).."`"
        }
      }
    if action ~= "Paused" then
        table.insert(fields, {
            ["name"] = "⌛BATTLE TIME⌛",
            ["value"] = "`"..math.round(tick()-battletime).."s`"
        })
    end
    if Client.Battle.CurrentData.EnemyDoodle.Skin ~= 0 then
        table.insert(fields, {
            ["name"] = "SKIN",
            ["value"] = "`"..Skins[Client.Battle.CurrentData.EnemyDoodle.RealName][Client.Battle.CurrentData.EnemyDoodle.Skin].Name.."`"
        })
    end
    if Client.Battle.CurrentData.EnemyDoodle.Ability == Client.Battle.CurrentData.EnemyDoodle.Info.HiddenAbility then
        table.insert(fields, {
            ["name"] = "HIDDEN TRAIT",
            ["value"] = "`"..Client.Battle.CurrentData.EnemyDoodle.Info.HiddenAbility.."`"
        })
    end
    if Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 then
        for i,v in pairs(Client.Battle.CurrentData.EnemyDoodle.Tint) do
            table.insert(fields, {
                ["name"] = "TINT "..i,
                ["value"] = "`"..Tints[Client.Battle.CurrentData.EnemyDoodle.Tint[i]].Name.."`"
            })
        end
    end
    if Client.Network:get("PlayerData", "GetChain", false).Name ~= nil then
        table.insert(fields, {
            ["name"] = "⛓️CHAIN⛓️",
            ["value"] = "`"..Client.Network:get("PlayerData", "GetChain", false).Name..": "..Client.Network:get("PlayerData", "GetChain", false).Number.."`"
        })
    end
    table.insert(fields, {
        ["name"] = "ACTION",
        ["value"] = "`"..action.."`"
    })
    requestfunc({
        Url = getgenv().autofarm_settings.webhook_url,
        Body = game:GetService("HttpService"):JSONEncode({
            ["content"] = action == "Paused" and getgenv().autofarm_settings.remote_control == false and "@everyone " or action == "Paused" and getgenv().autofarm_settings.remote_control == true and "@everyone DM <@966088801904631858> a choice: use ;kill or ;catch or ;run" or "",
            ["embeds"] = {
                {
                  ["type"] = "rich",
                  ["title"] = "Doodoo World AutoFarm",
                  ["description"] = "```"..ChecksTable["Misprint"]..ChecksTable["HiddenTrait"]..ChecksTable["Skin"]..ChecksTable["Tint"]..ChecksTable["NotAlreadyCaught"]..ChecksTable["SpecificDoodle"]..Client.Battle.CurrentData.EnemyDoodle.RealName.."```",
                  ["color"] = tonumber(0xe90e0e),
                  ["fields"] = fields,
                  ["timestamp"] = ParseDateTime(),
                  ["image"] = {
                    ["url"] = AssetIdToThumbnail(string.split(LocalPlayer.PlayerGui.MainGui.MainBattle.DoodleFront.NewSprite.Image, "=")[2]),
                    ["height"] = 0,
                    ["width"] = 0
                  },
                  ["footer"] = {
                    ["text"] = "Made By SPELLING#4664"
                  },
                  ["url"] = "https://discord.gg/spelling"
                }
            }
        }),
        Method = "POST",
        Headers = {["content-type"] = "application/json"}
    })
end

local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

local function getcustomassetfunc(path)
    if not betterisfile(path) then
        local req = requestfunc({
            Url = "https://spelling.wtf/scripts/assets/"..path,
            Method = "GET"
        })
        writefile(path, req.Body)
        repeat task.wait() until betterisfile(path)
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

local function updateUIThing(type, name, value)
    if type == "Toggle" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("TextButton")) and v.Name == "toggleElement" and v.togName.Text == name then
                if value == true and v.toggleEnabled.ImageTransparency == 1 then
                    getconnections(v.MouseEnter)[1]:Fire()
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    getconnections(v.MouseLeave)[1]:Fire()
                elseif value == false and v.toggleEnabled.ImageTransparency == 0 then
                    getconnections(v.MouseEnter)[1]:Fire()
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    getconnections(v.MouseLeave)[1]:Fire()
                end
                return v
            end
        end
    elseif type == "Slider" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("TextButton")) and v.Name == "sliderElement" and v.togName.Text == name then
                v.val.Text = value
                v.sliderBtn.sliderDrag.Visible = true
                v.sliderBtn.sliderDrag.Size = UDim2.new(0, tonumber(value)*2.8, 0, 6)
                return v
            end
        end
    elseif type == "Dropdown" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("Frame")) and v.Name == "dropFrame" and v.dropOpen.itemTextbox.Text == name then
                v.dropOpen.itemTextbox.Text = value
                return v
            end
        end
    end
end

local function checkUIExistence(type, name)
    if type == "Toggle" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("TextButton")) and v.Name == "toggleElement" and v.togName.Text == name then
                return true
            end
        end
        return false
    elseif type == "Slider" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("TextButton")) and v.Name == "sliderElement" and v.togName.Text == name then
                return true
            end
        end
        return false
    elseif type == "Dropdown" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("Frame")) and v.Name == "dropFrame" and v.dropOpen.itemTextbox.Text == name then
                return true
            end
        end
        return false
    elseif type == "TextBox" then
        for i,v in pairs(UI:GetDescendants()) do
            if (v:IsA("TextButton")) and v.Name == "textboxElement" and v.togName.Text == name then
                return true
            end
        end
        return false
    end
end

local Window = Library.CreateLib("Doodoo World AutoFarm", "DarkTheme")
for i,v in pairs(CoreGui:GetChildren()) do
    if v.Name == tostring(tonumber(v.Name)) then
        UI = v
    end
end
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")
local WarningLabel = MainSection:NewLabel("Don't forget to set your settings before enabling\n  (everything is off by default)")
local WarningLabel2 = MainSection:NewLabel("Theres a serversided 4 second cooldown in between\n  wild battles")

local AutoFarmingSince = MainSection:NewLabel("AutoFarming Since: 0 hours 0 minutes 0 seconds")

local Enabled = MainSection:NewToggle("Enabled", "Enable/Disable the AutoFarm", function(state)
    print("toggled")
    local validsettings = validatesettings()

    if validsettings == true then
        if state == true then
            getgenv().autofarm_settings.enabled = true
            local Seconds = 0
            local Minutes = 0
            local Hours = 0
            while getgenv().autofarm_settings.enabled == true do
                Seconds = Seconds + 1
                if Seconds == 60 then
                    Seconds = 0
                    Minutes = Minutes + 1
                end
                if Minutes == 60 then
                    Minutes = 0
                    Hours = Hours + 1
                end
                AutoFarmingSince:UpdateLabel("AutoFarming Since: "..Hours.." hours "..Minutes.." minutes "..Seconds.." seconds")
                wait(1)
            end
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
SupportSection:NewButton("Click to join discord server", "joins the discord server when u click", function()
    task.spawn(function()
        for i = 1, 14 do
            spawn(function()
                local reqbody = {
                    ["nonce"] = HttpService:GenerateGUID(false),
                    ["args"] = {
                        ["invite"] = {["code"] = "spelling"},
                        ["code"] = "spelling",
                    },
                    ["cmd"] = "INVITE_BROWSER"
                }
                local newreq = HttpService:JSONEncode(reqbody)
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
local WarningLabel2 = SupportSection:NewLabel("Discord Server:\n  discord.gg/spelling")
local SettingsTab = Window:NewTab("AutoFarm Settings")
local MainSettings = SettingsTab:NewSection("Main")

MainSettings:NewButton("Save Settings", "", function()
    writefile("DoodleWorldAutoFarmSettings.json", HttpService:JSONEncode(getgenv().autofarm_settings))
    print("Saved AutoFarm Settings: ")
    for i,v in pairs(getgenv().autofarm_settings) do
        print("    "..i, v)
        if typeof(v) == "table" then
            for i2, v2 in pairs(v) do
                print("        "..i2, v2)
            end
        end
    end
    repeat task.wait() until betterisfile("DoodleWorldAutoFarmSettings.json")
    notify("Save Settings", "Success")
end)

local Misc = SettingsTab:NewSection("Misc")
Misc:NewToggle("AutoHeal", "Automatically heal before battles start", function(state)
    if state == true then
        getgenv().autofarm_settings.autoheal = true
    elseif state == false then
        getgenv().autofarm_settings.autoheal = false
    end
end)
Misc:NewToggle("Webhooks", "enables webhooks", function(state)
    if state == true then
        getgenv().autofarm_settings.webhooks = true
        if checkUIExistence("TextBox", "Webhook URL") == false then
            Misc:NewTextBox("Webhook URL", "set the webhook URL", function(url)
                getgenv().autofarm_settings.webhook_url = url
                notify("Webhook", "Webhook URL Set")
            end)
        end
        if checkUIExistence("Toggle", "Remote Control") == false then
            Misc:NewToggle("Remote Control", "remote control discord bot", function(state)
                getgenv().autofarm_settings.remote_control = state
                if checkUIExistence("TextBox", "Discord ID") == false then
                    Misc:NewTextBox("Discord ID", "put your discord ID", function(ID)
                        getgenv().autofarm_settings.discord_ID = ID
                    end)
                end
            end)
        end
    elseif state == false then
        getgenv().autofarm_settings.webhooks = false
    end
end)
local Capsules = {}
local CapsuleSelection

MainSettings:NewButton("Load Settings", "", function()
    if betterisfile("DoodleWorldAutoFarmSettings.json") then
        local SettingsFile = readfile("DoodleWorldAutoFarmSettings.json")
        local SpecificDoodleTable
        local BlacklistTable
        if type(getgenv().autofarm_settings.specific_doodles) == "table" then
            SpecificDoodleTable = getgenv().autofarm_settings.specific_doodles
        end
        if type(getgenv().autofarm_settings.blacklist_doodles) == "table" then
            BlacklistTable = getgenv().autofarm_settings.blacklist_doodles
        end
        getgenv().autofarm_settings = HttpService:JSONDecode(SettingsFile)
        if SpecificDoodleTable ~= nil then getgenv().autofarm_settings.specific_doodles = SpecificDoodleTable end
        if BlacklistTable ~= nil then getgenv().autofarm_settings.blacklist_doodles = BlacklistTable end
        print("Loaded AutoFarm Settings: ")
        for i,v in pairs(getgenv().autofarm_settings) do
            print("    "..i, v)
            if typeof(v) == "table" then
                for i2, v2 in pairs(v) do
                    print("        "..i2, v2)
                end
            end
        end
        notify("Load Settings", "Success")
        local validsettings = validatesettings()
        if validsettings == true then
            removeNonUniversalSettings()
            if getgenv().autofarm_settings.wild_mode == true then
                local NormalDoodles = SettingsTab:NewSection("Normal Doodles\n(doodles that didnt pass any of the checks)")
                NormalDoodles:NewDropdown("Normal Doodle Mode", "", {"Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.kill_when_normal_doodle == false and getgenv().autofarm_settings.kill_when_normal_doodle == true then
                    updateUIThing("Dropdown", "Normal Doodle Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_normal_doodle == false and getgenv().autofarm_settings.kill_when_normal_doodle == false then
                    updateUIThing("Dropdown", "Normal Doodle Mode", "Run")
                elseif getgenv().autofarm_settings.kill_when_normal_doodle == false and getgenv().autofarm_settings.pause_when_normal_doodle == true then
                    updateUIThing("Dropdown", "Normal Doodle Mode", "Pause")
                end
                local Shiny = SettingsTab:NewSection("Shiny/Misprint")
                Shiny:NewDropdown("Shiny/Misprint Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.pause_when_shiny == false and getgenv().autofarm_settings.kill_when_shiny == false and getgenv().autofarm_settings.catch_when_shiny == true then
                    updateUIThing("Dropdown", "Shiny/Misprint Mode", "Catch")
                elseif getgenv().autofarm_settings.pause_when_shiny == false and getgenv().autofarm_settings.catch_when_shiny == false and getgenv().autofarm_settings.kill_when_shiny == true then
                    updateUIThing("Dropdown", "Shiny/Misprint Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_shiny == false and getgenv().autofarm_settings.catch_when_shiny == false and getgenv().autofarm_settings.kill_when_shiny == false then
                    updateUIThing("Dropdown", "Shiny/Misprint Mode", "Run")
                elseif getgenv().autofarm_settings.pause_when_shiny == true and getgenv().autofarm_settings.catch_when_shiny == false and getgenv().autofarm_settings.kill_when_shiny == false then
                    updateUIThing("Dropdown", "Shiny/Misprint Mode", "Pause")
                end
                local Skin = SettingsTab:NewSection("Skin")
                Skin:NewDropdown("Skin Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.pause_when_skin == false and getgenv().autofarm_settings.kill_when_skin == false and getgenv().autofarm_settings.catch_when_skin == true then
                    updateUIThing("Dropdown", "Skin Mode", "Catch")
                elseif getgenv().autofarm_settings.pause_when_skin == false and getgenv().autofarm_settings.catch_when_skin == false and getgenv().autofarm_settings.kill_when_skin == true then
                    updateUIThing("Dropdown", "Skin Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_skin == false and getgenv().autofarm_settings.catch_when_skin == false and getgenv().autofarm_settings.kill_when_skin == false then
                    updateUIThing("Dropdown", "Skin Mode", "Run")
                elseif getgenv().autofarm_settings.pause_when_skin == true and getgenv().autofarm_settings.catch_when_skin == false and getgenv().autofarm_settings.kill_when_skin == false then
                    updateUIThing("Dropdown", "Skin Mode", "Pause")
                end
                local Tint = SettingsTab:NewSection("Tint")
                Tint:NewDropdown("Tint Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.pause_when_tint == false and getgenv().autofarm_settings.kill_when_tint == false and getgenv().autofarm_settings.catch_when_tint == true then
                    updateUIThing("Dropdown", "Tint Mode", "Catch")
                elseif getgenv().autofarm_settings.pause_when_tint == false and getgenv().autofarm_settings.catch_when_tint == false and getgenv().autofarm_settings.kill_when_tint == true then
                    updateUIThing("Dropdown", "Tint Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_tint == false and getgenv().autofarm_settings.catch_when_tint == false and getgenv().autofarm_settings.kill_when_tint == false then
                    updateUIThing("Dropdown", "Tint Mode", "Run")
                elseif getgenv().autofarm_settings.pause_when_tint == true and getgenv().autofarm_settings.catch_when_tint == false and getgenv().autofarm_settings.kill_when_tint == false then
                    updateUIThing("Dropdown", "Tint Mode", "Pause")
                end
                local DoodlesThatHaventBeenCaughtBefore = SettingsTab:NewSection("Doodles that haven't been caught before")
                DoodlesThatHaventBeenCaughtBefore:NewDropdown("Not AlreadyCaught Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.pause_when_havent_caught_before == false and getgenv().autofarm_settings.kill_when_havent_caught_before == false and getgenv().autofarm_settings.catch_when_havent_caught_before == true then
                    updateUIThing("Dropdown", "Not AlreadyCaught Mode", "Catch")
                elseif getgenv().autofarm_settings.pause_when_havent_caught_before == false and getgenv().autofarm_settings.catch_when_havent_caught_before == false and getgenv().autofarm_settings.kill_when_havent_caught_before == true then
                    updateUIThing("Dropdown", "Not AlreadyCaught Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_havent_caught_before == false and getgenv().autofarm_settings.catch_when_havent_caught_before == false and getgenv().autofarm_settings.kill_when_havent_caught_before == false then
                    updateUIThing("Dropdown", "Not AlreadyCaught Mode", "Run")
                elseif getgenv().autofarm_settings.pause_when_havent_caught_before == true and getgenv().autofarm_settings.catch_when_havent_caught_before == false and getgenv().autofarm_settings.kill_when_havent_caught_before == false then
                    updateUIThing("Dropdown", "Not AlreadyCaught Mode", "Pause")
                end
                local SpecificDoodles = SettingsTab:NewSection("Specific Doodle")
                SpecificDoodles:NewDropdown("Specific Doodle Mode", "", {"Catch", "Kill", "Run", "Pause"}, function(mode)
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
                if getgenv().autofarm_settings.pause_when_specific_doodle == false and getgenv().autofarm_settings.kill_when_specific_doodle == false and getgenv().autofarm_settings.catch_when_specific_doodle == true then
                    updateUIThing("Dropdown", "Specific Doodle Mode", "Catch")
                elseif getgenv().autofarm_settings.pause_when_specific_doodle == false and getgenv().autofarm_settings.catch_when_specific_doodle == false and getgenv().autofarm_settings.kill_when_specific_doodle == true then
                    updateUIThing("Dropdown", "Specific Doodle Mode", "Kill")
                elseif getgenv().autofarm_settings.pause_when_specific_doodle == false and getgenv().autofarm_settings.catch_when_specific_doodle == false and getgenv().autofarm_settings.kill_when_specific_doodle == false then
                    updateUIThing("Dropdown", "Specific Doodle Mode", "Run")
                elseif getgenv().autofarm_settings.pause_when_specific_doodle == true and getgenv().autofarm_settings.catch_when_specific_doodle == false and getgenv().autofarm_settings.kill_when_specific_doodle == false then
                    updateUIThing("Dropdown", "Specific Doodle Mode", "Pause")
                end
                local AutoCatch = SettingsTab:NewSection("Catch Mode")
                Capsules = {}
                for i,v in pairs(Client.Network:get("PlayerData", "GetItems")["Capsules"]) do
                    table.insert(Capsules, i)
                end
                CapsuleSelection = AutoCatch:NewDropdown("Capsule", "choose your capsule", Capsules, function(capsule)
                    getgenv().autofarm_settings.autocatch_capsule = capsule
                end)
                updateUIThing("Dropdown", "Capsule", getgenv().autofarm_settings.autocatch_capsule)
                AutoCatch:NewToggle("Use Glancing Blow", "", function(state)
                    if state == true then
                        getgenv().autofarm_settings.autocatch_use_glancing_blow = true
                    elseif state == false then
                        getgenv().autofarm_settings.autocatch_use_glancing_blow = false
                    end
                end)
                updateUIThing("Toggle", "Use Glancing Blow", getgenv().autofarm_settings.autocatch_use_glancing_blow)
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
                if getgenv().autofarm_settings.autokill_use_strongest_move == true then
                    updateUIThing("Dropdown", "Which move to use", "Strongest Move")
                elseif getgenv().autofarm_settings.autokill_use_strongest_move == false then
                    updateUIThing("Dropdown", "Which move to use", "Custom Move")
                    updateUIThing("Dropdown", "Custom Move Choice", getgenv().autofarm_settings.autokill_custom_move)
                end
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
                if getgenv().autofarm_settings.pause_all == false and getgenv().autofarm_settings.kill_all == false and getgenv().autofarm_settings.catch_all == true then
                    updateUIThing("Dropdown", "Mode (Optional Setting)", "Catch")
                elseif getgenv().autofarm_settings.pause_all == false and getgenv().autofarm_settings.catch_all == false and getgenv().autofarm_settings.kill_all == true then
                    updateUIThing("Dropdown", "Mode (Optional Setting)", "Kill")
                elseif getgenv().autofarm_settings.pause_all == false and getgenv().autofarm_settings.catch_all == false and getgenv().autofarm_settings.kill_all == false then
                    updateUIThing("Dropdown", "Mode (Optional Setting)", "Mode (Optional Setting)")
                elseif getgenv().autofarm_settings.pause_all == true and getgenv().autofarm_settings.catch_all == false and getgenv().autofarm_settings.kill_all == false then
                    updateUIThing("Dropdown", "Mode (Optional Setting)", "Pause")
                end
                Misc:NewToggle("Sound Alerts", "", function(state)
                    if state == true then
                        getgenv().autofarm_settings.sound_alerts = true
                    elseif state == false then
                        getgenv().autofarm_settings.sound_alerts = false
                    end
                end)
                updateUIThing("Toggle", "Sound Alerts", getgenv().autofarm_settings.sound_alerts)
                updateUIThing("Toggle", "AutoHeal", getgenv().autofarm_settings.autoheal)
                updateUIThing("Toggle", "Webhooks", getgenv().autofarm_settings.webhooks)
                if getgenv().autofarm_settings.webhooks == true then
                    if checkUIExistence("TextBox", "Webhook URL") == false then
                        Misc:NewTextBox("Webhook URL", "set the webhook URL", function(url)
                            getgenv().autofarm_settings.webhook_url = url
                        end)
                    end
                    if checkUIExistence("Toggle", "Remote Control") == false then
                        Misc:NewToggle("Remote Control", "remote control discord bot", function(state)
                            getgenv().autofarm_settings.remote_control = state
                        end)
                    end
                    if getgenv().autofarm_settings.remote_control == true then
                        updateUIThing("Toggle", "Remote Control", true)
                        if checkUIExistence("TextBox", "Discord ID") == false then
                            Misc:NewTextBox("Discord ID", "put your discord ID", function(ID)
                                getgenv().autofarm_settings.discord_ID = ID
                            end)
                        end
                    else
                        updateUIThing("Toggle", "Remote Control", false)
                    end
                end
                updateUIThing("Dropdown", "AutoFarm Mode", "Wild Battle")
            elseif getgenv().autofarm_settings.trainer_mode == true then
                getgenv().autofarm_settings.trainer_ID = 39
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
                if getgenv().autofarm_settings.autokill_use_strongest_move == true then
                    updateUIThing("Dropdown", "Which move to use", "Strongest Move")
                elseif getgenv().autofarm_settings.autokill_use_strongest_move == false then
                    updateUIThing("Dropdown", "Which move to use", "Custom Move")
                    updateUIThing("Dropdown", "Custom Move Choice", getgenv().autofarm_settings.autokill_custom_move)
                end
                updateUIThing("Toggle", "AutoHeal", getgenv().autofarm_settings.autoheal)
                updateUIThing("Dropdown", "AutoFarm Mode", "Trainer Farm")
                updateUIThing("Toggle", "Webhooks", getgenv().autofarm_settings.webhooks)
                if getgenv().autofarm_settings.webhooks == true then
                    Misc:NewTextBox("Webhook URL", "set the webhook URL", function(url)
                        getgenv().autofarm_settings.webhook_url = url
                    end)
                    Misc:NewToggle("Remote Control", "remote control discord bot", function(state)
                        getgenv().autofarm_settings.remote_control = state
                    end)
                    if getgenv().autofarm_settings.remote_control == true then
                        updateUIThing("Toggle", "Remote Control", true)
                        Misc:NewTextBox("Discord ID", "put your discord ID", function(ID)
                            getgenv().autofarm_settings.discord_ID = ID
                        end)
                    else
                        updateUIThing("Toggle", "Remote Control", false)
                    end
                end
            elseif getgenv().autofarm_settings.panhandle_mode == true then
                updateUIThing("Toggle", "AutoHeal", getgenv().autofarm_settings.autoheal)
                updateUIThing("Dropdown", "AutoFarm Mode", "Panhandle Money Farm")
                updateUIThing("Toggle", "Webhooks", getgenv().autofarm_settings.webhooks)
                if getgenv().autofarm_settings.webhooks == true then
                    Misc:NewTextBox("Webhook URL", "set the webhook URL", function(url)
                        getgenv().autofarm_settings.webhook_url = url
                    end)
                end
            end
        end
    else
        notify("Load Settings", "Settings Not Found")
    end
end)

local TeleportTab = Window:NewTab("Teleports")
local MainTeleportTabSection = TeleportTab:NewSection("Teleport")
MainTeleportTabSection:NewDropdown("Teleport to Location", "Teleports to chosen location", {"The Crossroads", "Graphite Lodge", "Route 4", "Lakewood Sewer", "Route 3", "Lakewood Town", "Route 2", "Route 1", "Sketchvale"}, function(location)
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
    if setthreadidentityfunc ~= nil then
        setthreadidentityfunc(2)
        Client.DataManager.Chunk.new(Client, LocationsTable[location], "Entrance", nil, nil)
        setthreadidentityfunc(7)
    else
        notify("no set thread identity", "npcs and doors will be glitched")
        pcall(function()
            Client.DataManager.Chunk.new(Client, LocationsTable[location], "Entrance", true, true)
        end)
        task.wait(0.6)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end
end)


MainSettings:NewDropdown("AutoFarm Mode", "Choose the AutoFarm Mode", {"Wild Battle", "Panhandle Money Farm", "Trainer Farm"}, function(state)
    if state == "Wild Battle" then
        if getgenv().autofarm_settings.enabled == true then
            getgenv().autofarm_settings.enabled = false
            notify("AutoFarm", "Disabled")
            updateUIThing("Toggle", "Enabled", false)
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
        Capsules = {}
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
            updateUIThing("Toggle", "Enabled", false)
        end
        getgenv().autofarm_settings.trainer_mode = false
        getgenv().autofarm_settings.wild_mode = false
        getgenv().autofarm_settings.panhandle_mode = true
        removeNonUniversalSettings()
    elseif state == "Trainer Farm" then
        if getgenv().autofarm_settings.enabled == true then
            getgenv().autofarm_settings.enabled = false
            notify("AutoFarm", "Disabled")
            updateUIThing("Toggle", "Enabled", false)
        end
        getgenv().autofarm_settings.wild_mode = false
        getgenv().autofarm_settings.panhandle_mode = false
        getgenv().autofarm_settings.trainer_mode = true
        removeNonUniversalSettings()
        getgenv().autofarm_settings.trainer_ID = 39
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
local FreeMagnifyingGlass = MainMiscSection:NewButton("Free Magnifying Glass", "gets magnifying glass free", function()
    if LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.MagnifyingGlass.Visible == false then
        LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.MagnifyingGlass.Visible = true
    end
    LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.MagnifyingGlass:GetPropertyChangedSignal("Visible"):Connect(function()
        if LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.MagnifyingGlass.Visible == false then
            LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.MagnifyingGlass.Visible = true
        end
    end)
end)
local RainbowName = MainMiscSection:NewButton("Rainbow Name", "makes your name rainbow", function()
    while task.wait() do
        for i = 1, 9 do
            Client.Network:get("ChangeNameColor", i)
            if i == 9 then
                Client.Network:get("ChangeNameColor", 68)
            end
        end
    end
end)

local OpenSection = MiscTab:NewSection("Open UIs")
local OpenShop = OpenSection:NewButton("Open Shop", "Opens the shop GUI", function()
    Client.NormalShop.new()
    repeat task.wait() until LocalPlayer.Character.Humanoid.WalkSpeed == 0
    LocalPlayer.Character.Humanoid.WalkSpeed = 16
    Client.Controls:ToggleWalk(true)
end)
local OpenPC = OpenSection:NewButton("Open PC", "Opens the PC GUI", function()
    Client.PC.new()
    repeat task.wait() until LocalPlayer.Character.Humanoid.WalkSpeed == 0
    LocalPlayer.Character.Humanoid.WalkSpeed = 16
    Client.Controls:ToggleWalk(true)
end)
local OpenHelpCenter = OpenSection:NewButton("Open Help Center", "Opens the help center GUI", function()
    Client.HelpCenter.new({
        Location = "GraphiteLodge"
    })
    repeat task.wait() until LocalPlayer.Character.Humanoid.WalkSpeed == 0
    LocalPlayer.Character.Humanoid.WalkSpeed = 16
    Client.Controls:ToggleWalk(true)
end)


local GUISettings = Window:NewTab("GUI Settings")
local GUISettingsSection = GUISettings:NewSection("Settings")
local ToggleGUIConnection 
GUISettingsSection:NewTextBox("Toggle GUI Keybind", "", function(txt)

    local success, result = pcall(function()
        if Enum.KeyCode[txt] ~= nil then
            KeyBind = txt
        end
    end)

    if not success then
        local success2, result2 = pcall(function()
            if Enum.KeyCode[txt:upper()] ~= nil then
                KeyBind = txt:upper()
            end
        end)
        if not success2 then
            notify("Invalid Keybind", "")
        end
    end

    if ToggleGUIConnection ~= nil then ToggleGUIConnection:Disconnect() end
    ToggleGUIConnection = UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode[KeyBind] then
            Library:ToggleUI()
        end
    end)
end)

local DebugTab = Window:NewTab("Debug")
local DebugTabSection = DebugTab:NewSection("Main")
DebugTabSection:NewButton("Print Current Settings", "", function()
    print("AutoFarm Settings: ")
    for i,v in pairs(getgenv().autofarm_settings) do
        print("    "..i, v)
        if typeof(v) == "table" then
            for i2, v2 in pairs(v) do
                print("        "..i2, v2)
            end
        end
    end
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
                    wait(0.05)
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
            repeat
                task.wait()
                if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The opposing "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") then return end
            until LocalPlayer.PlayerGui.MainGui.PartyUI.Visible == true
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
                    repeat
                        task.wait()
                        if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The opposing "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") then return end
                    until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil
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

local function hashfunction(str)
    local shalib = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/shalib.lua"))()
    return shalib.sha512(tostring(str).."SelfReport")
end

local function pause()
    print("paused")
    if getgenv().autofarm_settings.remote_control == true and websocketfunc ~= nil then
        local PORT = 5000
        print("connecting to webhook")
        local WebSocket = websocketfunc("wss://doodle-world-websocket.glitch.me/"..PORT)
        print("connected to webhook")
        local foundmessage = false
        local websocketpreventdisconnect
        local websocketconnection;
        local function onmessage(Msg)
            local Message = HttpService:JSONDecode(Msg)
            if Message.discordID == hashfunction(getgenv().autofarm_settings.discord_ID) or hashfunction(getgenv().autofarm_settings.discord_ID) == Message.discordID then
                print("got message")
                foundmessage = true
                if Message.Action == "kill" then
                    websocketpreventdisconnect:Disconnect()
                    websocketconnection:Disconnect()
                    WebSocket:Close()
                    kill()
                    return
                elseif Message.Action == "catch" then
                    websocketpreventdisconnect:Disconnect()
                    WebSocket:Close()
                    websocketconnection:Disconnect()
                    catch()
                    return
                elseif Message.Action == "run" then
                    websocketpreventdisconnect:Disconnect()
                    WebSocket:Close()
                    websocketconnection:Disconnect()
                    run()
                    return
                end
            end
        end
        local function reconnect()
            if foundmessage == false then
                if websocketpreventdisconnect ~= nil then websocketpreventdisconnect:Disconnect() end
                if websocketconnection ~= nil then websocketconnection:Disconnect() end
                wait(0.1)
                print("reconnecting")
                WebSocket = websocketfunc("wss://doodle-world-websocket.glitch.me/"..PORT)
                print("reconnected")
                websocketpreventdisconnect = WebSocket.OnClose:Connect(reconnect)
                websocketconnection = WebSocket.OnMessage:Connect(function(Msg) onmessage(Msg) end)
            end
        end
        websocketpreventdisconnect = WebSocket.OnClose:Connect(reconnect)
        websocketconnection = WebSocket.OnMessage:Connect(function(Msg) onmessage(Msg) end)
        repeat task.wait() until foundmessage == true or string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "You won")
    elseif getgenv().autofarm_settings.remote_control == true and websocketfunc == nil then
        notify("Unsupported Exploit", "No Websockets")
    end
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
            Capsules = {}
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
                local RandomNPC
                repeat
                    RandomNPC = CurrentRoute.NPC:GetChildren()[math.random(1, #CurrentRoute.NPC:GetChildren())]
                until RandomNPC:FindFirstChild("Head")
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
                Client.Music:PlaySong("battlefield5")
                print("starting wild battle")
            elseif getgenv().autofarm_settings.trainer_mode == true then
                print("starting trainer battle")
                Client.Music:PlaySong("battlefield5")
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
        repeat task.wait() until type(Client.Battle.CurrentData) == "table"
        repeat task.wait() until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^What will") == "What will"
        if getgenv().autofarm_settings.wild_mode == true and not table.find(getgenv().autofarm_settings.blacklist_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) then
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
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_when_shiny == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_when_shiny == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
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
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_when_skin == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_when_skin == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
                end
            elseif Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.pause_when_tint == true or Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.catch_when_tint == true or Client.Battle.CurrentData.EnemyDoodle.Tint ~= 0 and getgenv().autofarm_settings.kill_when_tint == true then
                print("found tint")
                notify("AutoFarm Found:", "Tint")
                if getgenv().autofarm_settings.kill_when_tint == true then
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_when_tint == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_when_tint == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
                end
            elseif Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == nil and getgenv().autofarm_settings.pause_when_havent_caught_before == true or Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == nil and getgenv().autofarm_settings.catch_when_havent_caught_before == true or Client.Battle.CurrentData.EnemyDoodle.AlreadyCaught == nil and getgenv().autofarm_settings.kill_when_havent_caught_before == true then
                print("found doodle that hasnt been caught before")
                notify("AutoFarm Found:", "Doodle that hasn't been caught before")
                if getgenv().autofarm_settings.kill_when_havent_caught_before == true then
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_when_havent_caught_before == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_when_havent_caught_before == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
                end
            elseif table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.pause_when_specific_doodle == true or table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.catch_when_specific_doodle == true or table.find(getgenv().autofarm_settings.specific_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) and getgenv().autofarm_settings.kill_when_specific_doodle == true then
                print("found specific doodle")
                notify("AutoFarm Found:", "Specific Doodle")
                if getgenv().autofarm_settings.kill_when_specific_doodle == true then
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_when_specific_doodle == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_when_specific_doodle == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
                end
            else
                if getgenv().autofarm_settings.kill_all == true or getgenv().autofarm_settings.kill_when_normal_doodle == true then
                    local battletime = tick()
                    kill()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Killed") end
                elseif getgenv().autofarm_settings.catch_all == true then
                    local battletime = tick()
                    catch()
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(battletime, "Caught") end
                elseif getgenv().autofarm_settings.pause_all == true or getgenv().autofarm_settings.pause_when_normal_doodle == true then
                    if getgenv().autofarm_settings.webhooks == true then wildbattlewebhook(tick(), "Paused") end
                    pause()
                else
                    run()
                end
            end
        elseif getgenv().autofarm_settings.wild_mode == true and table.find(getgenv().autofarm_settings.blacklist_doodles, Client.Battle.CurrentData.EnemyDoodle.RealName) then
            run()
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
        Client.BattleEnd:Wait()
        --[[repeat
            task.wait()
            if LocalPlayer.PlayerGui.MainGui.Menu.Visible == true then
                LocalPlayer.PlayerGui.MainGui.Menu.Visible = false
            end
        until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false and LocalPlayer.PlayerGui.MainGui.MenuButton.Visible == true]]
    end
    FirstEncounter = false
    InABattle = false
end)

--// UNINJECT
UninjectConnection = UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Comma then
        getgenv().autofarm_settings.enabled = false
        notify("AutoFarm", "Uninjecting...")
        AutoFarmConnection:Disconnect()
        if ToggleGUIConnection ~= nil then
            ToggleGUIConnection:Disconnect()
        end
        for i,v in pairs(CoreGui:GetChildren()) do
            if v.Name == tostring(tonumber(v.Name)) then
                v:Destroy()
            end
        end
        getgenv().executed = false
        notify("AutoFarm", "Uninjected") 
        UninjectConnection:Disconnect()
    end
end)
