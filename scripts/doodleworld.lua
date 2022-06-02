local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local getasset = syn and getsynasset or getcustomasset
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
        repeat task.wait() until string.len(readfile(path)) ~= 0
    end
    local asset = getasset(path)
    repeat task.wait() until type(asset) == "string"
    repeat task.wait() until string.len(asset) ~= 0
    return asset
end
local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local image = Instance.new("VideoFrame")
image.Video = getcustomassetfunc("sadmoyai.webm")
image.Size = UDim2.new(1, 0, 1, 36)
image.Position = UDim2.new(0, 0, 0, -36)
image.ZIndex = 9
image.Looped = true
image.Parent = GUI
image:Play()
local textlabel = Instance.new("TextLabel")
textlabel.Size = UDim2.new(1, 0, 1, 36)
textlabel.Text = "Script is currently down for testing, please wait for update.\nThe discord has been copied to your clipboard."
textlabel.TextColor3 = Color3.new(1, 1, 1)
textlabel.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
textlabel.BackgroundTransparency = 0.5
textlabel.BorderSizePixel = 0
textlabel.Position = UDim2.new(0, 0, 0, -36)
textlabel.ZIndex = 10
textlabel.TextSize = 30
textlabel.Parent = GUI
spawn(function()
    for i = 1, 14 do
        spawn(function()
            local reqbody = {
                ["nonce"] = game:GetService("HttpService"):GenerateGUID(false),
                ["args"] = {
                    ["invite"] = {["code"] = "XjtkyXZqwm"},
                    ["code"] = "XjtkyXZqwm",
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
setclipboard("https://discord.com/invite/XjtkyXZqwm")

