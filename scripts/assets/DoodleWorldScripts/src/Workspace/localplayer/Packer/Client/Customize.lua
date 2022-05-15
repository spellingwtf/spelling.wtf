-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = nil;
	local u2 = {};
	local function u3(p2)
		for v2, v3 in pairs(p2:GetChildren()) do
			if v3:IsA("GuiObject") then
				v3:Destroy();
			end;
		end;
	end;
	local v4 = l__Utilities__1.Class({
		ClassName = "Customize"
	}, function(p3)
		u1 = p1.ColorAnim;
		local v5, v6, v7, v8 = p1.ClientDatabase:PDSFunc("GetCustomizeInfo");
		p3.Equipped = v5;
		p3.ColorList = v6;
		p3.TitleList = v7;
		p3.AnimList = v8;
		p3.UI = p1.guiholder:WaitForChild("Customize");
		p3.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p3.Holder = p3.UI:WaitForChild("Holder");
		p3.Labels = p3.Holder:WaitForChild("ButtonHolder");
		p3.ColorScroller = p3.Holder:WaitForChild("ColorScroller");
		p3.TitleScroller = p3.Holder:WaitForChild("TitleScroller");
		p3.CharacterFrame = p3.Holder:WaitForChild("CharacterFrame");
		p1.Gui.ViewportModule(p1.p.Character, p3.CharacterFrame, {
			Zoom = 2, 
			Diagonal = 1, 
			BackgroundColor3 = p3.CharacterFrame.ImageColor3
		});
		p3.Labels.Visible = true;
		p3.ColorScroller.Visible = false;
		p3.TitleScroller.Visible = false;
		p3:ChangeTitle("Currently Equipped");
		p3:ShowEquipped();
		p3.SearchButton = p3.UI.Holder.Search;
		p3.SearchBox = p3.UI.Holder.SearchTextBox;
		p1.Gui:Hover(p3.SearchButton);
		p3:ResetSearch();
		u2.CloseClick = p3.UI.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			p3:Destroy();
		end);
		u2.CloseHover = p3.UI.Close.MouseEnter:Connect(function()
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u2.CloseLeave = p3.UI.Close.MouseLeave:Connect(function()
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u2.NameColor = p3.Labels.NameColor.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p3.Labels.Visible = false;
			p3:MakeSquares("NameColor");
			p3:ChangeTitle("Change Name Color");
		end);
		u2.TitleColor = p3.Labels.TitleColor.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p3.Labels.Visible = false;
			p3:MakeSquares("TitleColor");
			p3:ChangeTitle("Change Title Color");
		end);
		u2.ChangeTitle = p3.Labels.CurrentTitle.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p3.Labels.Visible = false;
			p3:MakeRectangles();
			p3:ChangeTitle("Change Current Title");
		end);
		u2.VictoryAnim = p3.Labels.VictoryAnim.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p3.Labels.Visible = false;
			p3:MakeAnims();
			p3:ChangeTitle("Change Victory Animation");
		end);
		u2.BackClick = p3.Holder.Back.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p3:ChangeTitle("Currently Equipped");
			p3.Holder.Back.Visible = false;
			p3.ColorScroller.Visible = false;
			p3.TitleScroller.Visible = false;
			p3:ResetSearch();
			u3(p3.ColorScroller);
			u3(p3.TitleScroller);
			p3.Labels.Visible = true;
		end);
		u2.BackHover = p3.Holder.Back.MouseEnter:Connect(function()
			p3.Holder.Back.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p3.Holder.Back.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u2.BackLeave = p3.Holder.Back.MouseLeave:Connect(function()
			p3.Holder.Back.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p3.Holder.Back.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p3.Holder.Back.Visible = false;
		p3.UI.Visible = true;
		p3.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
		p3:UISize();
		u2.ChangeSize = p3.UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p3:UISize();
		end);
		u2.ClickSearch = p3.SearchButton.MouseButton1Click:Connect(function()
			p3.SearchBox:TweenSize(UDim2.new(0.506, 0, 0.035, 0), "Out", "Bounce", 0.35, true);
			p3.SearchBox.Roundify:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Bounce", 0.35, true);
		end);
		u2.FocusLost = p3.SearchBox.TextBox.FocusLost:Connect(function()
			p3.SearchString = p3.SearchBox.TextBox.Text;
			p3:Search(p3.SearchString);
		end);
		return p3;
	end);
	function v4.ResetSearch(p4)
		p4.SearchButton.Visible = false;
		p4.SearchBox.Visible = false;
		p4.SearchString = nil;
		p4:Search("");
		p1.Gui:ChangeText(p4.SearchBox.TextBox, "Search");
		p4.SearchBox.Size = UDim2.new(0, 0, 0.035, 0);
		p4.SearchBox.Roundify.Size = UDim2.new(0, 0, 1, 0);
	end;
	function v4.EnableSearch(p5)
		p5.SearchButton.Visible = true;
		p5.SearchBox.Visible = true;
	end;
	function v4.Search(p6, p7)
		if not p7 then
			p7 = "";
		end;
		local v9 = p7:lower();
		local v10 = nil;
		if p6.ColorScroller.Visible == true then
			v10 = p6.ColorScroller;
		elseif p6.TitleScroller.Visible == true then
			v10 = p6.TitleScroller;
		end;
		if v10 then
			for v11, v12 in pairs(v10:GetChildren()) do
				if v12:IsA("GuiObject") then
					if v12.Equipped.Visible == true or v12.Name:lower():find(v9) then
						v12.Visible = true;
					else
						v12.Visible = false;
					end;
				end;
			end;
			p1.Services.RunService.Heartbeat:wait();
			v10.CanvasSize = UDim2.new(0, 0, 0, v10.UIGridLayout.AbsoluteContentSize.Y);
			if v10 == p6.TitleScroller then
				return;
			end;
			if v10.UIGridLayout.AbsoluteCellCount.Y > 1 then
				v10.UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
				return;
			end;
			v10.UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
		end;
	end;
	function v4.ChangeTitle(p8, p9)
		p1.Gui:ChangeText(p8.UI.Label, p9);
	end;
	function v4.MakeRectangles(p10)
		u3(p10.TitleScroller);
		for v13, v14 in pairs(p10.TitleList) do
			p10:TitleButton(v14);
		end;
		p10.TitleScroller.CanvasSize = UDim2.new(0, 0, 0, p10.TitleScroller.UIGridLayout.AbsoluteContentSize.Y);
		p10.Holder.Back.Visible = true;
		p10.TitleScroller.Visible = true;
		p10:EnableSearch();
	end;
	local l__Titles__4 = p1.Titles;
	function v4.TitleButton(p11, p12)
		local v15 = p1.GuiObjs.Rectangle:Clone();
		v15.LayoutOrder = p12;
		local v16 = l__Titles__4[p12];
		p1.Gui:ChangeText(v15.Label, v16);
		if p11.Equipped.Title == p12 then
			v15.Equipped.Visible = true;
			v15.LayoutOrder = v15.LayoutOrder - 100;
		else
			v15.Equipped.Visible = false;
		end;
		v15.Name = v16;
		v15.Parent = p11.TitleScroller;
		p1.Gui:Hover(v15);
		v15.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p11:ChangeTitleEquipped();
			v15.Equipped.Visible = true;
			v15.LayoutOrder = v15.LayoutOrder - 100;
			p11.Equipped = p1.Network:get("ChangeTitle", p12);
			p11:ShowEquipped();
		end);
	end;
	local l__Animations__5 = p1.Animations;
	function v4.AnimationSquare(p13, p14)
		local v17 = p1.GuiObjs.Square:Clone();
		v17.LayoutOrder = p14;
		local l__Name__18 = l__Animations__5[p14].Name;
		p1.Gui:ChangeText(v17.Label, l__Name__18);
		if p13.Equipped.VictoryAnim == p14 then
			v17.Equipped.Visible = true;
			v17.LayoutOrder = v17.LayoutOrder - 100;
		else
			v17.Equipped.Visible = false;
		end;
		v17.Name = l__Name__18;
		v17.Parent = p13.ColorScroller;
		v17.ImageColor3 = Color3.fromRGB(33, 33, 33);
		local v19 = p1.Gui.ViewportModule(p1.p.Character, v17, {
			Zoom = 6, 
			Diagonal = 0, 
			BackgroundColor3 = v17.ImageColor3, 
			StopAnimations = true
		});
		p1.Gui:Hover(v17);
		local l__Id__6 = l__Animations__5[p14].Id;
		v17.MouseEnter:Connect(function()
			v19:PlayAnim(l__Id__6);
		end);
		v17.MouseLeave:Connect(function()
			v19:StopAnim(l__Id__6);
		end);
		v17.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p13:ChangeColorEquipped();
			v17.Equipped.Visible = true;
			v17.LayoutOrder = v17.LayoutOrder - 100;
			p13.Equipped = p1.Network:get("ChangeVictoryAnim", p14);
			p13:ShowEquipped();
		end);
	end;
	function v4.MakeAnims(p15)
		local v20 = p15.ColorScroller.AbsoluteSize.X / 3;
		p15.ColorScroller.UIGridLayout.CellSize = UDim2.new(0, v20 - 5, 0, v20 - 5);
		u3(p15.ColorScroller);
		for v21, v22 in pairs(p15.AnimList) do
			p15:AnimationSquare(v22);
		end;
		p15.ColorScroller.CanvasSize = UDim2.new(0, 0, 0, p15.ColorScroller.UIGridLayout.AbsoluteContentSize.Y);
		p15.ColorScroller.UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
		p15.Holder.Back.Visible = true;
		p15.ColorScroller.Visible = true;
		p15:EnableSearch();
	end;
	function v4.MakeSquares(p16, p17)
		local v23 = p16.ColorScroller.AbsoluteSize.X / 5;
		p16.ColorScroller.UIGridLayout.CellSize = UDim2.new(0, v23 - 5, 0, v23 - 5);
		u3(p16.ColorScroller);
		for v24, v25 in pairs(p16.ColorList) do
			p16:ColorSquare(v25, p17);
		end;
		p16.ColorScroller.CanvasSize = UDim2.new(0, 0, 0, p16.ColorScroller.UIGridLayout.AbsoluteContentSize.Y);
		p16.Holder.Back.Visible = true;
		p16.ColorScroller.Visible = true;
		p16:EnableSearch();
	end;
	function v4.ChangeTitleEquipped(p18)
		for v26, v27 in pairs(p18.TitleScroller:GetChildren()) do
			if v27:IsA("GuiObject") and v27:FindFirstChild("Equipped") then
				if v27.Equipped.Visible == true then
					v27.LayoutOrder = v27.LayoutOrder + 100;
				end;
				v27.Equipped.Visible = false;
			end;
		end;
		p18:Search(p18.SearchString);
	end;
	function v4.ChangeColorEquipped(p19)
		for v28, v29 in pairs(p19.ColorScroller:GetChildren()) do
			if v29:IsA("GuiObject") and v29:FindFirstChild("Equipped") then
				if v29.Equipped.Visible == true then
					v29.LayoutOrder = v29.LayoutOrder + 100;
				end;
				v29.Equipped.Visible = false;
			end;
		end;
		p19:Search(p19.SearchString);
	end;
	local l__Colors__7 = p1.Colors;
	function v4.ColorSquare(p20, p21, p22)
		local v30 = p1.GuiObjs.Square:Clone();
		v30.LayoutOrder = p21;
		p1.Gui:ChangeText(v30.Label, l__Colors__7.GetColorName(p21), p1.MiscDB.Rarities[l__Colors__7.GetColorRarity(p21)]);
		if p20.Equipped[p22] == p21 then
			v30.Equipped.Visible = true;
			v30.LayoutOrder = v30.LayoutOrder - 100;
		else
			v30.Equipped.Visible = false;
		end;
		v30.Name = l__Colors__7.GetColorName(p21);
		v30.Parent = p20.ColorScroller;
		u1.Create(v30, p21);
		p1.Gui:Hover(v30);
		v30.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p20:ChangeColorEquipped();
			v30.Equipped.Visible = true;
			v30.LayoutOrder = v30.LayoutOrder - 100;
			if p22 == "NameColor" then
				p20.Equipped = p1.Network:get("ChangeNameColor", p21);
			else
				p20.Equipped = p1.Network:get("ChangeTitleColor", p21);
			end;
			p20:ShowEquipped();
		end);
	end;
	function v4.ShowEquipped(p23)
		if not p23.Equipped then
			return;
		end;
		p1.Gui:ChangeText(p23.Labels.CurrentTitle.Equipped, l__Titles__4[p23.Equipped.Title]);
		p1.Gui:ChangeText(p23.Labels.TitleColor.Equipped, l__Colors__7.GetColorName(p23.Equipped.TitleColor));
		p1.Gui:ChangeText(p23.Labels.NameColor.Equipped, l__Colors__7.GetColorName(p23.Equipped.NameColor));
		p1.Gui:ChangeText(p23.Labels.VictoryAnim.Equipped, l__Animations__5[p23.Equipped.VictoryAnim].Name);
		u1.Create(p23.Labels.NameColor.Equipped, p23.Equipped.NameColor);
		u1.Create(p23.Labels.TitleColor.Equipped, p23.Equipped.TitleColor);
		u1.Create(p23.Labels.CurrentTitle.Equipped, p23.Equipped.TitleColor);
	end;
	function v4.UISize(p24)
		p24.TitleScroller.UIGridLayout.CellSize = UDim2.new(1, -12, 0, p24.TitleScroller.AbsoluteSize.X / 10);
		local v31 = p24.ColorScroller.AbsoluteSize.X / 5;
		p24.ColorScroller.UIGridLayout.CellSize = UDim2.new(0, v31 - 5, 0, v31 - 5);
	end;
	local function u8()
		for v32, v33 in pairs(u2) do
			v33:Disconnect();
		end;
	end;
	function v4.Destroy(p25)
		p25.CharacterFrame:ClearAllChildren();
		u3(p25.ColorScroller);
		u3(p25.TitleScroller);
		u8();
		p25.UI:TweenPosition(UDim2.new(0.5, 0, -1, -0), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.5);
		p25.UI.Visible = false;
		p1.Menu:EnableActive();
		p25.Equipped = nil;
		p25.ColorList = nil;
		p25.TitleList = nil;
		p25.AnimList = nil;
		setmetatable(p25, nil);
	end;
	return v4;
end;
