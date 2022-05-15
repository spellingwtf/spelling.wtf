-- Decompiled with the Synapse X Luau decompiler.

local u1 = {};
return function(p1)
	u1.ShopRequirements = {
		["Basic Capsule"] = { "Starter", 1 }, 
		Bandage = { "Starter", 2 }, 
		Antidote = { "Starter", 3 }, 
		["Anti-Paralysis Spray"] = { "Starter", 4 }, 
		["Anti-Sleep Spray"] = { "Starter", 5 }, 
		["Stat Candy"] = { "Starter", 6 }, 
		["Level-Down Cube"] = { "Starter", 7 }, 
		["Gold Capsule"] = { "Starter", 8 }, 
		["Level-Up Cube"] = { "Starter", 9 }
	};
	local v1 = {
		Description = "These bandages heal a Doodle by 25 HP.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		Image = "http://www.roblox.com/asset/?id=8736096006"
	};
	local l__Utilities__2 = p1.Utilities;
	function v1.Function(p2, p3, p4)
		local v2 = l__Utilities__2:GetStats(p2);
		if p2.currenthp == v2.hp then
			return (p2.Nickname or p2.Name) .. " is already at full health!";
		end;
		if p2.currenthp == 0 then
			return "You can't use Bandage on a fainted doodle!";
		end;
		if not game:GetService("RunService"):IsServer() then
			return "You used Bandage on " .. (p2.Nickname or p2.Name) .. ".", true;
		end;
		p2.currenthp = math.min(p2.currenthp + 25, v2.hp);
		if p3 then
			p3:AddAction(p3.ActionList, {
				Player = p2.Owner, 
				Doodle = p2, 
				Action = "PlayAnim", 
				Move = "GenericHeal"
			});
			p3:AddAction(p3.ActionList, {
				Action = "UpdateHealth", 
				currenthp = p2.currenthp, 
				Doodle = p2, 
				Player = p4
			});
			p3:AddDialogue(p3.ActionList, (p2.Nickname or p2.Name) .. " was healed!");
		end;
		return true;
	end;
	u1.Bandage = v1;
	u1["Anti-Burn Spray"] = {
		Description = "Use this spray on a Doodle to cure their burn.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974960723", 
		Function = function(p5, p6, p7)
			if p5.Status ~= "Burn" then
				return (p5.Nickname or p5.Name) .. " isn't burned!";
			end;
			if not game:GetService("RunService"):IsServer() or p5.Status ~= "Burn" then
				return "You used Anti-Burn Spray on " .. (p5.Nickname or p5.Name) .. ".", true;
			end;
			p5.Status = nil;
			if p6 then
				p6:AddAction(p6.ActionList, {
					Player = p5.Owner, 
					Doodle = p5, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p6:AddAction(p6.ActionList, {
					Player = p5.Owner, 
					Doodle = p5, 
					Action = "ClearStatus"
				});
				p6:AddDialogue(p6.ActionList, (p5.Nickname or p5.Name) .. " was cured of their Burn!");
			end;
			return true;
		end
	};
	u1["Anti-Freeze Spray"] = {
		Description = "Use this spray on a Doodle to cure their freeze.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974962320", 
		Function = function(p8, p9, p10)
			if p8.Status ~= "Frozen" then
				return (p8.Nickname or p8.Name) .. " isn't frozen!";
			end;
			if not game:GetService("RunService"):IsServer() or p8.Status ~= "Frozen" then
				return "You used Anti-Freeze Spray on " .. (p8.Nickname or p8.Name) .. ".", true;
			end;
			p8.Status = nil;
			if p9 then
				p9:AddAction(p9.ActionList, {
					Player = p8.Owner, 
					Doodle = p8, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p9:AddAction(p9.ActionList, {
					Player = p8.Owner, 
					Doodle = p8, 
					Action = "ClearStatus"
				});
				p9:AddDialogue(p9.ActionList, (p8.Nickname or p8.Name) .. " was cured of their freeze!");
			end;
			return true;
		end
	};
	u1["Anti-Sleep Spray"] = {
		Description = "Use this item to throw it at a Doodle to wake them up.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974962769", 
		Function = function(p11, p12, p13)
			if p11.Status ~= "Sleep" then
				return (p11.Nickname or p11.Name) .. " isn't asleep!";
			end;
			if not game:GetService("RunService"):IsServer() or p11.Status ~= "Sleep" then
				return "You threw Anti-Sleep Spray at " .. (p11.Nickname or p11.Name) .. ".", true;
			end;
			p11.Status = nil;
			if p12 then
				p12:AddAction(p12.ActionList, {
					Player = p11.Owner, 
					Doodle = p11, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p12:AddAction(p12.ActionList, {
					Player = p11.Owner, 
					Doodle = p11, 
					Action = "ClearStatus"
				});
				p12:AddDialogue(p12.ActionList, (p11.Nickname or p11.Name) .. " was awakened!");
			end;
			return true;
		end
	};
	u1.Antidote = {
		Description = "Use this spray on a Doodle to cure their poisoning.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974963169", 
		Function = function(p14, p15, p16)
			if p14.Status ~= "Poison" then
				return (p14.Nickname or p14.Name) .. " isn't poisoned!";
			end;
			if not game:GetService("RunService"):IsServer() or p14.Status ~= "Poison" then
				return "You used Antidote on " .. (p14.Nickname or p14.Name) .. ".", true;
			end;
			p14.Status = nil;
			if p15 then
				p15:AddAction(p15.ActionList, {
					Player = p14.Owner, 
					Doodle = p14, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p15:AddAction(p15.ActionList, {
					Player = p14.Owner, 
					Doodle = p14, 
					Action = "ClearStatus"
				});
				p15:AddDialogue(p15.ActionList, (p14.Nickname or p14.Name) .. " was cured of their poisoning!");
			end;
			return true;
		end
	};
	u1.Disinfectant = {
		Description = "Use this spray on a Doodle to cure their disease.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974961687", 
		Function = function(p17, p18, p19)
			if p17.Status ~= "Diseased" then
				return (p17.Nickname or p17.Name) .. " isn't diseased!";
			end;
			if not game:GetService("RunService"):IsServer() or p17.Status ~= "Diseased" then
				return "You used Disinfectant on " .. (p17.Nickname or p17.Name) .. ".", true;
			end;
			p17.Status = nil;
			if p18 then
				p18:AddAction(p18.ActionList, {
					Player = p17.Owner, 
					Doodle = p17, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p18:AddAction(p18.ActionList, {
					Player = p17.Owner, 
					Doodle = p17, 
					Action = "ClearStatus"
				});
				p18:AddDialogue(p18.ActionList, (p17.Nickname or p17.Name) .. " was cured of their disease!");
			end;
			return true;
		end
	};
	u1["Anti-Paralysis Spray"] = {
		Description = "Use this spray on a Doodle to cure their paralysis.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974961170", 
		Function = function(p20, p21, p22)
			if p20.Status ~= "Paralysis" then
				return (p20.Nickname or p20.Name) .. " isn't paralyzed!";
			end;
			if not game:GetService("RunService"):IsServer() or p20.Status ~= "Paralysis" then
				return "You used Anti-Paralysis Spray on " .. (p20.Nickname or p20.Name) .. ".", true;
			end;
			p20.Status = nil;
			if p21 then
				p21:AddAction(p21.ActionList, {
					Player = p20.Owner, 
					Doodle = p20, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p21:AddAction(p21.ActionList, {
					Player = p20.Owner, 
					Doodle = p20, 
					Action = "ClearStatus"
				});
				p21:AddDialogue(p21.ActionList, (p20.Nickname or p20.Name) .. " was cured of their paralysis!");
			end;
			return true;
		end
	};
	local v3 = {
		Description = "This strange orb of darkness allows certain Doodles to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(21, 21, 21), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8463940065"
	};
	local function u3(p23, p24)
		local v4 = p1.DoodleInfo[p23.Name];
		if v4.Evolve and v4.Evolve.Item and v4.Evolve.Item[p24] then
			return true;
		end;
		return false;
	end;
	function v3.Function(p25, p26, p27)
		if p26 then
			return false;
		end;
		if not u3(p25, "Orb of Darkness") then
			return (p25.Nickname or p25.Name) .. " cannot evolve using the Orb of Darkness!";
		end;
		if game:GetService("RunService"):IsServer() then
			p25:EvolveItem(p27, "Orb of Darkness");
			return true;
		end;
		return "Evolving " .. (p25.Nickname or p25.Name) .. "...", true;
	end;
	u1["Orb of Darkness"] = v3;
	u1["Strange Catalyst"] = {
		Description = "A strange, reactive item that may make a certain Doodle evolve. It doesn't seem safe to touch. ", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(91, 59, 135), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789994663", 
		Function = function(p28, p29, p30)
			if p29 then
				return false;
			end;
			if not u3(p28, "Orb of Cayalyst") then
				return (p28.Nickname or p28.Name) .. " cannot evolve using the Strange Catalyst!";
			end;
			if game:GetService("RunService"):IsServer() then
				p28:EvolveItem(p30, "Strange Catalyst");
				return true;
			end;
			return "Evolving " .. (p28.Nickname or p28.Name) .. "...", true;
		end
	};
	u1["Strange Substance"] = {
		Description = "This strange orb of darkness allows certain Doodles to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(97, 24, 47), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789995239", 
		Function = function(p31, p32, p33)
			if p32 then
				return false;
			end;
			if not u3(p31, "Strange Substance") then
				return (p31.Nickname or p31.Name) .. " cannot evolve using the Strange Substance!";
			end;
			if game:GetService("RunService"):IsServer() then
				p31:EvolveItem(p33, "Strange Substance");
				return true;
			end;
			return "Evolving " .. (p31.Nickname or p31.Name) .. "...", true;
		end
	};
	u1["Strange Solution"] = {
		Description = "A strange, reactive liquid that may make a certain Doodle evolve. It's cool to the touch.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(33, 117, 187), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789994917", 
		Function = function(p34, p35, p36)
			if p35 then
				return false;
			end;
			if not u3(p34, "Strange Solutiin") then
				return (p34.Nickname or p34.Name) .. " cannot evolve using the Strange Solution!";
			end;
			if game:GetService("RunService"):IsServer() then
				p34:EvolveItem(p36, "Strange Solution");
				return true;
			end;
			return "Evolving " .. (p34.Nickname or p34.Name) .. "...", true;
		end
	};
	local v5 = {
		Description = "Give this item to a Doodle to have it cure a status effect when the Doodle is inflicted with one. This item is consumed after one use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(65, 175, 238), 
		Image = "http://www.roblox.com/asset/?id=7325480728"
	};
	local u4 = {
		Paralysis = "Paralysis", 
		Poison = "Poison", 
		Rage = "Rage", 
		Burn = "Burn", 
		Sleep = "Sleep", 
		Frozen = "Freeze", 
		Marked = "Mark", 
		Vulnerable = "Vulnerable", 
		Cursed = "Curse", 
		Diseased = "Disease"
	};
	function v5.OnStatus(p37, p38, p39)
		if not p38.Status or not u4[p38.Status] then
			return false;
		end;
		p38.Status = nil;
		p37:AddDialogue(p37.ActionList, "The Cure Jelly got rid of " .. "&DOODLENAME," .. p38.ID .. "&" .. "'s " .. u4[p38.Status] .. "!");
		p37:AddAction(p37.ActionList, {
			Player = p38.Owner, 
			Doodle = p38, 
			Action = "ClearStatus"
		});
		p38.HeldItem = nil;
		return true;
	end;
	u1["Cure Jelly"] = v5;
	u1["Running Shoes"] = {
		Description = "Give this item to a Doodle so it can flee from any wild Doodle without fail.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(205, 64, 44), 
		Image = "http://www.roblox.com/asset/?id=9575744399", 
		RunningShoes = true
	};
	u1["Frozen TV Dinner"] = {
		Description = "Give this item to a Doodle. They will be so distracted snacking on a delicious dinner that they will always attack last.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(130, 186, 237), 
		Image = "http://www.roblox.com/asset/?id=7325464936", 
		AttackLast = true
	};
	u1["Wake-up Jelly"] = {
		Description = "Give this item to a Doodle to wake it up when it gets put to sleep. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(87, 31, 189), 
		Image = "http://www.roblox.com/asset/?id=7325464058", 
		OnStatus = function(p40, p41, p42)
			if not p41.Status or p41.Status ~= "Sleep" or not u4[p41.Status] then
				return false;
			end;
			local l__Status__6 = p41.Status;
			p41.Status = nil;
			p40:AddDialogue(p40.ActionList, "The Wake-up Jelly woke up " .. "&DOODLENAME," .. p41.ID .. "&!");
			p41.HeldItem = nil;
			p41.Resting = nil;
			return true;
		end
	};
	u1["Heal Jelly"] = {
		Description = "Give this item to a Doodle to have them heal after their health drops below half.  This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(211, 54, 107), 
		Image = "http://www.roblox.com/asset/?id=7325470567", 
		AfterDamage = function(p43, p44, p45)
			local l__hp__7 = p44.Stats.hp;
			local v8 = math.floor(l__hp__7 * 0.25);
			if p44.currenthp <= l__hp__7 / 2 then
				p43:AddDialogue(p43.ActionList, p44.Name .. " used its Heal Jelly!");
				p43:TakeDamage(p44, -v8);
				p44.HeldItem = nil;
				p43:AddDialogue(p43.ActionList, p44.Name .. " restored health!");
			end;
		end
	};
	u1["Speed Jelly"] = {
		Description = "Give this item to a Doodle to have them boost their speed when their health gets low. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(0, 145, 40), 
		Image = "http://www.roblox.com/asset/?id=7325462367", 
		AfterDamage = function(p46, p47, p48)
			if p47.currenthp <= p47.Stats.hp / 4 and p47.Boosts.spe < 6 then
				p46:AddDialogue(p46.ActionList, "&DOODLENAME," .. p47.ID .. "& used their Speed Jelly!");
				l__Utilities__2.ChangeStats(p46, p47, p47, 100, {
					spe = 1
				});
				p47.HeldItem = nil;
			end;
		end
	};
	u1["Strength Jelly"] = {
		Description = "Give this item to a Doodle to increase the power of one of their weak attacks. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(185, 19, 26), 
		Image = "http://www.roblox.com/asset/?id=7325464522", 
		OffensiveDamageCalc = function(p49, p50, p51, p52, p53)
			if not (p53 < p51.Stats.hp / 4) then
				return p53;
			end;
			p50.HeldItem = nil;
			p49:AddDialogue(p49.ActionList, "&DOODLENAME," .. p50.ID .. "& used their Strength Jelly! This next attack is doing more damage!");
			return p53 * 2;
		end
	};
	u1["Plant Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Plant-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(57, 137, 30), 
		Image = "http://www.roblox.com/asset/?id=9552698960", 
		OffensiveDamageCalc = function(p54, p55, p56, p57, p58)
			if p57.Type ~= "Plant" then
				return p58;
			end;
			p55.HeldItem = nil;
			p54:AddDialogue(p54.ActionList, "&DOODLENAME," .. p55.ID .. "& consumed their Plant Taffy! This attack is doing more damage!");
			return p58 * 1.5;
		end
	};
	u1["Mind Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Mind-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(173, 89, 97), 
		Image = "http://www.roblox.com/asset/?id=9553024865", 
		OffensiveDamageCalc = function(p59, p60, p61, p62, p63)
			if p62.Type ~= "Mind" then
				return p63;
			end;
			p60.HeldItem = nil;
			p59:AddDialogue(p59.ActionList, "&DOODLENAME," .. p60.ID .. "& consumed their Mind Taffy! This attack is doing more damage!");
			return p63 * 1.5;
		end
	};
	u1["Air Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Air-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 212, 227), 
		Image = "http://www.roblox.com/asset/?id=9552702093", 
		OffensiveDamageCalc = function(p64, p65, p66, p67, p68)
			if p67.Type ~= "Air" then
				return p68;
			end;
			p65.HeldItem = nil;
			p64:AddDialogue(p64.ActionList, "&DOODLENAME," .. p65.ID .. "& consumed their Air Taffy! This attack is doing more damage!");
			return p68 * 1.5;
		end
	};
	u1["Basic Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Basic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(136, 136, 136), 
		Image = "http://www.roblox.com/asset/?id=9552701606", 
		OffensiveDamageCalc = function(p69, p70, p71, p72, p73)
			if p72.Type ~= "Basic" then
				return p73;
			end;
			p70.HeldItem = nil;
			p69:AddDialogue(p69.ActionList, "&DOODLENAME," .. p70.ID .. "& consumed their Basic Taffy! This attack is doing more damage!");
			return p73 * 1.5;
		end
	};
	u1["Insect Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Insect-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 209, 84), 
		Image = "http://www.roblox.com/asset/?id=9552701242", 
		OffensiveDamageCalc = function(p74, p75, p76, p77, p78)
			if p77.Type ~= "Insect" then
				return p78;
			end;
			p75.HeldItem = nil;
			p74:AddDialogue(p74.ActionList, "&DOODLENAME," .. p75.ID .. "& consumed their Insect Taffy! This attack is doing more damage!");
			return p78 * 1.5;
		end
	};
	u1["Chain Preserver"] = {
		Description = "Stores a chain for later use. ", 
		Type = "OverworldOnly", 
		Category = "Key Items", 
		InfiniteUses = true, 
		Color3 = Color3.fromRGB(255, 66, 87), 
		Image = "http://www.roblox.com/asset/?id=9631194297", 
		SpecialFunction = function(p79, p80)
			local v9, v10 = p79.ClientDatabase:PDSFunc("ChainPreserver");
			local v11 = "Do you want to store your current chain?";
			if v10.Name then
				if v9.Name then
					v11 = "Do you want to switch your current chain with your stored chain? Current stored chain: #" .. v10.Number .. " for " .. v10.Name .. ".";
				else
					v11 = "Do you want to take out your current preserved chain? Current stored chain: #" .. v10.Number .. " for " .. v10.Name .. ".";
				end;
			end;
			p79.Process = true;
			local v12 = nil;
			if p79.Dialogue:SaySimpleYesNo(v11) == "Yes" then
				p79.Network:post("PreserveChain");
				if v9.Name then
					v12 = "New stored chain: #" .. v9.Number .. " for " .. v9.Name .. ".";
				end;
			end;
			if v12 then
				p79.Gui:SayText("", v12, nil, true);
			end;
			p79.Talky.Visible = false;
			p79.Process = false;
		end
	};
	u1["Crystal Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Crystal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(65, 195, 205), 
		Image = "http://www.roblox.com/asset/?id=9552700861", 
		OffensiveDamageCalc = function(p81, p82, p83, p84, p85)
			if p84.Type ~= "Crystal" then
				return p85;
			end;
			p82.HeldItem = nil;
			p81:AddDialogue(p81.ActionList, "&DOODLENAME," .. p82.ID .. "& consumed their Crystal Taffy! This attack is doing more damage!");
			return p85 * 1.5;
		end
	};
	u1["Food Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Food-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(209, 131, 87), 
		Image = "http://www.roblox.com/asset/?id=9552699828", 
		OffensiveDamageCalc = function(p86, p87, p88, p89, p90)
			if p89.Type ~= "Food" then
				return p90;
			end;
			p87.HeldItem = nil;
			p86:AddDialogue(p86.ActionList, "&DOODLENAME," .. p87.ID .. "& consumed their Food Taffy! This attack is doing more damage!");
			return p90 * 1.5;
		end
	};
	u1["Water Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Water-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(45, 84, 179), 
		Image = "http://www.roblox.com/asset/?id=9552699458", 
		OffensiveDamageCalc = function(p91, p92, p93, p94, p95)
			if p94.Type ~= "Water" then
				return p95;
			end;
			p92.HeldItem = nil;
			p91:AddDialogue(p91.ActionList, "&DOODLENAME," .. p92.ID .. "& consumed their Water Taffy! This attack is doing more damage!");
			return p95 * 1.5;
		end
	};
	u1["Spirit Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Spirit-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(50, 37, 83), 
		Image = "http://www.roblox.com/asset/?id=9553014795", 
		OffensiveDamageCalc = function(p96, p97, p98, p99, p100)
			if p99.Type ~= "Spirit" then
				return p100;
			end;
			p97.HeldItem = nil;
			p96:AddDialogue(p96.ActionList, "&DOODLENAME," .. p97.ID .. "& consumed their Spirit Taffy! This attack is doing more damage!");
			return p100 * 1.5;
		end
	};
	u1["Spark Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Spark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(241, 173, 30), 
		Image = "http://www.roblox.com/asset/?id=9553013394", 
		OffensiveDamageCalc = function(p101, p102, p103, p104, p105)
			if p104.Type ~= "Spark" then
				return p105;
			end;
			p102.HeldItem = nil;
			p101:AddDialogue(p101.ActionList, "&DOODLENAME," .. p102.ID .. "& consumed their Spark Taffy! This attack is doing more damage!");
			return p105 * 1.5;
		end
	};
	u1["Poison Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Poison-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(129, 93, 174), 
		Image = "http://www.roblox.com/asset/?id=9553012344", 
		OffensiveDamageCalc = function(p106, p107, p108, p109, p110)
			if p109.Type ~= "Poison" then
				return p110;
			end;
			p107.HeldItem = nil;
			p106:AddDialogue(p106.ActionList, "&DOODLENAME," .. p107.ID .. "& consumed their Poison Taffy! This attack is doing more damage!");
			return p110 * 1.5;
		end
	};
	u1["Mythic Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Mythic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(34, 48, 119), 
		Image = "http://www.roblox.com/asset/?id=9553011102", 
		OffensiveDamageCalc = function(p111, p112, p113, p114, p115)
			if p114.Type ~= "Mythic" then
				return p115;
			end;
			p112.HeldItem = nil;
			p111:AddDialogue(p111.ActionList, "&DOODLENAME," .. p112.ID .. "& consumed their Mythic Taffy! This attack is doing more damage!");
			return p115 * 1.5;
		end
	};
	u1["Metal Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Metal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(77, 99, 100), 
		Image = "http://www.roblox.com/asset/?id=9553009871", 
		OffensiveDamageCalc = function(p116, p117, p118, p119, p120)
			if p119.Type ~= "Metal" then
				return p120;
			end;
			p117.HeldItem = nil;
			p116:AddDialogue(p116.ActionList, "&DOODLENAME," .. p117.ID .. "& consumed their Metal Taffy! This attack is doing more damage!");
			return p120 * 1.5;
		end
	};
	u1["Light Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Light-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(245, 213, 125), 
		Image = "http://www.roblox.com/asset/?id=9553007659", 
		OffensiveDamageCalc = function(p121, p122, p123, p124, p125)
			if p124.Type ~= "Light" then
				return p125;
			end;
			p122.HeldItem = nil;
			p121:AddDialogue(p121.ActionList, "&DOODLENAME," .. p122.ID .. "& consumed their Light Taffy! This attack is doing more damage!");
			return p125 * 1.5;
		end
	};
	u1["Melee Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Melee-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(191, 57, 49), 
		Image = "http://www.roblox.com/asset/?id=9553008930", 
		OffensiveDamageCalc = function(p126, p127, p128, p129, p130)
			if p129.Type ~= "Melee" then
				return p130;
			end;
			p127.HeldItem = nil;
			p126:AddDialogue(p126.ActionList, "&DOODLENAME," .. p127.ID .. "& consumed their Melee Taffy! This attack is doing more damage!");
			return p130 * 1.5;
		end
	};
	u1["Ice Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Ice-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(107, 187, 213), 
		Image = "http://www.roblox.com/asset/?id=9553006558", 
		OffensiveDamageCalc = function(p131, p132, p133, p134, p135)
			if p134.Type ~= "Ice" then
				return p135;
			end;
			p132.HeldItem = nil;
			p131:AddDialogue(p131.ActionList, "&DOODLENAME," .. p132.ID .. "& consumed their Ice Taffy! This attack is doing more damage!");
			return p135 * 1.5;
		end
	};
	u1["Fire Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Fire-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(213, 67, 5), 
		Image = "http://www.roblox.com/asset/?id=9553005518", 
		OffensiveDamageCalc = function(p136, p137, p138, p139, p140)
			if p139.Type ~= "Fire" then
				return p140;
			end;
			p137.HeldItem = nil;
			p136:AddDialogue(p136.ActionList, "&DOODLENAME," .. p137.ID .. "& consumed their Fire Taffy! This attack is doing more damage!");
			return p140 * 1.5;
		end
	};
	u1["Earth Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Earth-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(164, 116, 91), 
		Image = "http://www.roblox.com/asset/?id=9553004221", 
		OffensiveDamageCalc = function(p141, p142, p143, p144, p145)
			if p144.Type ~= "Earth" then
				return p145;
			end;
			p142.HeldItem = nil;
			p141:AddDialogue(p141.ActionList, "&DOODLENAME," .. p142.ID .. "& consumed their Earth Taffy! This attack is doing more damage!");
			return p145 * 1.5;
		end
	};
	u1["Dark Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Dark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(61, 62, 63), 
		Image = "http://www.roblox.com/asset/?id=9553003459", 
		OffensiveDamageCalc = function(p146, p147, p148, p149, p150)
			if p149.Type ~= "Dark" then
				return p150;
			end;
			p147.HeldItem = nil;
			p146:AddDialogue(p146.ActionList, "&DOODLENAME," .. p147.ID .. "& consumed their Dark Taffy! This attack is doing more damage!");
			return p150 * 1.5;
		end
	};
	u1["Beast Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Beast-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(119, 60, 46), 
		Image = "http://www.roblox.com/asset/?id=9553001420", 
		OffensiveDamageCalc = function(p151, p152, p153, p154, p155)
			if p154.Type ~= "Beast" then
				return p155;
			end;
			p152.HeldItem = nil;
			p151:AddDialogue(p151.ActionList, "&DOODLENAME," .. p152.ID .. "& consumed their Beast Taffy! This attack is doing more damage!");
			return p155 * 1.5;
		end
	};
	u1["Magical Jelly"] = {
		Description = "Give this item to a Doodle to increase the power of one of their magical attacks. This item is consumed  after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(185, 19, 26), 
		Image = "http://www.roblox.com/asset/?id=7325462966", 
		OffensiveDamageCalc = function(p156, p157, p158, p159, p160)
			if p159.Category ~= "Magical" then
				return p160;
			end;
			p157.HeldItem = nil;
			p156:AddDialogue(p156.ActionList, "&DOODLENAME," .. p157.ID .. "& used their Magical Jelly! This next attack is doing more damage!");
			return p160 * 1.2;
		end
	};
	u1["Defensive Jelly"] = {
		Description = "Give this item to a Doodle to reduce the power of a super-effective attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(51, 11, 153), 
		Image = "http://www.roblox.com/asset/?id=7325543224", 
		DuringDamageCalc = function(p161, p162, p163, p164, p165)
			if not (p1.Database.Typings:GetEffectiveness(p162, p163, p164.Type) > 1) then
				return p165;
			end;
			p161:AddDialogue(p161.ActionList, "&DOODLENAME," .. p163.ID .. "&'s Defensive Jelly reduced the damage of this attack!");
			p163.HeldItem = nil;
			return math.floor(p165 * 0.7);
		end
	};
	u1["Weird Jelly"] = {
		Description = "Give this item to a Doodle to boost their attack and magic attack after they are hit with a super effective attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(44, 44, 44), 
		Image = "http://www.roblox.com/asset/?id=8864653270", 
		AfterDamage = function(p166, p167, p168, p169)
			if not p168 then
				return;
			end;
			if p1.Database.Typings:GetEffectiveness(p168, p167, p169.Type) > 1 then
				p166:AddDialogue(p166.ActionList, "&DOODLENAME," .. p167.ID .. "&'s Weird Jelly activated!");
				l__Utilities__2.ChangeStats(p166, p167, p167, 100, {
					atk = 1, 
					matk = 1
				});
				p167.HeldItem = nil;
			end;
		end
	};
	u1["Power Jelly"] = {
		Description = "Give this item to a Doodle to restore their stats when they are lowered.  This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(175, 175, 174), 
		Image = "http://www.roblox.com/asset/?id=8864653882", 
		OnStatChange = function(p170, p171, p172, p173, p174)
			local v13 = nil;
			for v14, v15 in pairs(p171.Boosts) do
				if p171.Boosts[v14] < 0 then
					v13 = true;
					p171.Boosts[v14] = 0;
				end;
			end;
			if v13 then
				p170:AddDialogue(p170.ActionList, "&DOODLENAME," .. p171.ID .. "&'s Power Jelly prevented their stats from lowering!");
				p171.HeldItem = nil;
			end;
		end
	};
	u1["Candy Heart"] = {
		Description = "This weird object made of candy fits snugly in your hand, and feels as though it'll start beating.  Allows a certain Doodle to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8830143801", 
		Function = function(p175, p176, p177)
			if p176 then
				return false;
			end;
			if not u3(p175, "Candy Heart") then
				return (p175.Nickname or p175.Name) .. " cannot evolve using the Candy Heart!";
			end;
			if game:GetService("RunService"):IsServer() then
				p175:EvolveItem(p177, "Candy Heart");
				return true;
			end;
			return "Evolving " .. (p175.Nickname or p175.Name) .. "...", true;
		end
	};
	u1["Orb of Light"] = {
		Description = "This strange orb of light allows certain Doodles to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(255, 255, 127), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8463939552", 
		Function = function(p178, p179, p180)
			if p179 then
				return false;
			end;
			if not u3(p178, "Orb of Light") then
				return (p178.Nickname or p178.Name) .. " cannot evolve using the Orb of Light!";
			end;
			if game:GetService("RunService"):IsServer() then
				p178:EvolveItem(p180, "Orb of Light");
				return true;
			end;
			return "Evolving " .. (p178.Nickname or p178.Name) .. "...", true;
		end
	};
	u1["Gold Capsule"] = {
		Description = "Use this on a wild Doodle to capture it. This capsule will never fail on a wild doodle.", 
		Target = "Capsule", 
		CaptureRate = "Gold", 
		Price = 50, 
		RobuxOnly = true, 
		DevProduct = 1251977223, 
		Category = "Capsules", 
		BattleOnly = true, 
		Color3 = Color3.fromRGB(255, 224, 79), 
		CapsuleName = "Gold", 
		Image = "http://www.roblox.com/asset/?id=9195088516", 
		Function = function(p181, p182, p183)

		end
	};
	u1["Striped Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture than Basic Capsules.", 
		Target = "Capsule", 
		CaptureRate = 1.5, 
		Price = 800, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Striped", 
		Image = "http://www.roblox.com/asset/?id=6493788764", 
		Function = function(p184, p185, p186)

		end
	};
	u1["Basic Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Price = 400, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Basic", 
		Image = "http://www.roblox.com/asset/?id=5723539856", 
		Function = function(p187, p188, p189)

		end
	};
	u1["Magical Banana"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its magic attack.", 
		Target = "Out", 
		Price = 1000, 
		BattleOnly = true, 
		Category = "Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5723459665", 
		Function = function(p190, p191, p192)
			p190.Boosts.matk = p190.Boosts.matk + 2;
			return true;
		end
	};
	u1["Power Banana"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its attack.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(255, 255, 0), 
		Image = "http://www.roblox.com/asset/?id=5723501902", 
		Function = function(p193, p194, p195)
			p193.Boosts.atk = p193.Boosts.atk + 2;
			return true;
		end
	};
	u1["Speed Soda"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its speed.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5721610564", 
		Function = function(p196, p197, p198)
			p196.Boosts.spe = p196.Boosts.spe + 2;
			return true;
		end
	};
	u1["Defense Orange"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its defense.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(255, 85, 0), 
		Image = "http://www.roblox.com/asset/?id=5723467215", 
		Function = function(p199, p200, p201)
			p199.Boosts.def = p199.Boosts.def + 2;
			return true;
		end
	};
	u1["Resist Grapes"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its magical defense.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(170, 85, 255), 
		Image = "http://www.roblox.com/asset/?id=5721610847", 
		Function = function(p202, p203, p204)
			p202.Boosts.mdef = p202.Boosts.mdef + 2;
			return true;
		end
	};
	u1["Starry Glasses"] = {
		Description = "Give this item to a Doodle and when it gets sent out, identifies the stars the opponents have.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(250, 208, 86), 
		Image = "http://www.roblox.com/asset/?id=9443817615", 
		SendOut = function(p205, p206, p207)
			local v16 = "Stars";
			if p207.Star == 1 then
				v16 = "Star";
			end;
			p205:AddDialogue(p205.ActionList, "&DOODLENAME," .. p207.ID .. "&" .. " has " .. p207.Star .. " " .. v16 .. "!");
		end
	};
	u1.Glasses = {
		Description = "Give this item to a Doodle to improve its accuracy.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5721611157", 
		AttackModifier = function(p208, p209, p210, p211)
			if typeof(p211.Accuracy) == "number" then
				p211.Accuracy = p211.Accuracy + 20;
			end;
		end
	};
	u1["Ice Pack"] = {
		Description = "Give this item to a Doodle to improve the damage of its Ice-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(84, 120, 201), 
		Image = "http://www.roblox.com/asset/?id=9136451114", 
		ModifyDamage = function(p212, p213, p214, p215)
			local v17 = 1;
			if p215.Type == "Ice" then
				v17 = 1.2;
			end;
			return v17;
		end
	};
	u1["Lucky Pebble"] = {
		Description = "Give this item to a Doodle to improve the damage of its Earth-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(84, 120, 201), 
		Image = "http://www.roblox.com/asset/?id=9135923816", 
		ModifyDamage = function(p216, p217, p218, p219)
			local v18 = 1;
			if p219.Type == "Earth" then
				v18 = 1.2;
			end;
			return v18;
		end
	};
	u1.Battery = {
		Description = "Give this item to a Doodle to improve the damage of its Spark-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(236, 201, 98), 
		Image = "http://www.roblox.com/asset/?id=9136628337", 
		ModifyDamage = function(p220, p221, p222, p223)
			local v19 = 1;
			if p223.Type == "Spark" then
				v19 = 1.2;
			end;
			return v19;
		end
	};
	u1["Used Timber"] = {
		Description = "Give this item to a Doodle to improve the damage of its Fire-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(68, 47, 45), 
		Image = "http://www.roblox.com/asset/?id=9136096252", 
		ModifyDamage = function(p224, p225, p226, p227)
			local v20 = 1;
			if p227.Type == "Fire" then
				v20 = 1.25;
			end;
			return v20;
		end
	};
	u1["Champion Belt"] = {
		Description = "Give this item to a Doodle to improve its physical attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(248, 196, 100), 
		Image = "http://www.roblox.com/asset/?id=6830108296", 
		ModifyDamage = function(p228, p229, p230, p231)
			local v21 = 1;
			if p231.Category == "Physical" then
				v21 = 1.1;
			end;
			return v21;
		end
	};
	u1["Determination Jelly"] = {
		Description = "Give this item to a Doodle. If they have full HP, the holder will survive an attack that would otherwise cause it to faint. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(224, 84, 3), 
		Image = "http://www.roblox.com/asset/?id=7325471960", 
		DuringDamageCalc = function(p232, p233, p234, p235, p236)
			local v22 = false;
			if typeof(p236) == "number" and p236 > 0 and p234.Stats.hp <= p236 and p234.Stats.hp <= p234.currenthp then
				p232:AddDialogue(p232.ActionList, "&DOODLENAME," .. p234.ID .. "& held on thanks to its Determination Jelly!");
				p236 = p234.currenthp - 1;
				v22 = true;
				p234.HeldItem = nil;
			end;
			return p236, v22;
		end
	};
	u1["Determination Headband"] = {
		Description = "Give this item to a Doodle. The Doodle may survive attacks that would otherwise cause it to faint.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(193, 80, 58), 
		Image = "http://www.roblox.com/asset/?id=6832985197", 
		DuringDamageCalc = function(p237, p238, p239, p240, p241)
			local v23 = false;
			if typeof(p241) == "number" and p241 > 0 and math.random(1, 8) == 1 and p239.currenthp <= p241 then
				p237:AddDialogue(p237.ActionList, "&DOODLENAME," .. p239.ID .. "& held on thanks to its Determination!");
				p241 = p239.currenthp - 1;
				v23 = true;
			end;
			return p241, v23;
		end
	};
	u1.Grease = {
		Description = "Give this item to a Doodle to prevent it from getting trapped or wrapped.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(207, 187, 127), 
		Image = "http://www.roblox.com/asset/?id=9135977089", 
		Grease = true
	};
	u1["Used Crayons"] = {
		Description = "Give this item to a Doodle to have it restore a little bit of its health at the end of every turn.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6852190534", 
		EndTurn = function(p242, p243, p244)
			if p243.currenthp > 0 and p243.currenthp < p243.Stats.hp then
				p242:TakeDamage(p243, -math.floor(p243.Stats.hp / 16));
				p242:AddDialogue(p242.ActionList, "&DOODLENAME," .. p243.ID .. "& restored health from its Used Crayons!");
			end;
		end
	};
	u1.Laminate = {
		Description = "Give this item to a Doodle to preserve it, stopping it from evolving.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6845111599", 
		NoEvolve = true
	};
	u1["Level-Down Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels down.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 200, 
		LevelupItem = true, 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(85, 111, 121), 
		Image = "http://www.roblox.com/asset/?id=9283898560", 
		Function = function(p245, p246, p247)
			if p246 then
				return false;
			end;
			if p245.Level <= 5 then
				return (p245.Nickname or p245.Name) .. " is too low level!";
			end;
			if game:GetService("RunService"):IsServer() then
				p245:LevelDown(p247, true, false, true);
				return true;
			end;
			return (p245.Nickname or p245.Name) .. " leveled down!", true, "Levelup";
		end
	};
	u1["Level-Up Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels up!", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 20, 
		RobuxOnly = true, 
		LevelupItem = true, 
		DevProduct = 1197967011, 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(65, 29, 2), 
		Image = "http://www.roblox.com/asset/?id=8951230295", 
		Function = function(p248, p249, p250)
			if p249 then
				return false;
			end;
			local v24 = l__Utilities__2.LevelCap(p250);
			if v24 < p248.Level + 1 then
				return (p248.Nickname or p248.Name) .. " is already past the level cap (" .. v24 .. ")!";
			end;
			if game:GetService("RunService"):IsServer() then
				p248:Levelup(p250, true, false, true);
				return true;
			end;
			return (p248.Nickname or p248.Name) .. " leveled up!", true, "Levelup";
		end
	};
	u1["Silver Level-Up Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels up three times!", 
		Type = "OverworldOnly", 
		LevelupItem = true, 
		Target = "Party", 
		Category = "Items", 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=8951231016", 
		Function = function(p251, p252, p253)
			if p252 then
				return false;
			end;
			if l__Utilities__2.LevelCap(p253) < p251.Level + 3 then
				return (p251.Nickname or p251.Name) .. " is too high level...";
			end;
			if not game:GetService("RunService"):IsServer() then
				return (p251.Nickname or p251.Name) .. " leveled up thrice!", true, "Levelup";
			end;
			local v25 = {};
			for v26 = 1, 3 do
				v25 = p251:Levelup(p253, true, true, v26 == 3, v25);
			end;
			return true;
		end
	};
	u1["Master Cube"] = {
		Description = "[DEV ITEM] When this item is used on a Doodle, the Doodle levels up to 100!", 
		Type = "OverworldOnly", 
		LevelupItem = true, 
		Target = "Party", 
		Category = "Items", 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(120, 120, 120), 
		Image = "http://www.roblox.com/asset/?id=8962603595", 
		Function = function(p254, p255, p256, p257)
			if p255 then
				return false;
			end;
			if p254.Level >= 100 then
				return (p254.Nickname or p254.Name) .. " is already level 100!";
			end;
			if not game:GetService("RunService"):IsServer() then
				return (p254.Nickname or p254.Name) .. " is now level 100!", true, "Levelup";
			end;
			local v27 = {};
			local v28 = 100 - p254.Level;
			for v29 = 1, v28 do
				v27 = p254:Levelup(p256, true, true, v29 == v28, v27);
			end;
			return true;
		end
	};
	u1["Training Helper"] = {
		Description = "If this item is on, every Doodle in your party gets experience in each battle.", 
		Type = "Toggleable", 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5755227686"
	};
	u1["Spectator Camera"] = {
		Description = "This camera allows you to spectate other people's battles.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5786118191", 
		SpecialFunction = function(p258, p259)
			p259:Destroy();
			p258.SpectateBattle.new({});
		end
	};
	u1["Skin Trunk"] = {
		Description = "This leather briefcase lets you see all your un-equipped skins.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8734085982", 
		SpecialFunction = function(p260, p261)
			p261.ItemUI.Visible = false;
			p260.SkinInventory.new({
				Bag = p261
			});
			p260.Talky.Visible = false;
		end
	};
	local v30 = {
		Description = "Allows to see your current Doodle chain.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6832985555"
	};
	local function u5(p262, p263)
		return tonumber(string.format("%." .. (p263 and 0) .. "f", (math.min(100, p262 * 100))));
	end;
	function v30.SpecialFunction(p264, p265)
		p264.Process = true;
		local v31, v32 = p264.ClientDatabase:PDSFunc("GetChain", false);
		local v33 = u5(v32.Misprint, 2) .. "%";
		local v34 = u5(v32.Skin, 2) .. "%";
		local v35 = u5(v32.HT, 2) .. "%";
		if v32.Prestige then
			local v36 = "Yes";
		else
			v36 = "No";
		end;
		if v31.Name then
			p264.Gui:SayText("", v31.Name .. " chances at #" .. v31.Number .. ": Misprint chance: " .. v33 .. ". Skin chance: " .. v34 .. ". Hidden trait chance: " .. v35 .. ". Prestige unlocked: " .. v36 .. ".", nil, true);
		else
			p264.Gui:SayText("", "You are currently not chaining anything.", nil, true);
		end;
		p264.Talky.Visible = false;
		p264.Process = false;
	end;
	u1["Tally Counter"] = v30;
	u1["Opal Orb"] = {
		Description = "An Opal Orb containing the soul of Craig. Also allows you to encounter Maelzuri in the Crystal Caverns.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(236, 232, 234), 
		Image = "http://www.roblox.com/asset/?id=9423140689", 
		SpecialFunction = function(p266, p267)
			p266.Process = true;
			p266.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p266.Talky.Visible = false;
			p266.Process = false;
		end
	};
	u1.Memento = {
		Description = "A memento from the good old days.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=7297929502", 
		SpecialFunction = function(p268, p269)
			p268.Process = true;
			p268.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p268.Talky.Visible = false;
			p268.Process = false;
		end
	};
	u1["Pristine Axe"] = {
		Description = "An axe used to chop down trees and wooden doors.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(131, 160, 183), 
		Image = "http://www.roblox.com/asset/?id=9552475405", 
		SpecialFunction = function(p270, p271)
			p270.Process = true;
			p270.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p270.Talky.Visible = false;
			p270.Process = false;
		end
	};
	u1["Money Trinket"] = {
		Description = "Allows you to get double money from tamer battles and help center requests.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9145190706", 
		SpecialFunction = function(p272, p273)
			p272.Process = true;
			p272.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p272.Talky.Visible = false;
			p272.Process = false;
		end
	};
	u1["Magnifying Glass"] = {
		Description = "Allows you to view wild Doodle's stats.", 
		InfiniteUses = true, 
		Category = "Key Items", 
		BattleOnly = true, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9137034166", 
		LocalFunction = function(p274, p275)
			local l__Battle__37 = p275.Battle;
			if not l__Battle__37 then
				p274.Process = true;
				p274.Gui:SayText("", "There's a time and place for everything.", nil, true);
				p274.Talky.Visible = false;
				p274.Process = false;
				return;
			end;
			if l__Battle__37.BattleType ~= "Wild" then
				p274.Gui:SayText("", "You can only use the Magnifying Glass against Wild Doodles!", nil, true);
				p274.Talky.Visible = false;
				p274.Process = false;
				return;
			end;
			p275:Hide();
			local v38 = l__Battle__37.BattleData.Out2[1];
			v38.OriginalOwner = "Unknown";
			local v39 = {
				NoTamer = true, 
				NoMoveSwap = true, 
				Battle = l__Battle__37.BattleData
			};
			function v39.CloseFunc()
				p274.guiholder.MainBattle.Visible = true;
			end;
			p274.Stats.new(v39, v38);
		end
	};
	u1["Hidden Trait Trinket"] = {
		Description = "You are more likely to meet Doodles who have their hidden trait.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205213322", 
		SpecialFunction = function(p276, p277)
			p276.Process = true;
			p276.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p276.Talky.Visible = false;
			p276.Process = false;
		end
	};
	u1["Worn-Out Misprint Trinket"] = {
		Description = "You are more likely to meet misprinted Doodles. However, because it's worn out, the effect isn't as potent.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205804692", 
		SpecialFunction = function(p278, p279)
			p278.Process = true;
			p278.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p278.Talky.Visible = false;
			p278.Process = false;
		end
	};
	u1["Misprint Trinket"] = {
		Description = "You are more likely to meet misprinted Doodles.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8964981590", 
		SpecialFunction = function(p280, p281)
			p280.Process = true;
			p280.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p280.Talky.Visible = false;
			p280.Process = false;
		end
	};
	u1["Worn-Out Mythical Trinket"] = {
		Description = "You are more likely to meet doodles of Legend. However, because it's worn out, the effect isn't as potent.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205534035", 
		SpecialFunction = function(p282, p283)
			p282.Process = true;
			p282.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p282.Talky.Visible = false;
			p282.Process = false;
		end
	};
	u1["Mythical Trinket"] = {
		Description = "You are more likely to meet doodles of Legend.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205212570", 
		SpecialFunction = function(p284, p285)
			p284.Process = true;
			p284.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p284.Talky.Visible = false;
			p284.Process = false;
		end
	};
	u1["Equipment Case"] = {
		Description = "A case that holds all your equipment.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=7657468277", 
		SpecialFunction = function(p286, p287)
			p287.ItemUI.Visible = false;
			p286.Equip.new({
				Bag = p287, 
				ForcePage = "Helmet"
			});
			p286.Talky.Visible = false;
		end
	};
	local v40 = {
		Description = "You can use this item for a free Roulette spin! However, the Doodle you get will be trade-locked.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(29, 124, 212), 
		Image = "http://www.roblox.com/asset/?id=9407500752"
	};
	local u6 = false;
	function v40.NonPartyFunc(p288, p289)
		if u6 then
			return;
		end;
		u6 = true;
		if not p288.ClientDatabase:PDSFunc("IsMaximum") then
			p288.Sound:Play("BasicClick", 0.8);
			p289:Destroy();
			p288.ClientDatabase:PDSFunc("RouletteSpin", true);
		else
			p288.Gui:TextAnnouncement("You have no space for any more Doodles.");
		end;
		u6 = nil;
	end;
	u1["Roulette Ticket"] = v40;
	u1["Stat Candy"] = {
		Description = "This item lets you change the stat bonuses of a Doodle.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 1500, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8734086723", 
		StatCandy = true
	};
	u1["Hidden Trait Badge"] = {
		Description = "[DEV ITEM] Changes Doodle's Trait to Hidden Trait", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=7244408626", 
		Function = function(p290, p291, p292)
			local v41 = nil;
			if p291 then
				return false;
			end;
			local v42 = p290.Nickname or p290.Name;
			if game:GetService("RunService"):IsServer() then
				return p290:ChangeAbility("Hidden");
			end;
			local v43 = p1.DoodleInfo[p290.Name];
			v41 = v43.HiddenAbility;
			if p290.Ability == v43.HiddenAbility then
				return v42 .. " already has its hidden trait (" .. v41 .. ")!";
			end;
			return v42 .. "'s trait changed to " .. v41 .. "!", true;
		end
	};
	u1["Trait Badge"] = {
		Description = "This badge allows you to swap a Doodle's trait.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=6833202115", 
		Function = function(p293, p294, p295)
			if p294 then
				return false;
			end;
			local v44 = p293.Nickname or p293.Name;
			if game:GetService("RunService"):IsServer() then
				return p293:ChangeAbility();
			end;
			local v45 = p1.DoodleInfo[p293.Name];
			local l__Abilities__46 = v45.Abilities;
			local v47 = l__Abilities__46[1];
			if #l__Abilities__46 == 1 and p293.Ability == v45.HiddenAbility then
				v47 = l__Abilities__46[1];
			else
				if #l__Abilities__46 == 1 then
					return v44 .. " only has 1 normal trait.";
				end;
				if p293.Ability == l__Abilities__46[1] then
					v47 = l__Abilities__46[2];
				end;
			end;
			return v44 .. " changed trait to " .. v47 .. "!", true;
		end
	};
	u1["Friendship Ribbon"] = {
		Description = "A doodle holding this item becomes friendlier faster.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6832984941", 
		FriendshipModifier = 2
	};
	u1.Scroll = {
		Description = "PLACEHOLDER TEXT - REPORT IF YOU CAN SEE THIS.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Scrolls", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5806222018"
	};
	return u1;
end;
