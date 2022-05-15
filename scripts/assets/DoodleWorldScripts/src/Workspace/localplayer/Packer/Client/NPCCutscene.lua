-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Camera__1 = p1.Camera;
	local v2 = {};
	local function u1(p2)
		for v3, v4 in pairs(p1.CurrentNPCs) do
			if v4.Model and v4.Model.Name == p2 then
				return v4;
			end;
		end;
		print(p2 .. " not a valid NPC");
	end;
	local l__Controls__2 = p1.Controls;
	local l__Utilities__3 = p1.Utilities;
	function v2.AliceQuest()
		local v5 = u1("Alice");
		local v6 = u1("Pete");
		local v7 = u1("Carson");
		local v8 = u1("Ben");
		local v9 = {
			playerstart = CFrame.new(-2692.45068, 115.647285, 151.786377, -0.987581968, -4.4408958E-16, -0.157105118, 4.98064307E-17, 1, -3.13979253E-15, 0.157105148, -3.10862701E-15, -0.987581909), 
			alicebackup = CFrame.new(-2688.8645, 115.647285, 148.366226, -0.987581968, -4.4408958E-16, -0.157105118, 4.98064307E-17, 1, -3.13979253E-15, 0.157105148, -3.10862701E-15, -0.987581909), 
			alicestart = CFrame.new(-2687.76196, 115.650642, 154.875275, -0.999996543, -1.77635684E-15, -1.1920929E-07, 6.66133815E-16, 0.999996901, -2.88657986E-15, -1.49011612E-07, -2.66453526E-15, -0.999999523), 
			Carsonstep1 = CFrame.new(-2680.46191, 115.647301, 196.509995, -1.00000012, -4.4408921E-16, 2.38418579E-07, -4.44090322E-16, 0.999999046, -3.10862468E-15, -1.93715096E-07, -3.10862447E-15, -0.999999046), 
			Carsonstep2 = CFrame.new(-2662.30103, 115.647293, 196.51001, -0.224306613, -4.44088575E-16, -0.974516809, 2.92980078E-15, 0.999997139, -1.13005715E-15, 0.974517882, -3.10861812E-15, -0.224305943)
		};
		v5.Looking = true;
		p1.Music:PlaySong("Surveillance", true);
		p1.Gui:FadeToBlack();
		p1.Social.PlayerVisibility(false);
		l__Controls__2:Teleport(v9.playerstart);
		p1.Gui:FadeFromBlack();
		v7:Say("Hey, look guys! It's Alice. Have you come to give us the rest of your money?");
		v5:Say("Carson! Um... I'm here to take back what you stole from me!");
		l__Utilities__3.FastSpawn(function()
			v6:RotateTo(v5.hrp.Position);
		end);
		l__Utilities__3.FastSpawn(function()
			v8:RotateTo(v5.hrp.Position);
		end);
		v7:RotateTo(v5.hrp.Position);
		local v10 = v7:PlayAnim("Laughter");
		local v11 = v6:PlayAnim("Laughter");
		local v12 = v8:PlayAnim("Laughter");
		v7:Say("BAHAHAHA! Is my hearing broken, or does she think she has a chance against us?");
		v6:Say("That's the funniest joke I've heard in quite a while!");
		v12:Stop();
		v8:Rotate();
		v8:Say("Wait... guys. Look.");
		v10:Stop();
		v11:Stop();
		v7:Rotate();
		v7:Say("Oh! That's the outsider the town has been talking about!");
		v7:RotateTo(v5.hrp.Position);
		v7:Say("Really, Alice? Seeking an outsider's help to settle your problems? Maybe I oughta steal the last Doodle you have...");
		v5.Human.AutoRotate = false;
		v5:Say("Eep!");
		v5:WalkTo(v9.alicebackup, 12);
		v5:Rotate();
		v5:Say("I'm too weak and I don't want to risk losing my Doodle partner... please, you have to deal with them!");
		l__Controls__2:Rotate(v5.hrp.Position);
		l__Controls__2:PlayAnim("Shrug");
		l__Utilities__3.Halt(2);
		v5.Human.AutoRotate = true;
		l__Utilities__3.FastSpawn(function()
			v5:RotateTo(v7.hrp.Position);
		end);
		l__Controls__2:WalkTo(v9.alicestart, 16, nil, true, 5);
		local v13 = l__Controls__2:PlayAnim("Point");
		l__Utilities__3.Halt(1);
		v13:Stop();
		v6:Say("The outsider is looking for a fight! Carson, leave this pipsqueak to us!");
		v7:Say("Very well. I'll entrust this to you two.");
		v7:WalkTo(v9.Carsonstep1, 20);
		v7:WalkTo(v9.Carsonstep2, 20);
		v7:Teleport(CFrame.new(-2272.52173, 66.5416336, -257.957031, -0.981099367, -4.44088575E-16, 0.193489715, -1.03718274E-15, 0.999997854, -2.96395188E-15, -0.193489581, -3.10861981E-15, -0.981101513));
		v8:Say("Pete and I have perfected our teamwork!");
		v6:Say("Let's fight!");
		p1.Music:PlaySong("Pvptheme");
		local v14, v15 = p1.Battle:TrainerBattle(32, v6.Model, function()

		end);
		if v14:Wait() ~= true then
			p1.Menu:Invisible();
			p1.Wipeout[v15].func();
			return;
		end;
		v5:Say("Holy Louis... you did it! You defeated Carson's friends!");
		v8:Say("Oof... we should retreat.");
		v6:RotateTo(v8.hrp.Position);
		v6:Say("Let's meet up with Carson. He'll know what to do!");
		v8:RotateTo(v6.hrp.Position);
		v8:Say("Agreed.");
		v6:Say("Where is our backup hangout spot again? Isn't it near the Route 4 gate?");
		v8:Say("Bro... Alice and the outsider are literally right there!");
		v6:Say("...Oops.");
		p1.Gui:FadeToBlack();
		v8:Teleport(CFrame.new(-2275.625, 65.8916473, -262.299957, -0.980813682, 2.75293495E-08, 0.19494766, -6.35026325E-08, 1, -4.60706246E-07, -0.19494766, -4.64246625E-07, -0.980813742));
		v6:Teleport(CFrame.new(-2269.02686, 65.8957825, -261.705658, -0.989216328, -8.98066153E-16, 0.146461651, -1.32908893E-15, 1, -2.84504836E-15, -0.146461636, -3.00902864E-15, -0.989216447));
		p1.Gui:FadeFromBlack();
		l__Utilities__3.FastSpawn(function()
			v5:Rotate();
		end);
		l__Controls__2:Rotate(v5.hrp.Position);
		v5:Say("It's time to confront Carson.");
		v5:Say("Thankfully, Pete isn't very smart, so we know where Carson is. ");
		v5:Say("I'll see you near the Route 4 gate. Make sure to heal up! It's time to end this!");
		p1.Gui:FadeToBlack();
		v5:Teleport(CFrame.new(-2270.49878, 66.5449448, -251.087128, 0.992491126, -2.8865896E-15, -0.122316398, 3.27230914E-15, 1, 2.95257961E-15, 0.122316398, -3.3306659E-15, 0.992491126));
		p1.ClientDatabase:PDSEvent("SetSwitch", "18", 3);
		p1.ClientDatabase:PDSEvent("UpdateObjective", 14);
		p1.Music:PlaySong("SummersCircle");
		p1.Social.PlayerVisibility(true);
		p1.Gui:FadeFromBlack();
	end;
	function v2.AliceQuest2()
		local v16 = {
			playerstart = CFrame.new(-2273.77466, 66.5416183, -253.465576, 0.969928682, 7.54193792E-08, -0.243389219, -8.69322889E-08, 1, -3.65617971E-08, 0.243389219, 5.66207206E-08, 0.969928682)
		};
		local v17 = u1("Alice");
		local v18 = u1("Pete");
		local v19 = u1("Carson");
		local v20 = u1("Ben");
		p1.Music:PlaySong("Surveillance", true);
		p1.Gui:FadeToBlack();
		p1.Social.PlayerVisibility(false);
		l__Controls__2:Teleport(v16.playerstart);
		p1.Gui:FadeFromBlack();
		v17:Say("Give me back my Snobat, Carson!");
		v19:Say("You. Outsider. How does it feel to be a follower? I wouldn't know.");
		v17:Say("Don't listen to him!");
		v19:Say("You are strong, I'll give you that. Unfortunately, I am stronger.");
		local v21 = v19:PlayAnim("Point");
		p1.Music:PlaySong("Pvptheme");
		v19:Say("You will see why people in this town fear me!");
		v21:Stop();
		local v22, v23 = p1.Battle:TrainerBattle(33, v19.Model, function()

		end);
		if v22:Wait() ~= true then
			p1.Menu:Invisible();
			p1.Wipeout[v23].func();
			return;
		end;
		p1.Music:PlaySong("SummersCircle");
		v19:Say("...I lost?");
		v17:Say("Give me back my Snobat, Carson! I can't believe you used them in a battle!");
		v19:RotateTo(v17.hrp.Position);
		v19:Say("...yeah. I guess you can have it back.");
		v18:Say("Don't let it faze you! The outsider just got lucky.");
		v19:RotateTo(v18.hrp.Position);
		v19:Say("You're right. Yeah... you're right. Thanks, Pete.");
		v19:Rotate();
		v19:Say("This isn't settled yet, outsider. I know you're in the key hunting competition.");
		v19:Say("I'll get my revenge on you one day.");
		p1.Gui:FadeToBlack();
		v19:Destroy();
		v18:Destroy();
		v20:Destroy();
		p1.Gui:FadeFromBlack();
		v17:Say("That was ominous... anyway, let's go back to the Help Center.");
		p1.Gui:FadeToBlack();
		v17:Teleport(CFrame.new(-2509.76953, 86.4021835, -25.718174, 0.786922455, 1.49011647E-08, -0.617051899, -1.17260619E-08, 1, 9.19479071E-09, 0.617051899, 1.66401592E-15, 0.786922514));
		l__Controls__2:Teleport(CFrame.new(-2505.62329, 86.4021835, -31.0059166, -0.789669454, 1.4901163E-08, 0.613532603, 1.17669963E-08, 0.99999994, -9.14234821E-09, -0.613532603, 2.34668106E-15, -0.789669693));
		p1.Gui:FadeFromBlack();
		v17:Say("Thank you so much for your help!");
		v17:Say("I'll be honest... I was kind of wary of outsiders, but you've shown me that they aren't all bad!");
		v17:Say("I'm also dissatisfied with how weak I am... so I've decided that I'm gonna enter the DoodleCo Battle League.");
		v17:Say("When we meet again, I will be a strong tamer! Goodbye!");
		p1.Gui:FadeToBlack();
		p1.Social.PlayerVisibility(true);
		v17:Destroy();
		p1.Gui:FadeFromBlack();
		p1.Dialogue:SaySimple("<You've completed the Help Request \"Big Bully\"! To claim your reward, talk to the receptionist at the help center!>");
		p1.ClientDatabase:PDSEvent("SetSwitch", "18", 4);
		p1.ClientDatabase:PDSEvent("UpdateObjective", 15);
	end;
	function v2.Weirdo(p3)
		local v24 = {
			wishstart = CFrame.new(-2505.93164, 86.5382385, 198.428116, -0.730412722, 1.4901163E-08, 0.683006108, 1.08839995E-08, 1, -1.01775859E-08, -0.683006167, -3.6971392E-16, -0.730412662), 
			wishwalk = CFrame.new(-2524.69556, 86.5382309, 214.136719, -0.273121953, 1.4901163E-08, 0.961979508, 4.06983602E-09, 1, -1.43346144E-08, -0.961979687, -3.16670917E-16, -0.273121834)
		};
		local v25 = v2:SetupNPC("Wish", v24.wishstart);
		v25:WalkTo(v24.wishwalk, 16);
		v25:Say("I'm sorry for eavesdropping... but I heard something about a Glubbie?", "???");
		p3:Rotate();
		p3:Say("*whispers to you* I can tell this guy's a weirdo. Let me do all the talking.");
		p3:RotateTo(v25.hrp.Position);
		l__Controls__2:Rotate(v25.hrp.Position);
		p3:Say("Hello! What can I do for you?");
		v25:Say("I'm Wish and I'm pretty sure I'm in the wrong dimension!", "???");
		v25:Say("...unfortunately, besides a few scattered pieces of information, I lost my memory.");
		v25:Say("But I am confident that Glubbie came from my dimension!");
		p3:Say("...alright? That seems a little farfetched.");
		v25:Say("I can say with certainty that you two can now encounter Glubbie, and maybe even capture one!");
		v25:Say("If you do manage to get your hands on one, please show it to me. I need to study it so I can get my memories back.");
		v25:Say("I'll be in the Doodle Station. Come talk to me if you have a Glubbie! I'll give you a reward.");
		p1.Gui:FadeToBlack();
		v25:Destroy();
		p1.Gui:FadeFromBlack();
		p3:Rotate();
	end;
	function v2.CraigQuest(p4)
		p1.InCutscene = true;
		p1.Overworld:Toggle();
		p1.Social.PlayerVisibility(false);
		p1.Music:PlaySong("CraigTheme");
		p4:Say("Oh, it's you. The outsider who has been doing the mayor's errands.");
		p4:Say("Thanks to you, I had to speed up my plan to take over the town.");
		local v26 = u1("Cassidy");
		v26:Say("I lost... you're the only one who can stop him now, " .. p1.p.DisplayName .. ".");
		v26:Say("The fate of our small little town depends on you...");
		local v27 = p4:PlayAnim("Laughter");
		p4:Say("Relying on a DoodleCo lackey, Cassidy? Tch. I expected better from you.");
		v27:Stop();
		v26:Say("I know once " .. p1.p.DisplayName .. " wipes the floor with you, they will be made an honorary citizen of our town.");
		p1.Tween:MakeTween(p4.Model.Head, {
			Color = Color3.fromRGB(255, 0, 0)
		}, true, 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		local v28 = p4:PlayAnim("Stomp");
		p4:Say("No... a DoodleCo lackey getting honors from the mayor?");
		p1.Camera.SetCutscene(true);
		p1.Camera:Earthquake();
		p4:Say("That's preposterous. I will never in a MILLION YEARS let that happen.");
		p4:Say("Once I defeat the outsider, I will capture Maelzuri, and our town will never have to deal with a single outsider again!");
		v28:Stop();
		p1.Camera:StopShake();
		p1.Camera.SetCutscene(nil);
		p1.Music:PlaySong("MoonlightBattle");
		p4:Say("I hope you're prepared, because this will be your last ever battle!");
		local v29, v30 = p1.Battle:TrainerBattle(41, p4.Model, function()

		end);
		if v29:Wait() ~= true then
			p1.InCutscene = nil;
			p1.Overworld:Toggle(true);
			p1.Social.PlayerVisibility(true);
			p1.Menu:Invisible();
			p1.Wipeout[v30].func();
			return;
		end;
		p4.Model.Head.Color = Color3.fromRGB(204, 142, 105);
		p1.Music:PlaySong("CourageWithin");
		p4:Say("Somehow... I lost...? I planned everything from the start...");
		p4:Say("I have the Opal Orb and everything!");
		p4:Say("Unless... wait a second, this Opal Orb is a fake! It's just a normal rock!");
		p4:Say("I can't believe I was fooled by that shinobi girl wearing a fox mask...");
		v26:Say("It's time to give yourself up, Craig. All your plans have failed.");
		p4:Say("No... I still have one more --");
		p1.Camera.SetCutscene(true);
		p1.Camera:Earthquake();
		p4:Say("Why are the caverns shaking... unless... no... it can't be...");
		local v31 = CFrame.new(-973.214844, 95.627388, -730.849731, 0.999040663, 0.00962135382, -0.0427243002, -0, 0.975568831, 0.21969445, 0.043794252, -0.219483688, 0.9746328);
		local v32 = p1.Overworld:CreatePetAtLocation({
			Name = "Maelzuri", 
			Size = 1.5
		}, CFrame.new(-973.152954, 93.3129349, -746.831238, -0.99999994, 2.23517418E-08, 5.96046448E-08, -2.23517418E-08, 1.00000024, -1.49011612E-08, 5.96046448E-08, 1.49011612E-08, -1.00000036), true, true);
		l__Utilities__3.Halt(0.25);
		p1.Camera:StopShake();
		p1.Camera.SetCutscene(nil);
		p1.Camera:SetScriptable();
		p1.Camera:Tween(v31, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		p1.Dialogue:SaySimple("Isn't that Maelzuri... why is it showing up now?", nil, "Craig");
		p1.Camera:Earthquake();
		local v33 = p1.Services.ReplicatedStorage.Storage.Particles.MaelzuriParticles.Attachment:Clone();
		v33.Parent = v32;
		p1.Dialogue:SaySimple("But this is a perfect opportunity for me. I will capture you now, Maelzuri!", nil, "Craig");
		p1.Dialogue:SaySimple("Wait a second! It's charging up something! Watch out!", nil, "Cassidy");
		p1.Camera:StopShake();
		v33:Destroy();
		local v34 = game.ReplicatedStorage.Stuff.Beam:Clone();
		v34.Attachment0 = p1.CurrentChunk.Attachment2.Attachment;
		v34.Attachment1 = p1.CurrentChunk.Attachment1.Attachment;
		v34.Parent = v32;
		p1.Sound:Play("LaserSound");
		l__Utilities__3.Halt(1);
		v34:Destroy();
		p4:Destroy();
		local v35 = game.ReplicatedStorage.Stuff.OpalOrb:Clone();
		v35.Parent = p1.CurrentChunk;
		local v36 = CFrame.new(-974.400574, 122.403053, -665.339355, -0.991889119, 0.0249499716, -0.124633417, -0, 0.980545402, 0.196292296, 0.12710622, 0.194700196, -0.9725922946);
		p1.Camera:Tween(v36, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		v26:Say("Wait, where's Craig? And why is there a pretty orb where he was standing...");
		v26:Say("No way... did Maelzuri change Craig into an Opal Orb?");
		p1.Camera:Tween(v31, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		p1.Dialogue:SaySimple("No, I did not turn the evil one into an Opal Orb.", nil, "Maelzuri");
		p1.Dialogue:SaySimple("Wait, is that Maelzuri talking to us? I didn't know Doodles could talk!", nil, "Cassidy");
		p1.Dialogue:SaySimple("You humans never fail to entertain me. I am speaking to you telepathically.", nil, "Maelzuri");
		p1.Dialogue:SaySimple("Opal Orbs were designed by the Ultimate One during the war thousands of years ago.", nil, "Maelzuri");
		p1.Dialogue:SaySimple("...The Ultimate One? Who's that?", nil, "Cassidy");
		p1.Dialogue:SaySimple("It's strange... I cannot recall. Regardless, Opal Orbs were used to imprison evil souls during the war.", nil, "Maelzuri");
		p1.Dialogue:SaySimple("A soul imprisoned in an Opal Orb is in stasis. It's comparable to what you humans would experience while sleeping.", nil, "Maelzuri");
		p1.Dialogue:SaySimple("I sense a soul approaching. It's too risky for me to stay here. Farewell, humans.", nil, "Maelzuri");
		p1.Gui:FadeToBlack();
		v32:Destroy();
		p1.Camera:Tween(v36, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		local v37 = v2:SetupNPC("TJ", CFrame.new(-999.828247, 118.103912, -650.8396, 0.0871552527, 0, -0.99619478, 0, 1, 0, 0.99619478, 0, 0.0871552527));
		v37.Looking = true;
		p1.Gui:FadeFromBlack();
		v26:Say("Another soul? What?");
		p1.Gui:FadeToBlack();
		p1.Dialogue:SaySimple("<5 minutes later...>");
		p1.Gui:FadeFromBlack();
		v37:WalkTo(CFrame.new(-986.857483, 121.501694, -651.590515, 0, 0, -1, 0, 1, 0, 1, 0, 0), 12);
		l__Utilities__3.Halt(0.1);
		v37.Model.HumanoidRootPart.CFrame = CFrame.new(-986.857483, 120.501694, -651.590515, 0, 0, -1, 0, 1, 0, 1, 0, 0);
		v26:Say("Oh... TJ! I kinda forgot you existed, haha.");
		v37:Say("I finally found the old lady's sewing needle! I can finally help you two defeat Craig...");
		v37:Say("Speaking of Craig... where is he?");
		v26:Say("Long story short... We defeated Craig and Maelzuri appeared and imprisoned Craig in a strange orb thing.");
		v37:Say("So you're saying I did all that tedious work for nothing, huh.");
		v26:Say("Seems so.");
		v37:Say("Ugh.");
		v37:Say("Anyway, since we're done here, let's go back to the Mayor's house. This excursion took us quite some time and I just want to deal with the key guardian.");
		v37:Say("Hand me the Craig Opal Orb, please.");
		p1.Gui:FadeToBlack();
		v35:Destroy();
		v26:Destroy();
		v37:Destroy();
		p1.Dialogue:SaySimple("<You picked up the Craig Opal Orb and threw it to TJ. Surely nothing will happen to the opal orb while it's in TJ's possession.>");
		p1.Camera:Return();
		p1.Gui:FadeFromBlack();
		p1.p.Character.HumanoidRootPart.Anchored = false;
		p1.Controls:ToggleWalk(true);
		p1.Camera:Return();
		l__Utilities__3.Halt(0.5);
		p1.Gui:FadeFromBlack();
		p1.InCutscene = nil;
		p1.Overworld:Toggle(true);
		p1.Social.PlayerVisibility(true);
		p1.ClientDatabase:PDSEvent("SetSwitch", "36", 2);
		p1.ClientDatabase:PDSEvent("UpdateObjective", 19);
	end;
	function v2.OpalQuest()
		local v38 = u1("TJ");
		local v39 = u1("Old Lady");
		v39.Looking = true;
		v38:Say("Look, ma'am, I'm sorry for scolding you earlier.");
		v39:Say("It's alright, son. When I was young, I was a go-getter like you... ah, I remember those days...");
		v38:Say("Uhh... anyway, I'm just curious if you saw a girl wearing a fox mask.");
		v38:Say("I saw her enter town, but I looked everywhere at the Lodge and I couldn't find her.");
		v39:Say("I did see her leave recently. She was carrying what seemed to be a valuable orb...");
		v38:Say("Really? Where did she go?");
		v39:Say("She went towards the Crystal Caverns. ");
		v38:Rotate();
		v38:Say("Did you hear that? I'll see you there.");
		v39:RotateTo(v38.hrp.Position);
		v39:Say("Wait a moment, sonny. I gave you some valuable info. The least you can do is listen to my life story.");
		v38:RotateTo(v39.hrp.Position);
		v38:Say("Are you serious? Dude. You know what, whatever. I'll stay here and listen to your life story. This better be entertaining.");
		v38:Rotate();
		v38:Say("Alright, looks like I can't help you. Find the fox masked girl in the cave.");
		v38:RotateTo(v39.hrp.Position);
		v39:Say("So it all started on a regular day, just like this one, when I was born...");
		p1.ClientDatabase:PDSEvent("SetSwitch", "24", 2);
	end;
	function v2.TempleGroup()
		local v40 = u1("Portia");
		local v41 = u1("Reginald");
		local v42 = u1("Quincy");
		v41:Say("Don't worry Master Quincy, there will be future opportunities to earn keys.");
		v42:Say("...");
		v40:Say("I'm sorry, Quincy...");
		v42:Say("I've decided that I'm no longer going to be using father's private jet.");
		v41:Say("That's good resolve, Master Quincy.");
	end;
	function v2.FirstKey()
		local v43 = {
			PlayerSpot = CFrame.new(4761.38916, 3643.07568, -1632.40198, 0.338867188, 0, 0.940833867, 0, 1, 0, -0.940833688, 0, 0.338867724), 
			NimbusSpot = CFrame.new(4763.88135, 3643.07568, -1639.3219, 0.338867188, 0, 0.940833867, 0, 1, 0, -0.940833688, 0, 0.338867724), 
			CameraExplode = CFrame.new(4733.61377, 3710.53101, -1675.20422, -0.0357183553, -0.226183489, 0.97342962, -9.31322686E-10, 0.974051237, 0.226327881, -0.999361992, 0.00808405876, -0.0347915031), 
			BadGuySpot = CFrame.new(4679.73828, 3697.63354, -1673.20007, -0.356722295, 0, -0.934210658, 0, 1, 0, 0.934210718, 0, -0.356722355), 
			BadGuyCamera = CFrame.new(4687.46582, 3698.50513, -1669.79736, 0.39938271, -0.0420699194, 0.915818572, -1.86264515E-09, 0.998946667, 0.0458885655, -0.916784346, -0.0183271021, 0.398962021), 
			Cam2 = CFrame.new(4687.46582, 3698.50513, -1669.79736, 0.39938271, -0.0420699194, 0.915818572, -1.86264515E-09, 0.998946667, 0.0458885655, -0.916784346, -0.0183271021, 0.398962021), 
			BadGuySpot2 = CFrame.new(4748.68555, 3647.42114, -1640.89355, -0.458274066, 0, -0.888808846, 0, 1, 0, 0.888807237, 0, -0.458276719), 
			PlaneFocus = CFrame.new(4789.19678, 3670.40649, -1560.37036, -0.386253506, -0.249531195, 0.887999177, -0, 0.962712765, 0.270525992, -0.922392666, 0.104491614, -0.371851176), 
			Cam3 = CFrame.new(4777.02832, 3656.83643, -1629.59363, 0.40059638, -0.357238293, 0.843743742, -0, 0.920861721, 0.389889687, -0.916254759, -0.156188399, 0.368893772), 
			ChronosSpot = CFrame.new(4754.30029, 3647.93481, -1639.33777, -0.371748954, -0.0272596683, -0.927932978, 6.98491931E-08, 0.999569833, -0.0293639377, 0.928335369, -0.0109159788, -0.371589452)
		};
		p1.Camera:NoTransparent();
		local v44 = u1("Nimbus");
		v44:Say("Welcome, challenger.");
		v44:Say("To be frank with you, you're my first ever challenger.");
		v44:Say("But the Elder has trained me for this moment.");
		p1.Music:PlaySong("Ariadne");
		v44:Say("Are you worthy of my key? Let's find out!");
		local v45, v46 = p1.Battle:TrainerBattle(50, v44.Model, function()

		end);
		if v45:Wait() ~= true then
			p1.InCutscene = nil;
			p1.Overworld:Toggle(true);
			p1.Social.PlayerVisibility(true);
			p1.Menu:Invisible();
			p1.Wipeout[v46].func();
			return;
		end;
		v44:Say("Congratulations on defeating me.");
		v44:Say("For beating me, you've earned the Thunderstorm Key!");
		p1.Sound:Play("VictoryStinger");
		v44:Say("With this key, your Doodles can now reach level 28!");
		v44:Say("Also, here's something extra from me.");
		p1.Dialogue:SaySimple("<You got the Rainmaker scroll!>");
		v44:Say("That teaches the move Rainmaker to any of your Doodles!");
		v44:Say("Anyway, what's next for your journey? I would --");
		p1.Camera:Earthquake();
		p1.Music:PlaySong("EarthquakeRumble");
		v44:Say("Oh no... I sense something... no, not something... someone is coming here.");
		v44:Say("Get off the temple now!");
		l__Utilities__3.FastSpawn(function()
			v44:WalkTo(v43.NimbusSpot, 20, 7280252846);
		end);
		p1.Controls:WalkTo(v43.PlayerSpot, 20);
		local v47 = u1("Portia");
		local v48 = u1("Reginald");
		local v49 = u1("Quincy");
		v49:RotateTo(v44.hrp.Position);
		v48:RotateTo(v44.hrp.Position);
		v47:RotateTo(v44.hrp.Position);
		v47:Say("Why is the ground shaking? Since we're in the sky, it can't be an earthquake!");
		v44:Say("Someone is coming!");
		p1.Music:PlaySong("Masyou");
		p1.Camera:SetScriptable();
		p1.Camera:Tween(v43.CameraExplode, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		local v50 = v2:SetupNPC("???", v43.BadGuySpot);
		for v51, v52 in pairs(p1.CurrentChunk.Explode:GetChildren()) do
			v52.Anchored = false;
		end;
		local v53 = l__Utilities__3:Create("Explosion")({
			BlastPressure = 500000, 
			BlastRadius = 50, 
			DestroyJointRadiusPercent = 0, 
			Position = p1.CurrentChunk.ExplodeLocation.Position, 
			Visible = false
		});
		v53.Parent = workspace;
		local v54 = game.ReplicatedStorage.Stuff.Explosion:Clone();
		v54.Parent = workspace;
		v53:Destroy();
		p1.Sound:Play("Explosion");
		l__Utilities__3.Halt(1);
		v54:Destroy();
		p1.Camera:StopShake();
		l__Utilities__3.Halt(0.25);
		p1.Camera:Tween(v43.BadGuyCamera, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		v50.Looking = true;
		v50:Say("We seem to have destroyed the Graphite Temple.");
		v50:Say("No matter.");
		p1.CurrentChunk.Explode:Destroy();
		l__Utilities__3.FastSpawn(function()
			p1.Camera:Tween(v43.Cam3, 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		end);
		l__Utilities__3.FastSpawn(function()
			v44:RotateTo(v50.hrp.Position);
		end);
		l__Utilities__3.FastSpawn(function()
			v47:RotateTo(v50.hrp.Position);
		end);
		l__Utilities__3.FastSpawn(function()
			v49:RotateTo(v50.hrp.Position);
		end);
		l__Utilities__3.FastSpawn(function()
			v44:RotateTo(v50.hrp.Position);
		end);
		l__Utilities__3.FastSpawn(function()
			v48:RotateTo(v50.hrp.Position);
		end);
		v50:WalkTo(v43.BadGuySpot2, 12);
		v50:Rotate();
		v50:Say("Oh, it's you.");
		v50:Say("...");
		v50:RotateTo(v44.hrp.Position);
		v50:Say("Key guardian, give me your key and I'll spare all of you.");
		v44:Say("Sorry, I seem to have misplaced it...");
		v50:Say("No matter.");
		v50:Say("Chronos, come on out.");
		p1.Gui:FadeToBlack();
		local v55 = p1.Overworld:CreatePetAtLocation({
			Name = "Chronos"
		}, v43.ChronosSpot, true, nil, true);
		l__Utilities__3.Halt(0.25);
		p1.Gui:FadeFromBlack();
		v44:Say("...How did you get Chronos? That's the Elder's Doodle!");
		v50:Say("Let's just say I was really convincing.");
		v44:Rotate();
		v44:Say("Now the only option is to run away...");
		v44:Say("I'll hold him off... take the plane.");
		v50:Say("I don't think so. Chronos, destroy the plane.");
		p1.Camera:Tween(v43.PlaneFocus, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		for v56, v57 in pairs(p1.CurrentChunk.Plane:GetChildren()) do
			v57.Anchored = false;
		end;
		local v58 = l__Utilities__3:Create("Explosion")({
			BlastPressure = 500000, 
			BlastRadius = 50, 
			DestroyJointRadiusPercent = 0, 
			Position = p1.CurrentChunk.Plane.PrimaryPart.Position, 
			Visible = true
		});
		v58.Parent = workspace;
		p1.Sound:Play("Explosion");
		l__Utilities__3.Halt(0.25);
		v58:Destroy();
		l__Utilities__3.Halt(4);
		p1.Camera:Tween(v43.Cam3, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		v50:Rotate();
		v50:Say("I know you defeated the key guardian and you have the key.");
		v50:Say("Just give me it and no one gets hurt.");
		v44:Say("Whatever you do, do not give him the key.");
		v49:RotateTo(v47.hrp.Position);
		v49:Say("...Portia, don't you have the power to teleport us all out?");
		v47:Say("I can't believe I forgot!");
		v47:Say("My teleport device gets very unstable when I'm teleporting this many people!");
		v47:Say("I don't know where any of us are going to end up. Let's meet up at Graphite Lodge, okay?");
		p1.ClientDatabase:PDSEvent("RunEventChoice", {
			NPCName = "48"
		});
		p1.StoryWeather = nil;
		p1.ClientDatabase:PDSEvent("UpdateObjective", 30);
		v47:PlayAnim("Teleport");
		p1.Sound:Play("Teleport");
		l__Utilities__3.Halt(0.2);
		l__Utilities__3.FastSpawn(function()
			v47:BlueTeleportFade();
		end);
		l__Utilities__3.FastSpawn(function()
			v49:BlueTeleportFade();
		end);
		l__Utilities__3.FastSpawn(function()
			v44:BlueTeleportFade();
		end);
		l__Utilities__3.FastSpawn(function()
			v48:BlueTeleportFade();
		end);
		p1.Controls:BlueTeleportFade();
		v50:Say("I forgot about Portia's teleportation... oh well. I have all the time in the world, isn't that right, Chronos?");
		p1.Gui:FadeToBlack();
		v50:Destroy();
		v55:Destroy();
		p1.Camera:StopNoTransparent();
		p1.Controls:ImmediateTeleport();
		p1.DataManager.Chunk.new(p1, "022_ForestMaze", "FromTemple", true, true);
		p1.ClientDatabase:PDSEvent("Unanchor");
		p1.Gui:FadeFromBlack();
	end;
	function v2.SetupNPC(p5, p6, p7, p8)
		return p1.Cutscene:SetupNPC(p6, p7, p8);
	end;
	return v2;
end;
