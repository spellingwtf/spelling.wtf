-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local l__Network__2 = p1.Network;
	local u1 = { "RobuxShop", "CurrencyShop", "Roulette", "Boosters", "GemShop", "GamepassShop", "CodeUI" };
	p1.Network:BindEvent("CurrencyPurchase", function(p2, p3)
		p1.Sound:Play("PurchaseSuccess");
		for v3, v4 in pairs(u1) do
			p1[v4]:UpdateCurrency(p2, p3);
		end;
	end);
	p1.Network:BindEvent("UpdateCurrency", function(p4, p5)
		for v5, v6 in pairs(u1) do
			p1[v6]:UpdateCurrency(p4, p5);
		end;
	end);
	local v7 = l__Utilities__1.Class({
		ClassName = "RobuxShop"
	}, function(p6)
		p6.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p6.UI = p6.maingui.RobuxShop;
		local l__Close__8 = p6.UI:WaitForChild("Close");
		p6.Close = l__Close__8;
		l__Close__8.MouseEnter:Connect(function()
			l__Close__8.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__8.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__8.MouseLeave:Connect(function()
			l__Close__8.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__8.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		local u2 = nil;
		l__Close__8.MouseButton1Click:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("Boop", 0.8);
			p6:Hide(true);
		end);
		for v9, v10 in pairs(p6.UI.ButtonHolder:GetChildren()) do
			p1.Gui:PushButton(v10.ItemButton);
		end;
		p6.UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p6:UpdateTextSize();
		end);
		p6.Buttons = p6.UI.ButtonHolder;
		p6.Buttons.Boosters.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.Boosters:Show();
		end);
		p6.Buttons.Gamepasses.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.GamepassShop:Show();
		end);
		p6.Buttons.BuyCash.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.CurrencyShop:Show("Cash");
		end);
		p6.Buttons.BuyGems.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.CurrencyShop:Show("Gems");
		end);
		p6.Buttons.GemShop.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.GemShop:Show();
		end);
		p6.Buttons.Codes.ItemButton.MouseButton1Down:Connect(function()
			if u2 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p6:Hide(false);
			p1.CodeUI:Show();
		end);
		p6.Buttons.Roulette.ItemButton.MouseButton1Down:Connect(function()
			if not p1.RouletteBan then
				p1.Sound:Play("BasicClick");
				p6:Hide(false);
				p1.Roulette:Show();
				return;
			end;
			if u2 then
				return;
			end;
			u2 = true;
			p1.Gui:SayText("", "Your country does not allow you to use this feature.", nil, true);
			p1.Dialogue:Hide();
			p1.RobuxShop:Show();
			u2 = nil;
		end);
		local l__Purchase__11 = p6.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__12 = p6.UI.CashHolder.Gems.Icon.Purchase;
		l__Purchase__11.MouseEnter:Connect(function()
			l__Purchase__11.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__11.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__11.MouseLeave:Connect(function()
			l__Purchase__11.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__11.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__11.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p6:Hide();
			p1.CurrencyShop:Show("Cash");
		end);
		l__Purchase__12.MouseEnter:Connect(function()
			l__Purchase__12.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__12.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__12.MouseLeave:Connect(function()
			l__Purchase__12.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__12.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__12.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p6:Hide();
			p1.CurrencyShop:Show("Gems");
		end);
		return p6;
	end);
	local function u3(p7, p8)
		if p7.MinTextSize < p8 then
			p7.MaxTextSize = p8;
			p7.MinTextSize = p8;
			return;
		end;
		p7.MinTextSize = p8;
		p7.MaxTextSize = p8;
	end;
	function v7.UpdateTextSize(p9)
		local v13 = p9.UI.CashHolder.AbsoluteSize.Y / 3;
		u3(p9.UI.CashHolder.Cash.Label.UITextSizeConstraint, v13);
		u3(p9.UI.CashHolder.Gems.Label.UITextSizeConstraint, v13);
		u3(p9.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v13);
		u3(p9.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v13);
	end;
	function v7.UpdateCurrency(p10, p11, p12)
		if p11 == nil then
			local v14, v15, v16 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p10.Cash = v14;
			p10.Gems = v15;
			p10.ShopList = v16;
		else
			p10.Cash = p11;
			p10.Gems = p12;
		end;
		if p10.Cash then
			p1.Gui:ChangeText(p10.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p10.Cash));
		end;
		if p10.Gems then
			p1.Gui:ChangeText(p10.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p10.Gems));
		end;
	end;
	local u4 = nil;
	local function u5()
		u4 = { "http://www.roblox.com/asset/?id=8964981590", "http://www.roblox.com/asset/?id=9145190706", "http://www.roblox.com/asset/?id=9145249077", "http://www.roblox.com/asset/?id=9137034166" };
	end;
	local u6 = nil;
	function v7.Show(p13)
		u5();
		if not p1.RandomDoodleTable then
			p1.RandomDoodleTable = p1.Network:get("ListOfRandomDoodles");
		end;
		if not u6 then
			u6 = true;
			l__Utilities__1.FastSpawn(function()
				while u6 == true do
					local v17 = p1.RandomDoodleTable[math.random(#p1.RandomDoodleTable)];
					local l__Size__18 = p1.DoodleInfo[v17].Size;
					local l__DoodleLabel__19 = p13.Buttons.Roulette.ItemButton.DoodleLabel;
					l__DoodleLabel__19.Size = UDim2.new(0.8, 0, 0.8);
					l__DoodleLabel__19.Image = p1.DoodleInfo[v17].FrontSprite;
					p13.Buttons.Gamepasses.ItemButton.GamepassImage.Image = table.remove(u4, math.random(#u4));
					if #u4 == 0 then
						u5();
					end;
					l__Utilities__1.Halt(1);				
				end;
			end);
		end;
		p13:UpdateCurrency();
		p13:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p13.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p13.UI.Visible = true;
		p13.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		return p13;
	end;
	function v7.Hide(p14, p15)
		u6 = nil;
		p14.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p14.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p14.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p14.UI.Visible = false;
		end);
		if p15 then
			l__Utilities__1.Halt(0.2);
			p1.Menu:EnableActive();
		end;
	end;
	return v7.new();
end;
