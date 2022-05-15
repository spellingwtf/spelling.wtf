-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local v2 = {};
	for v3, v4 in pairs(p1.DoodleInfo) do
		table.insert(v1, v3);
	end;
	local u1 = p1.Utilities:shallowCopy(v1);
	local u2 = {};
	local function u3(p2)
		local v5 = p1.DoodleInfo[p2];
		if v5.Evolve then
			if v5.Evolve.Level then
				return v5.Evolve.Level.Doodle;
			end;
			if v5.Evolve.MaxFriendship then
				return v5.Evolve.MaxFriendship.Doodle;
			end;
			if not v5.Evolve.Item then
				if v5.Evolve.Equipment then
					return v5.Evolve.Equipment.Doodle;
				else
					return;
				end;
			end;
		else
			return;
		end;
		local v6, v7, v8 = pairs(v5.Evolve.Item);
		local v9, v10 = v6(v7, v8);
		if not v9 then
			return;
		end;
		return v10;
	end;
	(function()
		while #u1 > 0 do
			for v11, v12 in pairs(u1) do
				local v13 = p1.DoodleInfo[v12];
				if v13 then
					if not v13.Evolve then
						u2[v12] = { v12 };
						table.remove(u1, v11);
					elseif v13.Evolve and u3(v12) and u2[u3(v12)] then
						table.insert(u2[u3(v12)], v12);
						table.remove(u1, v11);
					elseif v13.Evolve then
						for v14, v15 in pairs(u2) do
							if table.find(u2[v14], u3(v12)) then
								table.insert(u2[v14], v12);
								table.remove(u1, v11);
								break;
							end;
						end;
					end;
				end;
			end;		
		end;
		u2.Endovul = nil;
		u2.Exovul = nil;
		u2.Noxvul = nil;
		u2.Vuliable = { "Flaskit", "Vuliable", "Endovul", "Exovul", "Noxvul" };
		u2.Spiraryu = nil;
		u2.Theaterror = nil;
		u2.Maskomedy = { "Dramask", "Maskomedy", "Theaterror" };
		u2.Spirasol = { "Kowosu", "Spirasol", "Spiraryu" };
		u2.Kidere = nil;
		u2.Kibara = { "Shyce", "Kibara", "Kidere" };
	end)();
	function v2.GetLines(p3)
		return u2;
	end;
	return v2;
end;
