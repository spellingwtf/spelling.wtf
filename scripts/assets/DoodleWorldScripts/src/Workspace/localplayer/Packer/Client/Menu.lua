-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = false;
	local function u2(p2)
		local v2 = {};
		for v3, v4 in pairs(p2) do
			if v4:IsDescendantOf(p1.guiholder) then
				table.insert(v2, v4);
			end;
		end;
		return v2;
	end;
	local u3 = { "Party", "Backpack", "Customize", "Passport", "Social", "Special Shop", "Settings", "Doodlepedia" };
	local v5 = l__Utilities__1.Class({
		ClassName = "Menu"
	}, function(p3)
		local l__PlayerGui__6 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
		p3.maingui = l__PlayerGui__6:WaitForChild("MainGui");
		p3.MenuButton = p3.maingui:WaitForChild("MenuButton");
		p3.MenuGui = p3.maingui:FindFirstChild("Menu");
		p3.Active = false;
		p3.Enabled = true;
		p3.MenuButton.MouseEnter:Connect(function()
			if p3.Active == false and p3.Enabled then
				p3.MenuButton.ImageColor3 = Color3.fromRGB(200, 200, 200);
			end;
		end);
		p3.MenuButton.MouseLeave:Connect(function()
			p3:ResetColor();
		end);
		p3.maingui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p3:ChangeSize();
		end);
		p3.MenuButton.MouseButton1Click:Connect(function()
			if p3.Active == false and p3.Enabled and u1 == false and not p1.DailyLoginOn then
				u1 = true;
				p3:MakeActive();
				u1 = false;
			end;
		end);
		p1.Services.UserInputService.InputBegan:Connect(function(p4, p5)
			if p1.DailyLoginOn then
				return;
			end;
			if p4.UserInputType == Enum.UserInputType.Keyboard and p3.Enabled and u1 == false and p4.KeyCode == Enum.KeyCode.Tab then
				u1 = true;
				if p3.Active then
					p3:MakeInactive();
				elseif not p3.Active then
					p3:MakeActive();
				end;
				u1 = false;
			end;
			if p3.Active == true and p3.Enabled and (p4.UserInputType == Enum.UserInputType.MouseButton1 or p4.UserInputType == Enum.UserInputType.Touch) then
				local v7 = u2(l__PlayerGui__6:GetGuiObjectsAtPosition(p4.Position.X, p4.Position.Y));
				local v8 = true;
				for v9, v10 in pairs(v7) do
					if v10 == p3.MenuGui then
						v8 = false;
					end;
				end;
				if #v7 == 0 and v8 and not u1 then
					p3:MakeInactive();
					return;
				end;
				if not v8 and p4.UserInputType ~= Enum.UserInputType.Touch then
					local v11 = p3:GetSector(p4.Position);
					if v11 and #v7 > 0 and p3.Events[v11] then
						p3.Events[v11](p3);
					end;
				end;
			end;
		end);
		p1.Services.UserInputService.InputChanged:Connect(function(p6)
			if p3.Active == true and p3.Enabled and (p6.UserInputType == Enum.UserInputType.MouseMovement or p6.UserInputType == Enum.UserInputType.Touch) then
				local v12 = p3:GetSector(p6.Position);
				if v12 and #l__PlayerGui__6:GetGuiObjectsAtPosition(p6.Position.X, p6.Position.Y) > 0 then
					p3:EnlargeButton(v12);
					p3:CenterText(u3[v12]);
					return;
				end;
				p3:CancelEnlarge();
				p3:CenterText("");
			end;
		end);
		p1.Services.UserInputService.TouchEnded:Connect(function(p7)
			local v13 = l__PlayerGui__6:GetGuiObjectsAtPosition(p7.Position.X, p7.Position.Y);
			local v14 = true;
			for v15, v16 in pairs(v13) do
				if v16 == p3.MenuGui then
					v14 = false;
				end;
			end;
			if not v14 then
				local v17 = p3:GetSector(p7.Position);
				if v17 and #v13 > 0 and p3.Events[v17] then
					p3.Events[v17](p3);
				end;
			end;
		end);
		p3:ChangeSize();
		for v18, v19 in pairs(p3.MenuGui:GetChildren()) do
			if v19:IsA("ImageButton") then
				p3.OriginalPositions[v19] = v19.Position;
			end;
		end;
		return p3;
	end);
	v5.OriginalPositions = {};
	local v20 = {};
	local u4 = nil;
	v20[1] = function(p8, p9)
		p8 = p8 - u4.X;
		p9 = p9 - u4.Y;
		if p8 > 0 and p9 < 0 and p9 <= p8 and p9 <= -p8 then
			return true;
		end;
	end;
	v20[2] = function(p10, p11)
		p10 = p10 - u4.X;
		p11 = p11 - u4.Y;
		if p10 > 0 and p11 < 0 and p11 <= p10 and -p10 <= p11 then
			return true;
		end;
	end;
	v20[3] = function(p12, p13)
		p12 = p12 - u4.X;
		p13 = p13 - u4.Y;
		if p12 > 0 and p13 > 0 and p13 <= p12 and -p12 <= p13 then
			return true;
		end;
	end;
	v20[4] = function(p14, p15)
		p14 = p14 - u4.X;
		p15 = p15 - u4.Y;
		if not (p14 > 0) or not (p15 > 0) or not (p14 <= p15) then
			return;
		end;
		return true;
	end;
	v20[5] = function(p16, p17)
		p16 = p16 - u4.X;
		p17 = p17 - u4.Y;
		if p16 < 0 and p17 > 0 and p16 <= p17 and -p16 <= p17 then
			return true;
		end;
	end;
	v20[6] = function(p18, p19)
		p18 = p18 - u4.X;
		p19 = p19 - u4.Y;
		if p18 < 0 and p19 > 0 and p18 <= p19 and p19 <= -p18 then
			return true;
		end;
	end;
	v20[7] = function(p20, p21)
		p20 = p20 - u4.X;
		p21 = p21 - u4.Y;
		if p20 < 0 and p21 < 0 and p20 <= p21 and p21 <= -p20 then
			return true;
		end;
	end;
	v20[8] = function(p22, p23)
		p22 = p22 - u4.X;
		p23 = p23 - u4.Y;
		if not (p22 < 0) or not (p23 < 0) or not (p23 <= p22) then
			return;
		end;
		return true;
	end;
	local v21 = {};
	local function u5(p24)
		local v22 = 0;
		for v23, v24 in pairs(p24) do
			v22 = v22 + 1;
		end;
		return v22 > 0;
	end;
	local u6 = nil;
	v21[1] = function(p25)
		p25:Disable();
		p1.Sound:Play("Boop");
		local v25 = p1.ClientDatabase:PDSFunc("GetParty");
		if u5(v25) then
			u6 = p1.Party.new({
				Manual = true, 
				Menu = true, 
				Party = v25, 
				String = "You can view your doodles' stats and swap your party order."
			});
			return;
		end;
		p1.Gui:SayText("", "You have no Doodles! Go to the Doodle Lab to get your first one!", nil, true);
		p1.Dialogue:Hide();
		p25.DisableBlur();
		p1.Controls:ToggleWalk(true, true);
		p25:Enable();
	end;
	v21[2] = function(p26)
		p26:Disable();
		p1.Sound:Play("Boop");
		local v26 = p1.ClientDatabase:PDSFunc("GetParty");
		local v27 = p1.ClientDatabase:PDSFunc("GetItems");
		if u5(v26) then
			u6 = p1.Items.new({
				Items = v27, 
				Party = v26, 
				Menu = true, 
				String = "Pick an item to use!"
			});
			return;
		end;
		p1.Gui:SayText("", "This feature is unavailable until you get your first Doodle!", nil, true);
		p1.Dialogue:Hide();
		p26.DisableBlur();
		p1.Controls:ToggleWalk(true, true);
		p26:Enable();
	end;
	v21[3] = function(p27)
		p27:Disable();
		p1.Sound:Play("Boop");
		u6 = p1.Customize.new({});
	end;
	v21[4] = function(p28)
		p28:Disable();
		p1.Sound:Play("Boop");
		l__Utilities__1.Halt(0.2);
		u6 = p1.Passport.new({
			Player = game.Players.LocalPlayer, 
			Type = "Menu"
		});
	end;
	v21[5] = function(p29)
		p29:Disable();
		p1.Sound:Play("Boop");
		if u5((p1.ClientDatabase:PDSFunc("GetParty"))) then
			u6 = p1.Social:Show();
			return;
		end;
		p1.Gui:SayText("", "This feature is unavailable until you get your first Doodle!", nil, true);
		p1.Dialogue:Hide();
		p29.DisableBlur();
		p1.Controls:ToggleWalk(true, true);
		p29:Enable();
	end;
	v21[6] = function(p30)
		p30:Disable();
		local v28 = p1.ClientDatabase:PDSFunc("GetParty");
		p1.Sound:Play("Boop");
		if u5(v28) then
			u6 = p1.RobuxShop:Show({});
			return;
		end;
		p1.Gui:SayText("", "This feature is unavailable until you get your first Doodle!", nil, true);
		p1.Dialogue:Hide();
		p30.DisableBlur();
		p1.Controls:ToggleWalk(true, true);
		p30:Enable();
	end;
	v21[7] = function(p31)
		p31:Disable();
		p1.Sound:Play("Boop");
		u6 = p1.Settings:Show({});
	end;
	v21[8] = function(p32)
		p32:Disable();
		local v29 = p1.ClientDatabase:PDSFunc("GetParty");
		p1.Sound:Play("Boop");
		if u5(v29) then
			u6 = p1.Doodlepedia.new({});
			return;
		end;
		p1.Gui:SayText("", "This feature is unavailable until you get your first Doodle!", nil, true);
		p1.Dialogue:Hide();
		p32.DisableBlur();
		p1.Controls:ToggleWalk(true, true);
		p32:Enable();
	end;
	v5.Events = v21;
	function v5.CloseAll(p33)
		if u6 then
			if u6.Hide then
				u6:Hide();
			elseif u6.Destroy then
				u6:Destroy();
			end;
			u6.Party = nil;
			u6.Items = nil;
			u6 = nil;
		end;
	end;
	function v5.Invisible(p34)
		p34.Active = false;
		p34.Enabled = false;
		p34.MenuGui.Visible = false;
		p34.MenuButton.Visible = false;
	end;
	function v5.MakeInactive(p35)
		p1.ObjectiveUI:Show();
		p1.PlayerList:Show();
		p1.Controls:ToggleWalk(true, true);
		p35.MenuButton.Visible = true;
		p1.Sound:Play("Menu", 0.8);
		p35:Hide();
		p35.Active = false;
		p35.MenuButton:TweenPosition(p35:GetMenuButtonPosition(), "Out", "Quad", 0.5, true);
		p35.DisableBlur();
		p35.MenuGui.Visible = false;
	end;
	function v5.MakeActive(p36)
		if p1.Controls and p1.ControlObj then
			p36.Active = true;
			p36.Enabled = true;
			p1.ObjectiveUI:Hide();
			p1.PlayerList:Hide();
			p1.Controls:ToggleWalk(false, true);
			p1.Sound:Play("Menu");
			p36:ResetColor();
			p36.MenuButton:TweenPosition(UDim2.new(-0.5, 0, 1.5, 0), "Out", "Quad", 0.5, true);
			p36.Blur();
			l__Utilities__1.Halt(0.5);
			p36:Show();
			if p36.Active then
				p36.MenuButton.Visible = false;
			end;
		end;
	end;
	local l__Tween__7 = p1.Tween;
	function v5.CancelEnlarge(p37)
		if p37.Enlarged then
			p37.Enlarged.ImageColor3 = Color3.fromRGB(255, 255, 255);
			l__Tween__7:PlayTween(p37.Enlarged, {
				Rotation = 0
			}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			p37.Enlarged:TweenSize(UDim2.new(0.2, 0, 0.2, 0), "Out", "Linear", 0.25, true);
			p37.Enlarged = nil;
		end;
	end;
	local u8 = { {
			x = 0.5, 
			y = -1
		}, {
			x = 1, 
			y = -1
		}, {
			x = 1, 
			y = 0.5
		}, {
			x = 0.5, 
			y = 0.75
		}, {
			x = -0.5, 
			y = 0.75
		}, {
			x = -1, 
			y = 0.5
		}, {
			x = -1, 
			y = -1
		}, {
			x = -0.5, 
			y = -1
		} };
	function v5.EnlargeButton(p38, p39)
		if not p39 then
			return;
		end;
		local v30 = p38.MenuGui:FindFirstChild(p39);
		if v30 == p38.Enlarged then
			return;
		end;
		if p38.Enlarged then
			p38.Enlarged.ImageColor3 = Color3.fromRGB(255, 255, 255);
			l__Tween__7:PlayTween(p38.Enlarged, {
				Rotation = 0
			}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			p38.Enlarged:TweenSize(UDim2.new(0.2, 0, 0.2, 0), "Out", "Linear", 0.25, true);
		end;
		if not v30 then
			print("No Gui!");
			p38.Enlarged = nil;
			return;
		end;
		p38.Enlarged = v30;
		v30.ImageColor3 = Color3.fromRGB(100, 100, 100);
		local v31 = u8[tonumber(p39)];
		local v32 = p38.OriginalPositions[v30] + UDim2.new(0, v31.x * v30.AbsoluteSize.X / 2, 0, v31.y * v30.AbsoluteSize.Y / 2);
		v30:TweenSize(UDim2.new(0.3, 0, 0.3, 0), "Out", "Linear", 0.25, true);
		l__Utilities__1.FastSpawn(function()
			while p38.Enlarged == v30 do
				l__Tween__7:PlayTween(v30, {
					Rotation = -25
				}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.5);
				if p38.Enlarged ~= v30 then
					break;
				end;
				l__Tween__7:PlayTween(v30, {
					Rotation = 0
				}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.5);
				if p38.Enlarged ~= v30 then
					break;
				end;
				l__Tween__7:PlayTween(v30, {
					Rotation = 25
				}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.5);
				if p38.Enlarged ~= v30 then
					break;
				end;
				l__Tween__7:PlayTween(v30, {
					Rotation = 0
				}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.5);			
			end;
		end);
	end;
	function v5.CenterText(p40, p41)
		if p40.CurrentText == p41 then
			return;
		end;
		p40.CurrentText = p41;
		if p40.CenterTextGui then
			p40.CenterTextGui:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Linear", 0.1, true);
			l__Utilities__1.Halt(0.1);
			p40.CenterTextGui:Destroy();
		end;
		p1.Sound:Play("BasicClick");
		p40.CenterTextGui = l__Utilities__1:Create("TextLabel")({
			Text = p41, 
			TextColor3 = Color3.fromRGB(255, 255, 255), 
			TextScaled = true, 
			Font = Enum.Font.Cartoon, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0.5, 0, -1, 0), 
			Size = UDim2.new(1, 0, 1, 0), 
			Name = "CenterText"
		});
		p40.CenterTextGui.Parent = p40.MenuGui.Center;
		p40.CenterTextGui:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
	end;
	function v5.GetSector(p42, p43)
		for v33, v34 in pairs(v20) do
			if v34(p43.X, p43.Y) then
				return v33;
			end;
		end;
		return nil;
	end;
	function v5.CheckActive(p44)
		return p44.Active;
	end;
	function v5.EnableActive(p45)
		p45.MenuGui.Position = UDim2.new(0.5, 0, -1, 0);
		p45.MenuGui.Visible = true;
		p45.MenuGui:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		p45.Active = true;
		p45.Enabled = true;
	end;
	function v5.Enable(p46)
		p46.Enabled = true;
		p46.MenuButton.Position = UDim2.new(-0.5, 0, 1.5, 0);
		if p46.Active then
			v5.DisableBlur(true);
		end;
		p46.MenuButton.Visible = true;
		p46.MenuButton:TweenPosition(p46:GetMenuButtonPosition(), "Out", "Quad", 0.5, true);
		p46.Active = false;
	end;
	function v5.Disable(p47)
		p47.Enabled = false;
		p47:Hide();
		p47.MenuButton:TweenPosition(UDim2.new(-0.5, 0, 1.5, 0), "Out", "Quad", 0.5, true);
	end;
	function v5.Show(p48)
		local l__AbsoluteSize__35 = p48.MenuGui.AbsoluteSize;
		local l__GameBlur__36 = p1.Services.Lighting.GameBlur;
		l__GameBlur__36.Size = 12;
		l__GameBlur__36.Enabled = true;
		p48.MenuGui.Position = UDim2.new(0.5, 0, -1, 0);
		p48.MenuGui.Visible = true;
		p48.MenuGui:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true, function()

		end);
	end;
	function v5.Hide(p49)
		local l__AbsoluteSize__37 = p49.MenuGui.AbsoluteSize;
		local v38 = UDim2.new(0.5, 0, -1, 0);
		if p49.Active then
			p49.MenuGui.Visible = true;
			p49.MenuGui:TweenPosition(v38, "Out", "Quad", 0.5, true);
		end;
	end;
	function v5.DisableBlur(p50)
		local l__GameBlur__39 = p1.Services.Lighting.GameBlur;
		local l__Darken__40 = p1.Services.Lighting.Darken;
		p1.Tween:PlayTween(l__GameBlur__39, {
			Size = 0
		}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		p1.Tween:PlayTween(l__Darken__40, {
			TintColor = Color3.fromRGB(255, 255, 255)
		}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		if not p50 then
			l__Utilities__1.Halt(0.5);
		end;
		l__GameBlur__39.Enabled = false;
		l__Darken__40.Enabled = false;
	end;
	function v5.Blur()
		local l__GameBlur__41 = p1.Services.Lighting.GameBlur;
		local l__Darken__42 = p1.Services.Lighting.Darken;
		if l__GameBlur__41.Enabled then
			return;
		end;
		l__Darken__42.TintColor = Color3.fromRGB(255, 255, 255);
		l__GameBlur__41.Size = 0;
		l__GameBlur__41.Enabled = true;
		l__Darken__42.Enabled = true;
		p1.Tween:PlayTween(l__GameBlur__41, {
			Size = 12
		}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		p1.Tween:PlayTween(l__Darken__42, {
			TintColor = Color3.fromRGB(161, 161, 161)
		}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
	end;
	function v5.GetMenuButtonPosition(p51)
		local l__AbsoluteSize__43 = p51.MenuButton.AbsoluteSize;
		return UDim2.new(0, -l__AbsoluteSize__43.X / 3, 1, l__AbsoluteSize__43.X / 3);
	end;
	function v5.ChangeSize(p52)
		u4 = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - game:GetService("GuiService"):GetGuiInset().Y / 2);
		local l__AbsoluteSize__44 = p52.maingui.AbsoluteSize;
		local l__AbsoluteSize__45 = p52.MenuButton.AbsoluteSize;
		local l__AbsoluteSize__46 = p52.MenuGui.AbsoluteSize;
		if p52.Enabled then
			if p52.Active then
				p52.MenuGui.Position = UDim2.new(0.5, 0, 0.5, 0);
				return;
			end;
		else
			return;
		end;
		p52.MenuButton.Position = UDim2.new(0, -l__AbsoluteSize__45.X / 3 + 15, 1, l__AbsoluteSize__45.X / 3 - 10);
	end;
	function v5.ResetColor(p53)
		p53.MenuButton.ImageColor3 = Color3.fromRGB(255, 255, 255);
	end;
	return v5.new();
end;
