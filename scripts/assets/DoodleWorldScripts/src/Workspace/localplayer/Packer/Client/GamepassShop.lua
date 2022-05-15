-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {
		[28818787] = "Hidden Trait trinket", 
		[28818793] = "Misprint trinket", 
		[28818799] = "Double Money trinket", 
		[28818802] = "Mythical trinket", 
		[30385012] = "Extra victory animations", 
		[30402046] = "Magnifying Glass"
	};
	local u1 = nil;
	local u2 = { 28818787, 28818793, 28818799, 28818802, 30385012, 30402046 };
	local u3 = {
		[28818787] = {
			Name = "Hidden Trait Trinket", 
			Image = "http://www.roblox.com/asset/?id=9205213322", 
			Description = "Doubles the chance of finding a hidden trait on a Doodle."
		}, 
		[28818793] = {
			Name = "Misprint Trinket", 
			Image = "http://www.roblox.com/asset/?id=8964981590", 
			Description = "Doubles the chance of finding a Misprinted Doodle."
		}, 
		[28818799] = {
			Name = "Double Money Trinket", 
			Image = "http://www.roblox.com/asset/?id=9145190706", 
			Description = "Doubles the money you get from tamer battles and help center requests."
		}, 
		[28818802] = {
			Name = "Mythical Trinket", 
			Image = "http://www.roblox.com/asset/?id=9205212570", 
			Description = "Doubles the chance of finding mythical Doodles."
		}, 
		[30385012] = {
			Name = "Extra victory animations", 
			Image = "http://www.roblox.com/asset/?id=9145249077", 
			Description = "Grants you 6 victory animations you can use to style on other people in PvP."
		}, 
		[30402046] = {
			Name = "Magnifying glass", 
			Image = "http://www.roblox.com/asset/?id=9137034166", 
			Description = "Allows you to view a wild Doodle's stat page before catching."
		}
	};
	local u4 = {};
	local v3 = l__Utilities__1.Class({
		ClassName = "GamepassShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.GamepassShop;
		local l__Close__4 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__4;
		p2.Holder = p2.UI.Holder;
		p2.SellHolder = p2.Holder.SellHolder;
		p2.Selected = p2.Holder.Selected;
		p2.Purchase = p2.Selected.Purchase;
		p2.Purchase.MouseButton1Click:Connect(function()
			if u1 then
				p1.Sound:Play("Boop");
				p1.Services.MarketplaceService:PromptGamePassPurchase(p1.p, u1);
			end;
		end);
		p1.Gui:PushButton(p2.Purchase);
		l__Close__4.MouseEnter:Connect(function()
			l__Close__4.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__4.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__4.MouseLeave:Connect(function()
			l__Close__4.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__4.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		l__Close__4.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p2:Hide();
		end);
		local l__Purchase__5 = p2.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__6 = p2.UI.CashHolder.Gems.Icon.Purchase;
		l__Purchase__5.MouseEnter:Connect(function()
			l__Purchase__5.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__5.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__5.MouseLeave:Connect(function()
			l__Purchase__5.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__5.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__5.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Cash");
		end);
		l__Purchase__6.MouseEnter:Connect(function()
			l__Purchase__6.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__6.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__6.MouseLeave:Connect(function()
			l__Purchase__6.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__6.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__6.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Gems");
		end);
		for v7, v8 in pairs(u2) do
			local v9 = p1.GuiObjs.GamepassButton:Clone();
			local v10 = u3[v8];
			v9.Name = v10.Name;
			p1.Gui:PushButton(v9.ItemButton);
			v9.ItemButton.ImageLabel.Image = v10.Image;
			p1.Gui:ChangeText(v9.ItemButton.Titleplate.Label, v10.Name);
			v9.Parent = p2.SellHolder;
			v9.LayoutOrder = v7;
			l__Utilities__1.FastSpawn(function()
				pcall(function()
					local l__PriceInRobux__11 = p1.Services.MarketplaceService:GetProductInfo(v8, Enum.InfoType.GamePass).PriceInRobux;
					if l__PriceInRobux__11 == nil then
						u4[v8] = "Price not found";
						return;
					end;
					u4[v8] = l__PriceInRobux__11 .. " R$";
				end);
			end);
			v9.ItemButton.MouseButton1Down:Connect(function()
				p1.Sound:Play("BasicClick");
				p2:SetPrompt(v8);
			end);
		end;
		p2:SetPrompt(28818787);
		return p2;
	end);
	function v3.SetPrompt(p3, p4)
		u1 = p4;
		local v12 = u3[u1];
		p1.Gui:ChangeText(p3.Selected.Title, v12.Name);
		p1.Gui:ChangeText(p3.Selected.Description.Ready, v12.Description);
		p3.Selected.GamepassImage.Icon.Image = v12.Image;
		p1.Gui:ChangeText(p3.Selected.Purchase.Ready, "Purchase (" .. (u4[p4] and "Price not found") .. ")");
	end;
	local function u5(p5, p6)
		if p5.MinTextSize < p6 then
			p5.MaxTextSize = p6;
			p5.MinTextSize = p6;
			return;
		end;
		p5.MinTextSize = p6;
		p5.MaxTextSize = p6;
	end;
	function v3.UpdateTextSize(p7)
		local v13 = p7.UI.CashHolder.AbsoluteSize.Y / 3;
		u5(p7.UI.CashHolder.Cash.Label.UITextSizeConstraint, v13);
		u5(p7.UI.CashHolder.Gems.Label.UITextSizeConstraint, v13);
		u5(p7.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v13);
		u5(p7.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v13);
	end;
	function v3.UpdateCurrency(p8, p9, p10)
		if p9 == nil then
			local v14, v15, v16 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p8.Cash = v14;
			p8.Gems = v15;
			p8.ShopList = v16;
		else
			p8.Cash = p9;
			p8.Gems = p10;
		end;
		if p8.Cash then
			p1.Gui:ChangeText(p8.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p8.Cash));
		end;
		if p8.Gems then
			p1.Gui:ChangeText(p8.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p8.Gems));
		end;
	end;
	function v3.Hide(p11, p12)
		u1 = nil;
		p11.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p11.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p11.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p11.UI.Visible = false;
		end);
		if not p12 then
			p1.RobuxShop:Show();
		end;
	end;
	function v3.Show(p13)
		p13:UpdateCurrency();
		p13:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p13.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p13.UI.Visible = true;
		p13.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	return v3.new();
end;
