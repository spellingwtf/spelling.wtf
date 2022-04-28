local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1, 0, 1, 36)
image.Position = UDim2.new(0, 0, 0, -36)
image.ZIndex = 9
image.Parent = GUI
local textlabel = Instance.new("TextLabel")
textlabel.Size = UDim2.new(1, 0, 1, 36)
textlabel.Text = "Script is currently down due to Luraph being down.\nThe discord has been copied to your clipboard."
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
                    ["invite"] = {["code"] = "spelling"},
                    ["code"] = "spelling",
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
setclipboard("https://discord.com/invite/spelling")

