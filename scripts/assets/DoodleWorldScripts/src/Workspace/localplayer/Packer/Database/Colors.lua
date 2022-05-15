-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	White = Color3.fromRGB(255, 255, 255), 
	Cyan = Color3.fromRGB(0, 255, 255), 
	Blue = Color3.fromRGB(0, 0, 255), 
	NavyBlue = Color3.fromRGB(0, 85, 127), 
	LightBlue = Color3.fromRGB(0, 170, 255), 
	LimeGreen = Color3.fromRGB(0, 255, 0), 
	Green = Color3.fromRGB(0, 170, 0), 
	DarkGreen = Color3.fromRGB(0, 85, 0), 
	Red = Color3.fromRGB(255, 0, 0), 
	DarkRed = Color3.fromRGB(170, 0, 0), 
	Yellow = Color3.fromRGB(255, 255, 0), 
	Orange = Color3.fromRGB(255, 85, 0), 
	Black = Color3.fromRGB(0, 0, 0), 
	Pink = Color3.fromRGB(255, 85, 255), 
	Purple = Color3.fromRGB(170, 0, 255), 
	Gray = Color3.fromRGB(128, 128, 128), 
	Brown = Color3.fromRGB(139, 69, 19)
};
local u1 = {
	GetColorName = function(p1)
		return u1[p1].Name;
	end, 
	GetColorTable = function(p2)
		return u1[p2].ColorSequence, u1[p2].Animation;
	end, 
	GetColorRarity = function(p3)
		return u1[p3].Rarity and "Common";
	end,
	{
		Name = "White", 
		ColorSequence = { v1.White }, 
		Rarity = "Common"
	}, {
		Name = "Light Blue", 
		ColorSequence = { v1.LightBlue }, 
		Rarity = "Common"
	}, {
		Name = "Green", 
		ColorSequence = { v1.Green }, 
		Rarity = "Common"
	}, {
		Name = "Red", 
		ColorSequence = { v1.Red }, 
		Rarity = "Common"
	}, {
		Name = "Orange", 
		ColorSequence = { v1.Orange }, 
		Rarity = "Common"
	}, {
		Name = "Purple", 
		ColorSequence = { v1.Purple }, 
		Rarity = "Common"
	}, {
		Name = "Yellow", 
		ColorSequence = { v1.Yellow }, 
		Rarity = "Common"
	}, {
		Name = "Cyan", 
		ColorSequence = { v1.Cyan }, 
		Rarity = "Common"
	}, {
		Name = "Pink", 
		ColorSequence = { v1.Pink }, 
		Rarity = "Common"
	}, {
		Name = "Brown", 
		ColorSequence = { v1.Brown }, 
		Rarity = "Common"
	}, {
		Name = "Rainbow", 
		ColorSequence = { v1.Red, v1.Orange, v1.Yellow, v1.Green, v1.Blue, v1.Purple }, 
		Rarity = "Legendary", 
		Animation = "Movement"
	}, {
		Name = "Frost Witch", 
		ColorSequence = { v1.Black, v1.Cyan, v1.Black }, 
		Rarity = "Epic", 
		Animation = "Fade"
	}, {
		Name = "Zach", 
		ColorSequence = { Color3.fromRGB(247, 115, 154), Color3.fromRGB(93, 188, 210), Color3.fromRGB(180, 149, 255), Color3.fromRGB(140, 140, 255), Color3.fromRGB(183, 104, 203) }, 
		Rarity = "Unique", 
		Animation = "Movement"
	}, {
		Name = "Elusive", 
		ColorSequence = { v1.Black, Color3.fromRGB(255, 111, 0), Color3.fromRGB(255, 153, 0), Color3.fromRGB(255, 111, 0), v1.Black }, 
		Rarity = "Unique", 
		Animation = "Movement"
	}, {
		Name = "Ice", 
		ColorSequence = { Color3.fromRGB(159, 197, 232) }
	}, {
		Name = "Icy Stare", 
		ColorSequence = { Color3.fromRGB(159, 197, 232), Color3.fromRGB(255, 255, 255), Color3.fromRGB(159, 197, 232), Color3.fromRGB(159, 197, 232) }
	}, {
		Name = "Fire", 
		ColorSequence = { Color3.fromRGB(230, 145, 56) }, 
		Rarity = "Common"
	}, {
		Name = "Fiery Glare", 
		ColorSequence = { Color3.fromRGB(230, 145, 56), Color3.fromRGB(255, 255, 255), Color3.fromRGB(230, 145, 56), Color3.fromRGB(230, 145, 56) }, 
		Rarity = "Rare"
	}, {
		Name = "Poison", 
		ColorSequence = { Color3.fromRGB(180, 167, 214) }, 
		Rarity = "Common"
	}, {
		Name = "Venomous", 
		ColorSequence = { v1.Black, v1.Purple, v1.Purple }, 
		Rarity = "Legendary", 
		Animation = "Movement"
	}, {
		Name = "Beastfire", 
		ColorSequence = { v1.LightBlue, v1.Black }, 
		Rarity = "Rare", 
		Animation = "Fade"
	}, {
		Name = "Werewolf", 
		ColorSequence = { v1.Brown, v1.Black, v1.Brown, v1.Black }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Plant", 
		ColorSequence = { Color3.fromRGB(106, 171, 110) }, 
		Rarity = "Common"
	}, {
		Name = "Sunshine", 
		ColorSequence = { Color3.fromRGB(106, 171, 110), v1.Yellow, v1.Orange, v1.Red }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Raging", 
		ColorSequence = { v1.Yellow, v1.Orange, v1.Red, v1.Yellow, v1.Orange, v1.Red }, 
		Animation = "Movement", 
		Rarity = "Epic"
	}, {
		Name = "Earth", 
		ColorSequence = { Color3.fromRGB(184, 137, 107) }, 
		Rarity = "Common"
	}, {
		Name = "Watery Beast", 
		ColorSequence = { Color3.fromRGB(109, 158, 235), Color3.fromRGB(133, 104, 94), Color3.fromRGB(109, 158, 235), Color3.fromRGB(133, 104, 94) }, 
		Rarity = "Rare"
	}, {
		Name = "Red and White", 
		ColorSequence = { v1.Red, v1.White, v1.Red }, 
		Rarity = "Rare", 
		Animation = "Rotation"
	}, {
		Name = "Valuable", 
		ColorSequence = { Color3.fromRGB(255, 223, 0), Color3.fromRGB(212, 175, 55), Color3.fromRGB(207, 181, 59), Color3.fromRGB(197, 179, 88) }, 
		Rarity = "Legendary", 
		Animation = "Movement"
	}, {
		Name = "Cactus", 
		ColorSequence = { Color3.fromRGB(106, 171, 110), Color3.fromRGB(184, 137, 107) }, 
		Rarity = "Rare", 
		Animation = "Rotation"
	}, {
		Name = "Spirit", 
		ColorSequence = { Color3.fromRGB(103, 78, 167) }, 
		Rarity = "Common"
	}, {
		Name = "Girl Power", 
		ColorSequence = { v1.Pink, v1.White }, 
		Rarity = "Rare", 
		Animation = "Fade"
	}, {
		Name = "Protector", 
		ColorSequence = { Color3.fromRGB(103, 78, 167), v1.Green }, 
		Rarity = "Rare", 
		Animation = "Rotation"
	}, {
		Name = "Chronos", 
		ColorSequence = { v1.Black, v1.LightBlue, v1.LightBlue, v1.Black }, 
		Rarity = "Legendary", 
		Animation = "Movement"
	}, {
		Name = "Genie", 
		ColorSequence = { v1.NavyBlue, v1.Blue, v1.LightBlue }, 
		Rarity = "Rare", 
		Animation = "Fade"
	}, {
		Name = "Party All Night", 
		ColorSequence = { v1.Blue, v1.Pink }, 
		Rarity = "Rare", 
		Animation = "Fade"
	}, {
		Name = "Cactus King", 
		ColorSequence = { v1.LimeGreen, v1.Green, v1.DarkGreen }, 
		Rarity = "Rare", 
		Animation = "Movement"
	}, {
		Name = "Evil Beast", 
		ColorSequence = { v1.Black, v1.Gray, v1.White, v1.Gray, v1.Black }, 
		Rarity = "Rare", 
		Animation = "Movement"
	}, {
		Name = "Rosethorns", 
		ColorSequence = { v1.Black, v1.Red, v1.Red }, 
		Rarity = "Legendary", 
		Animation = "Movement"
	}, {
		Name = "Insect", 
		ColorSequence = { Color3.fromRGB(160, 206, 131) }, 
		Rarity = "Common"
	}, {
		Name = "Monkey Stare", 
		ColorSequence = { v1.Brown, Color3.fromRGB(255, 255, 255), v1.Brown, v1.Brown }, 
		Rarity = "Rare"
	}, {
		Name = "Lightning Goat", 
		ColorSequence = { v1.Yellow, v1.White, v1.Yellow, v1.White, v1.Yellow }, 
		Rarity = "Rare"
	}, {
		Name = "Forest Fire", 
		ColorSequence = { v1.Red, v1.Yellow, v1.Orange }, 
		Rarity = "Rare"
	}, {
		Name = "Earthy Fire", 
		ColorSequence = { Color3.fromRGB(184, 137, 107), Color3.fromRGB(230, 145, 56), Color3.fromRGB(184, 137, 107), Color3.fromRGB(230, 145, 56), Color3.fromRGB(184, 137, 107), Color3.fromRGB(230, 145, 56), Color3.fromRGB(184, 137, 107), Color3.fromRGB(230, 145, 56) }, 
		Rarity = "Rare", 
		Animation = "Movement"
	}, {
		Name = "Orca", 
		ColorSequence = { v1.Black, v1.White, v1.White, v1.Black }, 
		Rarity = "Rare"
	}, {
		Name = "Spark", 
		ColorSequence = { Color3.fromRGB(255, 228, 98) }, 
		Rarity = "Common"
	}, {
		Name = "Sparky Glare", 
		ColorSequence = { Color3.fromRGB(255, 228, 98), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 228, 98), Color3.fromRGB(255, 228, 98) }, 
		Rarity = "Rare"
	}, {
		Name = "Demon of the Frozen Wasteland", 
		ColorSequence = { Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 255, 255), Color3.fromRGB(170, 85, 255), Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 255, 255), Color3.fromRGB(170, 85, 255) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Light", 
		ColorSequence = { Color3.fromRGB(255, 229, 153) }, 
		Rarity = "Common"
	}, {
		Name = "Night Light", 
		ColorSequence = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0) }, 
		Rarity = "Uncommon"
	}, {
		Name = "Kaleidoscope", 
		ColorSequence = { Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 156, 38), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 107, 255), Color3.fromRGB(0, 255, 246), Color3.fromRGB(50, 255, 0), Color3.fromRGB(230, 255, 100), Color3.fromRGB(204, 204, 255) }, 
		Rarity = "Legendary", 
		Animation = "Fade"
	}, {
		Name = "Royalty", 
		ColorSequence = { Color3.fromRGB(35, 35, 35), Color3.fromRGB(216, 216, 216), Color3.fromRGB(255, 43, 92), Color3.fromRGB(35, 35, 35), Color3.fromRGB(216, 216, 216), Color3.fromRGB(255, 43, 92) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Marshy", 
		ColorSequence = { Color3.fromRGB(170, 255, 255), Color3.fromRGB(170, 255, 127), Color3.fromRGB(170, 255, 255) }, 
		Rarity = "Uncommon"
	}, {
		Name = "Toxic Goo", 
		ColorSequence = { v1.Purple, v1.Green, v1.Black }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Nature's Friend", 
		ColorSequence = { v1.Green, v1.Yellow, v1.Red }, 
		Rarity = "Rare"
	}, {
		Name = "Nature", 
		ColorSequence = { v1.Green, v1.DarkGreen, v1.NavyBlue, v1.LimeGreen, v1.NavyBlue, v1.DarkGreen, v1.Green }, 
		Rarity = "Uncommon"
	}, {
		Name = "Fairy Isle", 
		ColorSequence = { v1.LightBlue, Color3.fromRGB(252, 202, 255), v1.LightBlue, Color3.fromRGB(252, 202, 255), v1.LightBlue, Color3.fromRGB(252, 202, 255) }, 
		Rarity = "Uncommon"
	}, {
		Name = "Toxic Sewage", 
		ColorSequence = { v1.Green, v1.Black, v1.Green, v1.Back }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "IceTera", 
		ColorSequence = { Color3.fromRGB(159, 197, 232), Color3.fromRGB(184, 137, 107), Color3.fromRGB(159, 197, 232), Color3.fromRGB(184, 137, 107) }, 
		Rarity = "Uncommon"
	}, {
		Name = "Otherworldy Invader", 
		ColorSequence = { v1.Orange, v1.NavyBlue, v1.Orange, v1.Black }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Light and Dark", 
		ColorSequence = { Color3.fromRGB(102, 102, 102), Color3.fromRGB(255, 229, 153), Color3.fromRGB(102, 102, 102), Color3.fromRGB(255, 229, 153) }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Light and Spirit", 
		ColorSequence = { Color3.fromRGB(255, 229, 153), Color3.fromRGB(103, 78, 167), Color3.fromRGB(255, 229, 153), Color3.fromRGB(103, 78, 167) }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Dark and Spirit", 
		ColorSequence = { Color3.fromRGB(102, 102, 102), Color3.fromRGB(103, 78, 167), Color3.fromRGB(102, 102, 102), Color3.fromRGB(103, 78, 167) }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Sad Plant", 
		ColorSequence = { v1.Green, v1.Black, v1.Green, v1.Back }, 
		Animation = "Movement", 
		Rarity = "Rare"
	}, {
		Name = "Maelzuri", 
		ColorSequence = { Color3.fromRGB(212, 223, 235), Color3.fromRGB(99, 197, 239), Color3.fromRGB(212, 223, 235), Color3.fromRGB(15, 22, 35) }, 
		Animation = "Movement", 
		Rarity = "Legendary"
	}, {
		Name = "Honeycrisp", 
		ColorSequence = { Color3.fromRGB(248, 216, 66), Color3.fromRGB(243, 72, 37), Color3.fromRGB(243, 72, 37), Color3.fromRGB(243, 72, 37), Color3.fromRGB(243, 72, 37) }, 
		Rarity = "Uncommon"
	}, {
		Name = "Candy Cane", 
		ColorSequence = { Color3.fromRGB(73, 71, 141), Color3.fromRGB(243, 214, 240), Color3.fromRGB(207, 56, 79), Color3.fromRGB(73, 71, 141), Color3.fromRGB(243, 214, 240), Color3.fromRGB(207, 56, 79) }, 
		Animation = "Movement", 
		Rarity = "Epic"
	}, {
		Name = "Gray", 
		ColorSequence = { v1.Gray }, 
		Rarity = "Common"
	}, {
		Name = "Armenti", 
		ColorSequence = { Color3.fromRGB(254, 69, 28), Color3.fromRGB(255, 165, 28), Color3.fromRGB(255, 217, 28), Color3.fromRGB(255, 165, 28) }, 
		Rarity = "Unique", 
		Animation = "Movement"
	}, {
		Name = "Joeblox", 
		ColorSequence = { Color3.fromRGB(22, 52, 230), Color3.fromRGB(22, 122, 230), Color3.fromRGB(22, 180, 230), Color3.fromRGB(22, 222, 230) }, 
		Rarity = "Unique", 
		Animation = "Fade"
	}, {
		Name = "Jerii's Color", 
		ColorSequence = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(80, 17, 17), Color3.fromRGB(120, 20, 20), Color3.fromRGB(181, 20, 20), Color3.fromRGB(225, 40, 40), Color3.fromRGB(255, 40, 40), Color3.fromRGB(255, 40, 40), Color3.fromRGB(225, 40, 40), Color3.fromRGB(181, 20, 20), Color3.fromRGB(120, 20, 20), Color3.fromRGB(80, 17, 17), Color3.fromRGB(0, 0, 0) }, 
		Rarity = "Unique", 
		Animation = "Fade"
	}, {
		Name = "ClassicNative", 
		ColorSequence = { Color3.fromRGB(137, 93, 29), Color3.fromRGB(0, 0, 0), Color3.fromRGB(237, 43, 50), Color3.fromRGB(247, 205, 215), Color3.fromRGB(249, 242, 232), Color3.fromRGB(233, 153, 32) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Fujin", 
		ColorSequence = { Color3.fromRGB(25, 176, 4), Color3.fromRGB(118, 118, 118), Color3.fromRGB(0, 0, 0), Color3.fromRGB(236, 235, 226), Color3.fromRGB(20, 238, 166), Color3.fromRGB(219, 219, 219) }, 
		Animation = "Fade", 
		Rarity = "Unique"
	}, {
		Name = "PokeNova", 
		ColorSequence = { Color3.fromRGB(121, 0, 255), Color3.fromRGB(255, 0, 0), Color3.fromRGB(121, 0, 255) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Dino's Fusion", 
		ColorSequence = { Color3.fromRGB(190, 45, 14), Color3.fromRGB(0, 0, 0), Color3.fromRGB(122, 1, 1) }, 
		Animation = "Fade", 
		Rarity = "Unique"
	}, {
		Name = "Speedah", 
		ColorSequence = { Color3.fromRGB(249, 141, 12), Color3.fromRGB(207, 26, 8), Color3.fromRGB(40, 106, 238), Color3.fromRGB(42, 161, 7), Color3.fromRGB(239, 16, 203), Color3.fromRGB(106, 6, 188), Color3.fromRGB(131, 243, 11) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "i_eaturface", 
		ColorSequence = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255), Color3.fromRGB(214, 64, 64), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Game4All", 
		ColorSequence = { Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 255, 0) }, 
		Animation = "Rotation", 
		Rarity = "Unique"
	}, {
		Name = "Terra's Requiem", 
		ColorSequence = { Color3.fromRGB(227, 105, 64), Color3.fromRGB(229, 180, 24), Color3.fromRGB(229, 28, 28), Color3.fromRGB(229, 180, 24), Color3.fromRGB(113, 113, 113), Color3.fromRGB(229, 180, 24), Color3.fromRGB(0, 0, 0), Color3.fromRGB(229, 180, 24) }, 
		Animation = "Rotation", 
		Rarity = "Unique"
	}, {
		Name = "Wizard Purple", 
		ColorSequence = { Color3.fromRGB(153, 51, 255), Color3.fromRGB(127, 0, 255), Color3.fromRGB(102, 0, 204), Color3.fromRGB(76, 0, 153), Color3.fromRGB(51, 0, 102), Color3.fromRGB(76, 0, 153), Color3.fromRGB(102, 0, 204), Color3.fromRGB(127, 0, 255), Color3.fromRGB(153, 51, 255) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Wiki Helper", 
		ColorSequence = { Color3.fromRGB(0, 128, 188), Color3.fromRGB(249, 176, 6), Color3.fromRGB(159, 103, 219), Color3.fromRGB(0, 85, 127) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "LuckyHD", 
		ColorSequence = { Color3.fromRGB(222, 255, 208), Color3.fromRGB(174, 255, 140), Color3.fromRGB(139, 255, 89), Color3.fromRGB(110, 255, 49), Color3.fromRGB(76, 255, 0), Color3.fromRGB(58, 194, 0), Color3.fromRGB(42, 141, 0), Color3.fromRGB(31, 104, 0), Color3.fromRGB(20, 67, 0) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "FlyPoint", 
		ColorSequence = { Color3.fromRGB(254, 0, 255), Color3.fromRGB(234, 0, 179), Color3.fromRGB(228, 0, 223), Color3.fromRGB(0, 87, 255), Color3.fromRGB(0, 191, 255) }, 
		Animation = "Fade", 
		Rarity = "Unique"
	}, {
		Name = "AdrianSky Was Here", 
		ColorSequence = { Color3.fromRGB(114, 0, 255), Color3.fromRGB(0, 0, 0) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Iridescent Inferno", 
		ColorSequence = { Color3.fromRGB(237, 79, 45), Color3.fromRGB(237, 107, 45), Color3.fromRGB(237, 166, 45), Color3.fromRGB(237, 191, 45), Color3.fromRGB(237, 166, 45), Color3.fromRGB(237, 107, 45), Color3.fromRGB(237, 79, 45) }, 
		Animation = "Rotation", 
		Rarity = "Unique"
	}, {
		Name = "UFO Sighting", 
		ColorSequence = { v1.NavyBlue, v1.LightBlue, v1.NavyBlue }, 
		Animation = "Rotation", 
		Rarity = "Rare"
	}, {
		Name = "Crystalized", 
		ColorSequence = { Color3.fromRGB(159, 197, 232), Color3.fromRGB(90, 194, 200) }, 
		Animation = "Fade", 
		Rarity = "Rare"
	}, {
		Name = "Crystal", 
		ColorSequence = { Color3.fromRGB(90, 194, 200) }, 
		Rarity = "Common"
	}, {
		Name = "WarmConal007", 
		ColorSequence = { Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(160, 160, 160) }, 
		Rarity = "Unique", 
		Animation = "Movement"
	}, {
		Name = "Warclipes", 
		ColorSequence = { Color3.fromRGB(254, 254, 255), Color3.fromRGB(223, 250, 255), Color3.fromRGB(144, 241, 255), Color3.fromRGB(173, 200, 255), Color3.fromRGB(214, 143, 255) }, 
		Rarity = "Unique", 
		Animation = "Fade"
	}, {
		Name = "Equilibrium", 
		ColorSequence = { Color3.fromRGB(201, 255, 114), Color3.fromRGB(223, 234, 235), Color3.fromRGB(223, 234, 235), Color3.fromRGB(201, 255, 114) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Noxious", 
		ColorSequence = { Color3.fromRGB(176, 142, 216), Color3.fromRGB(223, 234, 235), Color3.fromRGB(223, 234, 235), Color3.fromRGB(176, 142, 216) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Endothermic", 
		ColorSequence = { Color3.fromRGB(76, 138, 225), Color3.fromRGB(223, 234, 235), Color3.fromRGB(223, 234, 235), Color3.fromRGB(76, 138, 225) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Exothermic", 
		ColorSequence = { Color3.fromRGB(233, 106, 61), Color3.fromRGB(223, 234, 235), Color3.fromRGB(223, 234, 235), Color3.fromRGB(233, 106, 61) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Volt", 
		ColorSequence = { Color3.fromRGB(141, 155, 164), Color3.fromRGB(255, 219, 97), Color3.fromRGB(255, 219, 97), Color3.fromRGB(141, 155, 164) }, 
		Rarity = "Epic", 
		Animation = "Movement"
	}, {
		Name = "Jamiy", 
		ColorSequence = { Color3.fromRGB(0, 7, 111), Color3.fromRGB(68, 0, 139), Color3.fromRGB(159, 69, 176), Color3.fromRGB(20, 1, 20), Color3.fromRGB(68, 0, 139), Color3.fromRGB(0, 7, 111), Color3.fromRGB(229, 78, 208), Color3.fromRGB(68, 0, 139), Color3.fromRGB(0, 7, 111), Color3.fromRGB(240, 230, 230), Color3.fromRGB(0, 7, 111), Color3.fromRGB(159, 69, 176) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Jamiy", 
		ColorSequence = { Color3.fromRGB(0, 7, 111), Color3.fromRGB(68, 0, 139), Color3.fromRGB(159, 69, 176), Color3.fromRGB(20, 1, 20), Color3.fromRGB(68, 0, 139), Color3.fromRGB(0, 7, 111), Color3.fromRGB(229, 78, 208), Color3.fromRGB(68, 0, 139), Color3.fromRGB(0, 7, 111), Color3.fromRGB(240, 230, 230), Color3.fromRGB(0, 7, 111), Color3.fromRGB(159, 69, 176) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}, {
		Name = "Naits", 
		ColorSequence = { Color3.fromRGB(52, 204, 14), Color3.fromRGB(53, 255, 3), Color3.fromRGB(6, 112, 2), Color3.fromRGB(0, 0, 0) }, 
		Animation = "Movement", 
		Rarity = "Unique"
	}
};
return u1;
