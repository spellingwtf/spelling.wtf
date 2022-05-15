-- Decompiled with the Synapse X Luau decompiler.

local u1 = {};
spawn(function()
	while wait() do
		for v1, v2 in pairs(u1) do
			if v2.Destroyed == true then
				u1[v1] = nil;
			else
				v2:Update();
			end;
		end;	
	end;
end);
local v3 = {};
local u2 = require(script:FindFirstChild("ViewportMaster"));
function v3.new(p1)
	local v4 = u2.buildFrame(p1);
	table.insert(u1, v4);
	return v4;
end;
return v3;
