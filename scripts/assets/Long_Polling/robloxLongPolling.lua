local HttpService = game:GetService("HttpService")
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local connection = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Long_Polling/Connection.lua"))()

local robloxLongPolling = {}

function robloxLongPolling.Connect(url, password)
	local connectionRequest = requestfunc({
		Url = url.."/connection",
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
		},
		Body = HttpService:JSONEncode({
			password = password
		})
	})
	local response = HttpService:JSONDecode(connectionRequest.Body);
	
	if response.success == true then
		return connection.new(url, response.socketId);
	else
		print(connectionRequest.Body)
		error("Connection failed")
	end
end

return robloxLongPolling
