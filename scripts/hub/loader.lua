local GameIds = { --// PlaceId
    --// Skywars
    [8542275097] = {"Skywars", "skywars.lua"}, -- Solo
    [8592115909] = {"Skywars", "skywars.lua"}, -- Party (dou)
    [8768229691] = {"Skywars", "skywars.lua"}, -- Custom

}
local url = "https://fern.wtf/scripts/"
local hub = url .. "hub/"

local Library = loadstring(game:HttpGet(url .. "ui_lib.lua", true))():InitNew("")

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local FOLDERNAME = "Fern Hub"
local PREFIX = ".fern"
local CONFIGPATH = FOLDERNAME .. "/config" .. PREFIX

function sendNotification(message, debug)
    Library:SendNotification(debug and ("[DEBUG] "..message) or message, debug and Color3.fromRGB(6, 255, 118) or nil)
end

sendNotification("Loading...")

function saveConfig(t)
    writefile(CONFIGPATH, HttpService:JSONEncode(t))
end

function loadConfig()
    return HttpService:JSONDecode(readfile(CONFIGPATH))[tostring(game.PlaceId)]
end

if not isfolder(FOLDERNAME) then
    makefolder(FOLDERNAME)
end

if not isfile(CONFIGPATH) then
    writefile(CONFIGPATH, HttpService:JSONEncode({}))
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local UICorner_2 = Instance.new("UICorner")
local Back = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui.RobloxGui
ScreenGui.DisplayOrder = 9e9

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 1.000
Frame.ClipsDescendants = true
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 252, 0, 102)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BackgroundTransparency = 1.000
Frame_2.ClipsDescendants = true
Frame_2.Size = UDim2.new(1, 0, 0, 0)

Frame_3.Parent = Frame_2
Frame_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.Position = UDim2.new(0, 1, 0, 1)
Frame_3.Size = UDim2.new(0, 250, 0, 100)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Frame_3

TextLabel.Parent = Frame_3
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.ZIndex = 2
TextLabel.Font = Enum.Font.Code
TextLabel.Text = "Fern Hub"
TextLabel.TextColor3 = Color3.fromRGB(255, 85, 255)
TextLabel.TextSize = 20.000
TextLabel.TextStrokeTransparency = 0.000

ImageLabel.Parent = Frame_3
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Image = "rbxassetid://8704079728"
ImageLabel.ImageTransparency = 0.300

UICorner_2.CornerRadius = UDim.new(0, 4)
UICorner_2.Parent = ImageLabel

Back.Name = "Back"
Back.Parent = Frame_2
Back.AnchorPoint = Vector2.new(0.5, 0.5)
Back.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
Back.ClipsDescendants = true
Back.Position = UDim2.new(0.5, 0, 0.5, 0)
Back.Size = UDim2.new(1, 0, 1, 0)
Back.ZIndex = 0

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = Back


--// stuffs
TweenService:Create(Frame_2, TweenInfo.new(0.5), {Size = UDim2.new(1, 0, 1, 0)}):Play()
wait(2)

Frame_2.AnchorPoint = Vector2.new(0, 1)
Frame_2.Position = UDim2.new(0, 0, 1, 0)

Frame_3.AnchorPoint = Vector2.new(0, 1)
Frame_3.Position = UDim2.new(0, 1, 1, -1)

TweenService:Create(Frame_2, TweenInfo.new(0.5), {Size = UDim2.new(1, 0, 0, 0)}):Play()

if rawget(GameIds, game.PlaceId) then
    sendNotification("Loading " .. GameIds[game.PlaceId][1] .. " 🧢")
    task.spawn(function()loadstring(game:HttpGet(hub .. GameIds[game.PlaceId][2], true))()end)
    sendNotification("Loaded")
else
    sendNotification("no universal script rn :(")
    task.spawn(function()
        wait(6)
        game.CoreGui.RobloxGui["?"]:Destroy()
    end)
end

wait(0.5)
ScreenGui:Destroy()