-- Decompiled with the Synapse X Luau decompiler.

return {
	Animations = {
		DefaultIdle = {
			Id = "507766388"
		}, 
		Wave = {
			Id = "507770239"
		}, 
		DefaultWalk = {
			Id = "913402848"
		}, 
		DefaultThrow = {
			Id = "4638452918", 
			Wait = 0.25
		}, 
		Up_Toss = {
			Id = "04642283256", 
			Wait = 0.4
		}, 
		Laugh = {
			Id = "507770818"
		}, 
		Laughter = {
			Id = "507770818"
		}, 
		Point = {
			Id = "507770453"
		}, 
		Bow = {
			Id = "7349183903"
		}, 
		Nod = {
			Id = "7349343242"
		}, 
		Dance1 = {
			Id = "507771019"
		}, 
		Dance2 = {
			Id = "507776043"
		}, 
		Dance3 = {
			Id = "507777268"
		}, 
		DeskSlam = {
			Id = "8598576387"
		}, 
		Sitting = {
			Id = "8625804079"
		}, 
		MaleLeaning = {
			Id = "8628215977"
		}, 
		OffenseIdle = {
			Id = "8628271295"
		}, 
		BreathingIdle = {
			Id = "8628295891"
		}, 
		Shrug = {
			Id = "8661325787"
		}, 
		Knocked = {
			Id = "8758876802"
		}, 
		Teleport = {
			Id = "8817342624", 
			Wait = 0.4
		}, 
		VampireIdle = {
			Id = "1083445855"
		}, 
		Wiggle = {
			Id = "8958514615"
		}, 
		Default = {
			Id = "8958529742"
		}, 
		Dab = {
			Id = "8958542262"
		}, 
		Orange = {
			Id = "8958552633"
		}, 
		LDance = {
			Id = "8958562672"
		}, 
		WakeUpCall = {
			Id = "7199000883"
		}, 
		KluIdle = {
			Id = "616158929"
		}, 
		Stomp = {
			Id = "9215533108"
		}, 
		Monkey = {
			Id = "3333499508"
		}, 
		RoundhouseKick = {
			Id = "9241548874"
		}, 
		GetHit = {
			Id = "9241585505"
		}
	}, 
	Capsules = {
		Basic = {
			Open = "http://www.roblox.com/asset/?id=5723542507", 
			Closed = "http://www.roblox.com/asset/?id=5723541748", 
			Color3 = Color3.fromRGB(85, 255, 0)
		}, 
		Striped = {
			Open = "http://www.roblox.com/asset/?id=6493789323", 
			Closed = "http://www.roblox.com/asset/?id=6493789086", 
			Color3 = Color3.fromRGB(84, 118, 215)
		}, 
		Gold = {
			Open = "http://www.roblox.com/asset/?id=9195089437", 
			Closed = "http://www.roblox.com/asset/?id=9195090072", 
			Color3 = Color3.fromRGB(255, 224, 79)
		}
	}, 
	BattleBGs = {
		Route1 = "http://www.roblox.com/asset/?id=7291014922", 
		LakewoodLake = "http://www.roblox.com/asset/?id=8634687658", 
		GenericIndoors = "http://www.roblox.com/asset/?id=8631714430"
	}, 
	StatusInfo = {
		Paralysis = {
			Icon = "http://www.roblox.com/asset/?id=5719886562", 
			Color = Color3.fromRGB(255, 223, 0)
		}, 
		Poison = {
			Icon = "http://www.roblox.com/asset/?id=5734231647", 
			Color = Color3.fromRGB(194, 136, 228)
		}, 
		Rage = {
			Icon = "http://www.roblox.com/asset/?id=5734893117", 
			Color = Color3.fromRGB(255, 0, 0)
		}, 
		Burn = {
			Icon = "http://www.roblox.com/asset/?id=5756553617", 
			Color = Color3.fromRGB(207, 90, 24)
		}, 
		Frozen = {
			Icon = "http://www.roblox.com/asset/?id=5756785249", 
			Color = Color3.fromRGB(113, 205, 227)
		}, 
		Sleep = {
			Icon = "http://www.roblox.com/asset/?id=5784445369", 
			Color = Color3.fromRGB(227, 212, 97)
		}, 
		Cursed = {
			Icon = "http://www.roblox.com/asset/?id=5827308527", 
			Color = Color3.fromRGB(111, 22, 163)
		}, 
		Marked = {
			Icon = "http://www.roblox.com/asset/?id=5756539629", 
			Color = Color3.fromRGB(255, 255, 255)
		}, 
		Vulnerable = {
			Icon = "http://www.roblox.com/asset/?id=5756615804", 
			Color = Color3.fromRGB(177, 177, 179)
		}, 
		Diseased = {
			Icon = "http://www.roblox.com/asset/?id=5827307624", 
			Color = Color3.fromRGB(201, 206, 60)
		}
	}, 
	GenderIcons = {
		U = {
			Image = "", 
			Color = Color3.fromRGB(0, 0, 0)
		}, 
		M = {
			Image = "http://www.roblox.com/asset/?id=5686176593", 
			Color = Color3.fromRGB(0, 170, 255)
		}, 
		F = {
			Image = "http://www.roblox.com/asset/?id=5686175334", 
			Color = Color3.fromRGB(255, 170, 255)
		}
	}, 
	PartyGuis = {
		Healthy = "http://www.roblox.com/asset/?id=5872548123", 
		Fainted = "http://www.roblox.com/asset/?id=5872549094", 
		Status = "http://www.roblox.com/asset/?id=5872549668", 
		Empty = "http://www.roblox.com/asset/?id=5872550604"
	}, 
	StatChangeColors = {
		atk = Color3.fromRGB(237, 187, 67), 
		def = Color3.fromRGB(157, 254, 136), 
		matk = Color3.fromRGB(255, 182, 44), 
		mdef = Color3.fromRGB(149, 222, 131), 
		spe = Color3.fromRGB(63, 191, 146), 
		acc = Color3.fromRGB(157, 254, 136), 
		eva = Color3.fromRGB(63, 191, 146), 
		mix = Color3.fromRGB(177, 176, 190)
	}, 
	Rarities = {
		Common = Color3.fromRGB(255, 255, 255), 
		Uncommon = Color3.fromRGB(0, 150, 0), 
		Rare = Color3.fromRGB(0, 85, 255), 
		Epic = Color3.fromRGB(170, 85, 255), 
		Legendary = Color3.fromRGB(255, 85, 0), 
		Unique = Color3.fromRGB(255, 85, 127), 
		RouletteCommon = Color3.fromRGB(200, 200, 200)
	}, 
	TintList = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }, 
	MaxTints = 14, 
	Tints = {
		[0] = {
			Name = "No Tint", 
			Color = Color3.fromRGB(255, 255, 255)
		},
		{
			Name = "Red", 
			Color = Color3.fromRGB(255, 0, 0)
		}, {
			Name = "Green", 
			Color = Color3.fromRGB(0, 255, 0)
		}, {
			Name = "Orange", 
			Color = Color3.fromRGB(255, 85, 0)
		}, {
			Name = "Yellow", 
			Color = Color3.fromRGB(255, 255, 0)
		}, {
			Name = "Blue", 
			Color = Color3.fromRGB(0, 85, 255)
		}, {
			Name = "Cyan", 
			Color = Color3.fromRGB(85, 255, 255)
		}, {
			Name = "Teal", 
			Color = Color3.fromRGB(0, 128, 128)
		}, {
			Name = "Black", 
			Color = Color3.fromRGB(36, 36, 36)
		}, {
			Name = "Purple", 
			Color = Color3.fromRGB(85, 0, 127)
		}, {
			Name = "Dark Green", 
			Color = Color3.fromRGB(0, 43, 0)
		}, {
			Name = "Pink", 
			Color = Color3.fromRGB(255, 85, 255)
		}, {
			Name = "Brown", 
			Color = Color3.fromRGB(139, 69, 19)
		}, {
			Name = "Navy Blue", 
			Color = Color3.fromRGB(0, 39, 57)
		}, {
			Name = "Gold", 
			Color = Color3.fromRGB(212, 175, 55)
		}
	}
};
