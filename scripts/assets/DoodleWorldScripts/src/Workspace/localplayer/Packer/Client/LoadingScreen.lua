-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local v2 = {};
	local v3 = {
		Start = CFrame.new(-127.587227, -55.4212532, 357.012939, 0.4413068, -0.179037228, 0.879314542, 7.45057971E-09, 0.979894578, 0.199516326, -0.897356272, -0.0880479068, 0.432434142)
	};
	local l__Utilities__1 = p1.Utilities;
	local u2 = nil;
	local l__Camera__3 = p1.Camera;
	function v3.Function()
		_G.InBuilding = true;
		l__Utilities__1.Halt(3);
		if not _G.ActuallyReady then
			u2 = l__Camera__3:TitleTween(CFrame.new(-134.82106, -59.6993561, 298.947723, -0.558118105, -0.154413462, 0.815267205, -0, 0.982531965, 0.186093777, -0.829761565, 0.103862308, -0.548368871), 15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
		end;
		l__Utilities__1.Halt(20);
		if not _G.ActuallyReady then
			u2 = l__Camera__3:TitleTween(CFrame.new(-127.587227, -55.4212532, 357.012939, 0.4413068, -0.179037228, 0.879314542, 7.45057971E-09, 0.979894578, 0.199516326, -0.897356272, -0.0880479068, 0.432434142), 17, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(17);
		end;
	end;
	v3.Lighting = "BuildingDefault";
	v2.Lab = v3;
	v2.Sketchvale = {
		Start = CFrame.new(818.607605, -55.9623222, -230.820389, -0.751092792, -0.283448845, 0.596251965, -1.49011594E-08, 0.903142989, 0.429340005, -0.660196662, 0.322474182, -0.67834419), 
		Function = function()
			l__Utilities__1.Halt(3);
			if not _G.ActuallyReady then
				u2 = l__Camera__3:TitleTween(CFrame.new(744.866882, -86.3863297, 4.68041182, -0.676675856, -0.142833844, 0.722293854, 7.45057971E-09, 0.981002808, 0.193993628, -0.736281097, 0.131270811, -0.663820863), 15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
			end;
			l__Utilities__1.Halt(20);
			if not _G.ActuallyReady then
				u2 = l__Camera__3:TitleTween(CFrame.new(794.280579, -85.8633041, 119.976486, -0.900993407, 0.117338583, -0.417663336, -0, 0.96272862, 0.270469517, 0.433832943, 0.243691251, -0.867412031), 15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(17);
			end;
			if not _G.ActuallyReady then
				u2 = l__Camera__3:TitleTween(CFrame.new(889.06897, -96.0980301, 803.879395, -0.964330137, 0.0299836043, -0.26299879, -1.86264493E-09, 0.99356401, 0.11327289, 0.26470241, 0.109232463, -0.958123744), 15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(17);
			end;
			if not _G.ActuallyReady then
				u2 = l__Camera__3:TitleTween(CFrame.new(818.607605, -55.9623222, -230.820389, -0.751092792, -0.283448845, 0.596251965, -1.49011594E-08, 0.903142989, 0.429340005, -0.660196662, 0.322474182, -0.67834419), 15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(17);
			end;
		end, 
		Lighting = "001_Chunk"
	};
	local v4 = { "Sketchvale", "Lab" };
	local u4 = nil;
	local u5 = v4[math.random(#v4)];
	local l__ReplicatedFirst__6 = p1.Services.ReplicatedFirst;
	function v1.Map(p2, p3)
		if u4 then
			u4:Destroy();
		end;
		if not p3 then
			p3 = u5;
		else
			u5 = p3;
		end;
		u4 = l__ReplicatedFirst__6.TitleScreenChunks:FindFirstChild(p3);
		u4.Parent = workspace;
		l__Camera__3:Scriptable(v2[p3].Start, true);
		if v2[p3].Lighting then
			p1.Lighting:Apply(v2[p3].Lighting);
		end;
	end;
	local u7 = false;
	function v1.Button(p4, p5, p6, p7, p8, p9)
		local l__Seen__5 = p6.Seen;
		local l__GameInfo__6 = p1.pgui.Cinematic.GameInfo;
		local l__Continue__7 = p1.pgui.Cinematic.Continue;
		if l__Seen__5 > 0 then
			local l__PartyHolder__8 = l__GameInfo__6.PartyHolder;
			local l__Info__9 = l__GameInfo__6.Info;
			p1.Gui:ChangeText(l__Info__9.Seen, "Seen: " .. l__Seen__5);
			p1.Gui:ChangeText(l__Info__9.Captured, "Captured: " .. p6.Captured);
			p1.Gui:ChangeText(l__Info__9.TimePlayed, "Played: " .. p1.Gui:SecondsToTimer(p7));
			p1.KeysObtained = p8;
			p1.Gui:ChangeText(l__Info__9.Keys, "Keys: " .. l__Utilities__1.TableCount(p8));
			for v10 = 1, 6 do
				local v11 = l__PartyHolder__8[v10];
				v11.Visible = false;
				if p5[v10] then
					p1.Gui:AnimateSprite(v11, p5[v10], true);
				end;
			end;
			l__GameInfo__6.Visible = true;
		else
			l__GameInfo__6.Visible = false;
			local l__NewGame__12 = p1.pgui.Cinematic.NewGame;
		end;
		l__NewGame__12.MouseEnter:Connect(function()
			l__NewGame__12.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		l__NewGame__12.MouseLeave:Connect(function()
			if l__NewGame__12.Name == "NewGame" then
				l__NewGame__12.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
				return;
			end;
			l__NewGame__12.Label.TextColor3 = Color3.fromRGB(72, 72, 72);
		end);
		l__NewGame__12.MouseButton1Click:Connect(function()
			if not u7 then
				u7 = true;
				p1.Sound:Play("BasicClick");
				p1.pgui.Cinematic.TopBar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.75);
				p1.pgui.Cinematic.BottomBar:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.75);
				l__Utilities__1.Halt(0.8);
				p1.pgui.MainGui.Blackscreen.BackgroundTransparency = 0;
				p1.pgui.MainGui.Blackscreen.Visible = true;
				if u4 then
					u4:Destroy();
				end;
				l__Camera__3:Return();
				if l__Seen__5 > 0 then
					p1.pgui.Cinematic:Destroy();
					p1.ClientDatabase:PDSEvent("LoadLocation");
				else
					p1.Cutscene:Play("Tutorial");
					p1.Utilities.FastSpawn(function()
						p1.Steps:Start();
					end);
					p1.Loaded = true;
				end;
				p1.ObjectiveUI:Show();
				p1.DailyLoginOn = nil;
				while true do
					l__Utilities__1.Halt(0.05);
					if _G.ActuallyReady then
						break;
					end;				
				end;
				if u2 then
					u2:Cancel();
				end;
			end;
		end);
		p1.RouletteBan = p9.APRIR;
		p1.TradeAllowed = p9.IPITA;
		p1.EquipUnlocked = p9.GateEquips;
		l__NewGame__12.Visible = true;
	end;
	local l__Tween__8 = p1.Tween;
	function v1.Start(p10)
		p10:Button(p1.ClientDatabase:PDSFunc("GetTitleScreen"));
		p1.Music:PlaySong("Menu");
		p10:Map();
		l__Utilities__1.Halt(0.5);
		l__Tween__8:MakeTween(p1.pgui.Loading.BlackScreen, {
			BackgroundTransparency = 1
		}, true, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(0.5);
		p1.pgui.Loading.BlackScreen:Destroy();
		while not _G.ActuallyReady do
			if v2[u5].Function then
				v2[u5].Function();
			else
				l__Utilities__1.Halt(0.1);
			end;		
		end;
	end;
	return v1;
end;
