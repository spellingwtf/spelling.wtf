-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {
		SetColor = function(p3, p4)
			local l__Scale__2 = p4.Size.X.Scale;
			if l__Scale__2 > 0.66 then
				p4.BackgroundColor3 = Color3.fromRGB(85, 255, 0);
				return;
			end;
			if l__Scale__2 > 0.33 then
				p4.BackgroundColor3 = Color3.fromRGB(255, 255, 0);
				return;
			end;
			p4.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
		end, 
		GetNewSprite = function(p5, p6)
			if not p6 then
				return nil;
			end;
			if not p6.Parent:FindFirstChild("New" .. p6.Name) then
				return;
			end;
			return p6.Parent:FindFirstChild("New" .. p6.Name);
		end
	};
	local u1 = {
		DoodleBack = UDim2.new(0.15, 0, 0.85, 0), 
		DoodleBack1 = UDim2.new(0.05, 0, 0.85, 0), 
		DoodleBack2 = UDim2.new(0.275, 0, 0.85, 0)
	};
	local u2 = false;
	local l__Utilities__3 = p1.Utilities;
	function v1.AnimateBobble(p7, p8)
		p8.Position = u1[p8.Name];
		u2 = true;
		coroutine.resume(coroutine.create(function()
			while u2 == true do
				l__Utilities__3.Halt(0.25);
				p8.Position = p8.Position - UDim2.new(0, 0, 0, 2);
				if u2 == false then
					break;
				end;
				l__Utilities__3.Halt(0.25);
				p8.Position = u1[p8.Name];			
			end;
		end));
	end;
	local u4 = {
		[true] = {
			StartPos = UDim2.new(-0.255, 0, 0.993, 0), 
			MidPos = 0.625, 
			EndPos = UDim2.new(0.15, 0, 0.85, 0)
		}, 
		[false] = {
			StartPos = UDim2.new(0.969, 0, 0.348, 0), 
			MidPos = 0.373, 
			EndPos = UDim2.new(0.582, 0, 0.598, 0)
		}
	};
	function v1.SendOutCapsule(p9, p10, p11, p12, p13, p14)
		p10.Sprite.Rotation = 180;
		local v3 = p1.MiscDB.Capsules[p11.Capsule];
		local v4, v5 = p2.Funcs:FindSpriteFromDoodle(p14, p13, p11);
		p10.Sprite.Image = v3.Closed;
		local v6 = u4[p12];
		p10.Position = v6.StartPos;
		local u5 = true;
		local u6 = 180;
		l__Utilities__3.FastSpawn(function()
			while u5 == true do
				u6 = u6 + math.random(25, 35);
				p10.Sprite.Rotation = u6;
				l__Utilities__3.Halt();			
			end;
		end);
		p10.Visible = true;
		p10:TweenPosition(UDim2.new(v4.Parent.Position.X.Scale, 0, v6.MidPos, 0), "Out", "Quint", 0.5, true);
		l__Utilities__3.Halt(0.5);
		p1.Sound:Play("LidOpen", 1, 1.6);
		u5 = false;
		p10.Sprite.Image = v3.Open;
		l__Utilities__3.Halt(0.05);
	end;
	function v1.ThrowCapsule(p15, p16, p17, p18, p19, p20)
		p16.Sprite.Rotation = 180;
		local v7 = p1.MiscDB.Capsules[p17];
		p16.Sprite.Image = v7.Closed;
		p16.Position = UDim2.new(-0.255, 0, 0.993, 0);
		local u7 = true;
		local u8 = 180;
		l__Utilities__3.FastSpawn(function()
			while u7 == true do
				u8 = u8 + math.random(25, 35);
				p16.Sprite.Rotation = u8;
				l__Utilities__3.Halt();			
			end;
		end);
		p16.Visible = true;
		p16:TweenPosition(UDim2.new(0.582, 0, 0.373), "Out", "Quint", 0.5, true);
		l__Utilities__3.Halt(0.5);
		p1.Sound:Play("LidOpen");
		u7 = false;
		p16.Sprite.Image = v7.Closed;
		l__Utilities__3.Halt(0.05);
		p16.Sprite.Image = v7.Open;
		l__Utilities__3.Halt(0.05);
		if p1.Settings:Get("BattleFlash") == true then
			p20.Visible = true;
		end;
		p16.Sprite.Image = v7.Closed;
		p16.Sprite.Rotation = 0;
		p18.Visible = false;
		p19.Visible = false;
		p16.Position = UDim2.new(0.582, 0, 0.598, 0);
		l__Utilities__3.Halt(0.05);
		p20.Visible = false;
		l__Utilities__3.Halt(0.5);
	end;
	function v1.MoveButton(p21, p22, p23, p24)
		local l__Name__8 = p23.Name;
		local v9 = p1.ClientDatabase:GetMoveData(l__Name__8);
		local l__Type__10 = v9.Type;
		p22.BackgroundColor3 = p1.Gui:DarkerColor((p1.Typings:GetColor(l__Type__10)));
		p22.Effective.Visible = false;
		local v11, v12 = p2.Funcs:GetOutDoodles(p24);
		local v13 = 1;
		if p24.Format == "Singles" then
			local v14, v15 = p1.Typings:GetEffectiveness(v11, v12, l__Type__10);
			v13 = v14;
		end;
		if v13 ~= 1 and v9.Category ~= "Passive" then
			p22.Effective.Image = p1.Typings.EffectiveIcons[v13].Image;
			p22.Effective.ImageColor3 = p1.Typings.EffectiveIcons[v13].Color;
			p22.Effective.Visible = true;
		end;
		p1.Gui:TypeImage(p22.Type, l__Type__10);
		p1.Gui:ChangeText(p22.MoveName, l__Name__8);
		p1.Gui:ChangeText(p22.Uses, p23.Uses .. "/" .. v9.Uses);
	end;
	function v1.SetEffectiveIcon(p25, p26, p27, p28, p29)
		p26.Effective.Visible = false;
		local v16 = p1.ClientDatabase:GetMoveData(p27);
		local v17, v18 = p1.Typings:GetEffectiveness(p28, p29, v16.Type);
		if v17 ~= 1 and v16.Category ~= "Passive" then
			p26.Effective.Image = p1.Typings.EffectiveIcons[v17].Image;
			p26.Effective.ImageColor3 = p1.Typings.EffectiveIcons[v17].Color;
			p26.Effective.Visible = true;
		end;
	end;
	function v1.StopBobble(p30)
		u2 = false;
	end;
	function v1.RepeatReplacingName(p31, p32, p33)
		local v19 = "the opposing";
		if p33:find("sent out") then
			v19 = "";
		end;
		if p32.BattleType == "Wild" then
			v19 = "the wild";
			if p33:find("appear") then
				if p33:find("misprint") then
					v19 = "";
				else
					v19 = "a wild";
				end;
			end;
		end;
		local v20 = {};
		for v21 in string.gmatch(p33, "%b&DOODLENAME,.-&") do
			local v22 = v21:gsub("&", ""):gsub("DOODLENAME,", "");
			local v23, v24 = p2.Funcs:IsAlliedDoodle(p32, v22);
			if v24 then
				local v25 = l__Utilities__3.GetName(v24);
				if not v23 and v19 ~= "" then
					v25 = v19 .. " " .. v25;
				end;
				v20[v22] = v25;
			end;
		end;
		local v26 = p33:gsub("&", ""):gsub("DOODLENAME,", "");
		for v27, v28 in pairs(v20) do
			v26 = v26:gsub(v27:gsub("%-", "%%-"), v28);
		end;
		return v26:sub(1, 1):upper() .. v26:sub(2, -1);
	end;
	function v1.ReplaceName(p34, p35, p36)
		local v29 = p35;
		if p1.Spectating then
			v29 = v29:gsub("<your>", game.Players.LocalPlayer.Name .. "'s");
		end;
		local v30 = v1:RepeatReplacingName(p36, (v29:gsub("<" .. p1.Name .. ">", "You"):gsub("<" .. p1.p.DisplayName .. ">", "You"):gsub("%[SPECTATORONLY%]", ""):gsub("%[PLAYERONLY%]", ""):gsub("%[OTHERPLAYER%]", p36.Player1 == game.Players.LocalPlayer and p36.Player2.DisplayName or p36.Player1.DisplayName)));
		if p36.Format == "Singles" then
			v30 = v30:gsub("%[DOODLEOUTNAME%]", l__Utilities__3.GetName(p2.Funcs:GetOutDoodles(p36)));
		elseif p36.Format == "Doubles" then
			v30 = v30:gsub("%[DOODLEOUTNAME%]", "you");
		end;
		return v30:gsub("[<>]", "");
	end;
	function v1.SetupEvents(p37, p38)
		v1:DisconnectEvents();
		v1:HealthBarColor(p38.BackBox.Health.Clipping);
		v1:HealthBarColor(p38.FrontBox.Health.Clipping);
		v1:HealthBarColor(p38.Front1Box.Health.Clipping);
		v1:HealthBarColor(p38.Front2Box.Health.Clipping);
		v1:HealthBarColor(p38.Back1Box.Health.Clipping);
		v1:HealthBarColor(p38.Back2Box.Health.Clipping);
	end;
	local u9 = {};
	function v1.DisconnectEvents(p39)
		for v31, v32 in pairs(u9) do
			if typeof(v32) == "RBXScriptConnection" or typeof(v32) == "table" then
				v32:Disconnect();
			end;
		end;
	end;
	function v1.HealthBarColor(p40, p41)
		u9[p41] = p41:GetPropertyChangedSignal("Size"):Connect(function()
			local l__Scale__33 = p41.Size.X.Scale;
			if l__Scale__33 > 0.75 then
				p41.TotalHealth.ImageColor3 = Color3.fromRGB(46, 204, 113);
				return;
			end;
			if l__Scale__33 > 0.5 then
				p41.TotalHealth.ImageColor3 = Color3.fromRGB(241, 196, 15);
				return;
			end;
			if l__Scale__33 > 0.25 then
				p41.TotalHealth.ImageColor3 = Color3.fromRGB(243, 156, 18);
				return;
			end;
			p41.TotalHealth.ImageColor3 = Color3.fromRGB(231, 76, 60);
		end);
		return u9[p41];
	end;
	function v1.HealthNumber(p42, p43, p44)
		if u9.HealthNumber then
			u9.HealthNumber:Disconnect();
		end;
		u9.HealthNumber = p43.Health.Clipping:GetPropertyChangedSignal("Size"):Connect(function()
			local v34 = math.floor(p43.Health.Clipping.Size.X.Scale * p44.Stats.hp + 0.5);
			if p43.Health:FindFirstChild("HealthNumber") then
				p1.Gui:ChangeText(p43.Health.HealthNumber, v34 .. " / " .. p44.Stats.hp);
			end;
		end);
	end;
	function v1.TakeDamage(p45, p46, p47, p48)
		p46.Health.Clipping.TotalHealth.Size = UDim2.new(0, p46.Health.AbsoluteSize.X, 0, p46.Health.AbsoluteSize.Y);
		p46.Health.Clipping:TweenSize(UDim2.new(p48 / p47.Stats.hp, 0, 1, 0), "Out", "Quad", 0.5, true);
	end;
	function v1.SpriteFlash(p49, p50, p51)
		if p51 and p50.Parent:FindFirstChild("Decoy") then
			p50 = p50.Parent:FindFirstChild("Decoy");
		end;
		if not p51 and p50:FindFirstChild("FreezeClone") then
			p50 = p50.FreezeClone;
		end;
		p50.Visible = false;
		l__Utilities__3.Halt(0.2);
		p50.Visible = true;
		l__Utilities__3.Halt(0.1);
		p50.Visible = false;
		l__Utilities__3.Halt(0.05);
		p50.Visible = true;
	end;
	local u10 = nil;
	function v1.SetYesEvent(p52, p53, p54, ...)
		if u10 then
			u10:Disconnect();
		end;
		local u11 = ...;
		u10 = p53.MouseButton1Click:Connect(function()
			p54(u11);
		end);
	end;
	local u12 = nil;
	function v1.SetNoEvent(p55, p56, p57, ...)
		if u12 then
			u12:Disconnect();
		end;
		local u13 = ...;
		u12 = p56.MouseButton1Click:Connect(function()
			p57(u13);
		end);
	end;
	function v1.UpdateStatus(p58, p59, p60, p61)
		if not p59 then
			return;
		end;
		if p61 == "Blank" then
			p59.Status.Visible = false;
			return;
		end;
		if (p60.Status or p61) and p60.Status ~= "Faint" then
			if u9[p59.Status] then
				u9[p59.Status]:Disconnect();
			end;
			local v35 = p1.MiscDB.StatusInfo[p60.Status];
			if not v35 then
				p59.Status.Visible = false;
			end;
			p59.Shiny.Visible = false;
			p59.Tint.Visible = false;
			if p61 then
				v35 = p1.MiscDB.StatusInfo[p61];
			end;
			if not v35 then
				p59.Status.Visible = false;
			end;
			if not v35 then
				local v36 = "";
			else
				v36 = v35.Icon;
			end;
			p59.Status.Image = v36;
			p59.Status.Visible = true;
			p59.Status.ImageColor3 = not v35 and Color3.fromRGB(255, 255, 255) or v35.Color;
			u9[p59.Status] = p1.Tooltip.new({
				TextColor3 = v35.Color
			}, p59.Status, p60.Status);
			if p59:FindFirstChild("AlreadyCaught") then
				p59.AlreadyCaught.Visible = false;
				return;
			end;
		else
			p59.Status.Visible = false;
		end;
	end;
	function v1.ChangedSize(p62, p63, p64)
		p63.SizeGetter.Visible = true;
		if p64 then
			p63.NameLabel.Size = UDim2.new(0.55, 0, 0.5, 0);
		else
			p63.NameLabel.Size = UDim2.new(0, p63.SizeGetter.TextBounds.X * 1.1, 0.35, 0);
		end;
		p63.SizeGetter.Visible = false;
		p63.Health.Clipping.TotalHealth.Size = UDim2.new(0, p63.Health.AbsoluteSize.X, 0, p63.Health.AbsoluteSize.Y);
	end;
	function v1.SetBox(p65, p66, p67, p68, p69)
		local l__Name__37 = p67.Name;
		local v38 = p68 or p67.currenthp;
		p1.Gui:ChangeText(p66.NameLabel, l__Name__37);
		p1.ColorAnim.Create(p66.NameLabel, p67.NameColor);
		p1.Gui:ChangeText(p66.LevelLabel, "Lv. " .. p67.Level);
		p1.Gui:SetGenderIcon(p67, p66.LevelLabel.GenderSign);
		p66.SizeGetter.Visible = true;
		p1.Gui:ChangeText(p66.SizeGetter, l__Name__37);
		if not p69 then
			p66.NameLabel.Size = UDim2.new(0, p66.SizeGetter.TextBounds.X * 1.1, 0.35, 0);
		else
			p66.NameLabel.Size = UDim2.new(0.55, 0, 0.5, 0);
		end;
		p66.SizeGetter.Visible = false;
		p66.Health.Clipping.TotalHealth.Size = UDim2.new(0, p66.Health.AbsoluteSize.X, 0, p66.Health.AbsoluteSize.Y);
		p66.Health.Clipping.Size = UDim2.new(v38 / p67.Stats.hp, 0, 1, 0);
		v1:UpdateStatus(p66, p67);
		p66.Tint.Visible = false;
		p66.Shiny.Visible = p67.Shiny;
		if not p66.Shiny.Visible and p67.Tint ~= 0 then
			p1.Gui:Tint(nil, p66.Tint, p67, nil);
			p66.Tint.Visible = true;
		end;
		if p66.Name:find("Back") then
			p1.Gui:ChangeText(p66.Health.HealthNumber, v38 .. " / " .. p67.Stats.hp);
			local v39 = p67.NextLevel - p67.CurrentLevel;
			if p66:FindFirstChild("Experience") then
				p66.Experience.BarHolder.ExperienceBar.Size = UDim2.new((v39 - (p67.NextLevel - p67.Experience)) / v39, 0, 1, 0);
				return;
			end;
		elseif p66.Name:find("Front") and p66:FindFirstChild("AlreadyCaught") then
			if not p67.Shiny and p66.Status.Visible == false and p67.AlreadyCaught then
				p66.AlreadyCaught.Visible = true;
				return;
			end;
			p66.AlreadyCaught.Visible = false;
		end;
	end;
	function v1.TweenExperience(p70, p71, p72, p73, p74)
		local v40 = p73 - p72;
		p74.Experience.BarHolder.ExperienceBar:TweenSize(UDim2.new(math.min(1, (v40 - (p73 - p71.Experience)) / v40), 0, 1, 0), "Out", "Quad", 0.5, true);
		l__Utilities__3.Halt(0.5);
	end;
	function v1.SetExpBar0(p75, p76)
		if p76:FindFirstChild("Experience") then
			p76.Experience.BarHolder.ExperienceBar.Size = UDim2.new(0, 0, 1, 0);
		end;
	end;
	local function u14(p77, p78)
		return ColorSequenceKeypoint.new(p77, p78);
	end;
	function v1.RaiseStat(p79, p80, p81)
		if not p80 then
			return;
		end;
		local v41 = Instance.new("UIGradient", p80:FindFirstChild("FreezeClone") and p80);
		v41.Rotation = 90;
		local v42 = Color3.fromRGB(254, 127, 46);
		local v43 = Color3.fromRGB(255, 255, 255);
		local v44 = u14(0, v43);
		local v45 = u14(1, v43);
		for v46 = 1, 2 do
			for v47 = 1, 0, -0.1 do
				v41.Color = ColorSequence.new({ v44, u14(math.max(0, v47 - 0.1), v43), u14(v47, v42), u14(math.min(1, v47 + 0.1), v43), v45 });
				l__Utilities__3.Halt();
			end;
		end;
		v41:Destroy();
	end;
	function v1.LowerStat(p82, p83, p84)
		if not p83 then
			return;
		end;
		local v48 = Instance.new("UIGradient", p83:FindFirstChild("FreezeClone") and p83);
		v48.Rotation = 90;
		local v49 = Color3.fromRGB(77, 108, 221);
		local v50 = Color3.fromRGB(255, 255, 255);
		local v51 = u14(0, v50);
		local v52 = u14(1, v50);
		for v53 = 1, 2 do
			for v54 = 0, 1, 0.1 do
				v48.Color = ColorSequence.new({ v51, u14(math.max(0, v54 - 0.1), v50), u14(v54, v49), u14(math.min(1, v54 + 0.1), v50), v52 });
				l__Utilities__3.Halt();
			end;
		end;
		v48:Destroy();
	end;
	function v1.FadeIn(p85, p86, p87)
		p87.ImageTransparency = 1;
		p87.Visible = true;
		for v55 = 1, 0, p86 do
			p87.ImageTransparency = v55;
			l__Utilities__3.Halt(0.05);
		end;
		p87.ImageTransparency = 0;
	end;
	function v1.FadeOut(p88, p89, p90)
		for v56 = 0, 1, p89 do
			p90.ImageTransparency = v56;
			l__Utilities__3.Halt(0.05);
		end;
		p90.ImageTransparency = 1;
		p90.Visible = false;
	end;
	function v1.EraserAnimChildren(p91, p92, p93)
		for v57, v58 in pairs(p92:GetChildren()) do
			if v58:IsA("GuiObject") and v58.Name ~= "Eraser" then
				v58.ImageTransparency = p93;
			end;
		end;
	end;
	local u15 = {
		Enemy = {
			X1 = 0.55, 
			X2 = 0.35, 
			X3 = 0.475, 
			X4 = 0.25, 
			X5 = 0.4, 
			X6 = 0.15, 
			X7 = 0.325, 
			X8 = 0.05, 
			X9 = 0.25, 
			Y1 = 0, 
			Y2 = -0.1, 
			Y3 = 0.15, 
			Y4 = 0, 
			Y5 = 0.3, 
			Y6 = 0.1, 
			Y7 = 0.45, 
			Y8 = 0.2, 
			Y9 = 0.6
		}, 
		Player = {
			X1 = 0.05, 
			X2 = 0.25, 
			X3 = 0.125, 
			X4 = 0.35, 
			X5 = 0.2, 
			X6 = 0.45, 
			X7 = 0.275, 
			X8 = 0.55, 
			X9 = 0.35, 
			Y1 = 0, 
			Y2 = -0.1, 
			Y3 = 0.15, 
			Y4 = 0, 
			Y5 = 0.3, 
			Y6 = 0.1, 
			Y7 = 0.45, 
			Y8 = 0.2, 
			Y9 = 0.6
		}
	};
	function v1.EraserAnim(p94, p95, p96)
		pcall(function()
			local v59 = l__Utilities__3:Create("ImageLabel")({
				Parent = p95, 
				Name = "Eraser", 
				Position = UDim2.new(0.25, 0, 0.2, 0), 
				BackgroundTransparency = 1, 
				Size = UDim2.new(0.4, 0, 0.4, 0), 
				Visible = true, 
				ZIndex = 490, 
				Image = "http://www.roblox.com/asset/?id=4595962061", 
				ImageRectSize = Vector2.new(200, 200)
			});
			local v60 = p96 and u15.Player or u15.Player;
			v1.Position = UDim2.new(v60.X1, 0, v60.Y1, 0);
			v1.Visible = true;
			p94:FadeIn(0.125, v1);
			p1.Sound:Play("Eraser");
			for v61 = 2, 9 do
				p95.ImageTransparency = (v61 - 1) / 8;
				v1:EraserAnimChildren(p95, (v61 - 1) / 8);
				v59:TweenPosition(UDim2.new(v60["X" .. v61], 0, v60["Y" .. v61], 0), "Out", "Quad", 0.125, true);
				l__Utilities__3.Halt(0.125);
			end;
			l__Utilities__3.FastSpawn(function()
				v1:FadeOut(0.125, v59);
				p95.Visible = false;
				v59:Destroy();
			end);
		end);
	end;
	function v1.PartyBarReset(p97, p98)
		for v62, v63 in pairs(p98:GetChildren()) do
			if v63:IsA("GuiObject") then
				v63.Image = p1.MiscDB.PartyGuis.Empty;
			end;
		end;
		p98.Visible = false;
	end;
	function v1.PartyBarFaint(p99, p100)
		p100.Doodle1.Image = p1.MiscDB.PartyGuis.Fainted;
	end;
	function v1.PartyBar(p101, p102, p103)
		for v64, v65 in pairs(p102) do
			local v66 = "Healthy";
			if v65.Status == "Faint" then
				v66 = "Fainted";
			elseif v65.Status then
				v66 = "Status";
			end;
			p103["Doodle" .. v64].Image = p1.MiscDB.PartyGuis[v66];
		end;
		p103.Visible = true;
	end;
	function v1.GetRidOfChildren(p104, p105)
		for v67, v68 in pairs(p105:GetChildren()) do
			if v68:IsA("GuiObject") then
				v68:Destroy();
			end;
		end;
	end;
	function v1.SummonScapegoat(p106, p107, p108)
		local v69 = "http://www.roblox.com/asset/?id=5799509303";
		local v70 = UDim2.new(0.5, 0, 0.4, 0);
		if p108 then
			v69 = "http://www.roblox.com/asset/?id=5799509638";
			v70 = UDim2.new(0.5, 0, 0.6, 0);
		end;
		local v71 = p107:Clone();
		v1:GetRidOfChildren(v71);
		v71.Visible = true;
		v71.Image = v69;
		v71.Name = "Decoy";
		v71.ImageRectSize = Vector2.new(300, 300);
		v71.Size = UDim2.new(1, 0, 1, 0);
		v71.Position = UDim2.new(0.5, 0, -1.5, 0);
		v71.Parent = p107.Parent;
		l__Utilities__3.FastSpawn(function()
			while v71.Parent == p107.Parent do
				pcall(function()
					v71.ImageRectOffset = Vector2.new(0, 0);
					l__Utilities__3.Halt(0.1);
					v71.ImageRectOffset = Vector2.new(300, 0);
					l__Utilities__3.Halt(0.1);
					v71.ImageRectOffset = Vector2.new(0, 301);
					l__Utilities__3.Halt(0.1);
				end);			
			end;
		end);
		v71:TweenPosition(v70, "Out", "Bounce", 1, true);
		l__Utilities__3.Halt(0.3);
	end;
	function v1.DisappearScapegoat(p109, p110, p111, p112, p113)
		if not p111.Parent:FindFirstChild("Decoy") then
			return;
		end;
		local l__Decoy__72 = p111.Parent:FindFirstChild("Decoy");
		v1:EraserAnim(l__Decoy__72, p112);
		l__Decoy__72:Destroy();
		local v73 = p1.Gui:GetGuiSize(p111.Parent, p110);
		if not p113 then
			p111.Size = UDim2.new(0, 0, 0.5, 0);
			p111.Visible = true;
			p111:TweenSize(v73, "Out", "Quint", 0.5, true);
		end;
		l__Utilities__3.Halt(0.5);
		return true;
	end;
	function v1.SpriteAppear(p114, p115, p116)
		if p116.Parent:FindFirstChild("Decoy") and p115.currenthp > 0 then
			p116.Parent:FindFirstChild("Decoy"):TweenSize(UDim2.new(0, 0, 0.8, 0), "Out", "Quint", 0.25, true);
			l__Utilities__3.Halt(0.25);
			p116.Size = UDim2.new(0, 0, 0.5, 0);
			p116.Visible = true;
			p116:TweenSize(p1.Gui:GetGuiSize(p116.Parent, p115), "Out", "Quint", 0.25, true);
		end;
	end;
	function v1.SpriteDisappear(p117, p118, p119)
		if p119.Parent:FindFirstChild("Decoy") and p118.currenthp > 0 then
			local l__Decoy__74 = p119.Parent:FindFirstChild("Decoy");
			p119:TweenSize(UDim2.new(0, 0, 0.8, 0), "Out", "Quint", 0.25, true);
			l__Utilities__3.Halt(0.25);
			p119.Visible = false;
			l__Decoy__74:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.25, true);
		end;
	end;
	return v1;
end;
