-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	local l__Utilities__1 = p1.Utilities;
	v4[1] = function(p3)
		p3.Return = nil;
		if p1.Dialogue:SaySimpleYesNo("Want me to open the door for you?", p3, "Bodybuilder") == "Yes" then
			p1.Dialogue:Hide();
			p1.Gui:FadeToBlack();
			p1.DataManager.Chunk.new(p1, "022_ForestMaze", "Entrance", true, true);
			p1.ClientDatabase:PDSEvent("Unanchor");
			l__Utilities__1.Halt(0.25);
			p1.Gui:FadeFromBlack();
			p1.Gui:AreaPopup("Graphite Maze");
		end;
	end;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.NPCId = 1;
	v1.Name = "";
	return v1;
end;
