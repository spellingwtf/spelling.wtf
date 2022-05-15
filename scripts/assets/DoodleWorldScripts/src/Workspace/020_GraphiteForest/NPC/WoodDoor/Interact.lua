-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	local function u1(p3)
		for v5, v6 in pairs(p1.CurrentNPCs) do
			if v6.Model and v6.Model.Name == p3 then
				return v6;
			end;
		end;
		print(p3 .. " not a valid NPC");
	end;
	local l__Utilities__2 = p1.Utilities;
	v4[1] = function(p4)
		local v7 = nil;
		local v8 = nil;
		local u3 = nil;
		local u4 = nil;
		local u5 = nil;
		local v9 = {
			CameraSpot = CFrame.new(1659.93872, 52.7302132, 440.237, 0.313803166, 0.317163497, -0.894949734, -0, 0.942560256, 0.33403632, 0.949488044, -0.104821652, 0.295778394), 
			BodybuilderStart = CFrame.new(1638.4563, 42.9977379, 442.963867, 0.162138894, 0, -0.986767948, -1.47039847E-08, 0.999999642, -2.41605824E-09, 0.98676759, 1.49011576E-08, 0.162138909), 
			BBWalk = CFrame.new(1666.4248, 42.9977379, 434.798309, 0.162138894, 0, -0.986767948, -1.47039847E-08, 0.999999642, -2.41605824E-09, 0.98676759, 1.49011576E-08, 0.162138909), 
			CamFocus = CFrame.new(1681.13281, 49.0418625, 437.241455, 0.177642435, -0.426634729, 0.886806726, -7.4505806E-09, 0.901139259, 0.433529943, -0.984095156, -0.0770133212, 0.160080567)
		};
		v7 = u1("TJ");
		v8 = u1("Portia");
		if p1:GetProgression()["44"] then
			p1.Dialogue:SaySimple("You have decided to not destroy the door. Talk to the Bodybuilder so he can open the door for you.");
			return;
		end;
		if p1.DataFunctions.ItemCheck(p1.ClientDatabase:PDSFunc("GetItems"), "Pristine Axe") then
			p1.Camera:SetScriptable();
			p1.Camera:Tween(v9.CameraSpot, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			v7:Say("Oh good, you have the axe.");
			v8:Say("Yep, time to break down this door!");
			p1.Sound:Play("Whip");
			p1.Camera:Bump();
			p1.Dialogue:SaySimple("Wait! Don't destroy that door!", nil, "???");
			u3 = v8;
			u4 = p1.Cutscene:SetupNPC("Bodybuilder", v9.BodybuilderStart);
			u5 = v7;
			l__Utilities__2.FastSpawn(function()
				u3:RotateTo(u4.hrp.Position);
				u5:RotateTo(u4.hrp.Position);
				p1.Controls:Rotate(u4.hrp.Position);
			end);
			l__Utilities__2.FastSpawn(function()
				p1.Camera:Tween(v9.CamFocus, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			end);
			u4:WalkTo(v9.BBWalk);
			u4:Say("Please don't destroy this door.");
			u4:Say("My ancestors paid for this door many years ago.");
			u4:Say("This door is very heavy -- so I've been opening it as part of my training regime ever since I was a little kid.");
			u4:Say("Here, I'll open the door for you, just don't destroy it.");
			u5:Rotate();
			u5:Say("Nah, I think you should destroy it. If anyone in the future wants to visit this area, they would also be stopped by this door.");
			u3:Rotate();
			u3:Say("Don't destroy the door! The door means a lot to this guy. I assume he'll open it whenever you ask.");
			u4:Say("Yes, I will! Please don't destroy this door. I beg of you.");
			p1.Controls:Rotate(p4.WoodDoor.Position);
			p1.Camera:Tween(v9.CameraSpot, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			local v10 = p1.Dialogue:SaySimpleYesNo("Do you want to destroy the door? This choice affects your karma.", nil, "");
			if v10 == "Yes" then
				p1.Gui:FadeToBlack();
				p1.Dialogue:SaySimple("You take out the axe, and destroy the door.");
				p1.Sound:Play("WoodDestroy");
				p4:Destroy();
				p1.Gui:FadeFromBlack();
				u4:Say("You're a jerk!");
				u4:WalkTo(v9.BodybuilderStart, 32);
				p1.Dialogue:SaySimple("You lost karma!");
				u5:Say("Good job. Now people won't be blocked by this door.");
				u3:Say("I disagree with this decision, but I don't think it matters in the end. Finding Quincy is more important.");
				p1.ClientDatabase:PDSEvent("SetSwitch", "43", 2);
				p1.ClientDatabase:PDSEvent("SetSwitch", "45", 2);
				p1.ClientDatabase:PDSEvent("UpdateObjective", 27);
				pcall(function()
					p1.Gui:FadeToBlack();
					u3:Destroy();
					u5:Destroy();
					u4:Destroy();
					p1.Camera:Return();
					p1.Gui:FadeFromBlack();
				end);
				return;
			end;
			if v10 ~= "No" then
				return;
			end;
		else
			v7:Say("If only we had the means to break down this door.");
			v8:Say("I tried calling Teneson, but he absolutely refuses to go anywhere near this forest.");
			return;
		end;
		p1.Controls:Rotate(u4.hrp.Position);
		p1.Dialogue:SaySimple("You've gained karma!");
		u4:Say("Thanks a bunch! I'll open this door for you now.");
		u4:Say("If you ever need me to open this door, just talk to me and I'll do it for you.");
		p1.ClientDatabase:PDSEvent("SetSwitch", "44", 2);
		p1.ClientDatabase:PDSEvent("SetSwitch", "45", 2);
		p1.ClientDatabase:PDSEvent("UpdateObjective", 27);
		u5:Say("Sounds more tedious than just destroying the door, but I won't argue.");
		u3:Say("Doesn't being nice feel good sometimes?");
		u4:Say("I'm going to be opening the door for you now. Get ready!");
		p1.Gui:FadeToBlack();
		p1.DataManager.Chunk.new(p1, "022_ForestMaze", "Entrance", true, true);
		p1.ClientDatabase:PDSEvent("Unanchor");
		u4:Destroy();
		l__Utilities__2.Halt(0.25);
		p1.Gui:FadeFromBlack();
		p1.Gui:AreaPopup("Graphite Maze");
	end;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.NPCId = 1;
	v1.Name = "";
	return v1;
end;
