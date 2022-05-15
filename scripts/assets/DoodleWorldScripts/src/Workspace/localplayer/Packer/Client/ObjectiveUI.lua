-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Objectives__1 = p1.Objectives;
	local v1 = p1.Utilities.Class({}, function(p2)
		p2.ObjectiveUI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui"):WaitForChild("Objective");
		p2.Desc = p2.ObjectiveUI.Desc;
		p1.Gui:ChangeText(p2.Desc, "No objectives found.");
		p1.Network:BindEvent("UpdateObjective", function(p3)
			if p3 then
				p1.Gui:ChangeText(p2.Desc, l__Objectives__1[p3].Shorten);
			end;
		end);
		return p2;
	end);
	local u2 = nil;
	function v1.Update(p4)
		if u2 and p1.Settings:Get("ShowObjective") ~= nil then
			p4.ObjectiveUI.Visible = p1.Settings:Get("ShowObjective");
		end;
	end;
	function v1.Show(p5)
		u2 = true;
		if p1.Settings:Get("ShowObjective") == true then
			p5.ObjectiveUI.Visible = true;
		end;
	end;
	function v1.Hide(p6)
		p6.ObjectiveUI.Visible = false;
	end;
	return v1.new();
end;
