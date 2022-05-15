-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	v4[1] = {
		Talking = "I don't quite understand this door... ABC II?"
	};
	v4[2] = {
		Talking = "I've tried the code \"Wiglet\" but that doesn't seem right."
	};
	v4[3] = {
		Talking = "I'm pretty sure it's a Doodle's name... "
	};
	v4[4] = function()
		p1.Dialogue:SaySimple("<Once you figured out the answer, type it in chat and the door will open!>");
	end;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.NPCId = 1;
	v1.Name = "";
	return v1;
end;
