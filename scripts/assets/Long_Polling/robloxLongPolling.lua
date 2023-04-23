local HttpService = game:GetService("HttpService")
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local Connection = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Long_Polling/Connection.lua"))()

local robloxLongPolling = {}

function robloxLongPolling.Connect(url, password)
    local response
    local connectionRequest
    repeat
        connectionRequest = requestfunc({
            Url = url.."/connection",
            Method = "POST",
            Headers = {
                ["content-type"] = "application/json",
            },
            Body = HttpService:JSONEncode({
                password = password
            })
        })
        response = HttpService:JSONDecode(connectionRequest.Body);
        if not response.success then print(bettertostring(response)) end
        task.wait()
    until response.success == true
	return Connection.new(url, response.socketId, password), response.socketId
end

return robloxLongPolling
