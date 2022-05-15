-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = {};
local v3 = {
	Name = "Big Bully", 
	Client = "Alice", 
	Description = "I need someone's help! The town's bully, Carson, took my lunch money! Please meet me in front of the Help Center for details.", 
	Reward = { {
			Money = 3500
		}, {
			Item = "Tally Counter", 
			Amount = 1
		} }, 
	Completed = "18", 
	Steps = 5
};
local function u1(p1)
	local v4 = tostring(p1);
	return #v4 % 3 == 0 and v4:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or v4:reverse():gsub("(%d%d%d)", "%1,"):reverse();
end;
function v3.CompleteQuest(p2, p3, p4)
	local l__Progression__5 = p2.Progression;
	p3 = p3 or {};
	if l__Progression__5["18"] and l__Progression__5["18"] == 4 then
		table.insert(p3, "You completed the quest Big Bully!");
		local v6 = 3500;
		if p2:TrinketCheck("MonT") then
			v6 = v6 * 2;
		end;
		p2:AddMoney(v6);
		table.insert(p3, "You earned $" .. u1(v6) .. " for completing this request!");
		if not p2:CheckItem("Tally Counter") then
			p2:AddItem("Tally Counter", 1);
			table.insert(p3, "You also got the Tally Counter!");
			table.insert(p3, "Alice provided instructions on how to chain Doodles.");
			table.insert(p3, "Fainting the same wild Doodle over and over again causes a ton of benefits. This is called \"chaining\"!");
			table.insert(p3, "These include: increased misprint chance, increased hidden trait chance, and increased skin chance.");
			table.insert(p3, "Your chain is reset if you capture any Doodle or faint a Doodle that you aren't currently chaining.");
			table.insert(p3, "This Tally Counter item lets you keep track of your current chain.");
		end;
		p2:UpdateObjective(16);
		l__Progression__5["18"] = 5;
	end;
	table.insert(p3, "Completing this request opened up more Help Center tasks!");
	return p3;
end;
v2[1] = v3;
v2[2] = {
	Name = "Missing Dunce", 
	Client = "Ilyanna", 
	Description = "Hello, this is ilyanna. My friend, the Village Dunce, left our home town of Ambasa to pursue his dancing dreams. However, he hasn't responded to any of my texts. I'm asking from the bottom of my heart, please help me find him! Meet me near the front of the Doodle Station.", 
	Reward = { {
			Doodle = "Appluff"
		} }, 
	Requirement = 10, 
	CompleteQuest = function(p5, p6, p7, p8)
		local v7 = nil;
		local l__Progression__8 = p5.Progression;
		p6 = p6 or {};
		print(l__Progression__8["19"]);
		if l__Progression__8["19"] then
			local v9 = nil;
			if l__Progression__8["19"] == 5 then
				local v10 = nil;
				local v11 = nil;
				v7, v10, v11 = p5:GetEmptyLocation();
				if not v7 then
					table.insert(p6, "You have no room for the reward! Come back when you do.");
					v9 = p6;
					return v9;
				end;
			else
				v9 = p6;
				return v9;
			end;
		else
			v9 = p6;
			return v9;
		end;
		table.insert(p6, "You completed the quest Missing Dunce!");
		l__Progression__8["19"] = 6;
		p5:AddDoodle(p8.Doodle.new({
			Name = "Appluff", 
			Level = 10, 
			OriginalOwner = p5.UserId
		}, p5, p5.player), v7, v10);
		table.insert(p6, "An Appluff was added to " .. v11 .. ".");
		table.insert(p6, "You also got the Village Dunce title!");
		p5:AddTitle(64);
		return p6;
	end, 
	Steps = 6, 
	Accept = "ilyanna is near the front of the Doodle Station. You can't miss her!", 
	Completed = "19"
};
v2[3] = {
	Name = "Picture Perfect", 
	Client = "Camera Julia", 
	Description = "They don't like my photography here! Please meet me near the entrance of Graphite Lodge and help me convince the two guards to let me take their picture!", 
	Reward = { {
			Item = "Level-Up Cube", 
			Amount = 2
		}, {
			Item = "Stat Candy", 
			Amount = 5
		} }, 
	CompleteQuest = function(p9, p10, p11)
		local l__Progression__12 = p9.Progression;
		p10 = p10 or {};
		if l__Progression__12["20"] and (l__Progression__12["20"] == 2 or l__Progression__12["20"] == 3) then
			table.insert(p10, "You completed the quest Picture Perfect!");
			table.insert(p10, "You got 2 Level-Up Cubes and 5 Stat Candies!");
			p9:AddItem("Stat Candy", 5);
			p9:AddItem("Level-Up Cube", 2);
			if l__Progression__12["20"] == 3 then
				table.insert(p10, "Wow! Since you went above and beyond, Julia added extra rewards!");
				table.insert(p10, "You earned the Mini Camera and a Trait Badge!");
				p9:AddItem("Trait Badge", 1);
				p9:AddEquipment("2", "Amulet");
			end;
			l__Progression__12["20"] = 4;
		end;
		return p10;
	end, 
	Accept = "Camera Julia is near the Route 4 gate! Time to go meet her.", 
	Requirement = 10, 
	Steps = 4, 
	Completed = "20"
};
v2[4] = {
	Name = "Blasted Music", 
	Client = "The Mayor", 
	ClientID = "Mayor", 
	Description = "...it's pretty strange for the mayor to be asking for help, but the neighbor right across from me won't stop playing music! Convince them to stop!", 
	Reward = { {
			Dance = "Monkey"
		}, {
			Money = 1500
		} }, 
	CompleteQuest = function(p12, p13, p14)
		local l__Progression__13 = p12.Progression;
		p13 = p13 or {};
		if l__Progression__13["21"] and (l__Progression__13["21"] == 5 or l__Progression__13["21"] == 6) then
			table.insert(p13, "You completed the quest Blasted Music!");
			local v14 = 1500;
			if p12:TrinketCheck("MonT") then
				v14 = v14 * 2;
			end;
			p12:AddMoney(v14);
			table.insert(p13, "You've earned $" .. u1(v14) .. " for completing this request!");
			if l__Progression__13["21"] == 6 then
				table.insert(p13, "You learned how to do the Monkey Dance!");
				p12:AddAnim(13);
			else
				table.insert(p13, "Because you destroyed the boombox, you didn't learn how to do the Monkey Dance.");
			end;
			l__Progression__13["21"] = 7;
		end;
	end, 
	Accept = "The mayor should be in his house!", 
	Requirement = 10, 
	Completed = "21", 
	Steps = 7
};
v2[5] = {
	Name = "Mysterious House", 
	Client = "Cassidy", 
	Description = "In Graphite Lodge, there's a strange house that nobody lives in. Let's go explore it! I'll be in front of that house!", 
	Reward = { {
			Item = "Scroll", 
			Name = "Disarm", 
			Color3 = Color3.fromRGB(204, 204, 204)
		}, {
			Doodle = "Glubbie", 
			Color3 = Color3.fromRGB(0, 0, 0)
		} }, 
	CompleteQuest = function(p15, p16, p17)
		local l__Progression__15 = p15.Progression;
		p16 = p16 or {};
		if l__Progression__15["22"] and l__Progression__15["22"] == 5 then
			table.insert(p16, "You completed the quest Mysterious House!");
			table.insert(p16, "You got the Disarm Scroll!");
			p15:AddItem("Disarm", 1);
			table.insert(p16, "And apparently, you can now encounter Glubbie? Nice!");
			l__Progression__15["22"] = 6;
		end;
		return p16;
	end, 
	Accept = "Cassidy is in front of one of the houses in Graphite Lodge!", 
	Steps = 6, 
	Requirement = 10, 
	Completed = "22"
};
v2[6] = {
	Name = "Looking for Opponent", 
	Client = "Jack", 
	Description = "I'm looking for someone to spar with me. Serious inquiries only! I will be on Route 4.", 
	Reward = { {
			Item = "Friendship Ribbon", 
			Amount = 1
		}, {
			Gems = 500
		} }, 
	CompleteQuest = function(p18, p19, p20)
		local l__Progression__16 = p18.Progression;
		p19 = p19 or {};
		if l__Progression__16["23"] and l__Progression__16["23"] == 2 then
			table.insert(p19, "You completed the quest Looking for Opponent!");
			p18:AddGems(500);
			table.insert(p19, "You earned " .. u1(500) .. " gems for completing this request!");
			p18:AddItem("Friendship Ribbon", 1);
			table.insert(p19, "You also earned the Friendship Ribbon!");
			table.insert(p19, "Give the Friendship Ribbon to a Doodle and they will become your friend faster!");
			l__Progression__16["23"] = 3;
		end;
		return p19;
	end, 
	Accept = "Time to meet Jack on Route 4!", 
	Requirement = 10, 
	Completed = "23", 
	Steps = 3
};
v2[7] = {
	Name = "The Opal Orb", 
	Client = "TJ", 
	Description = "A clumsy girl with a fox mask stole the Opal Orb, a prison for the town's sheriff. The mayor said to \"not worry about it\", but can we really ignore this matter?", 
	Reward = { {
			Item = "Opal Orb", 
			Amount = 1
		}, {
			Doodle = "Maelzuri", 
			Color3 = Color3.fromRGB(0, 0, 0)
		} }, 
	CompleteQuest = function(p21, p22, p23)
		local l__Progression__17 = p21.Progression;
		p22 = p22 or {};
		if l__Progression__17["24"] and l__Progression__17["24"] == 4 then
			table.insert(p22, "You completed the quest Opal Orb!");
			table.insert(p22, "You also received the Opal Orb!");
			p21:AddItem("Opal Orb", 1);
			table.insert(p22, "And with the Opal Orb, you can now encounter Maelzuri in the Crystal Caverns! Nice!");
			table.insert(p21.Roaming, "Maelzuri");
			l__Progression__17["24"] = 5;
		end;
		return p22;
	end, 
	Requirement = "38", 
	Steps = 5, 
	Accept = "TJ will be at the Crossroads.", 
	Completed = "24", 
	NotReady = "You need to have defeated Craig and talked with the mayor!"
};
v2[8] = {
	Name = "A Strange Cult", 
	Client = "???", 
	Description = "We're a Louis fanclub! If you would like to join our fanclub, come meet us. We're in the backyard of one of the houses.", 
	Reward = { {
			Doodle = "Louis"
		} }, 
	CompleteQuest = function(p24, p25, p26, p27)
		local v18 = nil;
		local l__Progression__19 = p24.Progression;
		p25 = p25 or {};
		if l__Progression__19["25"] then
			local v20 = nil;
			if l__Progression__19["25"] == 2 then
				local v21 = nil;
				local v22 = nil;
				v18, v21, v22 = p24:GetEmptyLocation();
				if not v18 then
					table.insert(p25, "You have no room for the reward! Come back when you do.");
					v20 = p25;
					return v20;
				end;
			else
				v20 = p25;
				return v20;
			end;
		else
			v20 = p25;
			return v20;
		end;
		table.insert(p25, "You completed the quest A Strange Cult!");
		l__Progression__19["25"] = 3;
		p24:AddDoodle(p27.Doodle.new({
			Name = "Louis", 
			Level = 15, 
			Skin = 0, 
			Star = 4, 
			OriginalOwner = p24.UserId
		}, p24, p24.player), v18, v21);
		table.insert(p25, "A Louis was added to " .. v22 .. ".");
		return p25;
	end, 
	Requirement = "38", 
	Steps = 3, 
	Completed = "25", 
	Accept = "...Let's see what this Louis fanclub is all about.", 
	NotReady = "You need to have defeated Craig and talked with the mayor!!"
};
v1.GraphiteLodge = v2;
v1.Func = {};
v1.Func.FindQuestData = function(p28)
	for v23, v24 in pairs(v1) do
		for v25, v26 in pairs(v24) do
			if typeof(v26) == "table" and v26.Completed == p28 then
				return v26;
			end;
		end;
	end;
	return nil;
end;
return v1;
