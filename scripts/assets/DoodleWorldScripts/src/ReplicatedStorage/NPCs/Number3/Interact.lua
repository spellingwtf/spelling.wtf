-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	v4[1] = function(p3)
		local v5 = p1:GetProgression();
		if v5.tunnelgoon == 2 then
			p1.Dialogue:SaySimple("Argh...", p3, "Number Three");
			return;
		end;
		if v5.TJLake == 2 then
			p1.Dialogue:SaySimple("Get lost, kid.", p3, "Number Three");
			return;
		end;
		p1.Dialogue:SaySimple("Me and my friend are inconspiciously blocking the entrance to this area. Yup.", p3, "???");
	end;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.NPCId = 1;
	v1.Name = "???";
	v1.NoRotate = true;
	return v1;
end;
