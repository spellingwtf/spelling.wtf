-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local u1 = {
		GetColor = function(p2, p3)
			if u1.Visual[p3] == nil then
				warn(p3 .. " is not a valid type");
				p3 = "Basic";
			end;
			return u1.Visual[p3].Color;
		end, 
		GetImage = function(p4, p5)
			if u1.Visual[p5] == nil then
				warn(p5 .. " is not a valid type");
				p5 = "Basic";
			end;
			return u1.Visual[p5].Image;
		end, 
		EffectiveIcons = {
			[2] = {
				Image = "http://www.roblox.com/asset/?id=4597869376", 
				Color = Color3.fromRGB(0, 255, 127)
			}, 
			[0.5] = {
				Image = "http://www.roblox.com/asset/?id=4597964185", 
				Color = Color3.fromRGB(170, 0, 0)
			}, 
			[4] = {
				Image = "http://www.roblox.com/asset/?id=4597964685", 
				Color = Color3.fromRGB(0, 200, 0)
			}, 
			[0.25] = {
				Image = "http://www.roblox.com/asset/?id=4597964304", 
				Color = Color3.fromRGB(255, 0, 0)
			}, 
			[0] = {
				Image = "http://www.roblox.com/asset/?id=4597964542", 
				Color = Color3.fromRGB(255, 0, 0)
			}
		}, 
		TypeOrder = { "Basic", "Fire", "Water", "Plant", "Spark", "Beast", "Air", "Insect", "Earth", "Mind", "Melee", "Food", "Light", "Crystal", "Metal", "Spirit", "Ice", "Dark", "Poison", "Mythic" }, 
		Visual = {
			Basic = {
				Color = Color3.fromRGB(204, 204, 204), 
				Image = "http://www.roblox.com/asset/?id=4557208777"
			}, 
			Mind = {
				Color = Color3.fromRGB(234, 153, 153), 
				Image = "http://www.roblox.com/asset/?id=6519698515"
			}, 
			Melee = {
				Color = Color3.fromRGB(216, 74, 56), 
				Image = "http://www.roblox.com/asset/?id=4604288204"
			}, 
			Fire = {
				Color = Color3.fromRGB(230, 145, 56), 
				Image = "http://www.roblox.com/asset/?id=4598175977"
			}, 
			Food = {
				Color = Color3.fromRGB(249, 203, 156), 
				Image = "http://www.roblox.com/asset/?id=4604283378"
			}, 
			Spark = {
				Color = Color3.fromRGB(255, 228, 98), 
				Image = "http://www.roblox.com/asset/?id=4604834458"
			}, 
			Light = {
				Color = Color3.fromRGB(255, 229, 153), 
				Image = "http://www.roblox.com/asset/?id=4598176416"
			}, 
			Insect = {
				Color = Color3.fromRGB(160, 206, 131), 
				Image = "http://www.roblox.com/asset/?id=4604288448"
			}, 
			Plant = {
				Color = Color3.fromRGB(106, 171, 110), 
				Image = "http://www.roblox.com/asset/?id=4557208188"
			}, 
			Crystal = {
				Color = Color3.fromRGB(90, 194, 200), 
				Image = "http://www.roblox.com/asset/?id=6524832960"
			}, 
			Water = {
				Color = Color3.fromRGB(109, 158, 235), 
				Image = "http://www.roblox.com/asset/?id=4598175859"
			}, 
			Ice = {
				Color = Color3.fromRGB(159, 197, 232), 
				Image = "http://www.roblox.com/asset/?id=4557207717"
			}, 
			Air = {
				Color = Color3.fromRGB(207, 226, 243), 
				Image = "http://www.roblox.com/asset/?id=4604289154"
			}, 
			Poison = {
				Color = Color3.fromRGB(180, 167, 214), 
				Image = "http://www.roblox.com/asset/?id=4598176219"
			}, 
			Spirit = {
				Color = Color3.fromRGB(103, 78, 167), 
				Image = "http://www.roblox.com/asset/?id=4598179077"
			}, 
			Dark = {
				Color = Color3.fromRGB(102, 102, 102), 
				Image = "http://www.roblox.com/asset/?id=4598175756"
			}, 
			Earth = {
				Color = Color3.fromRGB(184, 137, 107), 
				Image = "http://www.roblox.com/asset/?id=4604284148"
			}, 
			Metal = {
				Color = Color3.fromRGB(136, 160, 177), 
				Image = "http://www.roblox.com/asset/?id=4604834752"
			}, 
			Beast = {
				Color = Color3.fromRGB(133, 104, 94), 
				Image = "http://www.roblox.com/asset/?id=4557207616"
			}, 
			Mythic = {
				Color = Color3.fromRGB(72, 89, 190), 
				Image = "http://www.roblox.com/asset/?id=4604289554"
			}, 
			["???"] = {
				Color = Color3.fromRGB(72, 89, 190), 
				Image = ""
			}
		}, 
		TypeChart = {
			["???"] = {
				SE = {}, 
				NVE = {}, 
				NH = {}
			}, 
			Basic = {
				SE = {}, 
				NVE = { "Mythic", "Metal" }, 
				NH = { "Spirit" }
			}, 
			Mind = {
				SE = { "Melee", "Beast", "Poison" }, 
				NVE = { "Mind", "Spirit", "Metal" }, 
				NH = { "Dark" }
			}, 
			Melee = {
				SE = { "Basic", "Crystal", "Ice", "Metal" }, 
				NVE = { "Mind", "Insect", "Air", "Poison" }, 
				NH = { "Spirit" }
			}, 
			Fire = {
				SE = { "Food", "Insect", "Plant", "Beast", "Ice", "Metal" }, 
				NVE = { "Fire", "Water", "Crystal", "Earth", "Mythic" }, 
				NH = {}
			}, 
			Food = {
				SE = { "Mind", "Melee", "Mythic" }, 
				NVE = { "Fire", "Beast", "Plant", "Spirit" }, 
				NH = {}
			}, 
			Spark = {
				SE = { "Beast", "Air", "Water", "Insect" }, 
				NVE = { "Mythic", "Plant", "Food", "Spark", "Crystal" }, 
				NH = { "Earth" }
			}, 
			Light = {
				SE = { "Mythic", "Dark", "Spirit" }, 
				NVE = { "Spark", "Plant", "Crystal" }, 
				NH = {}
			}, 
			Insect = {
				SE = { "Mind", "Food", "Plant" }, 
				NVE = { "Melee", "Fire", "Air", "Poison", "Metal", "Beast" }, 
				NH = {}
			}, 
			Plant = {
				SE = { "Earth", "Light", "Water" }, 
				NVE = { "Plant", "Fire", "Insect", "Mythic", "Metal", "Air" }, 
				NH = {}
			}, 
			Crystal = {
				SE = { "Spark", "Mythic", "Spirit" }, 
				NVE = { "Earth", "Ice", "Water" }, 
				NH = {}
			}, 
			Water = {
				SE = { "Fire", "Earth", "Food" }, 
				NVE = { "Water", "Mythic", "Plant" }, 
				NH = {}
			}, 
			Mythic = {
				SE = { "Mythic" }, 
				NVE = { "Crystal", "Food" }, 
				NH = {}
			}, 
			Ice = {
				SE = { "Plant", "Air", "Earth", "Fire" }, 
				NVE = { "Water", "Ice", "Metal" }, 
				NH = {}
			}, 
			Air = {
				SE = { "Melee", "Insect", "Plant" }, 
				NVE = { "Metal", "Spark", "Poison" }, 
				NH = {}
			}, 
			Poison = {
				SE = { "Plant", "Water", "Air" }, 
				NVE = { "Poison", "Spirit", "Earth" }, 
				NH = { "Crystal", "Metal" }
			}, 
			Spirit = {
				SE = { "Spirit", "Mind" }, 
				NVE = { "Crystal", "Dark" }, 
				NH = { "Basic", "Light" }
			}, 
			Dark = {
				SE = { "Mind", "Light", "Spirit" }, 
				NVE = { "Food", "Dark" }, 
				NH = {}
			}, 
			Earth = {
				SE = { "Fire", "Crystal", "Spark", "Metal", "Poison" }, 
				NVE = { "Plant", "Insect" }, 
				NH = { "Air" }
			}, 
			Metal = {
				SE = { "Ice", "Crystal" }, 
				NVE = { "Fire", "Spark", "Water", "Metal" }, 
				NH = {}
			}, 
			Beast = {
				SE = { "Food", "Beast", "Insect", "Mind", "Dark" }, 
				NVE = { "Melee", "Fire", "Mythic" }, 
				NH = {}
			}
		}, 
		GetTypeColor = function(p6, p7)
			return u1.Visual[p7].Color;
		end
	};
	local function u2(p8, p9)
		for v1, v2 in pairs(p8) do
			if v2 == p9 then
				return true;
			end;
		end;
		return false;
	end;
	function u1.GetEffectiveness(p10, p11, p12, p13)
		local v3 = u1.TypeChart[p13];
		local v4 = 1;
		local v5 = nil;
		for v6, v7 in pairs(p1.DoodleInfo[p12.RealName or p12.Name].Type) do
			if u2(v3.SE, v7) then
				v4 = v4 * 2;
			elseif u2(v3.NVE, v7) then
				v4 = v4 / 2;
			elseif u2(v3.NH, v7) and (v7 ~= "Spirit" or not p11.Focused or p13 ~= "Basic" and p13 ~= "Melee") then
				v4 = 0;
			end;
		end;
		if v4 < 1 and v4 ~= 0 and p12.Status == "Vulnerable" then
			v4 = 1;
		end;
		if v4 > 1 then
			v5 = "It was super effective!";
		elseif v4 == 0 then
			v5 = "It did not affect " .. p12.Name .. "!";
		elseif v4 < 1 then
			v5 = "It wasn't very effective...";
		end;
		return v4, v5;
	end;
	return u1;
end;
