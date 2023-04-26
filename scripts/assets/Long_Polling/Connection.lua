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
	newConnection.lastPing = 0;
	newConnection.keepAlive = false;
	newConnection.disconnectCalled = false;

	local function reconnect()
		newConnection.disconnectCalled = true
		local handlers = newConnection.handlers
		newConnection:disconnect()
		newConnection = LongPolling.Connect(LongPollURL, LongPollPassword)
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
				print("[Server] Client has gone down, reconnecting...")
				reconnect()
			end
		end
	};
	
	newConnection.connected = true
	print("[Server] Connected")

	--// Recieving Messages
	coroutine.wrap(function()
		repeat
			local Data = requestfunc({
				Url = url.."/poll/"..id,
				Method = "GET",
			})
			if Data.Success == true then --timeout
				local response = HttpService:JSONDecode(Data.Body);
				newConnection.handlers[response.event.name](response.event.data)
			end
		    task.wait()
		until not newConnection.connected
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
	    until not newConnection.connected
	end)()

	--// Keep Alive (Server to Client) (For if server goes down)
	coroutine.wrap(function()
		repeat task.wait() until newConnection.keepAlive == true
		while task.wait() do
			if newConnection.keepAlive == true then
				if tick() - newConnection.lastPing > 5 then
					print("[Server] Server has gone down, reconnecting...")
					reconnect()
					break
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
