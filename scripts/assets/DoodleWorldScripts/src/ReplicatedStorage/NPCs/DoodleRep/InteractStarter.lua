-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	local v5 = {
		Talking = "Do you want to use the machine to purchase a starter?", 
		YesNo = true
	};
	local v6 = {};
	local v7 = {};
	local l__Utilities__1 = p1.Utilities;
	v7[1] = function(p3)
		local v8 = CFrame.new(-134.70874, -57.226387, 348.290344, -0.00227546436, -0.122558802, 0.992458642, -0, 0.992461264, 0.122559108, -0.999997497, 0.00027887887, -0.00225831009);
		p1.Dialogue:Hide();
		p1.Dialogue:BeamKill();
		p1.Camera.SetCutscene(true);
		p1.Camera:Tween(v8, 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(1);
		local v9 = p1.GuiObjs.Starter:Clone();
		v9.Parent = p1.pgui;
		local v10 = p1.StarterSelect.Boot(v9, "Purchase");
		if p1.CurrentChunk:FindFirstChild("Paper") then
			p1.CurrentChunk.Paper.SurfaceGui.Frame.ImageLabel.Image = p1.DoodleInfo[v10].FrontSprite;
		end;
		v9:Destroy();
		p1.Camera:Tween(workspace.CurrentCamera.CFrame, 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		p1.Camera.SetCutscene(nil);
	end;
	v6.Talk = v7;
	v5.Yes = v6;
	v5.No = {
		Talk = { function()

			end }
	};
	v4[1] = v5;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.Name = "DoodleCo Professor";
	v1.NPCId = 4;
	return v1;
end;
