-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local function u2()
		for v2, v3 in pairs(u1) do
			v3:Disconnect();
		end;
		u1 = {};
	end;
	local v4 = l__Utilities__1.Class({
		ClassName = "Passport"
	}, function(p2)
		u2();
		if p2.Player == nil then
			p2.Player = p1.p;
		end;
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.Passport;
		p2.Holder = p2.UI.Holder;
		p2.StatsFrame = p2.Holder.StatsFrame;
		p2.StatHolder = p2.StatsFrame.Holder;
		p2.CharacterFrame = p2.Holder.CharacterFrame;
		p2.Close = p2.UI.Close;
		u1.Close = p2.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p2.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			p2:Destroy();
		end);
		u1.CloseEnter = p2.Close.MouseEnter:Connect(function()
			p2.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p2.Close.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = p2.Close.MouseLeave:Connect(function()
			p2.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u1.ChangedSize = p2.UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p2:ChangeTextSize();
		end);
		p2:ChangeTextSize();
		p2.PassportTable = p1.Network:get("GetPassportInfo", p2.Player);
		p2:Setup(p2.PassportTable);
		p2.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p2.UI.Visible = true;
		p2.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end);
	function v4.ChangeTextSize(p3)
		local v5 = p3.StatHolder.AbsoluteSize.Y / 6;
		for v6, v7 in pairs(p3.StatHolder.TitleHolder:GetChildren()) do
			if v7:IsA("GuiObject") then
				v7.TextSize = v5;
			end;
		end;
		for v8, v9 in pairs(p3.StatHolder.StatHolder:GetChildren()) do
			if v9:IsA("GuiObject") then
				v9.TextSize = v5;
			end;
		end;
	end;
	local u3 = {
		LightningKey = "1"
	};
	function v4.Setup(p4, p5)
		p4.Viewport = p1.Gui.ViewportModule(p4.Player.Character or p4.Player.CharacterAdded:wait(), p4.CharacterFrame.CharacterHolder, {
			Zoom = 6, 
			Diagonal = 0, 
			BackgroundColor3 = p4.CharacterFrame.ImageColor3
		});
		if p5.VictoryAnim then
			p4.Viewport:PlayAnim(p1.Animations[p5.VictoryAnim].Id);
		end;
		local l__StatHolder__10 = p4.StatHolder.StatHolder;
		p1.Gui:ChangeText(p4.UI.Title, "@" .. p4.Player.Name .. "'s Passport");
		p1.Gui:ChangeText(p4.CharacterFrame.Username, p4.Player.DisplayName);
		if p5.Title then
			p1.Gui:ChangeText(p4.CharacterFrame.Title, p1.Titles[p5.Title]);
		end;
		for v11, v12 in pairs(p4.Holder.Keys.KeyHolder:GetChildren()) do
			if v12:IsA("GuiObject") and v12:FindFirstChild("KeyImage") then
				v12.KeyImage.Visible = false;
			end;
		end;
		if p5.Key then
			for v13, v14 in pairs(p5.Key) do
				if u3[v13] then
					p4.Holder.Keys.KeyHolder[u3[v13]].KeyImage.Visible = true;
				end;
			end;
		end;
		if p5.NameColor then
			p1.ColorAnim.Create(p4.CharacterFrame.Username, p5.NameColor);
		end;
		if p5.TitleColor then
			p1.ColorAnim.Create(p4.CharacterFrame.Title, p5.TitleColor);
		end;
		if p5.Cash then
			p1.Gui:ChangeText(l__StatHolder__10.Cash, "$" .. l__Utilities__1.AddComma(p5.Cash));
		end;
		if p5.Gems then
			p1.Gui:ChangeText(l__StatHolder__10.Gems, l__Utilities__1.AddComma(p5.Gems));
		end;
		if p5.Captured then
			p1.Gui:ChangeText(l__StatHolder__10.Doodlepedia, l__Utilities__1.AddComma(p5.Captured));
		end;
		if p5.TimePlayed then
			p1.Gui:ChangeText(l__StatHolder__10.TimePlayed, p1.Gui:SecondsToTimer(p5.TimePlayed));
		end;
		if p5.TamerLevel then
			p1.Gui:ChangeText(l__StatHolder__10.TamerLevel, l__Utilities__1.AddComma(p5.TamerLevel));
		end;
	end;
	function v4.Destroy(p6)
		u2();
		if not p6.Close then
			return;
		end;
		p6.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p6.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p6.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.52);
		p6.UI.Visible = false;
		if p6.Type == "Menu" then
			p1.Menu:EnableActive();
		else
			p1.Social:Show();
		end;
		if p6.Viewport then
			p6.Viewport:Destroy();
		end;
		for v15, v16 in pairs(p6) do
			p6[v15] = nil;
		end;
		p6 = nil;
	end;
	return v4;
end;
