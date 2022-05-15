-- Decompiled with the Synapse X Luau decompiler.

function getColor(p1, p2)
	if not (p1 < 0) then
		if 1 < p1 then
			warn("getColor got out of bounds percentage (less than 0 or greater than 1");
		end;
	else
		warn("getColor got out of bounds percentage (less than 0 or greater than 1");
	end;
	local v1 = p2[#p2];
	local v2 = #p2 - 1;
	local v3 = 1 - 1;
	while true do
		if p2[v3].Time <= p1 then
			if p1 <= p2[v3 + 1].Time then
				local v4 = p2[v3];
				local v5 = p2[v3 + 1];
				return v4.Value:lerp(v5.Value, (p1 - v4.Time) / (v5.Time - v4.Time));
			end;
		end;
		if 0 <= 1 then
			if v3 < v2 then

			else
				break;
			end;
		elseif v2 < v3 then

		else
			break;
		end;
		v3 = v3 + 1;	
	end;
	warn("Color not found!");
	return p2[1].Value;
end;
return getColor;
