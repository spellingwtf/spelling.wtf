-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {
		["No ability"] = {
			Description = "no ability"
		}, 
		Nullify = {
			Description = "When this Doodle's out, all Doodle's traits cannot be activated.", 
			Neutralize = true, 
			BeforeSendOut = function(p2, p3)
				p2:AddDialogue(p2.ActionList, "&DOODLENAME," .. p3.ID .. "& nullified all other traits!");
			end
		}, 
		Mimic = {
			Description = "When this Doodle is sent out, copies the opposing Doodle's trait.", 
			Neutralize = true, 
			SendOut = function(p4, p5, p6)
				if not (p6.currenthp > 0) or not p6.Ability or not (not table.find({ "Nullify", "Mimic" }, p6.Ability)) then
					return;
				end;
				p5.Ability = p6.Ability;
				p4:AddDialogue(p4.ActionList, "&DOODLENAME," .. p5.ID .. "&" .. " is mimicking " .. p6.Ability .. "!");
				return true;
			end
		}, 
		Savage = {
			Description = "This Doodle\226\128\153s Beast-type attacks do 30% more damage.", 
			ModifyDamage = function(p7, p8, p9, p10)
				if p10.Type == "Beast" then
					return 1.3;
				end;
				return 1;
			end
		}, 
		["Hidden Strength"] = {
			Description = "Doubles this Doodle's Attack stat.", 
			DoubleAttack = true
		}, 
		Gloomy = {
			Description = "Every Doodle's Dark-type moves do 30% more damage.", 
			ModifyDamageField = function(p11, p12, p13, p14)
				if p14.Type == "Dark" then
					return 1.3;
				end;
				return 1;
			end
		}, 
		["Stabby Stabby"] = {
			Description = "This Doodle\226\128\153s Metal-type attacks do 30% more damage.", 
			ModifyDamage = function(p15, p16, p17, p18)
				if p18.Type == "Metal" then
					return 1.3;
				end;
				return 1;
			end
		}, 
		Vitality = {
			Description = "This Doodle has a 50% increased speed stat when they are over half health.", 
			ModifySpeed = function(p19, p20, p21)
				if not (p20.Stats.hp / 2 < p20.currenthp) then
					return p21;
				end;
				return p21 + p21 * 0.5;
			end
		}, 
		Rush = {
			Description = "This Doodle has a 20% increased speed stat in battle.", 
			ModifySpeed = function(p22, p23, p24)
				return p24 + p24 * 0.2;
			end
		}
	};
	local v3 = {
		Description = "When this Doodle uses a magical attack, they have a 20% chance to boost their magical attack."
	};
	local l__ChangeStats__1 = l__Utilities__1.ChangeStats;
	function v3.BattleFunc(p25, p26, p27, p28)
		if p28.Category == "Magical" then
			l__ChangeStats__1(p25, p26, p26, 20, {
				matk = 1
			});
		end;
	end;
	v2.Magician = v3;
	v2.Scorch = {
		Description = "When this Doodle uses a Fire-type attack, they have a 20% chance to boost their magical attack.", 
		BattleFunc = function(p29, p30, p31, p32)
			if p32.Type == "Fire" and p32.Category ~= "Passive" then
				l__ChangeStats__1(p29, p30, p30, 20, {
					matk = 1
				});
			end;
		end
	};
	v2.Scavenge = {
		Description = "At the end of every wild battle, has a chance to pick up a random item."
	};
	v2.Puncture = {
		Description = "This Doodle\226\128\153s contact moves have a 30% chance to lower the target\226\128\153s defense.", 
		BattleFunc = function(p33, p34, p35, p36)
			if p36.Contact and p36.Category ~= "Passive" then
				l__ChangeStats__1(p33, p34, p35, 30, {
					def = -1
				});
			end;
		end
	};
	v2["Blinding Rocks"] = {
		Description = "When this Doodle uses an Earth-type attack, they have a 20% chance to lower the target\226\128\153s accuracy.", 
		BattleFunc = function(p37, p38, p39, p40)
			if p40.Type == "Earth" and p40.Category ~= "Passive" then
				l__ChangeStats__1(p37, p38, p39, 20, {
					acc = -1
				});
			end;
		end
	};
	v2.Whimsical = {
		Description = "This Doodle boosts a random stat and lowers another at the end of each turn.", 
		EndTurn = function(p41, p42, p43)
			local v4 = { "atk", "def", "matk", "mdef", "spe", "acc", "eva" };
			local v5 = table.remove(v4, math.random(#v4));
			local v6 = table.remove(v4, math.random(#v4));
			if p42.Status ~= "Faint" then
				l__ChangeStats__1(p41, p42, p42, 100, {
					[v5] = 1
				});
				l__ChangeStats__1(p41, p42, p42, 100, {
					[v6] = -1
				});
			end;
		end
	};
	v2.Molt = {
		Description = "This Doodle has a 25% chance to cure their status condition at the end of each turn.", 
		EndTurn = function(p44, p45, p46)
			if p45.Status and p45.Status ~= "Faint" and math.random(1, 4) == 1 then
				p45.Status = nil;
				p44:AddDialogue(p44.ActionList, "&DOODLENAME," .. p45.ID .. "&" .. " molted its skin and cured its " .. p45.Status:lower() .. " status!");
				p44:AddAction(p44.ActionList, {
					Player = p45.Owner, 
					Doodle = p45, 
					Action = "StatusAnim", 
					Status = ""
				});
			end;
		end
	};
	v2["Storm Surge"] = {
		Description = "If it\226\128\153s raining, this Doodle boosts their speed at the end of each turn.", 
		EndTurn = function(p47, p48, p49)
			if p48.currenthp > 0 and p47.Weather == "Rain" then
				l__ChangeStats__1(p47, p48, p48, 100, {
					spe = 1
				});
			end;
		end
	};
	v2.Firewall = {
		Description = "When this Doodle is sent out into battle, they summon a Flame Shield that shoots a Firebolt at any opposing Doodle that hits them with magical attack.", 
		SendOut = function(p50, p51, p52)
			p51.FlameShield = true;
			p50:AddDialogue(p50.ActionList, "&DOODLENAME," .. p51.ID .. "& is now surrounded by a flame shield!");
			p51.OnHit = p51.OnHit or {};
			if not p51.OnHit.FlameShield then
				p51.OnHit.FlameShield = function(p53, p54, p55, p56)
					if p51.FlameShield and p51.currenthp > 0 and p56.Category == "Magical" and not p56.NoFirewall then
						p53:AddDialogue(p53.ActionList, "&DOODLENAME," .. p54.ID .. "&'s Flame Shield shoots a Fire Bolt!");
						p53:UseMove(p54, { p55 }, "FirewallFirebolt", true);
					end;
				end;
			end;
		end
	};
	v2.Parry = {
		Description = "This Doodle has a 10% chance to parry contact moves, avoiding damage.", 
		ModifyDefendDamage = function(p57, p58, p59, p60, p61, p62, p63)
			if p60.Contact and p60.Category == "Physical" and math.random(1, 100) > 90 and p63 == nil then
				p57:AddDialogue(p57.ActionList, "&DOODLENAME," .. p59.ID .. "& parried the attack!");
				return 0;
			end;
			return 1;
		end
	};
	v2["Royal Decree"] = {
		Description = "If another Doodle is faster, this Doodle takes 30% less damage from their attacks.", 
		ModifyDefendDamage = function(p64, p65, p66, p67, p68, p69, p70)
			if p66.Stats.spe < p65.Stats.spe then
				return 0.7;
			end;
			return 1;
		end
	};
	v2["Sharp Reflexes"] = {
		Description = "If another Doodle is slower, their attacks on this Doodle miss 15% more often.", 
		AccCalc = function(p71, p72, p73, p74)
			local v7 = p74;
			if typeof(v7) == "number" and v7 < 100 and p73.Stats.spe < p72.Stats.spe then
				v7 = v7 * 0.85;
			end;
			return v7;
		end
	};
	v2.Guilt = {
		Description = "When this Doodle is hit by an attack, lower the user's attack.", 
		OnHit = function(p75, p76, p77, p78)
			if p78.Category ~= "Passive" then
				p75:AddDialogue(p75.ActionList, "&DOODLENAME," .. p77.ID .. "&" .. " felt guilt attacking " .. "&DOODLENAME," .. p76.ID .. "&!");
				l__ChangeStats__1(p75, p76, p77, 100, {
					atk = -1
				});
			end;
		end
	};
	v2.Rugged = {
		Description = "If this Doodle is hit with a contact move, they do some damage back.", 
		OnHit = function(p79, p80, p81, p82)
			if p82.Contact then
				local v8 = math.floor(p81.Stats.hp / 10);
				if v8 > 0 then
					p79:TakeDamage(p81, v8);
					p79:AddDialogue(p79.ActionList, "&DOODLENAME," .. p80.ID .. "&" .. "'s rugged edges hurt " .. "&DOODLENAME," .. p81.ID .. "&!");
				end;
			end;
		end
	};
	v2.Retaliate = {
		Description = "If this Doodle is hit with a contact move, they do some damage back.", 
		OnHit = function(p83, p84, p85, p86)
			if p86.Contact then
				local v9 = math.floor(p85.Stats.hp / 10);
				if v9 > 0 then
					p83:TakeDamage(p85, v9);
					p83:AddDialogue(p83.ActionList, "&DOODLENAME," .. p84.ID .. "&" .. " hurt " .. "&DOODLENAME," .. p85.ID .. "&!");
				end;
			end;
		end
	};
	v2["Steam Guard"] = {
		Description = "If this Doodle is hit with a Water-type move, boost their evasion.", 
		OnHit = function(p87, p88, p89, p90)
			if p88.currenthp > 0 and p90.Type == "Water" then
				l__ChangeStats__1(p87, p88, p88, 100, {
					eva = 1
				});
			end;
		end
	};
	local v10 = {
		Description = "This Doodle\226\128\153s contact moves have a 20% chance to flinch."
	};
	local l__InflictStatus__2 = l__Utilities__1.InflictStatus;
	function v10.BattleFunc(p91, p92, p93, p94)
		if p94.Category ~= "Passive" and p94.Contact == true and p93.currenthp > 0 then
			l__InflictStatus__2(p91, p92, p93, 20, "Flinch", nil, AdditionalMsg);
		end;
	end;
	v2.Stinky = v10;
	v2.Kaleidoscope = {
		Description = "When this Doodle is sent out into battle, they lower the accuracy of opposing Doodles.", 
		BeforeSendOut = function(p95, p96)
			p95:AddDialogue(p95.ActionList, "&DOODLENAME," .. p96.ID .. "& emits a blinding light and tried to lower the other team's accuracy!");
		end, 
		SendOut = function(p97, p98, p99)
			l__ChangeStats__1(p97, p98, p99, 100, {
				acc = -1
			});
		end
	};
	v2.Deepfreeze = {
		Description = "This Doodle\226\128\153s moves have a 2x chance to freeze.", 
		StatusModifier = function(p100, p101, p102, p103, p104)
			if p103 ~= "Freeze" then
				return p103, p104;
			end;
			return p103, p104 * 2;
		end
	};
	v2.Kindling = {
		Description = "This Doodle\226\128\153s moves have a 2x chance to burn.", 
		StatusModifier = function(p105, p106, p107, p108, p109)
			if p108 ~= "Burn" then
				return p108, p109;
			end;
			return p108, p109 * 2;
		end
	};
	v2["First Degree Burns"] = {
		Description = "If an opposing Doodle is burned, they take double damage at the end of each turn.", 
		BurnModifier = true
	};
	v2["Strong Armor"] = {
		Description = "If this Doodle is hit with a contact move, boost their defense.", 
		OnHit = function(p110, p111, p112, p113)
			if p111.currenthp > 0 and p113.Contact then
				l__ChangeStats__1(p110, p111, p111, 100, {
					def = 1
				});
			end;
		end
	};
	v2.Sticky = {
		Description = "If this Doodle is hit with a contact move, they lower the attacker\226\128\153s speed.", 
		OnHit = function(p114, p115, p116, p117)
			if p115.currenthp > 0 and p117.Contact then
				l__ChangeStats__1(p114, p115, p116, 100, {
					spe = -1
				});
			end;
		end
	};
	v2.Concentrated = {
		Description = "This Doodle's concentration is intense, preventing it from flinching.", 
		ImmuneStatus = { "Flinch" }, 
		StatusFunc = function(p118, p119, p120, p121, p122)
			if p121 ~= "Flinch" then
				return p121, p122;
			end;
			return "Flinch", 0, "&DOODLENAME," .. p120.ID .. "& is immune to flinching!";
		end
	};
	v2.Restless = {
		Description = "This Doodle can\226\128\153t fall asleep.", 
		ImmuneStatus = { "Sleep" }, 
		StatusFunc = function(p123, p124, p125, p126, p127)
			if p126 ~= "Sleep" then
				return p126, p127;
			end;
			local v11 = false;
			if p127 >= 100 then
				v11 = "&DOODLENAME," .. p125.ID .. "& can't fall asleep!";
			end;
			return "Sleep", 0, v11;
		end
	};
	v2.Nonchalant = {
		Description = "This Doodle does not rage or fall for taunts.", 
		ImmuneStatus = { "Rage" }, 
		ImmuneTaunt = true, 
		StatusFunc = function(p128, p129, p130, p131, p132)
			if p131 ~= "Rage" then
				return p131, p132;
			end;
			local v12 = nil;
			if p132 == 100 and p131.Name == "Rage" then
				v12 = "&DOODLENAME," .. p130.ID .. "& is immune to raging!";
			end;
			return p131, 0, v12;
		end
	};
	v2.Careless = {
		Description = "This Doodle can\226\128\153t be enraged or confused.", 
		ImmuneStatus = { "Confuse", "Rage" }, 
		StatusFunc = function(p133, p134, p135, p136, p137)
			if p136 ~= "Confuse" and p136 ~= "Rage" then
				return p136, p137;
			end;
			local v13 = nil;
			if p137 == 100 then
				if p136.Name == "Confuse" then
					v13 = "&DOODLENAME," .. p135.ID .. "& can't get confused!";
				elseif p136.Name == "Rage" then
					v13 = "&DOODLENAME," .. p135.ID .. "& is immune to raging!";
				end;
			end;
			return p136, 0, v13;
		end
	};
	v2["Bright Lights"] = {
		Description = "This Doodle is immune to Dark-type attacks.", 
		ModifyDefendDamage = function(p138, p139, p140, p141, p142, p143, p144)
			if p141.Type ~= "Dark" then
				return 1;
			end;
			if p144 == nil then
				p138:AddDialogue(p138.ActionList, "&DOODLENAME," .. p140.ID .. "& is immune to Dark-type attacks!");
			end;
			return 0;
		end
	};
	v2["Fireproof Armor"] = {
		Description = "This Doodle takes half damage from Fire-type attacks.", 
		ModifyDefendDamage = function(p145, p146, p147, p148, p149, p150, p151)
			if p148.Type == "Fire" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Pecking Order"] = {
		Description = "Lower power attacks do 25% less damage to this Doodle.", 
		ModifyDefendDamage = function(p152, p153, p154, p155, p156, p157, p158)
			if p155.Power and typeof(p155.Power) == "number" and p155.Power <= 60 then
				return 0.75;
			end;
			return 1;
		end
	};
	v2.Nitelite = {
		Description = "This Doodle takes 50% less damage from Dark-type attacks.", 
		ModifyDefendDamage = function(p159, p160, p161, p162, p163, p164, p165)
			if p162.Type == "Dark" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Holy Water"] = {
		Description = "This Doodle restores 25% of their health after using a Water or Light-type support move.", 
		BattleFunc = function(p166, p167, p168, p169)
			if p169.Category == "Passive" and (p169.Type == "Water" or p169.Type == "Light") then
				local v14 = math.floor(p167.Stats.hp / 4);
				if v14 > 0 and p167.currenthp < p167.Stats.hp then
					p166:AddDialogue(p166.ActionList, "&DOODLENAME," .. p167.ID .. "& restored health!");
					p166:TakeDamage(p167, -v14);
				end;
			end;
		end
	};
	v2["Air Current"] = {
		Description = "This Doodle\226\128\153s Air-type attacks do 20% more damage when this Doodle is at full health.", 
		ModifyDamage = function(p170, p171, p172, p173)
			if p173.Type == "Air" and p171.currenthp == p171.Stats.hp then
				return 1.2;
			end;
			return 1;
		end
	};
	v2["Rubber Tissue"] = {
		Description = "This Doodle is immune to Spark-type attacks.", 
		ModifyDefendDamage = function(p174, p175, p176, p177, p178, p179, p180)
			if p177.Type ~= "Spark" then
				return 1;
			end;
			if p180 == nil then
				p174:AddDialogue(p174.ActionList, "&DOODLENAME," .. p176.ID .. "& is immune to Spark-type attacks!");
			end;
			return 0;
		end
	};
	v2.Adipose = {
		Description = "This Doodle takes half damage from Fire and Ice-type attacks.", 
		ModifyDefendDamage = function(p181, p182, p183, p184, p185, p186, p187)
			if p184.Type ~= "Fire" and p184.Type ~= "Ice" then
				return 1;
			end;
			return 0.5;
		end
	};
	v2["Edible Treat"] = {
		Description = "If this Doodle faints, they fully restore their ally\226\128\153s health.", 
		SendOut = function(p188, p189, p190, p191)
			p189.OnFaint = p189.OnFaint or {};
			p189.OnFaintTargets.EdibleTreat = "Ally";
			p189.EdibleTreat = true;
			if not p189.OnFaint.EdibleTreat then
				p189.OnFaint.EdibleTreat = function(p192, p193, p194)
					if p189.EdibleTreat and p192.Format == "Doubles" and p194.currenthp > 0 and p194.currenthp < p194.Stats.hp then
						p192:AddDialogue(p192.ActionList, "&DOODLENAME," .. p189.ID .. "&" .. " healed their ally, " .. "&DOODLENAME," .. p194.ID .. "&!");
						p192:TakeDamage(p194, -math.round(p189.Stats.hp));
					end;
				end;
			end;
		end
	};
	v2["Chemical Explosion"] = {
		Description = "If this Doodle faints, damages all opposing Doodles by 25% of their max health.", 
		SendOut = function(p195, p196, p197, p198)
			p196.OnFaint = p196.OnFaint or {};
			p196.OnFaintTargets.ChemicalExplosion = "AllFoes";
			p196.ChemicalExplosion = true;
			if not p196.OnFaint.ChemicalExplosion then
				p196.OnFaint.ChemicalExplosion = function(p199, p200, p201)
					if p196.ChemicalExplosion then
						p199:AddDialogue(p199.ActionList, "&DOODLENAME," .. p196.ID .. "& exploded!");
						p199:TakeDamage(p201, (math.floor(p201.Stats.hp / 10)));
					end;
				end;
			end;
		end
	};
	v2["Balloon Pop"] = {
		Description = "If this Doodle faints, they lower the attack, magical attack, and speed of opposing Doodles.", 
		SendOut = function(p202, p203, p204, p205)
			p203.OnFaint = p203.OnFaint or {};
			p203.OnFaintTargets.BalloonPop = "AllFoes";
			p203.BalloonPop = true;
			if not p203.OnFaint.BalloonPop then
				p203.OnFaint.BalloonPop = function(p206, p207, p208)
					if p203.BalloonPop then
						p206:AddDialogue(p206.ActionList, "&DOODLENAME," .. p203.ID .. "& made a balloon popping noise!");
						l__ChangeStats__1(p206, p207, p208, 100, {
							matk = -1, 
							spe = -1, 
							atk = -1
						});
					end;
				end;
			end;
		end
	};
	v2.Stormwater = {
		Description = "If this Doodle is hit with a Water-type move, boost their magical attack.", 
		OnHit = function(p209, p210, p211, p212)
			if p210.currenthp > 0 and p212.Type == "Water" then
				l__ChangeStats__1(p209, p210, p210, 100, {
					matk = 1
				});
			end;
		end
	};
	v2.Tangled = {
		Description = "When this Doodle uses a Plant-type attack, they trap the target for three turns.", 
		BattleFunc = function(p213, p214, p215, p216)
			local v15 = p213:GetItemInfo(p215);
			if p216.Type == "Plant" and p215.Trapped == nil then
				if not v15.Grease then
					p215.Trapped = 4;
					p213:AddDialogue(p213.ActionList, "&DOODLENAME," .. p215.ID .. "& is trapped!");
					return;
				end;
			else
				return;
			end;
			p213:AddDialogue(p213.ActionList, "&DOODLENAME," .. p215.ID .. "& cannot be trapped due to Grease!");
		end
	};
	v2["Virulent Venom"] = {
		Description = "This Doodle\226\128\153s attacks have a 20% chance to poison.", 
		BattleFunc = function(p217, p218, p219, p220)
			if p220.Category ~= "Passive" and p219.currenthp > 0 then
				l__InflictStatus__2(p217, p218, p219, 20, "Poison", nil, "&DOODLENAME," .. p219.ID .. "&" .. " became poisoned because of " .. "&DOODLENAME," .. p218.ID .. "&'s Virulent Venom!");
			end;
		end
	};
	local v16 = {
		Description = "This Doodle\226\128\153s attacks have a 10% chance to paralyze."
	};
	function v16.BattleFunc(p221, p222, p223, p224)
		if p224.Category ~= "Passive" and p223.currenthp > 0 and l__Utilities__1.IsType(p223, "Earth") then
			l__InflictStatus__2(p221, p222, p223, 10, "Paralysis", nil, "&DOODLENAME," .. p223.ID .. "&" .. " became paralyzed because of " .. "&DOODLENAME," .. p222.ID .. "&'s Time Paralysis!");
		end;
	end;
	v2["Time Paralysis"] = v16;
	v2["Mind Control"] = {
		Description = "This Doodle\226\128\153s attacks have a 10% chance to enrage the target.", 
		BattleFunc = function(p225, p226, p227, p228)
			if p228.Category ~= "Passive" and p227.currenthp > 0 then
				l__InflictStatus__2(p225, p226, p227, 10, "Rage", nil, "&DOODLENAME," .. p227.ID .. "&" .. " is now angry because of " .. "&DOODLENAME," .. p226.ID .. "&'s Mind Control!");
			end;
		end
	};
	v2["Time Stop"] = {
		Description = "This Doodle always strikes first.", 
		PrioritySet = function(p229, p230, p231, p232)
			return p232 + 1;
		end
	};
	v2.Durable = {
		Description = "This Doodle can't be knocked out in one hit if they are at full health.", 
		DuringDamageCalc = function(p233, p234, p235, p236, p237)
			if typeof(p237) == "number" and p237 > 0 and p235.Stats.hp <= p237 and p235.Stats.hp <= p235.currenthp then
				p233:AddDialogue(p233.ActionList, "&DOODLENAME," .. p235.ID .. "& held on thanks to its Durable trait!");
				p237 = p235.Stats.hp - 1;
			end;
			return p237;
		end
	};
	v2.Fortified = {
		Description = "This Doodle is immune to critical hits.", 
		NoCrits = true
	};
	v2.Precise = {
		Description = "This Doodle is more likely to critical hit.", 
		CritApply = true
	};
	v2.Chlorokinesis = {
		Description = " If this Doodle is hit with a Plant-type attack, their next Mind-type attack does double damage.", 
		SendOut = function(p238, p239, p240, p241)
			p239.Chlorokinesis = true;
			p239.OnHit = p239.OnHit or {};
			p239.OnHit.Chlorokinesis = function(p242, p243, p244, p245)
				if p239.Chlorokinesis and p239.currenthp > 0 and p245.Type == "Grass" then
					p242:AddDialogue(p242.ActionList, "&DOODLENAME," .. p239.ID .. "&'s next Mind-type attack is boosted!");
					p242.BuffNextDamage = "Mind";
				end;
			end;
		end
	};
	v2["True Power"] = {
		Description = "When this Doodle is at low health, they do double damage.", 
		ModifyDamage = function(p246, p247, p248, p249)
			if p247.currenthp < p247.Stats.hp / 4 then
				return 2;
			end;
			return 1;
		end
	};
	v2.Stonefaced = {
		Description = "This Doodle\226\128\153s stats can\226\128\153t be lowered by other Doodles.", 
		NoStatLower = true
	};
	v2["Fire Up"] = {
		Description = "This Doodle's Fire-type moves become boosted if it's hit by one. They are also immune to Fire-type moves.", 
		DuringDamageCalc = function(p250, p251, p252, p253, p254)
			if (p254 == "Passive" or p254 > 0) and p251 ~= p252 and p253.Type == "Fire" then
				p254 = 0;
				p250:AddDialogue(p250.ActionList, "&DOODLENAME," .. p252.ID .. "& absorbed the Fire-type attack!");
				if not p252.FireUp then
					p252.FireUp = true;
					p250:AddDialogue(p250.ActionList, "&DOODLENAME," .. p252.ID .. "&'s Fire-type attacks became stronger!");
				end;
			end;
			return p254;
		end
	};
	v2.Conductor = {
		Description = "This Doodle's magical attack is raised if hit by a Spark-type attack. They are also immune to Spark-type moves.", 
		DuringDamageCalc = function(p255, p256, p257, p258, p259)
			if (p259 == "Passive" or p259 > 0) and p256 ~= p257 and p258.Type == "Spark" then
				p259 = 0;
				p255:AddDialogue(p255.ActionList, "&DOODLENAME," .. p257.ID .. "& absorbed the Spark-type attack!");
				l__ChangeStats__1(p255, p257, p257, 100, {
					matk = 1
				});
			end;
			return p259;
		end
	};
	v2["Water Absorb"] = {
		Description = "This Doodle restores health if hit by a Water-type move instead of taking damage.", 
		DuringDamageCalc = function(p260, p261, p262, p263, p264)
			if (p264 == "Passive" or p264 > 0) and p261 ~= p262 and p263.Type == "Water" then
				p264 = 0;
				p260:AddDialogue(p260.ActionList, "&DOODLENAME," .. p262.ID .. "& absorbed the Water-type attack!");
				if p262.currenthp < p262.Stats.hp then
					p260:TakeDamage(p262, -math.floor(p262.Stats.hp / 2));
					p260:AddDialogue(p260.ActionList, "&DOODLENAME," .. p262.ID .. "& restored health!");
				end;
			end;
			return p264;
		end
	};
	v2["Poison Absorb"] = {
		Description = "This Doodle restores health if hit by a Poison-type move instead of taking damage.", 
		DuringDamageCalc = function(p265, p266, p267, p268, p269)
			if (p269 == "Passive" or p269 > 0) and p266 ~= p267 and p268.Type == "Poison" then
				p269 = 0;
				p265:AddDialogue(p265.ActionList, "&DOODLENAME," .. p267.ID .. "& absorbed the Poison-type attack!");
				if p267.currenthp < p267.Stats.hp then
					p265:TakeDamage(p267, -math.floor(p267.Stats.hp / 2));
					p265:AddDialogue(p265.ActionList, "&DOODLENAME," .. p267.ID .. "& restored health!");
				end;
			end;
			return p269;
		end
	};
	v2["Trump Card"] = {
		Description = "If this Doodle has a status condition, they do 50% more physical damage.", 
		OverrideBurnModifier = true, 
		ModifyDamage = function(p270, p271, p272, p273)
			if p273.Category == "Physical" and p271.Status then
				return 1.5;
			end;
			return 1;
		end
	};
	v2.Opportunist = {
		Description = "This Doodle does 25% more damage to targets with a status condition.", 
		ModifyDamage = function(p274, p275, p276, p277)
			if p276.Status then
				return 1.25;
			end;
			return 1;
		end
	};
	v2.Chanting = {
		Description = "This Doodle\226\128\153s sound-based moves do more damage when used consecutively.", 
		ModifyDamage = function(p278, p279, p280, p281)
			if not p281.Sound then
				return 1;
			end;
			return p279.ChantingMultiplier and 1;
		end, 
		BattleFunc = function(p282, p283, p284, p285)
			if p285.Sound then
				p283.ChantingMultiplier = p283.ChantingMultiplier and 1;
				p283.ChantingMultiplier = math.min(1.5, p283.ChantingMultiplier + 0.1);
			end;
		end
	};
	v2.Serenade = {
		Description = "This Doodle\226\128\153s sound-based moves have a 10% chance to make the target fall asleep.", 
		BattleFunc = function(p286, p287, p288, p289)
			if p289.Sound and p289.Category ~= "Passive" and p287 ~= p288 then
				l__InflictStatus__2(p286, p287, p288, 10, "Sleep", nil, "&DOODLENAME," .. p288.ID .. "&" .. " was put to sleep because of " .. "&DOODLENAME," .. p287.ID .. "&'s Serenade!");
			end;
		end
	};
	v2.Galvanize = {
		Description = "This Doodle\226\128\153s Basic-type moves become Spark-type.", 
		ModifyDamage = function(p290, p291, p292, p293)
			if p293.Type == "Basic" then
				p293.Type = "Spark";
			end;
			return 1;
		end
	};
	v2.Routine = {
		Description = "Attack moves that are the same type as this Doodle do 50% more damage.", 
		BetterSTAB = true
	};
	v2["Jelly Lover"] = {
		Description = "This Doodle has a 50% chance to create another jelly after they consume one.", 
		EndTurn = function(p294, p295)
			if math.random(1, 2) == 1 and p295.HeldItem == nil and p295.Doodle.HeldItem and (p295.Doodle.HeldItem:find("Jelly") and not p295.NoRegen) then
				local l__HeldItem__17 = p295.Doodle.HeldItem;
				p294:AddDialogue(p294.ActionList, "&DOODLENAME," .. p295.ID .. "&" .. "'s Jelly Lover created another " .. l__HeldItem__17 .. "!");
				p295.HeldItem = l__HeldItem__17;
			end;
		end
	};
	v2.Apparition = {
		Description = "This Doodle\226\128\153s sound-based moves become Spirit-type.", 
		ModifyDamage = function(p296, p297, p298, p299)
			if p299.Sound then
				p299.Type = "Spirit";
			end;
			return 1;
		end
	};
	v2.Hypothermia = {
		Description = "If an opposing Doodle is frozen, they take damage at the end of each turn.", 
		EndTurnSpecific = function(p300, p301, p302)
			if p301.currenthp > 0 and p302.Status == "Frozen" then
				p300:TakeDamage(p302, (math.floor(p302.Stats.hp / 8)));
				p300:AddDialogue(p300.ActionList, "&DOODLENAME," .. p302.ID .. "&" .. " took damage from " .. "&DOODLENAME," .. p301.ID .. "&'s Hypothermia!");
			end;
		end
	};
	v2.Stitching = {
		Description = "This Doodle restores a little bit of health at the end of each turn.", 
		EndTurn = function(p303, p304, p305)
			if p304.currenthp > 0 and p304.currenthp < p304.Stats.hp then
				p303:TakeDamage(p304, -math.floor(p304.Stats.hp / 16));
				p303:AddDialogue(p303.ActionList, "&DOODLENAME," .. p304.ID .. "& restored health from its Stitching!");
			end;
		end
	};
	v2["Caloric Deficit"] = {
		Description = "This Doodle\226\128\153s Food-type moves do 30% more damage, but at the cost of health.", 
		ModifyDamage = function(p306, p307, p308, p309)
			if p309.Type == "Food" then
				return 1.3;
			end;
			return 1;
		end, 
		BattleFunc = function(p310, p311, p312, p313)
			if p313.Category ~= "Passive" and p313.Type == "Food" then
				p310:TakeDamage(p311, (math.floor(p311.Stats.hp / 8)));
				p310:AddDialogue(p310.ActionList, "&DOODLENAME," .. p311.ID .. "& lost health!");
			end;
		end
	};
	v2.Spool = {
		Description = "This Doodle\226\128\153s Basic-type moves do more damage, but at the cost of health.", 
		ModifyDamage = function(p314, p315, p316, p317)
			if p317.Type == "Basic" then
				return 1.2;
			end;
			return 1;
		end, 
		BattleFunc = function(p318, p319, p320, p321)
			if p321.Category ~= "Passive" and p321.Type == "Basic" then
				p318:TakeDamage(p319, (math.floor(p319.Stats.hp / 8)));
				p318:AddDialogue(p318.ActionList, "&DOODLENAME," .. p319.ID .. "& lost health!");
			end;
		end
	};
	local v18 = {
		Description = "When this doodle is sent out, create a temporary wind barrier that boosts allies' speed for 5 turns.", 
		Target = "Side"
	};
	function v18.SendOut(p322, p323, p324)
		if not p322:GetSideFromDoodle(p324).Sylphid then
			p322:AddDialogue(p322.ActionList, "&DOODLENAME," .. p323.ID .. "& creates a wind barrier!!");
			p1.Database.Moves.Sylphid.BattleFunc(p322, p323, p323);
		end;
	end;
	v2["Wind's Favor"] = v18;
	v2.Crystaline = {
		Description = "When this doodle is sent out, create a temporary crystal wall that halves the opponent's physical damage.", 
		Target = "Side", 
		SendOut = function(p325, p326, p327)
			if not p325:GetSideFromDoodle(p327).CrystalWall then
				p325:AddDialogue(p325.ActionList, "&DOODLENAME," .. p326.ID .. "& creates a Crystal Wall!");
				p1.Database.Moves["Crystal Wall"].BattleFunc(p325, p326, p326);
			end;
		end
	};
	v2["Chocolate Drizzle"] = {
		Description = "When this Doodle is sent out into battle, they summon Chocolate Rain.", 
		SendOut = function(p328, p329, p330)
			if p328.Weather ~= "Chocolate Rain" then
				p1.Database.Moves["Chocolate Rain"].BattleFunc(p328, p329, p329);
			end;
		end
	};
	v2["Spell Shield"] = {
		Description = "This Doodle takes half damage from magical attacks.", 
		Target = "Side", 
		ModifyDefendDamage = function(p331, p332, p333, p334, p335, p336, p337)
			if p334.Category == "Magical" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2.Relentless = {
		Description = "This Doodle's speed can't be lowered.", 
		PreventStatDisable = { "spe" }
	};
	v2.Arid = {
		Description = "If it\226\128\153s raining when this Doodle is sent out into battle, it stops raining.", 
		SendOut = function(p338, p339, p340)
			if p338.Weather == "Acid Rain" or p338.Weather == "Rain" or p338.Weather == "Chocolate Rain" then
				p338:AddDialogue(p338.ActionList, "&DOODLENAME," .. p339.ID .. "&'s Arid trait made it stop raining!");
				p338:AddDialogue(p338.ActionList, "The rain stopped.");
				p338.Weather = nil;
				p338.WeatherTurns = 0;
				p338:AddAction(p338.ActionList, {
					Action = "StopWeather"
				});
			end;
		end
	};
	v2.Corrosion = {
		Description = "When this Doodle is sent out into battle, they clear a random entry hazard from your side of the field.", 
		Target = "Side", 
		SendOut = function(p341, p342, p343)
			local v19 = p341:GetOppositeSideFromDoodle(p343);
			local v20 = {};
			local v21 = {
				YarnSnare = "Yarn Snare", 
				EntanglingVines = "Entangling Vines"
			};
			if v19.EntryHazards then
				for v22, v23 in pairs(v19.EntryHazards) do
					if v21[v22] then
						table.insert(v20, v22);
					end;
				end;
			end;
			if #v20 > 0 then
				local v24 = v20[math.random(#v20)];
				v19.EntryHazards[v24] = nil;
				p341:AddDialogue(p341.ActionList, "&DOODLENAME," .. p342.ID .. "&" .. "'s Corrosion destroyed the enemy's " .. v21[v24] .. "!");
			end;
		end
	};
	v2.Unraveling = {
		Description = "If this Doodle is hit with a super effective attack, boost their speed.", 
		OnHit = function(p344, p345, p346, p347)
			if p345.currenthp > 0 and p1.Database.Typings:GetEffectiveness(p346, p345, p347.Type) > 1 then
				l__ChangeStats__1(p344, p345, p345, 100, {
					spe = 1
				});
			end;
		end
	};
	v2["Poisonous Skin"] = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 20% chance to become poisoned.", 
		OnHit = function(p348, p349, p350, p351)
			if p351.Contact then
				l__InflictStatus__2(p348, p349, p350, 20, "Poison", nil, "&DOODLENAME," .. p350.ID .. "&" .. " became poisoned because of " .. "&DOODLENAME," .. p349.ID .. "&'s Poisonous Skin!");
			end;
		end
	};
	v2.Gauze = {
		Description = "When this Doodle uses a support move, they have a 50% chance to cure their status condition.", 
		BattleFunc = function(p352, p353, p354, p355, p356)
			if p355.Category == "Passive" and p353.Status ~= nil and p353.Status ~= "Fainted" and math.random(1, 2) == 1 then
				p353.Status = nil;
				p352:AddDialogue(p352.ActionList, "&DOODLENAME," .. p353.ID .. "&" .. " cured its " .. p353.Status:lower() .. " status with Gauze!");
				p352:AddAction(p352.ActionList, {
					Player = p353.Owner, 
					Doodle = p353, 
					Action = "StatusAnim", 
					Status = ""
				});
			end;
		end
	};
	v2.Leech = {
		Description = "This Doodle\226\128\153s Insect-type attacks restore them for half the damage done.", 
		BattleFunc = function(p357, p358, p359, p360, p361)
			if typeof(p361) == "number" and p361 > 0 and p360.Type == "Insect" then
				local v25 = math.floor(p361 / 2);
				if p357:GetTraitInfo(p359).Tainted then
					v25 = -v25;
				end;
				if v25 > 0 and p358.currenthp < p358.Stats.hp then
					p357:AddDialogue(p357.ActionList, "&DOODLENAME," .. p358.ID .. "& restored health!");
					p357:TakeDamage(p358, -v25);
				end;
			end;
		end
	};
	v2.Rejuvenator = {
		Description = "This Doodle restores 25% more health than normal.", 
		ExtraHeal = 1.25
	};
	v2.Herbivore = {
		Description = "This Doodle restores health if hit by a Plant-type move instead of taking damage.", 
		DuringDamageCalc = function(p362, p363, p364, p365, p366)
			if (p366 == "Passive" or p366 > 0) and p363 ~= p364 and p365.Type == "Plant" then
				p366 = 0;
				p362:AddDialogue(p362.ActionList, "&DOODLENAME," .. p364.ID .. "& absorbed the Plant-type attack!");
				if p364.currenthp < p364.Stats.hp then
					p362:TakeDamage(p364, -math.floor(p364.Stats.hp / 2));
					p362:AddDialogue(p362.ActionList, "&DOODLENAME," .. p364.ID .. "& restored health!");
				end;
			end;
			return p366;
		end
	};
	v2["Pollen Armor"] = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 20% chance to fall asleep.", 
		OnHit = function(p367, p368, p369, p370)
			if p370.Contact then
				l__InflictStatus__2(p367, p368, p369, 20, "Sleep", nil, "&DOODLENAME," .. p369.ID .. "&" .. " fell asleep because of " .. "&DOODLENAME," .. p368.ID .. "&'s Pollen Armor!");
			end;
		end
	};
	v2.Electrocute = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 30% chance to become paralyzed.", 
		OnHit = function(p371, p372, p373, p374)
			if p374.Contact and not l__Utilities__1.IsType(p373, "Earth") then
				l__InflictStatus__2(p371, p372, p373, 30, "Paralysis", nil, "&DOODLENAME," .. p373.ID .. "&" .. " became paralyzed because of " .. "&DOODLENAME," .. p372.ID .. "&'s Electrocute!");
			end;
		end
	};
	v2.Filament = {
		Description = "This Doodle is immune to Spark-type attacks. If this Doodle is hit by a Spark-type move, their Light-type moves do more damage.", 
		DuringDamageCalc = function(p375, p376, p377, p378, p379)
			if p378.Type == "Spark" and p376 ~= p377 and (p379 == "Passive" or p379 > 0) then
				p379 = 0;
				p377.LightBuff = 1.5;
				p375:AddDialogue(p375.ActionList, "&DOODLENAME," .. p377.ID .. "& absorbed the Spark-type attack!");
				p375:AddDialogue(p375.ActionList, "&DOODLENAME," .. p377.ID .. "&'s Light-type attacks have become stronger!");
				if not p377.ModFuncs.LightBuff then
					p377.ModFuncs.LightBuff = function(p380, p381, p382, p383)
						if p381.LightBuff and p383.Type == "Light" then
							return p381.LightBuff;
						end;
						return 1;
					end;
				end;
			end;
			return p379;
		end
	};
	v2.Incandescent = {
		Description = "If this Doodle is the first Doodle in your party, you are more likely to encounter higher star Doodles.", 
		HigherStar = true
	};
	v2["Iron Will"] = {
		Description = "This Doodle's attack can't be lowered.", 
		PreventStatDisable = { "atk" }
	};
	v2["Doll Eyes"] = {
		Description = "This Doodle's accuracy can't be lowered.", 
		PreventStatDisable = { "acc" }
	};
	v2["Four Eyes"] = {
		Description = "This Doodle's accuracy can't be lowered.", 
		PreventStatDisable = { "acc" }
	};
	v2["Rule of Cool"] = {
		Description = "This Doodle's not very effective attacks do double damage.", 
		Coolness = true
	};
	v2.Unbreakable = {
		Description = "This Doodle takes 25% less damage from super-effective attacks.", 
		SolidRock = true
	};
	v2.Capoeira = {
		Description = "This Doodle always hits the maximum amount of times when using multi-strike moves.", 
		SkillLink = true
	};
	v2.Lightfooted = {
		Description = "This Doodle\226\128\153s speed can\226\128\153t be lowered. If this Doodle\226\128\153s speed would be lowered, boost their speed instead.", 
		PreventStatDisable = { "spe" }, 
		PreventStatDisableFunc = function(p384, p385, p386, p387)
			p384:AddDialogue(p384.ActionList, "&DOODLENAME," .. p386.ID .. "&'s Lightfooted trait boosted its speed!");
			l__ChangeStats__1(p384, p386, p386, 100, {
				spe = -1 * p387
			});
		end
	};
	v2.Merciless = {
		Description = "When this Doodle's stats are lowered by an opponent, greatly boost this Doodle's attack.", 
		OnStatChange = function(p388, p389, p390, p391, p392)
			if p391 and p389.ID ~= p390.ID and not p388:IsAlly(p390, p389) and p390.Boosts.atk < 6 then
				l__ChangeStats__1(p388, p390, p390, 100, {
					atk = 2
				});
				p390.StatChangeLater = {
					atk = true
				};
				p390.LaterStatString = "&DOODLENAME," .. p390.ID .. "& is Merciless!";
			end;
		end
	};
	v2.Vengeance = {
		Description = "This Doodle\226\128\153s attacks do 30% more damage if it was attacked this turn.", 
		ModifyDamage = function(p393, p394, p395, p396)
			if #p394.Revenge > 0 then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Tainted = {
		Description = "This Doodle damages attackers using draining moves instead of restoring their health.", 
		Tainted = true
	};
	v2.Glutton = {
		Description = "This Doodle restores health if hit by a Food-type move instead of taking damage.", 
		DuringDamageCalc = function(p397, p398, p399, p400, p401)
			if (p401 == "Passive" or p401 > 0) and p398 ~= p399 and p400.Type == "Food" then
				p401 = 0;
				p397:AddDialogue(p397.ActionList, "&DOODLENAME," .. p399.ID .. "& absorbed the Food-type attack!");
				if p399.currenthp < p399.Stats.hp then
					p397:TakeDamage(p399, -math.floor(p399.Stats.hp / 2));
					p397:AddDialogue(p397.ActionList, "&DOODLENAME," .. p399.ID .. "& restored health!");
				end;
			end;
			return p401;
		end
	};
	v2.Exoskeleton = {
		Description = "This Doodle takes 30% less damage from contact attacks.", 
		ModifyDefendDamage = function(p402, p403, p404, p405, p406, p407, p408)
			if p405.Contact then
				return 0.7;
			end;
			return 1;
		end
	};
	v2["Titanium Bucket"] = {
		Description = "When this Doodle is sent out into battle, they boost their defense or magical defense, whichever is higher.", 
		Target = "Side", 
		SendOut = function(p409, p410, p411)
			p409:AddDialogue(p409.ActionList, "&DOODLENAME," .. p410.ID .. "& has a titanium bucket!");
			local v26 = "def";
			if p410.Stats.def < p410.Stats.mdef then
				v26 = "mdef";
			end;
			l__ChangeStats__1(p409, p410, p410, 100, {
				[v26] = 1
			});
		end
	};
	v2["Bon Appetit"] = {
		Description = "When this Doodle is sent out into battle, sprinkle Seasoning on opposing Doodles. Food-type Doodles do more damage to seasoned targets.", 
		BeforeSendOut = function(p412, p413)
			p412:AddDialogue(p412.ActionList, "&DOODLENAME," .. p413.ID .. "&'s applied Seasoning to the other team!");
		end, 
		SendOut = function(p414, p415, p416)
			p416.Seasoning = true;
		end
	};
	v2["Menacing Snarl"] = {
		Description = "When this Doodle is sent out into battle, they lower the attack of opposing Doodles.", 
		BeforeSendOut = function(p417, p418)
			p417:AddDialogue(p417.ActionList, "&DOODLENAME," .. p418.ID .. "&'s menacing snarl tried to lower the other team's attack!");
		end, 
		SendOut = function(p419, p420, p421)
			l__ChangeStats__1(p419, p420, p421, 100, {
				atk = -1
			});
		end
	};
	v2["Sickly Sweet"] = {
		Description = "When this Doodle is sent out into battle, they lower the magical attack of opposing Doodles.", 
		BeforeSendOut = function(p422, p423)
			p422:AddDialogue(p422.ActionList, "&DOODLENAME," .. p423.ID .. "&'s sweet aroma tried to lower the other team's magic attack!");
		end, 
		SendOut = function(p424, p425, p426)
			l__ChangeStats__1(p424, p425, p426, 100, {
				matk = -1
			});
		end
	};
	v2["Anti-Paralysis"] = {
		Description = "All party members are cured of paralysis when this Doodle is sent out into battle.", 
		SendOut = function(p427, p428, p429, p430)
			local v27 = nil;
			for v28, v29 in pairs(p430) do
				if v29.Status == "Paralysis" then
					v29.Status = nil;
					v27 = true;
				end;
			end;
			if v27 then
				p427:AddDialogue(p427.ActionList, "&DOODLENAME," .. p428.ID .. "&'s cured all of their party members' paralysis!");
			end;
		end
	};
	v2["Ice Stream"] = {
		Description = "This Doodle\226\128\153s Ice-type moves always go first when this Doodle is at full health.", 
		PrioritySet = function(p431, p432, p433, p434)
			if p433.Type ~= "Ice" or p432.currenthp ~= p432.Stats.hp then
				return p434;
			end;
			return p434 + 1;
		end
	};
	v2.Ethereal = {
		Description = "Attacks on this Doodle miss 10% more often.", 
		AccCalc = function(p435, p436, p437, p438)
			local v30 = p438;
			if typeof(v30) == "number" then
				v30 = v30 * 0.9;
			end;
			return v30;
		end
	};
	v2.Duel = {
		Description = "This Doodle never misses or dodges.", 
		AccCalc = function(p439, p440, p441, p442)
			return true;
		end, 
		OffensiveAccCalc = function(p443, p444, p445, p446)
			return true;
		end
	};
	v2.Rapier = {
		Description = "This Doodle\226\128\153s priority moves do 20% more damage.", 
		ModifyDamage = function(p447, p448, p449, p450)
			if p450.Priority and p450.Priority >= 1 then
				return 1.2;
			end;
			return 1;
		end
	};
	v2.Reaper = {
		Description = "This Doodle restores health if an opposing Doodle faints.", 
		OnOpposingFaint = function(p451, p452, p453)
			local v31 = math.round(p452.Stats.hp * 0.3);
			if v31 > 0 and p452.currenthp > 0 and p452.currenthp < p452.Stats.hp and p453.ID ~= p452.ID then
				p451:AddDialogue(p451.ActionList, "&DOODLENAME," .. p452.ID .. "& reaped and recovered health!");
				p451:TakeDamage(p452, -v31);
			end;
		end
	};
	v2.Calm = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Ignorant = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Apathetic = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Hawkeye = {
		Description = "Ignores target's evasion boosts.", 
		IgnoreEvasion = true
	};
	v2.Graceful = {
		Description = "This Doodle never misses.", 
		NeverMiss = true
	};
	v2.Escapist = {
		Description = "Guarantees fleeing from wild Doodles.", 
		FleeGuarantee = true
	};
	v2["Heavy Storms"] = {
		Description = "If this Doodle creates rain, the rain will last 10 turns.", 
		DoubleRain = true
	};
	v2["Slash Expert"] = {
		Description = "This Doodle\226\128\153s slashing moves do 20% more damage.", 
		ModifyDamage = function(p454, p455, p456, p457)
			if p457.Slash then
				return 1.2;
			end;
			return 1;
		end
	};
	v2["Sharp Fangs"] = {
		Description = "This Doodle\226\128\153s biting moves have a 30% chance to make the target vulnerable.", 
		BattleFunc = function(p458, p459, p460, p461)
			if p461.Category ~= "Passive" and p461.Biting and p460.currenthp > 0 then
				l__InflictStatus__2(p458, p459, p460, 30, "Vulnerable", nil, "&DOODLENAME," .. p460.ID .. "&" .. " became Vulnerable because of " .. "&DOODLENAME," .. p459.ID .. "&'s Sharp Fangs!");
			end;
		end
	};
	v2.Overbite = {
		Description = "This Doodle\226\128\153s biting moves do 20% more damage but have lower accuracy.", 
		AttackModifier = function(p462, p463, p464, p465)
			if p465.Biting and typeof(p465.Accuracy) == "number" then
				p465.Accuracy = p465.Accuracy - 20;
			end;
		end, 
		ModifyDamage = function(p466, p467, p468, p469)
			if p469.Biting then
				return 1.5;
			end;
			return 1;
		end
	};
	v2.Thievery = {
		Description = "When this Doodle uses a contact move, they have a 25% chance to steal the target's held item.", 
		BattleFunc = function(p470, p471, p472, p473)
			local v32 = l__Utilities__1.GetTrait(p472);
			if p472.HeldItem and p473.Contact then
				if math.random(1, 4) > 1 then
					return;
				end;
				if p471.HeldItem then
					p470:AddDialogue(p470.ActionList, "&DOODLENAME," .. p471.ID .. "& already has a held item!");
					return;
				end;
				if v32 and v32.NoItemSteal then
					p470:AddDialogue(p470.ActionList, "&DOODLENAME," .. p472.ID .. "& is really protective of its held item!");
					return;
				end;
				p470:AddDialogue(p470.ActionList, "&DOODLENAME," .. p471.ID .. "&" .. " stole " .. p472.HeldItem .. " from " .. "&DOODLENAME," .. p472.ID .. "&!");
				p471.HeldItem = p472.HeldItem;
				p472.HeldItem = nil;
				p472.NoUpdateItem = true;
				p471.NoUpdateItem = true;
			end;
		end
	};
	v2.Ward = {
		Description = "This Doodle\226\128\153s held item can never be removed in battle.", 
		NoItemSteal = true
	};
	v2.Dimwitted = {
		Description = "This Doodle does 25% more damage, but they can only use attacks that do damage.", 
		Dimwitted = true
	};
	v2.Premonition = {
		Description = "When this Doodle is sent out into battle, they sense one of the opposing Doodle\226\128\153s moves.", 
		SendOut = function(p474, p475, p476)
			p474:AddDialogue(p474.ActionList, "&DOODLENAME," .. p475.ID .. "&" .. " discovered that " .. "&DOODLENAME," .. p476.ID .. "&" .. " can use " .. p476.Moves[math.random(1, #p476.Moves)].Name .. "!");
		end
	};
	v2.Discover = {
		Description = "When this Doodle is sent out into battle, they discover the held items of opposing Doodles.", 
		SendOut = function(p477, p478, p479)
			if not p479.HeldItem then
				p477:AddDialogue(p477.ActionList, "&DOODLENAME," .. p478.ID .. "&" .. " discovered " .. "&DOODLENAME," .. p479.ID .. "& is holding nothing!");
				return;
			end;
			p477:AddDialogue(p477.ActionList, "&DOODLENAME," .. p478.ID .. "&" .. " discovered " .. "&DOODLENAME," .. p479.ID .. "&" .. " is holding " .. p479.HeldItem .. "!");
		end
	};
	v2.Possession = {
		Description = "This Doodle copies the trait of any Doodle they attack.", 
		BattleFunc = function(p480, p481, p482, p483)
			if p483.Category ~= "Passive" and p481.Ability ~= p482.Ability then
				p480:AddDialogue(p480.ActionList, "&DOODLENAME," .. p481.ID .. "&" .. "'s ability became " .. p482.Ability .. "!");
				p481.Ability = p482.Ability;
			end;
		end, 
		SendOut = function(p484, p485, p486, p487)
			p485.Possession = true;
			if not p485.SendOut.Possession then
				p485.SendOut.Possession = function(p488, p489, p490)
					if p489.Possession then
						p489.Ability = "Possession";
						p488:AddDialogue(p488.ActionList, "&DOODLENAME," .. p489.ID .. "& is ready to possess!");
					end;
				end;
			end;
		end
	};
	v2["Destructive Anger"] = {
		Description = "This Doodle does 50% more damage if enraged.", 
		ModifyDamage = function(p491, p492, p493, p494)
			if p492.Status == "Rage" then
				return 1.5;
			end;
			return 1;
		end
	};
	v2["Direct Combatant"] = {
		Description = "This Doodle can only take damage from attacks.", 
		DirectCombatant = true
	};
	v2.Reflective = {
		Description = "If a support move is used on this Doodle, it is redirected back to the user.", 
		Reflective = true
	};
	v2.Composed = {
		Description = "Rage has no effect on this Doodle.", 
		NoRage = true
	};
	v2["Burning Beast"] = {
		Description = "This Doodle\226\128\153s Beast-type moves have a 20% chance to burn.", 
		BattleFunc = function(p495, p496, p497, p498)
			if p498.Type == "Beast" and p498.Category ~= "Passive" and p497.currenthp > 0 then
				l__InflictStatus__2(p495, p496, p497, 20, "Burn", nil, "&DOODLENAME," .. p497.ID .. "&" .. " got burned because of " .. "&DOODLENAME," .. p496.ID .. "&'s Burning Beast!");
			end;
		end
	};
	v2["Wish For Power"] = {
		Description = "When this Doodle is sent out into battle, they boost their attack or magical attack, depending on the opponent.", 
		Target = "Side", 
		SendOut = function(p499, p500, p501)
			p499:AddDialogue(p499.ActionList, "&DOODLENAME," .. p500.ID .. "& wished for power to be granted!");
			local v33 = "matk";
			if p501.Stats.def < p501.Stats.mdef then
				v33 = "atk";
			end;
			l__ChangeStats__1(p499, p500, p500, 100, {
				[v33] = 1
			});
		end
	};
	v2["Wish For Wealth"] = {
		Description = "When this Doodle is in your party, you gain 30% more money from tamer battles.", 
		MoneyMultiplier = 1.3
	};
	v2["Wish For Experience"] = {
		Description = "This Doodle gains 30% more experience.", 
		ExpMultiplier = 1.3
	};
	v2["No trait"] = {
		Description = "This doodle doesn't have a trait."
	};
	return v2;
end;
