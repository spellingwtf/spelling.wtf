-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = false;
	local u2 = false;
	local u3 = true;
	local u4 = false;
	local u5 = false;
	local v2 = l__Utilities__1.Class({
		ClassName = "RobuxShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.Roulette;
		local l__Close__3 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__3;
		p2.Holder = p2.UI.Holder;
		p2.Circle = p2.Holder.Circle;
		p2.CurrentSet = p2.Holder.CurrentSet;
		p2.DoodleHolder = p2.CurrentSet.DoodleHolder;
		p2.ButtonHolder = p2.CurrentSet.ButtonHolder;
		p2.CircleHolder = p2.Circle.CircleHolder;
		p2.ShowStatsBool = p2.ButtonHolder.ShowStats.Bool;
		p1.Gui:Hover(p2.ShowStatsBool);
		p2.Results = p2.maingui.Result;
		l__Close__3.MouseEnter:Connect(function()
			l__Close__3.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__3.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__3.MouseLeave:Connect(function()
			l__Close__3.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__3.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		l__Close__3.MouseButton1Click:Connect(function()
			if not u1 and not u2 then
				p1.Sound:Play("Boop", 0.8);
				p2:Hide();
			end;
		end);
		local l__Purchase__4 = p2.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__5 = p2.UI.CashHolder.Gems.Icon.Purchase;
		l__Purchase__4.MouseEnter:Connect(function()
			l__Purchase__4.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__4.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__4.MouseLeave:Connect(function()
			l__Purchase__4.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__4.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__4.MouseButton1Click:Connect(function()
			if not u1 then
				p1.Sound:Play("BasicClick");
				p2:Hide(true);
				p1.CurrencyShop:Show("Cash");
			end;
		end);
		l__Purchase__5.MouseEnter:Connect(function()
			l__Purchase__5.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__5.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__5.MouseLeave:Connect(function()
			l__Purchase__5.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__5.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__5.MouseButton1Click:Connect(function()
			if not u1 then
				p1.Sound:Play("BasicClick");
				p2:Hide(true);
				p1.CurrencyShop:Show("Gems");
			end;
		end);
		p2.ShowStatsBool.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick", math.random(90, 110) / 100);
			u3 = not u3;
			p2.ShowStatsBool.Label.Visible = u3;
		end);
		for v6, v7 in pairs(p2.ButtonHolder:GetChildren()) do
			if v7:IsA("ImageButton") then
				p1.Gui:PushButton(v7);
			end;
		end;
		p2.UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p2:UpdateTextSize();
		end);
		p1.Services.ReplicatedStorage.CurrentDate.Seconds.Changed:Connect(function()
			if u4 == true then
				p1.Gui:ChangeText(p2.ButtonHolder.Timer, "Free set changes replenish in: " .. p1.Gui:NextDayTimer());
			end;
		end);
		p2.ButtonHolder.NewSet.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			if u2 then
				return;
			end;
			u2 = true;
			if not u5 and p2.FreeSet > 0 then
				u5 = true;
				p1.Sound:Play("BasicClick", 0.8);
				local v8, v9, v10 = p1.ClientDatabase:PDSFunc("GetRouletteTable", true);
				p2.RouletteTable = v8;
				p2.FreeSet = v9;
				p2.ResetCost = v10;
				p2:Update();
				u5 = false;
			elseif not u5 and p2.FreeSet <= 0 then
				if p2.Gems and p2.ResetCost <= p2.Gems then
					p1.Sound:Play("BasicClick", 0.8);
					local v11, v12, v13 = p1.ClientDatabase:PDSFunc("GetRouletteTable", true);
					p2.RouletteTable = v11;
					p2.FreeSet = v12;
					p2.ResetCost = v13;
					p2:Update();
					u5 = false;
				else
					p2:Hide(true);
					p1.CurrencyShop:Show("Gems");
				end;
			end;
			p1.Gui:ChangeText(p2.ButtonHolder.NewSet.Label, "Waiting...");
			l__Utilities__1.Halt(0.5);
			p1.Gui:ChangeText(p2.ButtonHolder.NewSet.Label, p2.ButtonHolder.NewSet.Label.Text);
			u2 = false;
		end);
		p2.ButtonHolder.Spin.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			if u2 then
				return;
			end;
			u2 = true;
			if p2.RouletteTable.Spins <= 0 then
				p1.Sound:Play("BasicClick", 0.8);
				p1.ClientDatabase:PDSFunc("RouletteSpin");
			elseif p2.Gems < 300 then
				p2:Hide(true);
				p1.CurrencyShop:Show("Gems");
			elseif not p1.ClientDatabase:PDSFunc("IsMaximum") then
				u1 = true;
				p1.Sound:Play("BasicClick", 0.8);
				p1.ClientDatabase:PDSFunc("RouletteSpin");
			else
				p1.Gui:TextAnnouncement("You have no space for any more Doodles.");
			end;
			if u1 ~= true then
				u2 = false;
			end;
		end);
		p2.ButtonHolder.BuySet.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			if u2 then
				return;
			end;
			if p1.ClientDatabase:PDSFunc("GetNumberOfEmptyLocations", true) >= 10 then
				p1.Services.MarketplaceService:PromptProductPurchase(p1.p, 1158295704);
				return;
			end;
			u2 = true;
			p1.Gui:TextAnnouncement("You don't have space for 10 Doodles.");
			u2 = false;
		end);
		p1.Network:BindEvent("BulkPurchase", function(p3)
			u1 = true;
			p2:ShowResults(p3);
		end);
		p1.Network:BindEvent("UpdateRoulette", function(p4, p5)
			while true do
				l__Utilities__1.Halt(0.05);
				if not u1 then
					break;
				end;			
			end;
			p2.RouletteTable = p4;
			p2.FreeSet = p5;
			p2:Update();
		end);
		p1.Network:BindEvent("RouletteSpin", function(p6, p7, p8, p9, p10)
			if p10 then
				p2:Show();
			end;
			u1 = true;
			p1.Gui:ChangeText(p2.ButtonHolder.SpinsLeft, p9.Spins .. "/3 Spins Until New Set");
			local v14 = (p6 - 1) * -36;
			for v15 = 1, 2 do
				for v16 = p2.Circle.CircleHolder.Rotation, p2.Circle.CircleHolder.Rotation - 360, -8 do
					p2.CircleHolder.Rotation = v16;
					l__Utilities__1.Halt(0.03);
					if p2.CircleHolder.Rotation <= -360 then
						p2.CircleHolder.Rotation = p2.CircleHolder.Rotation + 360;
					end;
				end;
			end;
			while true do
				p2.CircleHolder.Rotation = p2.CircleHolder.Rotation - 6;
				l__Utilities__1.Halt(0.03);
				if p2.CircleHolder.Rotation <= -360 then
					p2.CircleHolder.Rotation = p2.CircleHolder.Rotation + 360;
				end;
				if p2.CircleHolder.Rotation <= v14 + 7 and v14 - 7 <= p2.CircleHolder.Rotation then
					break;
				end;			
			end;
			p1.Gui:SayText("", "You got " .. p7.Name .. "! It was added to " .. p8 .. ".", nil, true);
			p1.Talky.Visible = false;
			if u3 then
				p2.UI.Visible = false;
				p1.Stats.new({
					Roulette = p2.UI, 
					ColorList = p2.ColorList
				}, p7);
			end;
			p2.RouletteTable = p9;
			p2:Update();
			u1 = false;
			u2 = false;
		end);
		p2:SetupResults();
		return p2;
	end);
	local u6 = false;
	function v2.ShowResults(p11, p12)
		local l__Scroller__17 = p11.Results.ResultHolder.Scroller;
		u6 = true;
		for v18, v19 in pairs(l__Scroller__17:GetChildren()) do
			if v19:IsA("GuiObject") then
				v19:Destroy();
			end;
		end;
		local v20 = {};
		p11.DoodleTable = p12;
		local v21, v22, v23 = pairs(p12);
		while true do
			local v24, v25 = v21(v22, v23);
			if not v24 then
				break;
			end;
			local v26 = p1.GuiObjs.DoodleRoulette:Clone();
			local l__Doodle__27 = v25.Doodle;
			table.insert(v20, v24, v25.Doodle);
			v26.LayoutOrder = v24;
			local v28 = p1.DoodleInfo[l__Doodle__27.Name];
			v26.Border.ImageColor3 = p1.MiscDB.Rarities[v28.Roulette];
			v26.MouseEnter:Connect(function()
				v26.ImageColor3 = Color3.fromRGB(18, 18, 18);
			end);
			if l__Doodle__27.Skin and l__Doodle__27.Skin ~= 0 then
				v26.Location.TextColor3 = Color3.fromRGB(255, 0, 0);
			end;
			v26.Sparkles.Visible = l__Doodle__27.Shiny;
			if l__Doodle__27.Shiny then
				v26.Location.TextColor3 = Color3.fromRGB(255, 255, 0);
			end;
			v26.HA.Visible = l__Doodle__27.Ability == v28.HiddenAbility;
			if l__Doodle__27.Ability == v28.HiddenAbility then
				p1.Tooltip.new({
					TextColor3 = Color3.fromRGB(255, 255, 0)
				}, v26.HA, "Hidden Trait: " .. v28.HiddenAbility);
			end;
			v26.MouseLeave:Connect(function()
				v26.ImageColor3 = Color3.fromRGB(54, 54, 54);
			end);
			v26.MouseButton1Click:Connect(function()
				p11.Results.Visible = false;
				p11.UI.Visible = false;
				p1.Stats.new({
					Results = p11.Results, 
					ColorList = p11.ColorList, 
					PlayerParty = p11.NewDoodleTable, 
					Roulette = p11.UI, 
					SkinList = p11.SkinList, 
					CloseFunc = function(p13)
						p11.NewDoodleTable[v24] = p13;
						p1.Gui:StaticImage(v26.DoodleLabel, p13, true);
						if p13.Skin and p13.Skin ~= 0 then
							v26.Location.TextColor3 = Color3.fromRGB(255, 0, 0);
							return;
						end;
						v26.Location.TextColor3 = Color3.fromRGB(255, 255, 255);
					end
				}, p11.NewDoodleTable[v24]);
			end);
			p1.Gui:ChangeText(v26.Location, v25.Location);
			p1.Gui:StaticImage(v26.DoodleLabel, l__Doodle__27, true);
			v26.Parent = l__Scroller__17;		
		end;
		p11.NewDoodleTable = v20;
		l__Scroller__17.CanvasSize = UDim2.new(0, 0, 0, l__Scroller__17.UIGridLayout.AbsoluteContentSize.Y);
		p11.Results.Position = UDim2.new(0.5, 0, -1, -18);
		p11.Results.Visible = true;
		p11.Results:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	function v2.SetupResults(p14)
		local l__Close__29 = p14.Results.Close;
		l__Close__29.MouseEnter:Connect(function()
			l__Close__29.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__29.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__29.MouseLeave:Connect(function()
			l__Close__29.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__29.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		l__Close__29.MouseButton1Click:Connect(function()
			u1 = false;
			p1.Sound:Play("Boop", 0.8);
			p14:HideResults(true);
		end);
	end;
	function v2.HideResults(p15)
		local l__Close__30 = p15.Results.Close;
		l__Close__30.ImageColor3 = Color3.fromRGB(170, 0, 0);
		l__Close__30.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p15.Results:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p15.Results.Visible = false;
		end);
	end;
	local function u7(p16, p17)
		if p16.MinTextSize < p17 then
			p16.MaxTextSize = p17;
			p16.MinTextSize = p17;
			return;
		end;
		p16.MinTextSize = p17;
		p16.MaxTextSize = p17;
	end;
	function v2.UpdateTextSize(p18)
		local v31 = p18.UI.CashHolder.AbsoluteSize.Y / 3;
		u7(p18.UI.CashHolder.Cash.Label.UITextSizeConstraint, v31);
		u7(p18.UI.CashHolder.Gems.Label.UITextSizeConstraint, v31);
		u7(p18.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v31);
		u7(p18.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v31);
	end;
	function v2.Clear(p19)
		for v32, v33 in pairs(p19.DoodleHolder:GetChildren()) do
			if v33:IsA("GuiObject") then
				v33:Destroy();
			end;
		end;
	end;
	function v2.Update(p20, p21)
		local l__RouletteTable__34 = p20.RouletteTable;
		local v35, v36 = p1.ClientDatabase:PDSFunc("GetColorList");
		p20.ColorList = v35;
		p20.SkinList = v36;
		p1.Gui:ChangeText(p20.ButtonHolder.SpinsLeft, l__RouletteTable__34.Spins .. "/3 Spins Until New Set");
		p1.Gui:ChangeText(p20.ButtonHolder.SetsLeft, p20.FreeSet .. "/3 Free Daily Set Changes");
		if p20.FreeSet > 0 then
			p1.Gui:ChangeText(p20.ButtonHolder.NewSet.Label, "New Set");
		else
			local v37 = p20.ResetCost;
			if v37 == nil then
				v37 = 50;
			end;
			p1.Gui:ChangeText(p20.ButtonHolder.NewSet.Label, "New Set (" .. v37 .. " Gems)");
		end;
		if l__RouletteTable__34.Spins > 0 then
			p1.Gui:ChangeText(p20.ButtonHolder.Spin.Label, "Spin (300 Gems)");
		else
			p1.Gui:ChangeText(p20.ButtonHolder.Spin.Label, "Get New Set (Free)");
		end;
		if not p21 then
			p20:Clear();
			local v38, v39, v40 = pairs(p20.RouletteTable.Doodles);
			while true do
				local v41, v42 = v38(v39, v40);
				if not v41 then
					break;
				end;
				if v42.Shiny ~= true or not p1.DoodleInfo[v42.Name].SFSprite then
					local l__FrontSprite__43 = p1.DoodleInfo[v42.Name].FrontSprite;
				end;
				local v44 = p1.GuiObjs.DoodleSet:Clone();
				p1.Gui:StaticImage(v44.DoodleLabel, {
					Name = v42.Name, 
					Skin = v42.Skin, 
					Gender = "M", 
					Shiny = v42.Shiny
				}, true);
				p1.Gui:ChangeText(v44.DoodleName, v42.Name);
				local v45 = p1.DoodleInfo[v42.Name].Roulette;
				if v45 == "Common" then
					v45 = "RouletteCommon";
				end;
				v44.BackgroundColor3 = p1.MiscDB.Rarities[v45];
				v44.Sparkles.Visible = v42.Shiny;
				local v46 = {};
				if v44.DoodleName:FindFirstChild("ColorName") then
					v44.DoodleName:FindFirstChild("ColorName"):Destroy();
				end;
				if v42.Shiny then
					table.insert(v46, Color3.fromRGB(255, 255, 0));
				end;
				if v42.HA then
					table.insert(v46, Color3.fromRGB(0, 255, 255));
				end;
				if v42.Skin and v42.Skin ~= 0 then
					if p1.Skins.Sprites[v42.Name][v42.Skin].Event then
						table.insert(v46, Color3.fromRGB(255, 85, 255));
					else
						table.insert(v46, Color3.fromRGB(255, 0, 0));
					end;
				end;
				if #v46 > 0 then
					local v47 = l__Utilities__1:Create("UIGradient")({
						Parent = v44.DoodleName, 
						Color = l__Utilities__1.CreateColorSequence(v46), 
						Rotation = 0, 
						Name = "ColorName"
					});
				end;
				v44.HA.Visible = v42.HA;
				if v42.HA then
					p1.Tooltip.new({
						TextColor3 = Color3.fromRGB(0, 255, 255)
					}, v44.HA, "Hidden Trait: " .. p1.DoodleInfo[v42.Name].HiddenAbility);
				end;
				v44.LayoutOrder = v41;
				v44.Parent = p20.DoodleHolder;
				local v48 = p20.Circle.CircleHolder["Slice" .. v41];
				v48.ImageColor3 = p1.MiscDB.Rarities[v45];
				p1.Gui:StaticImage(v48.DoodleLabel, {
					Name = v42.Name, 
					Skin = v42.Skin, 
					Gender = "M", 
					Shiny = v42.Shiny
				}, true);			
			end;
		end;
		u1 = false;
	end;
	function v2.UpdateCurrency(p22, p23, p24)
		if p23 == nil then
			local v49, v50, v51 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p22.Cash = v49;
			p22.Gems = v50;
			p22.ShopList = v51;
		else
			p22.Cash = p23;
			p22.Gems = p24;
		end;
		if p22.Cash then
			p1.Gui:ChangeText(p22.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p22.Cash));
		end;
		if p22.Gems then
			p1.Gui:ChangeText(p22.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p22.Gems));
		end;
	end;
	function v2.Show(p25)
		u4 = true;
		p25.Circle.CircleHolder.Rotation = math.random(1, 360);
		p1.Gui:ChangeText(p25.ButtonHolder.Timer, "Free set changes replenish in: " .. p1.Gui:NextDayTimer());
		if not p25.RouletteTable then
			local v52, v53, v54 = p1.ClientDatabase:PDSFunc("GetRouletteTable");
			p25.RouletteTable = v52;
			p25.FreeSet = v53;
			p25.ResetCost = v54;
		elseif not p25.ResetCost then
			p25.ResetCost = p1.ClientDatabase:PDSFunc("GetRouletteTable");
		end;
		p25:Update();
		p25:UpdateCurrency();
		p25:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p25.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p25.UI.Visible = true;
		p25.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	function v2.Hide(p26, p27)
		p1.Tooltip:Clear();
		u4 = false;
		p26.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p26.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p26.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p26.UI.Visible = false;
		end);
		if not p27 then
			p1.RobuxShop:Show();
		end;
	end;
	return v2.new();
end;
