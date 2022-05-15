-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = { "http://www.roblox.com/asset/?id=5698280594", "http://www.roblox.com/asset/?id=5698276075", "http://www.roblox.com/asset/?id=4639726377", "http://www.roblox.com/asset/?id=4644659286", "rbxassetid://3570695787", "http://www.roblox.com/asset/?id=5723544317", "http://www.roblox.com/asset/?id=5707602013", "http://www.roblox.com/asset/?id=5726879738", "http://www.roblox.com/asset/?id=5707602870", "http://www.roblox.com/asset/?id=5707667762", "http://www.roblox.com/asset/?id=5734520214", "http://www.roblox.com/asset/?id=5734669791", "M_rbxassetid://9057756903", "M_rbxassetid://9057747851", "http://www.roblox.com/asset/?id=7274071812", "http://www.roblox.com/asset/?id=4892618565" };
	l__Utilities__1.FastSpawn(function()
		for v2, v3 in pairs(u1) do
			if v3:sub(1, 2) == "M_" then
				local v4 = l__Utilities__1:Create("Sound")({
					SoundId = v3:sub(3, #v3)
				});
				p1.Services.ContentProvider:PreloadAsync({ v4 }, function()
					v4:Destroy();
				end);
			else
				p1.Services.ContentProvider:PreloadAsync({ v3 });
			end;
		end;
	end);
	return u1;
end;
