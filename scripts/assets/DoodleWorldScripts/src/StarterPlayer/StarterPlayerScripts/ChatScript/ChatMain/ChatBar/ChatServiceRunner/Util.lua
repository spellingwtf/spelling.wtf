-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatConstants")).StandardPriority;
if v1 == nil then
	v1 = 10;
end;
local v2 = {};
v2.__index = v2;
local v3 = {};
local v4 = {};
v4.__index = v4;
function v4.RebuildProcessCommandsPriorities(p1)
	p1.RegisteredPriorites = {};
	local v5, v6, v7 = pairs(p1.FunctionMap);
	while true do
		local v8, v9 = v5(v6, v7);
		if not v8 then
			break;
		end;
		local v10 = true;
		local v11, v12, v13 = pairs(v9);
		local v14, v15 = v11(v12, v13);
		if v14 then
			v10 = false;
		end;
		if not v10 then
			table.insert(p1.RegisteredPriorites, v8);
		end;	
	end;
	table.sort(p1.RegisteredPriorites, function(p2, p3)
		return p3 < p2;
	end);
end;
function v4.HasFunction(p4, p5)
	if p4.RegisteredFunctions[p5] == nil then
		return false;
	end;
	return true;
end;
function v4.RemoveFunction(p6, p7)
	p6.RegisteredFunctions[p7] = nil;
	p6.FunctionMap[p6.RegisteredFunctions[p7]][p7] = nil;
	p6:RebuildProcessCommandsPriorities();
end;
function v4.AddFunction(p8, p9, p10, p11)
	if p11 == nil then
		p11 = v1;
	end;
	if p8.RegisteredFunctions[p9] then
		error(p9 .. " is already in use!");
	end;
	p8.RegisteredFunctions[p9] = p11;
	if p8.FunctionMap[p11] == nil then
		p8.FunctionMap[p11] = {};
	end;
	p8.FunctionMap[p11][p9] = p10;
	p8:RebuildProcessCommandsPriorities();
end;
function v4.GetIterator(p12)
	local u1 = 1;
	local u2 = nil;
	local u3 = nil;
	return function()
		local v16 = nil;
		while true do
			if #p12.RegisteredPriorites < u1 then
				return;
			end;
			v16 = p12.RegisteredPriorites[u1];
			local v17, v18 = next(p12.FunctionMap[v16], u2);
			u2 = v17;
			u3 = v18;
			if u2 ~= nil then
				break;
			end;
			u1 = u1 + 1;		
		end;
		return u2, u3, v16;
	end;
end;
local u4 = v4;
function v3.new()
	local v19 = setmetatable({}, u4);
	v19.RegisteredFunctions = {};
	v19.RegisteredPriorites = {};
	v19.FunctionMap = {};
	return v19;
end;
u4 = function(p13)
	return v3.new();
end;
v2.NewSortedFunctionContainer = u4;
return v2;
