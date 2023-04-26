local HttpService = game:GetService("HttpService")
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local Base64 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Long_Polling/Base.lua"))()

local Connection = {}
Connection.__index = Connection

function Connection.new(url, id, password)
	local newConnection = {}
	setmetatable(newConnection, Connection)

	newConnection.url = url;
	newConnection.id = id;
	newConnection.disconnectCalled = false;
	newConnection.handlers = {};

	local function reconnect()
		newConnection.disconnectCalled = true
		local handlers = newConnection.handlers
		newConnection:disconnect()
		newConnection = LongPolling.Connect(LongPollURL, LongPollPassword)
		newConnection.handlers = handlers
	end
	
	newConnection.connected = true
	print("[Server] Connected")

	--// Recieving Messages
	coroutine.wrap(function()
		repeat
			local Data = requestfunc({
				Url = url.."/poll/"..id,
				Method = "GET",
			})
			if Data.Success == true then
				local response = HttpService:JSONDecode(Data.Body);
				newConnection.handlers[response.event.name](response.event.data)
			else
				print("[Server] Server has gone down, reconnecting...")
				reconnect()
				break
			end
		    task.wait()
		until not newConnection.connected
	end)()

	--// Keep Alive (Client to Server) (For if client goes down)
	coroutine.wrap(function()
		repeat task.wait() until type(newConnection.send) == "function"
	    repeat
			newConnection:send("internal_ping", "client to server ping")
		    task.wait(2.5)
	    until not newConnection.connected
	end)()
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
	self.handlers[event] = function(args)
		local suc, err = pcall(handler, args)
		if not suc then print(tostring(err)) end
	end;
end

function Connection:disconnect()
	coroutine.wrap(function()
		requestfunc({
			Url = self.url.."/disconnect/"..self.id,
			Method = "POST",
			Headers = {
				["content-type"] = "application/json"
			},
			Body = "[]"
		})
	end)()
	self = {}
end

return Connection
