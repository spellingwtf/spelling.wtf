-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {
		Database = {
			StatRaise = "4592853646", 
			StatLower = "4592850829", 
			Click = "4598251056", 
			Eraser = "4596173312", 
			NotEnough = "4598201720", 
			Levelup = "4604792544", 
			Expgain = "4604793450", 
			RunSuccess = "4630935071", 
			NormalHit = "4631015818", 
			Sparkles = "4629215744", 
			Blip = "4636541869", 
			Throw = "138097048", 
			Bounce = "4642410850", 
			PageFlip = "2785554441", 
			Flip = "2785702437", 
			BasicClick = "318763788", 
			LidOpen = "5694567139", 
			Menu = "325340000", 
			Boop = "290841329", 
			Claw = "5719987372", 
			Shock = "5720307258", 
			Poison = "1938535433", 
			Bite = "5750695751", 
			PurchaseSuccess = "134732869", 
			PurchaseFail = "2390695935", 
			HealJingle = "7293988349", 
			ItemGet = "7293988802", 
			ChestOpen = "865367121", 
			Snore = "7314995770", 
			VictoryStinger = "7323593555", 
			DefeatStinger = "7323643342", 
			RestoreHealth = "7338305343", 
			Whir = "7338397354", 
			Collision = "7349242100", 
			BasicDoorOpen = "212709219", 
			PaintSpray = "8589844738", 
			Beep = "6062698705", 
			DeskSlam = "131218412", 
			CameraClick = "8606839904", 
			Teleport = "34320952", 
			WoodDestroy = "8840683324", 
			Interrupt = "6947274815", 
			DiamondSparkle = "9194305773", 
			Lockpick = "4648952523", 
			ChildLaughter = "9113787508", 
			RecordScratch = "5043382144", 
			DestroyRadio = "9117877055", 
			LaserSound = "180204650", 
			Crickets = "138099172", 
			Jet = "6249767417", 
			Intercom = "9553598113", 
			Whip = "9558945292", 
			Explosion = "8226406520"
		}
	};
	function v1.PlayId(p2, p3, p4, p5)
		local v2 = Instance.new("Sound", p1.pgui);
		v2.SoundId = "rbxassetid://" .. p3;
		v2.PlaybackSpeed = p4 and 1;
		v2.Volume = p5 and 1;
		v2:Play();
		v2.Ended:Connect(function()
			v2:Destroy();
		end);
	end;
	local l__Utilities__1 = p1.Utilities;
	function v1.Play(p6, p7, p8, p9, p10)
		local v3 = Instance.new("Sound", p1.pgui);
		v3.SoundId = v1.Database[p7] and "rbxassetid://" .. v1.Database[p7] or (warn(v1 .. " does not exist") or 0);
		v3.PlaybackSpeed = p8 and 1;
		v3.Volume = p9 and 1;
		if p10 then
			for v4, v5 in pairs(p10) do
				l__Utilities__1:Create(v4)(v5).Parent = v3;
			end;
		end;
		v3:Play();
		v3.Ended:Connect(function()
			v3:Destroy();
		end);
	end;
	return v1;
end;
