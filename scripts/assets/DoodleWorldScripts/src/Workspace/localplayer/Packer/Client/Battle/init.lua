-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Signal();
	p1.GenericSignal = l__Utilities__1.Signal();
	p1.BattleStart = l__Utilities__1.Signal();
	p1.BattleEnd = l__Utilities__1.Signal();
	p1.Switch = l__Utilities__1.Signal();
	p1.MoveLearn = l__Utilities__1.Signal();
	p1.SelectedAction = l__Utilities__1.Signal();
	local v3 = l__Utilities__1.Signal();
	local u1 = nil;
	local u2 = nil;
	local u3 = nil;
	local u4 = nil;
	local u5 = {};
	function u5.EvolveCheck(p2)
		local v4 = {};
		for v5, v6 in pairs((p1.ClientDatabase:PDSFunc("GetParty"))) do
			if v6.Evolve then
				table.insert(v4, v6);
			end;
		end;
		return v4;
	end;
	local u6 = false;
	function u5.WildBattle(p3, p4, p5)
		u6 = false;
		l__Utilities__1.FastSpawn(function()
			p1.Camera:Zoom();
			p1.Gui:DiagonalBlackscreen();
			u6 = true;
			p1.BattleStart:Fire();
		end);
		p1.EndBattleFunc = nil;
		u5.RequestBattle = true;
		local v7 = p1.DataManager.RegionData.ChunkName or p1.DataManager.RegionData.Reference;
		if p1.DataManager.RegionData.BattleMusic then
			if math.random(1, 3) > 1 then
				p1.Music:PlaySong(p1.DataManager.RegionData.BattleMusic, true);
			else
				local v8 = { "battlefield2", "battlefield4", "battlefield5" };
				p1.Music:PlaySong(v8[math.random(#v8)], true);
			end;
		end;
		if p5 then
			p1.Network:post("RequestWi1d", v7, p5);
		else
			p1.Network:post("RequestWi1d", v7, p4, p1.Overworld:GetWeather());
		end;
		return p1.BattleEnd, p1.WipeoutLocation;
	end;
	function u5.TrainerBattle(p6, p7, p8, p9, p10)
		u6 = false;
		l__Utilities__1.FastSpawn(function()
			p1.Gui:ShadeBlackscreen();
			u6 = true;
			p1.BattleStart:Fire();
		end);
		if p9 then
			p1.EndBattleFunc = p9;
		else
			p1.EndBattleFunc = nil;
		end;
		u5.RequestBattle = true;
		p1.CurrentTrainerModel = p8;
		p1.CurrentTrainerModel2 = p10;
		p1.Network:post("RequestTrainer", p7, p1.Overworld:GetWeather());
		return p1.BattleEnd, p1.WipeoutLocation;
	end;
	local u7 = nil;
	p1.Network:BindEvent("BackupStart", function()
		if u6 then
			p1.BattleStart:Fire();
		end;
	end);
	local u8 = nil;
	local u9 = nil;
	local u10 = nil;
	local u11 = false;
	local function u12()
		if u1 then
			u1:Disconnect();
		end;
		if u2 then
			u2:Disconnect();
		end;
		if u3 then
			u3:Disconnect();
		end;
		if u4 then
			u4:Disconnect();
		end;
		local v9 = {
			MainBattle = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui").MainBattle
		};
		u2 = v9.MainBattle:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			u5.BGui:ChangedSize(v9.FrontBox);
			u5.BGui:ChangedSize(v9.BackBox);
			u5.BGui:ChangedSize(v9.Front1Box, true);
			u5.BGui:ChangedSize(v9.Front2Box, true);
			u5.BGui:ChangedSize(v9.Back1Box, true);
			u5.BGui:ChangedSize(v9.Back2Box, true);
		end);
		v9.Front = v9.MainBattle:WaitForChild("DoodleFront");
		v9.Front1 = v9.MainBattle:WaitForChild("DoodleFront1");
		v9.Front2 = v9.MainBattle:WaitForChild("DoodleFront2");
		v9.Front1Box = v9.MainBattle:WaitForChild("Front1Box");
		v9.Front2Box = v9.MainBattle:WaitForChild("Front2Box");
		v9.FrontBox = v9.MainBattle:WaitForChild("FrontBox");
		v9.Back = v9.MainBattle:WaitForChild("DoodleBack");
		v9.Back1 = v9.MainBattle:WaitForChild("DoodleBack1");
		v9.Back2 = v9.MainBattle:WaitForChild("DoodleBack2");
		v9.BackBox = v9.MainBattle:WaitForChild("BackBox");
		v9.Back1Box = v9.MainBattle:WaitForChild("Back1Box");
		v9.Back2Box = v9.MainBattle:WaitForChild("Back2Box");
		v9.Flash = v9.MainBattle:WaitForChild("Flash");
		v9.Background = v9.MainBattle:WaitForChild("Background");
		v9.BottomBar = v9.MainBattle:WaitForChild("BottomBar");
		v9.Levelup = v9.MainBattle:WaitForChild("LevelUpBG");
		v9.TrainerSprite = v9.MainBattle:WaitForChild("TrainerSprite");
		v9.FrontCapsule = v9.MainBattle:WaitForChild("CapsuleFront");
		v9.FrontCapsule.Visible = false;
		v9.BackCapsule = v9.MainBattle:WaitForChild("CapsuleBack");
		v9.EnemyParty = v9.MainBattle.OtherHider:WaitForChild("EnemyParty");
		v9.UserParty = v9.MainBattle.PlayerHider:WaitForChild("UserParty");
		v9.PlayerTimer = v9.MainBattle.PlayerHider.TimerLabel;
		v9.OtherTimer = v9.MainBattle.OtherHider.TimerLabel;
		v9.PlayerName = v9.MainBattle.PlayerHider.UserName;
		v9.OtherName = v9.MainBattle.OtherHider.UserName;
		v9.UserParty.Visible = false;
		v9.EnemyParty.Visible = false;
		for v10, v11 in pairs({ 1, 0.75, 0.6, 0.5, 0.4, 0.3, 0.25 }) do
			v9.UserParty.Size = UDim2.new(v11, 0, 2, 0);
			v9.PlayerName.Size = UDim2.new(v11, 0, 0.1, 0);
			v9.PlayerName.Position = UDim2.new(0.5 + (1 - v11) / 2, 0, 0.54, 0);
			if p1.Gui:IsGuiOnScreenNoVertical(v9.UserParty) then
				v9.UserParty.Visible = true;
				v9.EnemyParty.Visible = true;
				v9.OtherName.Position = UDim2.new(0.5 - (1 - v11) / 2, 0, 0.473, 0);
				v9.EnemyParty.Size = UDim2.new(v11, 0, 2, 0);
				v9.OtherName.Size = UDim2.new(v11, 0, 0.1, 0);
				break;
			end;
		end;
		local l__Settings__12 = v9.BottomBar.Settings;
		u1 = l__Settings__12.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop");
			p1.Settings:Show({});
		end);
		local l__TypeChart__13 = v9.BottomBar.TypeChart;
		v9.MagnifyingGlass = v9.BottomBar.MagnifyingGlass;
		u3 = l__TypeChart__13.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop");
			p1.TypeChart.new({
				CloseThing = true
			});
		end);
		p1.Gui:Hover(l__TypeChart__13);
		p1.Gui:Hover(l__Settings__12);
		p1.Gui:Hover(v9.MagnifyingGlass);
		return v9;
	end;
	local function u13(p11, p12)
		if p12 == "Rain" then
			u5.Weather.StartRain(p11.MainBattle);
			return;
		end;
		if p12 == "Acid Rain" then
			u5.Weather.AcidRain(p11.MainBattle);
			return;
		end;
		if p12 == "Chocolate Rain" then
			u5.Weather.ChocolateRain(p11.MainBattle);
			return;
		end;
		if p12 == "Sandstorm" then
			u5.Weather.Sandstorm(p11.MainBattle);
		end;
	end;
	local function u14(p13, p14)
		if p14.ReverseSingularity then
			u5.BattleEffects.ReverseSingularity(p13.MainBattle);
		end;
		u5.BattleEffects.Check(p13.MainBattle, p14);
	end;
	local function u15(p15, p16, p17)
		p17 = p17;
		local v14, v15, v16 = u5.Funcs:FindSpriteFromDoodle(p15, p16, p17);
		if v14:FindFirstChild("NewDoodleLabel") then
			v14:FindFirstChild("NewDoodleLabel"):Destroy();
		end;
		if p17.currenthp > 0 then
			u5.BGui:SetBox(v15, p17, p17.currenthp, p16.Format == "Doubles");
			if v16 then
				u7[p17.ID] = p1.Gui:AnimateSprite(v14, p17, not v16);
				local v17 = u7[p17.ID];
			else
				u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(p16), p15.EnemyParty);
				p15.TrainerSprite.Visible = false;
				u7[p17.ID] = p1.Gui:AnimateSprite(v14, p17, not v16);
				v17 = u7[p17.ID];
			end;
			if p17.Status == "Frozen" then
				p1.Gui:Cancel(v17);
			end;
			v14.Parent.Visible = true;
			if p17.Decoy then
				v14.Visible = false;
				u5.BGui:SummonScapegoat(v14, v16);
			end;
			v14.Parent.Visible = true;
			v15.Visible = true;
		end;
	end;
	p1.Network:BindEvent("SpectateBattle", function(p18, p19)
		u7 = {};
		u5.Funcs:ClearTiedSprites();
		if u8 then
			u8:Disconnect();
		end;
		if u9 then
			u9:Disconnect();
		end;
		if u10 then
			u10:Disconnect();
		end;
		u11 = false;
		p1.Spectating = p19;
		p1.ObjectiveUI:Hide();
		p1.PlayerList:Hide();
		p1.Menu:Disable();
		if p18.BattleMusic then
			p1.Music:PlaySong(p18.BattleMusic, true);
		end;
		local v18 = u12();
		p1.Gui:ChangeText(v18.BottomBar.Say, "");
		if p18.Background then
			v18.Background.Image = p1.Backgrounds[p18.Background].Image;
		end;
		u5.BGui:SetupEvents(v18);
		p1.Gui:FadeToBlack();
		v18.Front.Visible = false;
		v18.Front1.Visible = false;
		v18.Front2.Visible = false;
		v18.Back.Visible = false;
		v18.Back1.Visible = false;
		v18.Back2.Visible = false;
		v18.FrontBox.Visible = false;
		v18.Front1Box.Visible = false;
		v18.Front2Box.Visible = false;
		v18.BackBox.Visible = false;
		v18.Back1Box.Visible = false;
		v18.Back2Box.Visible = false;
		v18.PlayerTimer.Visible = false;
		v18.PlayerName.Visible = false;
		v18.OtherTimer.Visible = false;
		v18.OtherName.Visible = false;
		if p18.BattleType == "PvP" then
			p1.EndBattleFunc = nil;
			local v19 = p1.Spectating == p18.Player1 and p18.Player1 or p18.Player2;
			local v20 = v19 == p18.Player1 and p18.Player2 or p18.Player1;
			v18.PlayerTimer.Text = l__Utilities__1.ConvertTimer(v19.PvPTimer.Value);
			v18.OtherTimer.Text = l__Utilities__1.ConvertTimer(v20.PvPTimer.Value);
			u9 = v19.PvPTimer.Changed:Connect(function()
				v18.PlayerTimer.Text = l__Utilities__1.ConvertTimer(v19.PvPTimer.Value);
			end);
			u10 = v20.PvPTimer.Changed:Connect(function()
				v18.OtherTimer.Text = l__Utilities__1.ConvertTimer(v20.PvPTimer.Value);
			end);
			p1.Gui:ChangeText(v18.PlayerName, v19.Name);
			p1.Gui:ChangeText(v18.OtherName, v20.Name);
			v18.PlayerName.Visible = true;
			v18.OtherName.Visible = true;
			if p18.TimeLimit ~= 3 then
				v18.PlayerTimer.Visible = true;
				v18.OtherTimer.Visible = true;
			end;
		end;
		u8 = v18.BottomBar.Spectator.StopSpectating.MouseButton1Click:Connect(function()
			v18.BottomBar.Spectator.Visible = false;
			u11 = true;
			if u8 then
				u8:Disconnect();
			end;
			p1.Network:get("SpectateBattle", nil, false);
		end);
		v18.BottomBar.Spectator.Visible = true;
		v18.BottomBar.Moves.Visible = false;
		v18.BottomBar.MoveDescription.Visible = false;
		v18.BottomBar.SelectTarget.Visible = false;
		v18.BottomBar.Actions.Visible = false;
		v18.BottomBar.Back.Visible = false;
		v18.BottomBar.Next.Position = UDim2.new(0.9, 1, 0.5, 0);
		u5.BGui:PartyBarReset(v18.EnemyParty);
		u5.BGui:PartyBarReset(v18.UserParty);
		if p18.BattleType ~= "Wild" then
			u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(p18), v18.EnemyParty);
		end;
		u5.BGui:PartyBar(u5.Funcs:GetPlayerParty(p18), v18.UserParty);
		u13(v18, p18.Weather);
		u14(v18, p18);
		v18.TrainerSprite.Visible = false;
		u5.RequestBattle = nil;
		u5.CurrentBattle = p18;
		v18.MainBattle.Position = UDim2.new(0.5, 0, -1.5, 0);
		v18.MainBattle.Visible = true;
		local v21, v22 = u5.Funcs:FindOutDoodles(p18);
		for v23, v24 in pairs(v21) do
			u15(v18, p18, v24);
		end;
		for v25, v26 in pairs(v22) do
			u15(v18, p18, v26);
		end;
		v18.MainBattle:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.5);
		p1.Gui:ChangeText(v18.BottomBar.Say, "Waiting for action...");
	end);
	local function u16(p20)
		p1.Camera:Return();
		p1.Settings:Hide();
		p1.TypeChart:Close();
		p1.Battle.CurrentBattle = nil;
		p1.Spectating = nil;
		p1.Menu.DisableBlur();
		p1.Controls:ToggleWalk(true);
		p1.PlayerList:Show();
		p1.ObjectiveUI:Show();
		if p1.EndBattleFunc then
			p1.EndBattleFunc();
		end;
		p1.Gui:FadeFromBlack();
		if p20.Front:FindFirstChild("Decoy") then
			p20.Front:FindFirstChild("Decoy"):Destroy();
		end;
		if p20.Back:FindFirstChild("Decoy") then
			p20.Back:FindFirstChild("Decoy"):Destroy();
		end;
		u5.Weather.Stop(p20.MainBattle);
		u5.BattleEffects.DisableAll(p20.MainBattle);
	end;
	p1.Network:BindEvent("StopSpectating", function()
		if u8 then
			u8:Disconnect();
		end;
		p1.Spectating = nil;
		local v27 = u12();
		p1.Music:PlayPreviousSong(true);
		p1.Camera:Default();
		p1.CurrentTrainerModel = nil;
		v27.MainBattle:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.5);
		if u5.Trainer3D and u5.Trainer3D.Destroy then
			u5.Trainer3D:Destroy();
		end;
		v27.MainBattle.Visible = false;
		u16(v27);
		p1.BattleEnd:Fire();
	end);
	p1.Network:BindEvent("StartBattle", function(p21)
		u7 = {};
		u5.Funcs:ClearTiedSprites();
		if p21.BattleType == "Wild" or p21.BattleType == "Trainer" then
			p1.BattleStart:Wait();
		end;
		if u9 then
			u9:Disconnect();
		end;
		if u10 then
			u10:Disconnect();
		end;
		p1.Menu:CloseAll();
		u11 = false;
		p1.ObjectiveUI:Hide();
		p1.PlayerList:Hide();
		p1.Menu:Disable();
		if p1.guiholder:FindFirstChild("TeamPreview").Visible == true then
			u5.TeamPreview.Hide();
		end;
		if p21.BattleType ~= "Wild" and p21.BattleMusic then
			p1.Music:PlaySong(p21.BattleMusic, true);
		end;
		local v28 = u12();
		if p21.Background then
			v28.Background.Image = p1.Backgrounds[p21.Background].Image;
		end;
		u13(v28, p21.Weather);
		v28.Background.ImageColor3 = Color3.fromRGB(255, 255, 255);
		v28.PlayerTimer.Visible = false;
		v28.PlayerName.Visible = false;
		v28.OtherTimer.Visible = false;
		v28.OtherName.Visible = false;
		if p21.BattleType == "PvP" then
			p1.EndBattleFunc = nil;
			local v29 = game.Players.LocalPlayer == p21.Player1 and p21.Player1 or p21.Player2;
			local v30 = v29 == p21.Player1 and p21.Player2 or p21.Player1;
			v28.PlayerTimer.Text = l__Utilities__1.ConvertTimer(v29.PvPTimer.Value);
			v28.OtherTimer.Text = l__Utilities__1.ConvertTimer(v30.PvPTimer.Value);
			u9 = v29.PvPTimer.Changed:Connect(function()
				v28.PlayerTimer.Text = l__Utilities__1.ConvertTimer(v29.PvPTimer.Value);
			end);
			u10 = v30.PvPTimer.Changed:Connect(function()
				v28.OtherTimer.Text = l__Utilities__1.ConvertTimer(v30.PvPTimer.Value);
			end);
			p1.Gui:ChangeText(v28.PlayerName, v29.Name);
			p1.Gui:ChangeText(v28.OtherName, v30.Name);
			v28.PlayerName.Visible = true;
			v28.OtherName.Visible = true;
			if p21.TimeLimit ~= 3 then
				v28.PlayerTimer.Visible = true;
				v28.OtherTimer.Visible = true;
			end;
		end;
		u5.BGui:SetupEvents(v28);
		if p21.BattleType == "PvP" then
			p1.Gui:FadeToBlack();
		end;
		v28.Front.Visible = false;
		v28.Front1.Visible = false;
		v28.Front2.Visible = false;
		v28.Back.Visible = false;
		v28.Back1.Visible = false;
		v28.Back2.Visible = false;
		v28.FrontBox.Visible = false;
		v28.Front1Box.Visible = false;
		v28.Front2Box.Visible = false;
		v28.BackBox.Visible = false;
		v28.Back1Box.Visible = false;
		v28.Back2Box.Visible = false;
		v28.BottomBar.Spectator.Visible = false;
		v28.BottomBar.Moves.Visible = false;
		v28.BottomBar.MoveDescription.Visible = false;
		v28.BottomBar.Actions.Visible = false;
		v28.BottomBar.Back.Visible = false;
		v28.BottomBar.SelectTarget.Visible = false;
		v28.BottomBar.Next.Position = UDim2.new(0.9, 1, 0.5, 0);
		u5.BGui:PartyBarReset(v28.EnemyParty);
		u5.BGui:PartyBarReset(v28.UserParty);
		v28.TrainerSprite.Visible = false;
		u5.RequestBattle = nil;
		u5.CurrentBattle = p21;
		if p21.BattleType == "Wild" then
			if p21.Format == "Singles" then
				local v31, v32 = u5.Funcs:GetOutDoodles(p21);
				local l__Sprite__33 = v28.Front.Sprite;
				if l__Sprite__33:FindFirstChild("NewDoodleLabel") then
					l__Sprite__33:FindFirstChild("NewDoodleLabel"):Destroy();
				end;
				u7[v32.Doodle.ID] = p1.Gui:AnimateSprite(l__Sprite__33, v32, true);
				p1.Gui:ChangeText(v28.BottomBar.Say, "");
				v28.Front.Visible = true;
				v28.FrontBox.Visible = true;
				u5.BGui:SetBox(v28.FrontBox, v32);
			end;
		elseif p21.BattleType == "PvP" then
			local v34 = game.Players.LocalPlayer == p21.Player1 and p21.Player2.Character or p21.Player1.Character;
			v34.Archivable = true;
			u5.Trainer3D = p1.Gui.ViewportModule(v34, v28.TrainerSprite, "DefaultIdle");
			v28.TrainerSprite.Visible = true;
			u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(p21), v28.EnemyParty);
			p1.Gui:ChangeText(v28.BottomBar.Say, "");
		else
			p1.Camera:Return();
			u5.Trainer3D = p1.Gui.ViewportModule(p1.CurrentTrainerModel, v28.TrainerSprite, "DefaultIdle");
			v28.TrainerSprite.Visible = true;
			u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(p21), v28.EnemyParty);
			p1.Gui:ChangeText(v28.BottomBar.Say, "");
		end;
		u5.BGui:PartyBar(u5.Funcs:GetPlayerParty(p21), v28.UserParty);
		v28.MainBattle.Position = UDim2.new(0.5, 0, -1.5, 0);
		v28.MainBattle.Visible = true;
		v28.MainBattle:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 1, true);
		l__Utilities__1.Halt(1);
		p1.Network:post(p1.Name .. "InitialReady");
	end);
	local u17 = {};
	local function u18(p22, p23)
		if u17[1] == p22 then
			return true;
		end;
		v3:Wait();
		if p23 then
			p23.Visible = false;
		end;
		return u18(p22);
	end;
	local v35 = l__Utilities__1.Signal();
	local u19 = nil;
	local u20 = nil;
	local u21 = l__Utilities__1.Signal();
	local u22 = nil;
	local function u23(p24)
		if p24.Skin ~= 0 then
			local l__Sprites__36 = p1.Skins.Sprites;
			local v37 = l__Utilities__1.GetRealName(p24);
			if l__Sprites__36[v37] then
				for v38, v39 in pairs(l__Sprites__36[v37]) do
					if p24.Skin == v38 and v39.Name == "Prestige" then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
	local function u24(p25, p26, p27)
		local v40 = nil;
		local v41, v42, v43 = pairs(p26);
		while true do
			local v44, v45 = v41(v42, v43);
			if not v44 then
				break;
			end;
			local v46 = false;
			for v47, v48 in pairs(p25) do
				if v47 ~= 5 and v45.Name == v48.Name then
					v46 = true;
					break;
				end;
			end;
			if not v46 then
				v40 = v45.Name;
				break;
			end;		
		end;
		if v40 ~= nil and v40 ~= p27 then
			return "MoveForgotten", v40;
		end;
		return "DidNotLearn";
	end;
	p1.Network:BindEvent("RelayBattle", function(p28, p29)
		table.insert(u17, p28);
		u5.CurrentData = p29;
		local v49 = nil;
		OnForceSwitch = nil;
		local v50 = u12();
		v50.MagnifyingGlass.Visible = false;
		u5.BGui:SetupEvents(v50);
		local v51 = {};
		p1.Menu:Disable();
		if u19 then
			p1.Network:UnbindEvent("ForceEnd");
			u19 = nil;
		end;
		if u20 then
			p1.Network:UnbindEvent("UpdateParty");
			u20 = nil;
		end;
		local u25 = p29;
		p1.Network:BindEvent("UpdateParty", function(p30)
			if p1.p == u25.Player1 then
				u25.Player1Party = p30;
				u21:Fire();
				return;
			end;
			if p1.p == u25.Player2 then
				u25.Player2Party = p30;
				u21:Fire();
			end;
		end);
		local u26 = nil;
		p1.Network:BindEvent("ForceEnd", function()
			p1.Switch:Fire();
			p1.SelectedAction:Fire(true);
			l__Utilities__1.Halt(0.1);
			if u26 then
				u26:Destroy();
			end;
			u21:Fire();
		end);
		u19 = true;
		u20 = true;
		if u4 then
			u4:Disconnect();
		end;
		v50.MagnifyingGlass.Visible = false;
		if u18(p28) then
			local v52, v53, v54 = pairs(p28);
			while true do
				local v55, v56 = v52(v53, v54);
				if not v55 then
					break;
				end;
				if v55 == 1 then
					v50.MagnifyingGlass.Visible = false;
				end;
				if u11 then
					u11 = false;
					break;
				end;
				if v56.Action == "Dialogue" then
					local v57 = false;
					if u25.FinalStages and v56.FinalStages then
						v57 = true;
					end;
					if v56.Text:find("%[PLAYERONLY%]") and p1.Spectating then
						v57 = true;
					end;
					if v56.Text:find("%[SPECTATORONLY%]") and not p1.Spectating then
						v57 = true;
					end;
					local v58 = u5.BGui:ReplaceName(v56.Text, u25);
					if not v57 then
						if v56.FastSpawn then
							l__Utilities__1.FastSpawn(function()
								p1.Gui:Say(v50.BottomBar.Say, v58);
							end);
						else
							if p28[v55 + 1] == nil then
								v58 = "[LAST]" .. v58;
							elseif p28[v55 + 1].Action ~= "Dialogue" then
								v58 = "[LAST]" .. v58;
							end;
							p1.Gui:Say(v50.BottomBar.Say, v58);
						end;
					end;
				elseif v56.Action == "DoNotCall" then
					v49 = true;
				elseif v56.Action == "ActionAppear" then
					if p1.Spectating then
						p1.Gui:Say(v50.BottomBar.Say, "Waiting for action...");
					elseif v56.Player == p1.p then
						if u22 then
							setmetatable(u22, nil);
						end;
						if u25.BattleType == "Wild" and u25.OwnsMagnifyingGlass then
							v50.MagnifyingGlass.Visible = true;
						end;
						u4 = v50.MagnifyingGlass.MouseButton1Click:Connect(function()
							if u25 then
								p1.Sound:Play("BasicClick");
								p1.guiholder.MainBattle.Visible = false;
								local v59 = u25.Out2[1];
								v59.OriginalOwner = "Unknown";
								p1.Stats.new({
									NoTamer = true, 
									NoMoveSwap = true, 
									Battle = u25, 
									CloseFunc = function()
										p1.guiholder.MainBattle.Visible = true;
									end
								}, v59);
							end;
						end);
						u22 = u5.Actions.new({
							BattleData = u25, 
							OutDoodles = v56.Doodle, 
							Gui = v50
						});
					end;
				elseif v56.Action == "ActionDisappear" then
					v50.BottomBar.Actions.Visible = false;
					v50.BottomBar.Back.Visible = false;
					v50.BottomBar.Moves.Visible = false;
					v50.BottomBar.MoveDescription.Visible = false;
					v50.BottomBar.SelectTarget.Visible = false;
					u5.BGui:StopBobble();
					if p1.ActionParty and p1.ActionParty.Destroy then
						p1.ActionParty:Destroy();
						p1.ActionParty.Party = nil;
						p1.ActionParty = nil;
					end;
					if p1.ActionStats and p1.ActionStats.Destroy then
						p1.ActionStats:Destroy();
						p1.ActionStats = nil;
					end;
					p1.Settings:Hide();
					p1.TypeChart:Close();
					v50.MainBattle.Visible = true;
				elseif v56.Action == "OptionalSwitch" then
					local v60 = u5.Funcs:GetPlayerParty(u25);
					local l__Yes__61 = v50.BottomBar.Yes;
					local l__No__62 = v50.BottomBar.No;
					p1.Gui:Hover(l__Yes__61);
					p1.Gui:Hover(l__No__62);
					local u27 = p1.Party.new({
						Temp = true, 
						CloseFunction = function()

						end, 
						Party = v60, 
						String = "Do you want to switch doodles?", 
						Battle = self, 
						Manual = true, 
						NoColorList = true
					});
					u5.BGui:SetYesEvent(l__Yes__61, function()
						u27:Show();
					end);
					u5.BGui:SetNoEvent(l__No__62, function()
						if u27.Destroy then
							u27:Destroy();
						end;
						p1.Switch:Fire();
					end);
					l__Yes__61.Visible = true;
					l__No__62.Visible = true;
					p1.Switch:Wait();
				elseif v56.Action == "ForceSwitch" then
					if not p1.Spectating then
						if v56.Player == game.Players.LocalPlayer then
							p1.guiholder.MainBattle.Visible = false;
							local v63 = nil;
							local v64 = nil;
							if u25.BattleType == "PvP" and u25.TimeLimit ~= 3 then
								local v65 = game.Players.LocalPlayer == u25.Player1 and u25.Player1 or u25.Player2;
								v63 = v65:FindFirstChild("PvPTimer");
								v64 = (v65 == u25.Player1 and u25.Player2 or u25.Player1):FindFirstChild("PvPTimer");
							end;
							u26 = p1.Party.new({
								DoodleBattling = v56.Doodle.Doodle, 
								PlayerTimer = v63, 
								OtherTimer = v64, 
								Party = u5.Funcs:GetPlayerParty(u25), 
								String = "Please switch in a doodle.", 
								Battle = u25, 
								Manual = false, 
								WaitForSwitch = true
							});
							u21:Wait();
						else
							p1.Gui:Say(v50.BottomBar.Say, "Waiting for other player...");
						end;
					end;
				elseif v56.Action == "DoodleAppear" then
					if not u25.FinalStages then
						local v66, v67, v68 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
						if v66:FindFirstChild("NewDoodleLabel") then
							v66:FindFirstChild("NewDoodleLabel"):Destroy();
						end;
						local v69 = v68 and v50.BackCapsule or v50.FrontCapsule;
						u5.BGui:SendOutCapsule(v69, v56.Doodle, v68, u25, v50);
						if p1.Settings:Get("BattleFlash") == true then
							v50.Flash.Visible = true;
						end;
						u5.BGui:SetBox(v67, v56.Doodle, v56.CurrentHealth, u25.Format == "Doubles");
						if v68 then
							u5.BGui:PartyBar(u5.Funcs:GetPlayerParty(u25), v50.UserParty);
							u7[v56.Doodle.ID] = p1.Gui:AnimateSprite(v66, v56.Doodle, not v68);
							local v70 = u7[v56.Doodle.ID];
						else
							u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(u25), v50.EnemyParty);
							v50.TrainerSprite.Visible = false;
							u7[v56.Doodle.ID] = p1.Gui:AnimateSprite(v66, v56.Doodle, not v68);
							v70 = u7[v56.Doodle.ID];
						end;
						if v56.Doodle.Status == "Frozen" then
							p1.Gui:Cancel(v70);
						end;
						v69.Visible = false;
						v66.Parent.Visible = true;
						v67.Visible = true;
						l__Utilities__1.Halt(0.1);
						if u23(v56.Doodle) then
							p1.Sound:Play("DiamondSparkle");
						elseif v56.Doodle.Shiny then
							p1.Sound:Play("Sparkles");
						end;
						v50.Flash.Visible = false;
						l__Utilities__1.Halt(0.15);
						u5.Funcs:ClearPrevious(v67);
					end;
				elseif v56.Action == "Wait" then
					l__Utilities__1.Halt(v56.Time);
				elseif v56.Action == "TakeDamage" then
					local v71, v72, v73 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v71) then
						v71 = u5.BGui:GetNewSprite(v71);
					end;
					p1.Sound:Play("NormalHit");
					u5.BGui:SpriteFlash(v71, v56.Decoy);
					if v73 then
						u5.BGui:HealthNumber(v72, v56.Doodle);
					end;
					if not v56.Decoy then
						u5.BGui:TakeDamage(v72, v56.Doodle, v56.currenthp);
						l__Utilities__1.Halt(0.75);
					end;
				elseif v56.Action == "UpdateHealth" then
					local v74, v75, v76 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.Funcs:IsOut(v56.Doodle, u25) then
						if v76 then
							u5.BGui:HealthNumber(v75, v56.Doodle);
						end;
						u5.BGui:TakeDamage(v75, v56.Doodle, v56.currenthp);
						l__Utilities__1.Halt(0.75);
					end;
				elseif v56.Action == "RaiseStat" then
					p1.Sound:Play("StatRaise");
					u5.BGui:RaiseStat(u7[v56.Doodle.ID], v56.Stat);
				elseif v56.Action == "LowerStat" then
					p1.Sound:Play("StatLower");
					u5.BGui:LowerStat(u7[v56.Doodle.ID], v56.Stat);
				elseif v56.Action == "Fainted" then
					local v77, v78, v79 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					v78.Visible = false;
					u5.BGui:PartyBar(u5.Funcs:GetPlayerParty(u25), v50.UserParty);
					if u25.BattleType ~= "Wild" then
						u5.BGui:PartyBar(u5.Funcs:GetEnemyParty(u25), v50.EnemyParty);
					end;
					if not u5.BGui:DisappearScapegoat(v56.Doodle, v77, v79, true) then
						u5.BGui:EraserAnim(u7[v56.Doodle.ID], v79);
					end;
				elseif v56.Action == "BattleOver" then
					if not p1.Spectating and u25.BattleType ~= "PvP" then
						local v80 = "You won the battle!";
						if v56.Winner == nil then
							v80 = "You lost the battle!";
						end;
						p1.Music:FadeOutSong();
						if v56.Winner == nil then
							p1.Sound:Play("DefeatStinger");
						else
							p1.Sound:Play("VictoryStinger");
						end;
						p1.Gui:Say(v50.BottomBar.Say, v80);
						l__Utilities__1.Halt(1.5);
					end;
				elseif v56.Action == "Transition" then
					p1.Music:PlayPreviousSong(true);
					if not p1.Spectating then
						p1.Network:post(p1.Name .. "Over");
					end;
					p1.Camera:Default();
					p1.CurrentTrainerModel = nil;
					v50.MainBattle:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Quad", 0.5, true);
					l__Utilities__1.Halt(0.5);
					if u5.Trainer3D and u5.Trainer3D.Destroy then
						u5.Trainer3D:Destroy();
					end;
					v50.MainBattle.Visible = false;
					local v81 = u5:EvolveCheck();
					if #v81 > 0 and not p1.Spectating then
						for v82, v83 in pairs(v81) do
							p1.Evolution.new({
								Doodle = v83
							});
						end;
					end;
					u16(v50);
					if v56.Winner ~= "Ran" then
						local v84 = false;
						if v56.Winner == game.Players.LocalPlayer then
							v84 = true;
						end;
					else
						v84 = true;
					end;
					p1.BattleEnd:Fire(v84);
				elseif v56.Action == "ExpBar" then
					p1.Sound:Play("Expgain");
					local v85, v86, v87 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					u5.BGui:TweenExperience(v56.Doodle, v56.CurrentLevel, v56.NextLevel, v86);
				elseif v56.Action == "Levelup" then
					local v88, v89, v90 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.Funcs:IsOut(v56.Doodle, u25) then
						u5.BGui:SetExpBar0(v89);
						p1.Gui:ChangeText(v89.LevelLabel, "Lv. " .. v56.Doodle.Level);
						v89.Health.Clipping.Size = UDim2.new(v56.Doodle.currenthp / v56.Doodle.Stats.hp, 0, 1, 0);
						p1.Gui:ChangeText(v89.Health.HealthNumber, v56.Doodle.currenthp .. " / " .. v56.Doodle.Stats.hp);
					end;
					if not p1.Spectating and p1.Settings:Get("SkipLevelUp") == false then
						p1.Sound:Play("Levelup");
						local l__PreviousStats__91 = v56.PreviousStats;
						local v92 = {};
						for v93, v94 in pairs(v56.Doodle.Stats) do
							v92[v93] = v94 - l__PreviousStats__91[v93];
						end;
						for v95, v96 in pairs(v92) do
							v50.Levelup[v95].Text = "+" .. v96;
						end;
						v50.Levelup.Visible = true;
						local u28 = nil;
						u28 = v50.Levelup.Next.MouseButton1Click:Connect(function()
							u28:Disconnect();
							v50.Levelup.Visible = false;
							p1.Gui:ResetSay();
							v2:Fire();
						end);
						v2:Wait();
					end;
				elseif v56.Action == "PlaySound" then
					p1.Sound:Play(v56.Sound);
				elseif v56.Action == "TrainerDisappear" then
					pcall(function()
						if not p1.Spectating and u5.Trainer3D then
							u5.Trainer3D.Frame:TweenPosition(UDim2.new(1.2, 0, 0.5, 0), "Out", "Quad", 1, true);
							l__Utilities__1.Halt(0.5);
						end;
					end);
				elseif v56.Action == "TrainerAppear" then
					pcall(function()
						if not p1.Spectating and u5.Trainer3D then
							v50.TrainerSprite.Visible = true;
							local v97 = UDim2.new(0.5, 0, 0.5, 0);
							if u25.Format == "Doubles" then
								v97 = UDim2.new(0.75, 0, 0.5, 0);
							end;
							u5.Trainer3D.Frame:TweenPosition(v97, "Out", "Quad", 1, true);
							l__Utilities__1.Halt(1);
						end;
					end);
				elseif v56.Action == "TrainerAnim" then
					pcall(function()
						if not u5.Trainer3D then
							return;
						end;
						if not p1.Spectating then
							if v56.Winner then
								if v56.Winner ~= game.Players.LocalPlayer then
									u5.Trainer3D:PlayAnim(v56.Anim);
									wait(1);
									return;
								end;
							elseif v56.Loser then
								if v56.Loser == game.Players.LocalPlayer then
									u5.Trainer3D:PlayAnim(v56.Anim);
									wait(1);
									return;
								end;
							else
								u5.Trainer3D:PlayAnim(v56.Anim);
							end;
						end;
					end);
				elseif v56.Action == "SwapOut" then
					l__Utilities__1.Halt(0.3);
					if p1.Settings:Get("BattleFlash") == true then
						v50.Flash.Visible = true;
					end;
					local v98, v99, v100 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					v99.Visible = false;
					v98.Parent.Visible = false;
					l__Utilities__1.Halt(0.1);
					v50.Flash.Visible = false;
				elseif v56.Action == "ThrowCapsule" then
					local v101, v102, v103 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v101) then
						v101 = u5.BGui:GetNewSprite(v101);
					end;
					local l__Item__104 = v56.Item;
					u5.BGui:ThrowCapsule(v50.FrontCapsule, v56.Item, v102, v101, v50.Flash);
				elseif v56.Action == "Shakes" then
					local l__FrontCapsule__105 = v50.FrontCapsule;
					local l__Shakes__106 = v56.Shakes;
					if l__Shakes__106 > 0 then
						for v107 = 1, l__Shakes__106 do
							l__FrontCapsule__105:TweenPosition(UDim2.new(0.582, 0, 0.498, 0), "Out", "Linear", 0.2, true);
							l__Utilities__1.Halt(0.2);
							l__FrontCapsule__105:TweenPosition(UDim2.new(0.582, 0, 0.598, 0), "Out", "Bounce", 0.5, true);
							l__Utilities__1.Halt(0.2);
							p1.Sound:Play("Bounce");
							l__Utilities__1.Halt(0.3);
						end;
					end;
				elseif v56.Action == "Captured" then
					local l__FrontCapsule__108 = v50.FrontCapsule;
					l__FrontCapsule__108.Sprite.ImageColor3 = Color3.fromRGB(128, 128, 128);
					l__Utilities__1.Halt(0.5);
					p1.Sound:Play("Click");
					l__FrontCapsule__108.Sprite.ImageColor3 = Color3.fromRGB(255, 255, 255);
					l__Utilities__1.Halt(0.5);
				elseif v56.Action == "CaptureFail" then
					local v109, v110, v111 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v109) then
						v109 = u5.BGui:GetNewSprite(v109);
					end;
					local l__FrontCapsule__112 = v50.FrontCapsule;
					l__FrontCapsule__112.Sprite.Image = p1.MiscDB.Capsules[v56.Item].Closed;
					l__Utilities__1.Halt(0.2);
					if p1.Settings:Get("BattleFlash") == true then
						v50.Flash.Visible = true;
					end;
					v109.Visible = true;
					l__FrontCapsule__112.Visible = false;
					v110.Visible = true;
					p1.Sound:Play("LidOpen");
					l__Utilities__1.Halt(0.05);
					v50.Flash.Visible = false;
				elseif v56.Action == "MoveLearn" then
					if not p1.Spectating then
						p1.Gui:Say(v50.BottomBar.Say, "[NONEXT]" .. v56.Doodle.Name .. " wants to learn " .. v56.NewMove .. ", but can't learn more than 4 moves.");
						p1.Gui:Say(v50.BottomBar.Say, "[NONEXT]Replace a move with " .. v56.NewMove .. "?");
						local l__Yes__113 = v50.BottomBar.Yes;
						local l__No__114 = v50.BottomBar.No;
						p1.Gui:Hover(l__Yes__113);
						p1.Gui:Hover(l__No__114);
						v56.Doodle.Moves = v51[v56.Doodle.ID] or l__Utilities__1:deepCopy(v56.Doodle.Moves);
						u5.BGui:SetYesEvent(l__Yes__113, function()
							l__Yes__113.Visible = false;
							l__No__114.Visible = false;
							u5.Funcs:AddTemporaryMove(v56.Doodle, v56.NewMove);
							v50.MainBattle.Visible = false;
							local v115 = {
								Battle = u25
							};
							local u29 = l__Utilities__1:deepCopy(v56.Doodle.Moves);
							function v115.BattleAppear(p31)
								v50.MainBattle.Visible = true;
								if p1.Network:get("RemoveExtraMove", p31.ID, true) then
									local v116, v117 = u24(p31.Moves, u29, v56.NewMove);
									if v116 == "DidNotLearn" then
										p1.Gui:Say(v50.BottomBar.Say, v56.Doodle.Name .. " did not learn " .. v56.NewMove .. ".");
									elseif v116 == "MoveForgotten" then
										p1.Gui:Say(v50.BottomBar.Say, v56.Doodle.Name .. " forgot " .. v117 .. " and learned " .. v56.NewMove .. "!");
									end;
									v51[v56.Doodle.ID] = l__Utilities__1:deepCopy(p31.Moves);
									p1.MoveLearn:Fire();
								end;
							end;
							v115.LearningMove = true;
							p1.Stats.new(v115, v56.Doodle);
						end);
						u5.BGui:SetNoEvent(l__No__114, function()
							l__Yes__113.Visible = false;
							l__No__114.Visible = false;
							p1.Network:get("RemoveExtraMove", v56.Doodle.ID);
							p1.Gui:Say(v50.BottomBar.Say, v56.Doodle.Name .. " did not learn " .. v56.NewMove .. ".");
							p1.MoveLearn:Fire();
						end);
						l__Yes__113.Visible = true;
						l__No__114.Visible = true;
						p1.MoveLearn:Wait();
					end;
				elseif v56.Action == "ClearTiedSprites" then
					u5.Funcs:ClearTiedSprites();
				elseif v56.Action == "PlayAnim" then
					if (p1.Battle.Funcs:IsOut(v56.Doodle, u25) or u5.Funcs:IsTiedSprites(v56.Doodle)) and p1.Settings:Get("BattleAnimations") == true then
						local v118 = p1.Moves[v56.Move];
						local v119 = p1.Typings:GetTypeColor(v118.Type);
						local l__MoveAnims__120 = u5.MoveAnims;
						local v121, v122, v123 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
						if u5.BGui:GetNewSprite(v121) then
							v121 = u5.BGui:GetNewSprite(v121);
						end;
						if v118.MoveAnim then
							for v124, v125 in pairs(v118.MoveAnim.Order) do
								l__MoveAnims__120[v125.AnimType](v121, v125);
							end;
						elseif v118.Category ~= "Passive" then
							l__MoveAnims__120.Default(v121, {
								Color = v119, 
								Size = 0.8, 
								Times = 1, 
								Wait = 0.05, 
								Pitch = 0.8
							}, v118.Type);
						end;
					end;
				elseif v56.Action == "UpdateStatus" then
					local v126, v127, v128 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					u5.BGui:UpdateStatus(v127, v56.Doodle, v56.Status);
				elseif v56.Action == "StatusAnim" then
					local v129, v130, v131 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v129) then
						v129 = u5.BGui:GetNewSprite(v129);
					end;
					if p1.Settings:Get("BattleAnimations") == true then
						if u5.MoveAnims[v56.Status] then
							u5.MoveAnims[v56.Status](v129, {});
						else
							p1.Gui:Reboot(v129);
						end;
					end;
					if v56.Status == "" then
						v56.Status = "Blank";
					end;
					u5.BGui:UpdateStatus(v130, v56.Doodle, v56.Status);
				elseif v56.Action == "ClearStatus" then
					local v132, v133, v134 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					u5.BGui:UpdateStatus(v133, v56.Doodle, "Blank");
				elseif v56.Action == "ChangeFieldColor" then
					p1.Tween:MakeTween(v50.Background, {
						ImageColor3 = v56.NewColor
					}, true, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
					l__Utilities__1.Halt(0.5);
				elseif v56.Action == "StartEffect" then
					u14(v50, u25);
				elseif v56.Action == "StopEffect" then
					u14(v50, u25);
				elseif v56.Action == "StartWeather" then
					u13(v50, v56.Weather);
				elseif v56.Action == "StopWeather" then
					u5.Weather.Stop(v50.MainBattle);
				elseif v56.Action == "SummonScapegoat" then
					local v135, v136, v137 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v135) then
						v135 = u5.BGui:GetNewSprite(v135);
					end;
					v135:TweenSize(UDim2.new(0, 0, v135.Size.Y.Scale, 0), "Out", "Quad", 0.2, true);
					l__Utilities__1.Halt(0.2);
					v135.Visible = false;
					u5.BGui:SummonScapegoat(v135, v137);
				elseif v56.Action == "DisappearScapegoat" then
					local v138, v139, v140 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v138) then
						v138 = u5.BGui:GetNewSprite(v138);
					end;
					u5.BGui:DisappearScapegoat(v56.Doodle, v138, v140);
				elseif v56.Action == "SpriteAppear" then
					local v141, v142, v143 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v141) then
						v141 = u5.BGui:GetNewSprite(v141);
					end;
					u5.BGui:SpriteAppear(v56.Doodle, v141);
				elseif v56.Action == "SpriteDisappear" then
					local v144, v145, v146 = u5.Funcs:FindSpriteFromDoodle(v50, u25, v56.Doodle);
					if u5.BGui:GetNewSprite(v144) then
						v144 = u5.BGui:GetNewSprite(v144);
					end;
					u5.BGui:SpriteDisappear(v56.Doodle, v144);
				end;			
			end;
		end;
		if not v49 and #u17 == 1 and not p1.Spectating then
			p1.Network:post(p1.Name .. "Ready");
		end;
		table.remove(u17, 1);
		v3:Fire();
		u25 = nil;
	end);
	for v147, v148 in pairs(script:GetChildren()) do
		local v149 = require(v148);
		if typeof(v149) == "function" then
			u5[v148.Name] = v149(p1, u5);
		else
			u5[v148.Name] = v148;
		end;
	end;
	return u5;
end;
