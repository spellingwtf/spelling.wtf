-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {
		BasicBattle = "9057672961", 
		OldBasicBattle = "7323594319", 
		BasicOverworld = "9057756903", 
		DefaultTrainer = "9057747851", 
		Overcast = "9057783287", 
		Menu = "9057629792", 
		Seaside = "7256657004", 
		Quincy = "9057657621", 
		TerraTheme = "9057661605", 
		PleasantPorridge = "9057684743", 
		BattleTheme1 = "9057768454", 
		EvolutionTheme = "9057652770", 
		DoodleStationTheme = "9057676120", 
		MorningPrance = "9057642432", 
		BreakingNews = "9057617303", 
		Pvptheme = "9057691286", 
		Route3Theme = "9057665079", 
		BattleTheme2 = "9057715650", 
		RiffraffTheme = "9057667377", 
		TheNightclub = "9232634243", 
		MysteryUnsolved = "9057710852", 
		Grammophone = "9057654554", 
		Portia = "9057696322", 
		SummersCircle = "9057639600", 
		DeadVillage = "9057622883", 
		Protostar = "7028518546", 
		Surveillance = "9229234805", 
		battlefield2 = "9246245115", 
		battlefield4 = "9246249593", 
		battlefield5 = "9246253990", 
		CraigTheme = "9307091515", 
		Crossroads = "9307100202", 
		MoonlightBattle = "9419177451", 
		CourageWithin = "9419173360", 
		AdriftInAutumn = "9522112114", 
		ElectricDrift = "9559457852", 
		ForHonor = "9561369959", 
		AboveTheClouds = "9578083844", 
		Ariadne = "9580587651", 
		EarthquakeRumble = "9580850929", 
		Masyou = "9581600627"
	};
	local l__BasicOverworld__3 = v2.BasicOverworld;
	local v4 = l__Utilities__1.Class({
		ClassName = "Music"
	}, function(p2)
		p2.TimePosition = 0;
		p2.MusicObject = l__Utilities__1:Create("Sound")({
			Volume = 1, 
			Looped = true, 
			Parent = game.Players.LocalPlayer, 
			Name = "Music"
		});
		p2.MusicObject:Play();
		p2.CurrentId = p2.MusicObject.SoundId;
		return p2;
	end);
	function v4.FadeOutSong(p3)
		if p1.Settings:Get("MuteMusic") == false then
			for v5 = 1, 0, 0.1 do
				p3.MusicObject.Volume = v5;
				l__Utilities__1.Halt(0.05);
			end;
			p3.MusicObject.Volume = 0;
		end;
	end;
	function v4.FadeInSong(p4)
		if p1.Settings:Get("MuteMusic") == false then
			for v6 = 0, 1, 0.1 do
				p4.MusicObject.Volume = v6;
				l__Utilities__1.Halt(0.05);
			end;
			p4.MusicObject.Volume = 1;
		end;
	end;
	function v4.ChangeMute(p5)
		if p1.Settings:Get("MuteMusic") == false then
			p5.MusicObject.Volume = 1;
			return;
		end;
		p5.MusicObject.Volume = 0;
	end;
	function v4.Stop(p6)
		p6.MusicObject:Stop();
	end;
	function v4.Play(p7, p8)
		if p8 then
			warn("Use :PlaySong() instead");
		end;
		p7.MusicObject:Play();
	end;
	function v4.ChangeMusic(p9, p10, p11)
		p9.CurrentSong = p10;
		p10 = v2[p10] and "rbxassetid://" .. v2[p10] or p10;
		if p10 == p9.CurrentId then
			return;
		end;
		if p11 then
			p9.MusicObject.TimePosition = p9.TimePosition;
		else
			p9.MusicObject.TimePosition = 0;
		end;
		p9.MusicObject.SoundId = p10;
		p9.CurrentId = p9.MusicObject.SoundId;
		p9:ChangeMute();
	end;
	function v4.PlayPreviousSong(p12, p13)
		if p12.PreviousSong then
			p12:PlaySong(p12.PreviousSong, p13, true);
			p12.PreviousSong = nil;
		end;
	end;
	function v4.GetCurrentSong(p14)
		return p14.CurrentSong;
	end;
	local u1 = {};
	local function u2(p15)
		if v2[p15] then
			return v2[p15]:match("%d+");
		end;
		if typeof(p15) ~= "string" then
			return nil;
		end;
		return p15:match("%d+");
	end;
	function v4.PlaySong(p16, p17, p18, p19)
		if u1[p17] and p1.Settings:Get("ContentCreator") then
			return;
		end;
		if u2(p16.MusicObject.SoundId) == u2(v2[p17]) then
			return;
		end;
		p16.TimePosition = p16.MusicObject.TimePosition;
		p16.PreviousSong = p16.MusicObject.SoundId;
		if u2(p16.PreviousSong) == u2(p17) then
			return;
		end;
		p16:ChangeMute();
		if p18 then
			l__Utilities__1.FastSpawn(function()
				p16:FadeOutSong();
				p16:ChangeMusic(p17, p19);
				p16:FadeInSong();
			end);
			return;
		end;
		p16:ChangeMusic(p17, p19);
	end;
	return v4.new();
end;
