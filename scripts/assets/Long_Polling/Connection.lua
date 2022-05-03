local HttpService = game:GetService("HttpService")
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local Base64 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Long_Polling/Base.lua"))()
Connection = {}
Connection.__index = Connection

function Connection.new(url, id)
	local newConnection = {}
	setmetatable(newConnection, Connection)

	newConnection.url = url;
	newConnection.id = id;
	
	newConnection.handlers = {};

	spawn(function()
		while wait() do
			local success,response = pcall(function()
				local getData = requestfunc({
					Url = url.."/poll/"..id,
					Method = "GET",
				})
				local response = HttpService:JSONDecode(getData.Body);
				if response.success == true then
					newConnection.handlers[response.event.name](response.event.data)
				end
			end)
		end
	end)
	spawn(function()
		while wait(5) do
			local success,response = pcall(function()
				requestfunc({
					Url = newConnection.url.."/poll/"..newConnection.id,
					Method = "POST",
					Headers = {
						["content-type"] = "application/json"
					},
					Body = HttpService:JSONEncode({
						name = Base64.encode("internal_ping"),
						data = Base64.encode("whats poppin lo gang")
					})
				})
			end)
		end
	end)
	
	local function close()
		requestfunc({
			Url = newConnection.url.."/connection/"..newConnection.id,
			Method = "DELETE",
		})
	end
	
	--game:BindToClose(close);
	--game.Close:Connect(close)

	return newConnection
end

function Connection:send(name, data)
	requestfunc({
		Url = self.url.."/poll/"..self.id,
		Method = "POST",
		Headers = {
			["content-type"] = "application/json"
		},
		Body = HttpService:JSONEncode({
			name = Base64.encode(name),
				data = Base64.encode(data)
		})
	})
end

function Connection:on(event, handler)
	self.handlers[event] = handler;
end

function Connection:Disconnect()
	requestfunc({
		Url = self.url.."/connection/"..self.id,
		Method = "DELETE",
	})
end

return Connection
