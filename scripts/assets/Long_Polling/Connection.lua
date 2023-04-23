local HttpService = game:GetService("HttpService")
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or nil
local Base64 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Long_Polling/Base.lua"))()
Connection = {}
Connection.__index = Connection

function Connection.new(url, id, password)
	local newConnection = {}
	setmetatable(newConnection, Connection)

	newConnection.url = url;
	newConnection.id = id;
	newConnection.password = password;
	newConnection.lastPing = 0;
	newConnection.keepAlive = false;
	newConnection.disconnectCalled = false;

	local function reconnect()
		newConnection.disconnectCalled = true
		local handlers = newConnection.handlers
		newConnection:disconnect()

		local response
		local connectionRequest
		repeat
			connectionRequest = requestfunc({
				Url = "https://DoodleWorldLongPoll.spellingwtf.repl.co/connection",
				Method = "POST",
				Headers = {
					["content-type"] = "application/json",
				},
				Body = HttpService:JSONEncode({
					password = ""
				})
			})
			response = HttpService:JSONDecode(connectionRequest.Body);
			task.wait()
		until response.success == true
		newConnection = Connection.new("https://DoodleWorldLongPoll.spellingwtf.repl.co", response.socketId, "")

		newConnection.handlers = handlers
	end
	
	newConnection.handlers = {
		["internal_ping"] = function()
			newConnection.lastPing = tick()
			if newConnection.keepAlive == false then
				newConnection.keepAlive = true
			end
		end,
		["disconnection"] = function(socketid)
			if newConnection.id == socketid and newConnection.disconnectCalled == false then
				reconnect()
			end
		end
	};
	
	newConnection.connected = true

	--// Event
	coroutine.wrap(function()
		repeat
		    pcall(function()
				local getData = requestfunc({
					Url = url.."/poll/"..id,
					Method = "GET",
				})
				local response = HttpService:JSONDecode(getData.Body);
				if response.success == true then
					newConnection.handlers[response.event.name](response.event.data)
				end
		    end)
		    task.wait()
		until newConnection.connected == false
	end)()

	--// Keep Alive (Client to Server) (For if client goes down)
	coroutine.wrap(function()
	    repeat
	        local success,response = pcall(function()
				requestfunc({
					Url = newConnection.url.."/poll/"..newConnection.id,
					Method = "POST",
					Headers = {
						["content-type"] = "application/json"
					},
					Body = HttpService:JSONEncode({
						name = Base64.encode("internal_ping"),
						data = Base64.encode("client to server ping")
					})
				})
	        end)
		    task.wait(2.5)
	    until newConnection.connected == false
	end)()

	--Keep Alive (Server to Client) (For if server goes down)
	coroutine.wrap(function()
		repeat task.wait() until newConnection.keepAlive == true
		while task.wait() do
			if newConnection.keepAlive == true then
				if tick() - newConnection.lastPing > 5 then
					print("no ping receive")
					reconnect()
				end
			end
		end
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
	self.handlers[event] = handler;
end

function Connection:disconnect()
	coroutine.wrap(function()
		requestfunc({
			Url = self.url.."/disconnect/"..self.id,
			Method = "POST",
			Headers = {
				["content-type"] = "application/json"
			},
			Body = HttpService:JSONEncode({})
		})
		self.connected = false
		self.keepAlive = false
		self.lastPing = 0;
		self.handlers = {}
	end)()
end

return Connection
