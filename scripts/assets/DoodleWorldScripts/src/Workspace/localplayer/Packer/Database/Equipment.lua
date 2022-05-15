-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = {
	Helmet = {
		["1"] = {
			Name = "Magnificent Tophat", 
			Info = "+15 speed, -20 attack, -20 defense", 
			Bonus = {
				atk = -20, 
				def = -20, 
				spe = 15
			}, 
			Image = "http://www.roblox.com/asset/?id=8483540389"
		}, 
		["2"] = {
			Name = "Helmet of Nobodom", 
			Info = "+5 attack, +5 defense", 
			Bonus = {
				atk = 5, 
				def = 5
			}, 
			Image = "http://www.roblox.com/asset/?id=7325464936"
		}, 
		["3"] = {
			Name = "Doodad", 
			Info = "+10 attack, +5 defense", 
			Bonus = {
				atk = 10, 
				def = 5
			}, 
			Image = "http://www.roblox.com/asset/?id=8687430499"
		}, 
		["4"] = {
			Name = "Bowlcut", 
			Info = "+6 defense, +6 magical defense, +6 speed, -10 coolness", 
			Bonus = {
				mdef = 6, 
				spe = 6, 
				def = 5
			}, 
			Image = "http://www.roblox.com/asset/?id=9238585380"
		}, 
		["5"] = {
			Name = "Head Leaf", 
			Info = "+10 speed", 
			Bonus = {
				spe = 10
			}, 
			Image = "http://www.roblox.com/asset/?id=9301998780"
		}, 
		["6"] = {
			Name = "Feathered Hat", 
			Info = "+8 attack, +8 magical defense, -8 magical attack", 
			Bonus = {
				atk = 8, 
				matk = -8, 
				mdef = 8
			}, 
			Image = "http://www.roblox.com/asset/?id=9173973390"
		}, 
		["7"] = {
			Name = "Epic Shades", 
			Info = "+15 hp, -5 defense, +25 coolness", 
			Bonus = {
				hp = 15, 
				def = -5
			}, 
			Image = "http://www.roblox.com/asset/?id=9425372450"
		}, 
		["8"] = {
			Name = "Glummish Cap", 
			Info = "+8 hp, +8 magical attack", 
			Bonus = {
				hp = 8, 
				matk = 8
			}, 
			Image = "http://www.roblox.com/asset/?id=9545079365"
		}
	}, 
	Amulet = {
		["1"] = {
			Name = "Sapphire Amulet", 
			Info = "+15 magical attack, +10 magical defense", 
			Bonus = {
				matk = 15, 
				mdef = 10
			}, 
			Image = "http://www.roblox.com/asset/?id=8483367595"
		}, 
		["2"] = {
			Name = "Mini Camera", 
			Info = "+5 speed, +8 defense, -5 attack", 
			Bonus = {
				def = 8, 
				spe = 5, 
				atk = -5
			}, 
			Image = "http://www.roblox.com/asset/?id=5786118191"
		}, 
		["3"] = {
			Name = "Scrap Paper", 
			Info = "-10 to all stats.", 
			Bonus = {
				atk = -10, 
				def = -10, 
				spe = -10, 
				matk = -10, 
				mdef = -10, 
				hp = -10
			}, 
			Image = "http://www.roblox.com/asset/?id=8689055978"
		}, 
		["4"] = {
			Name = "Whatchamacallit", 
			Info = "+10 speed, -10 defense, -10 magical defense", 
			Bonus = {
				spe = 10, 
				def = -10, 
				mdef = -10
			}, 
			Image = "http://www.roblox.com/asset/?id=8687505607"
		}, 
		["5"] = {
			Name = "Crystal Shard", 
			Info = "+15 magical defense, +5 speed", 
			Bonus = {
				spe = 5, 
				mdef = 15
			}, 
			Image = "http://www.roblox.com/asset/?id=9301934076"
		}, 
		["6"] = {
			Name = "Swag Juice", 
			Info = "+10 hp, +8 attack, +10 coolness", 
			Bonus = {
				hp = 10, 
				atk = 8
			}, 
			Image = "http://www.roblox.com/asset/?id=9425373504"
		}
	}, 
	Artifact = {
		["1"] = {
			Name = "Oakwood Staff", 
			Info = "+10 magical attack, +10 attack", 
			Bonus = {
				matk = 10, 
				atk = 10
			}, 
			Image = "http://www.roblox.com/asset/?id=8481005395"
		}, 
		["2"] = {
			Name = "Decorative Katana", 
			Info = "+8 attack, +5 speed", 
			Bonus = {
				atk = 8, 
				spe = 5
			}, 
			Image = "http://www.roblox.com/asset/?id=8480797559"
		}, 
		["3"] = {
			Name = "Computer Mouse", 
			Info = "+7 attack, +7 speed, -7 defense ", 
			Bonus = {
				atk = 7, 
				spe = 7, 
				def = -7
			}, 
			Image = "http://www.roblox.com/asset/?id=8686617055"
		}, 
		["4"] = {
			Name = "Amber Trapped Fly", 
			Info = "+20 speed, -20 hp", 
			Bonus = {
				spe = 20, 
				hp = -20
			}, 
			Image = "http://www.roblox.com/asset/?id=8480796750"
		}, 
		["5"] = {
			Name = "Beach Ball", 
			Info = "+20 defense, +20 magical defense, -20 attack, -20 magical attack", 
			Bonus = {
				def = 20, 
				mdef = 20, 
				atk = -20, 
				matk = -20
			}, 
			Image = "http://www.roblox.com/asset/?id=8736098817"
		}, 
		["6"] = {
			Name = "Thingamajig", 
			Info = "+15 attack, +15 magical attack, -15 speed", 
			Bonus = {
				atk = 15, 
				matk = 15, 
				spe = -15
			}, 
			Image = "http://www.roblox.com/asset/?id=8687432224"
		}, 
		["7"] = {
			Name = "Sad Pebblett", 
			Info = "+5 attack, +10 defense, -5 magic attack, -10 magic defense", 
			Bonus = {
				atk = 5, 
				def = 10, 
				matk = 5, 
				mdef = -10
			}, 
			Image = "http://www.roblox.com/asset/?id=9302035220"
		}, 
		["8"] = {
			Name = "Faunsprout Tail", 
			Info = "+4 to every stat.", 
			Bonus = {
				atk = 4, 
				def = 4, 
				spe = 4, 
				matk = 4, 
				mdef = 4, 
				hp = 4
			}, 
			Image = "http://www.roblox.com/asset/?id=9545077768"
		}
	}
};
function v1.LookUp(p1, p2, p3)
	if not u1[p3] then
		print("Invalid page");
		return;
	end;
	if not u1[p3][p2] then
		print("Invalid equipment");
		return;
	end;
	return u1[p3][p2];
end;
return v1;
