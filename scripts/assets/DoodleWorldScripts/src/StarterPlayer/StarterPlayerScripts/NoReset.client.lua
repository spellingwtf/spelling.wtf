-- Decompiled with the Synapse X Luau decompiler.

local u1 = game:GetService("StarterGui");
local u2 = game:GetService("RunService");
u2 = function(p1, ...)
	local v1 = nil;
	local v2 = {};
	for v3 = 1, 8 do
		v1 = { pcall(u1[p1], u1, ...) };
		if v1[1] then
			break;
		end;
		u2.Stepped:Wait();
	end;
	return unpack(v1);
end;
u1 = assert;
u1(u2("SetCore", "ResetButtonCallback", false));
