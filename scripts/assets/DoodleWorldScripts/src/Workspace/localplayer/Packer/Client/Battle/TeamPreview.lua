-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local l__Network__1 = p1.Network;
	local u1 = {};
	local u2 = {};
	l__Network__1:BindEvent("ForfeitTP", function(p3)
		u2.Hide(true);
		p1.Gui:SayText("", p3.Name .. " forfeited the battle.", nil);
	end);
	local function u3()
		for v2, v3 in pairs(u1) do
			if v3.Disconnect then
				v3:Disconnect();
			end;
		end;
		u1 = {};
	end;
	local u4 = nil;
	local l__Utilities__5 = p1.Utilities;
	local u6 = nil;
	local u7 = false;
	l__Network__1:BindEvent("TeamPreview", function(p4, p5, p6, p7)
		p1.CurrentlyTalking = true;
		u3();
		u4 = p1.ClientDatabase:PDSFunc("GetColorList");
		l__Utilities__5.Halt(0.05);
		u6 = p5;
		u7 = false;
		p1.Menu:CloseAll();
		p1.Menu.Blur();
		p1.Menu:Disable();
		local l__TeamPreview__4 = p1.guiholder:WaitForChild("TeamPreview");
		u2.UISize(l__TeamPreview__4.PlayerParty);
		u2.UISize(l__TeamPreview__4.OtherParty);
		p1.Gui:Hover(l__TeamPreview__4.Ready);
		p1.Gui:Hover(l__TeamPreview__4.Forfeit);
		l__TeamPreview__4.Ready.Visible = true;
		l__TeamPreview__4.Forfeit.Visible = true;
		l__TeamPreview__4.OtherTime.TimerLabel.Text = l__Utilities__5.ConvertTimer(p4.PvPTimer.Value);
		l__TeamPreview__4.PlayerTime.TimerLabel.Text = l__Utilities__5.ConvertTimer(game.Players.LocalPlayer.PvPTimer.Value);
		u1.ReadyUp = l__TeamPreview__4.Ready.MouseButton1Click:Connect(function()
			u7 = true;
			l__TeamPreview__4.Ready.Visible = false;
			l__Network__1:post("TeamPreviewSwap", u6);
		end);
		u1.Forfeit = l__TeamPreview__4.Forfeit.MouseButton1Click:Connect(function()
			u7 = true;
			l__TeamPreview__4.Forfeit.Visible = false;
			l__TeamPreview__4.Ready.Visible = false;
			l__Network__1:post("TeamPreviewForfeit");
		end);
		if p7 == "Off" then
			l__TeamPreview__4.PlayerTime.TimerLabel.Visible = false;
			l__TeamPreview__4.OtherTime.TimerLabel.Visible = false;
		else
			l__TeamPreview__4.PlayerTime.TimerLabel.Visible = true;
			l__TeamPreview__4.OtherTime.TimerLabel.Visible = true;
		end;
		u1.PlayerTimer = game.Players.LocalPlayer.PvPTimer.Changed:Connect(function()
			l__TeamPreview__4.PlayerTime.TimerLabel.Text = l__Utilities__5.ConvertTimer(game.Players.LocalPlayer.PvPTimer.Value);
		end);
		u1.OtherPlayerTimer = p4.PvPTimer.Changed:Connect(function()
			l__TeamPreview__4.OtherTime.TimerLabel.Text = l__Utilities__5.ConvertTimer(p4.PvPTimer.Value);
		end);
		p1.Gui:ChangeText(l__TeamPreview__4.PlayerParty.Title.Label, game.Players.LocalPlayer.Name .. "'s Party");
		p1.Gui:ChangeText(l__TeamPreview__4.OtherParty.Title.Label, p4.Name .. "'s Party");
		l__TeamPreview__4.Position = UDim2.new(0.5, 0, -1, 0);
		l__TeamPreview__4.Visible = true;
		u2.SetupParty(p5, l__TeamPreview__4.PlayerParty, true);
		u2.SetupParty(p6, l__TeamPreview__4.OtherParty, nil);
		l__TeamPreview__4:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end);
	local u8 = nil;
	function u2.DestroyChoice()
		if u8 then
			u8:Destroy();
		end;
		u8 = nil;
	end;
	function u2.Show()
		p1.guiholder:WaitForChild("TeamPreview").Visible = true;
	end;
	local function u9(p8)
		return tonumber(p8.Name:match("%d"));
	end;
	function u2.SetupChoice(p9, p10, p11)
		local l__TeamPreview__5 = p1.guiholder:WaitForChild("TeamPreview");
		u2.DestroyChoice();
		u8 = p1.GuiObjs.TeamPreviewChoice:Clone();
		for v6, v7 in pairs(u8:GetChildren()) do
			if v7:IsA("ImageButton") then
				p1.Gui:TextHover(v7.Label);
				p1.Gui:Hover(v7);
			end;
		end;
		u8.Cancel.MouseButton1Click:Connect(function()
			u2.DestroyChoice();
		end);
		u8.Stats.MouseButton1Click:Connect(function()
			u2.DestroyChoice();
			local v8 = u9(p10.Parent);
			if u6[v8] then
				local v9 = {
					ColorList = u4, 
					PlayerParty = u6, 
					TeamPreview = u2
				};
				function v9.CloseFunc(p12)
					u6[v8] = p12;
				end;
				l__TeamPreview__5.Visible = false;
				p1.Stats.new(v9, u6[v8]);
			end;
		end);
		u8.Position = UDim2.new(0, p11.X, 0, p11.Y);
		u8.Parent = p1.guiholder;
	end;
	function u2.AllowedChecks(p13, p14)
		local v10 = {};
		for v11, v12 in pairs(p14:GetChildren()) do
			if v12.Name:find("Doodle") and v12 ~= p13 then
				table.insert(v10, v12);
			end;
		end;
		return v10;
	end;
	function u2.SetDraggable(p15, p16, p17)
		local v13 = {
			NotBigger = true, 
			Requirement = function()
				return not u7;
			end, 
			Collide = u2.AllowedChecks(p15, p17)
		};
		local l__mouse__10 = p1.p:GetMouse();
		function v13.Function(p18, p19)
			if not u7 then
				local v14 = tonumber(p15.Parent.Name:match("%d+"));
				local v15 = tonumber(p18.Name:match("%d+"));
				if v14 ~= v15 then
					if u6[v15] then
						local v16 = p17:FindFirstChild("Doodle" .. v14);
						local v17 = p17:FindFirstChild("Doodle" .. v15);
						v16:TweenPosition(v17.Position, "Out", "Quad", 0.3, true);
						v17:TweenPosition(v16.Position, "Out", "Quad", 0.3, true);
						v16.Name = v17.Name;
						v17.Name = v16.Name;
						u6[v14] = u6[v15];
						u6[v15] = u6[v14];
					end;
					return;
				end;
			else
				return;
			end;
			u2.SetupChoice(u6, p15, l__mouse__10);
		end;
		function v13.StartDraggingFunc()
			u2.DestroyChoice();
		end;
		function v13.IfNoDragging(p20)
			u2.SetupChoice(u6, p15, l__mouse__10);
		end;
		table.insert(u1, (p1.GuiDragging.new(v13, p15)));
	end;
	local function u11()
		return not u7;
	end;
	function u2.SetDoodle(p21, p22, p23, p24)
		if p22 == nil or p22.Name == nil then
			p1.Gui:AnimateSprite(p21, nil, true);
		end;
		if p22 and p22.Name then
			p1.Gui:ChangeText(p21.Level, "Lv. " .. p22.Level);
			local v18 = p1.Gui:AnimateSprite(p21, p22, true);
			if p23 == true then
				p1.Gui:Hover(v18, nil, nil, u11);
				u2.SetDraggable(v18, p22, p24);
			end;
		end;
	end;
	function u2.SetupParty(p25, p26, p27)
		if p25 == "Empty" then
			for v19, v20 in pairs(p26:GetChildren()) do
				if v20.Name:find("Doodle") then
					v20.DoodleLabel.Visible = false;
					v20.Unknown.Visible = true;
				end;
			end;
			return;
		end;
		for v21, v22 in pairs(p26:GetChildren()) do
			if v22.Name:find("Doodle") then
				v22.DoodleLabel.Visible = false;
				v22.Unknown.Visible = false;
				u2.SetDoodle(v22.DoodleLabel, p25[tonumber(v22.Name:match("%d+"))], p27, p26);
			end;
		end;
	end;
	function u2.UISize(p28)
		local v23 = p28.Doodle1.DoodleLabel.AbsoluteSize.X * 4 / 3 / 8;
		for v24 = 1, 6 do
			local v25 = p28:FindFirstChild("Doodle" .. v24);
			if v25 then
				v25.Position = UDim2.new((v24 + 1) % 2 * 0.5, v23, math.floor(v24 / 2 - (v24 + 1) % 2) * 0.33, v23);
			end;
		end;
	end;
	function u2.Hide(p29)
		local l__TeamPreview__26 = p1.guiholder:WaitForChild("TeamPreview");
		l__TeamPreview__26.Ready.Visible = false;
		l__TeamPreview__26.Forfeit.Visible = false;
		for v27, v28 in pairs(l__TeamPreview__26.PlayerParty:GetDescendants()) do
			if v28.Name == "NewDoodleLabel" then
				v28:Destroy();
			end;
		end;
		for v29, v30 in pairs(l__TeamPreview__26.OtherParty:GetDescendants()) do
			if v30.Name == "NewDoodleLabel" then
				v30:Destroy();
			end;
		end;
		u6 = nil;
		u3();
		p1.CurrentlyTalking = nil;
		l__TeamPreview__26:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.5, true, function()
			l__TeamPreview__26.Visible = false;
		end);
		if p29 then
			p1.Controls:ToggleWalk(true);
			p1.Menu.DisableBlur();
		end;
	end;
	return u2;
end;
