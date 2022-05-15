-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	return {
		ItemCheck = function(p2, p3)
			for v1, v2 in pairs(p2) do
				for v3, v4 in pairs(v2) do
					if p3 == v3 then
						if typeof(v4.Amount) == "boolean" then
							return v1;
						end;
						if v4.Amount > 0 then
							return v1;
						end;
					end;
				end;
			end;
			return nil;
		end
	};
end;
