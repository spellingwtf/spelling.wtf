-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	p1.WipeoutLocation = "Town1";
	local l__Network__1 = p1.Network;
	local u1 = {
		BlackRightInk = 2.553, 
		YellowInk = 2.752, 
		CyanInk = 3.522, 
		PinkInk = 2.697, 
		BlackLeftInk = 2.553
	};
	local l__Tween__2 = p1.Tween;
	local l__Utilities__3 = p1.Utilities;
	local function u4(p2)
		for v2, v3 in pairs(p1.CurrentNPCs) do
			if v3.Model and v3.Model.Name == p2 then
				return v3;
			end;
		end;
		print(p2 .. " not a valid NPC");
	end;
	local function u5(p3, p4)
		local v4 = u1[p3.Name];
		if p4 then
			v4 = math.random(250, v4 * 1000 - 500) / 1000;
		end;
		l__Tween__2:PlayTween(p3, {
			Size = Vector3.new(p3.Size.X, v4, p3.Size.Z), 
			Position = p3.Position + Vector3.new(0, (v4 - p3.Size.Y) / 2, 0)
		}, true, 2.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
	end;
	local v5 = {};
	local v6 = {};
	local function u6()
		p1.ClientDatabase:PDSEvent("Heal");
	end;
	function v6.func(p5)
		u6();
		p1.Gui:FadeToBlack();
		if p5 then
			p5:Destroy();
		end;
		p1.DataManager.Chunk.new(p1, "004_PlayerHouse", "Wipeout", true, true);
		p1.Dialogue:SaySimple("<You rush to mom's house as fast as you can.>");
		p1.ClientDatabase:PDSEvent("Unanchor");
		l__Utilities__3.Halt(0.5);
		p1.Gui:FadeFromBlack();
		local v7 = u4("Mom007");
		p1.Dialogue:SaySimple("You got hurt out there? Please rest here.", v7, "Mom");
		p1.Gui:FadeToBlack();
		p1.Sound:Play("HealJingle", 1, 2);
		l__Utilities__3.Halt(0.5);
		p1.Gui:FadeFromBlack();
		p1.Dialogue:SaySimple("Be careful out there next time, " .. p1.p.DisplayName .. "!", v7, "Mom");
		p1.Controls:ToggleWalk(true);
	end;
	v5.Town1 = v6;
	local v8 = {};
	local function u7(p6, p7)
		p1.Gui:FadeToBlack();
		if p6 then
			p6:Destroy();
		end;
		p1.DataManager.Chunk.new(p1, p7, "Wipeout", true, true);
		p1.Dialogue:SaySimple("<You rush to a doctor as fast as you can.>");
		p1.ClientDatabase:PDSEvent("Unanchor");
		l__Utilities__3.Halt(0.5);
		p1.Gui:FadeFromBlack();
		local v9 = u4("Doctor");
		p1.Dialogue:SaySimple("Okay, I'll take your Doodles for a few seconds.", v9, "Doctor");
		if p1.CurrentChunk:FindFirstChild("HealingStation") then
			local l__HealingStation__10 = p1.CurrentChunk:FindFirstChild("HealingStation");
			local v11 = l__Utilities__3:GetFront(l__HealingStation__10.PrimaryPart, 6);
			v9:RotateTo(l__HealingStation__10.PrimaryPart.Position);
			l__Utilities__3.Halt(0.3);
			local l__Slots__12 = l__HealingStation__10:FindFirstChild("Slots");
			local v13 = {};
			for v14, v15 in pairs((p1.ClientDatabase:PDSFunc("GetParty"))) do
				v13[v14] = p1.Capsule.new({}, v15, (l__Slots__12:FindFirstChild("Glow" .. v14)));
				p1.Sound:Play("Click");
				p1.Utilities.Halt(0.3);
			end;
			p1.Camera:InBuildingCamera(CFrame.new(v11.p, l__HealingStation__10.Slots.Glow2.Position), 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			p1.Dialogue:SaySimple("Now, I have to refill the ink...", nil, "Doctor");
			for v16, v17 in pairs(l__HealingStation__10.Ink:GetChildren()) do
				u5(v17);
			end;
			p1.Sound:Play("PaintSpray");
			l__Utilities__3.Halt(2.2);
			p1.Dialogue:SaySimple("Alright, time to turn on the machine!", nil, "Doctor");
			p1.Sound:Play("Beep");
			l__Utilities__3.Halt(1.3);
			for v18, v19 in pairs(l__HealingStation__10.Ink:GetChildren()) do
				u5(v19, true);
			end;
			p1.Sound:Play("PaintSpray");
			l__Utilities__3.Halt(2.2);
			p1.Camera:TweenOverhead();
			p1.Dialogue:SaySimple("All done!", v9, "Doctor");
			for v20 = 6, 1, -1 do
				if v13[v20] then
					v13[v20]:Destroy();
					p1.Sound:Play("Click");
					p1.Utilities.Halt(0.3);
				end;
			end;
			v9:Rotate();
			p1.Sound:Play("HealJingle");
			v9:PlayAnim("Bow");
			p1.Dialogue:SaySimple("We hope to see you again!", v9, "Doctor");
			p1.Controls:ToggleWalk(true);
		end;
	end;
	function v8.func(p8)
		u6();
		u7(p8, "008_LakewoodStation");
	end;
	v5.Lakewood = v8;
	v5.GraphiteLodge = {
		func = function(p9)
			u6();
			u7(p9, "015_LodgeStation");
		end
	};
	v5.GraphiteForest = {
		func = function(p10)
			u6();
			p1.Gui:FadeToBlack();
			if p10 then
				p10:Destroy();
			end;
			p1.DataManager.Chunk.new(p1, "021_ForestHouse", "Wipeout", true, true);
			p1.Dialogue:SaySimple("<You rush to the closest safe point.>");
			p1.ClientDatabase:PDSEvent("Unanchor");
			l__Utilities__3.Halt(0.5);
			p1.Gui:FadeFromBlack();
			local v21 = u4("Rest");
			p1.Dialogue:SaySimple("You got hurt out there? Please rest here.", v21, "");
			p1.Gui:FadeToBlack();
			p1.Sound:Play("HealJingle", 1, 2);
			l__Utilities__3.Halt(0.5);
			p1.Gui:FadeFromBlack();
			p1.Dialogue:SaySimple("Be careful out there next time, traveler!", v21, "");
			p1.Controls:ToggleWalk(true);
		end
	};
	p1.Network:BindEvent("UpdateWipeout", function(p11)
		p1.WipeoutLocation = p11;
	end);
	return v5;
end;
