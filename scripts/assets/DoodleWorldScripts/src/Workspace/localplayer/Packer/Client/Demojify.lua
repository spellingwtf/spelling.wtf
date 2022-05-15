-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = (function(p1)
	local v2 = {};
	for v3, v4 in pairs(p1) do
		v2[v4] = true;
	end;
	return v2;
end)({ 169, 174, 8252, 8265, 8419, 8482, 8505, 8617, 8618, 8986, 8987, 9642, 9643, 9654, 9664, 10548, 10549, 11013, 11014, 11015, 11035, 11036, 11088, 11093, 12336, 12349, 12951, 12953, 126980, 127183 });
local u2 = { { 128513, 128591 }, { 9986, 10160 }, { 128640, 128704 }, { 9410, 127569 }, { 127744, 128511 }, { 8596, 8601 }, { 9193, 9203 }, { 9723, 9981 }, { 127744, 128511 }, { 128512, 128566 }, { 128641, 128709 }, { 127757, 128359 } };
function v1.Convert(p2)
	local v5 = {};
	local v6, v7, v8 = utf8.codes(p2);
	while true do
		local v9, v10 = v6(v7, v8);
		if not v9 then
			break;
		end;
		local v11 = true;
		if u1[v10] then
			v11 = false;
		else
			for v12, v13 in pairs(u2) do
				if v13[1] <= v10 and v10 <= v13[2] then
					v11 = false;
					break;
				end;
			end;
		end;
		if v11 then
			table.insert(v5, v10);
		end;	
	end;
	return utf8.char(unpack(v5));
end;
return v1;
