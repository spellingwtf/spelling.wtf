-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = nil;
	local v2 = l__Utilities__1.Class({
		ClassName = "GemShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.GemShop;
		p2.Holder = p2.maingui.GemShop.Holder;
		p2.SellHolder = p2.Holder.SellHolder;
		p2.Selected = p2.Holder.Selected;
		local l__Close__3 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__3;
		p2.PurchaseButton = p2.Selected.Purchase;
		p1.Gui:PushButton(p2.PurchaseButton);
		l__Close__3.MouseEnter:Connect(function()
			l__Close__3.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__3.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__3.MouseLeave:Connect(function()
			l__Close__3.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__3.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		l__Close__3.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p2:Hide();
		end);
		local l__GemShopProducts__4 = p1.GemShopProducts;
		for v5, v6 in pairs(l__GemShopProducts__4) do
			local v7 = p1.GuiObjs.SkinShop:Clone();
			p1.Gui:AnimateSprite(v7.SkinImage, {
				Name = v6.Showcase, 
				Skin = v6.Skin, 
				Gender = "M"
			}, true);
			p1.Gui:ChangeText(v7.SkinName, v6.Name);
			p1.Gui:ChangeText(v7.GemCost.Label, l__Utilities__1.AddComma(v6.Cost));
			p1.Gui:Hover(v7);
			v7.Parent = p2.SellHolder;
			v7.GemCost.Icon.Position = UDim2.new(1, -v7.GemCost.Label.TextBounds.X * 1.1, 0.5, 0);
			v7.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick");
				p2:Focus(v5);
			end);
		end;
		p2:Focus(1);
		p2.PurchaseButton.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			if not (l__GemShopProducts__4[u1].Cost <= p2.Gems) then
				p2:Hide(true);
				p1.CurrencyShop:Show("Gems");
				return;
			end;
			p1.Network:BindEvent("PurchaseGemShop", function(p3)
				p1.Network:UnbindEvent("PurchaseGemShop");
				if not p3 then
					return;
				end;
				p1.Sound:Play("PurchaseSuccess");
			end);
			p1.Network:post("PurchaseGemShop", u1);
		end);
		local l__Purchase__8 = p2.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__9 = p2.UI.CashHolder.Gems.Icon.Purchase;
		l__Purchase__8.MouseEnter:Connect(function()
			l__Purchase__8.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__8.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__8.MouseLeave:Connect(function()
			l__Purchase__8.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__8.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__8.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Cash");
		end);
		l__Purchase__9.MouseEnter:Connect(function()
			l__Purchase__9.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__9.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__9.MouseLeave:Connect(function()
			l__Purchase__9.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__9.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__9.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Gems");
		end);
		return p2;
	end);
	local u2 = 0;
	function v2.Focus(p4, p5)
		u1 = p5;
		u2 = u2 + 1;
		local v10 = p1.GemShopProducts[p5];
		p1.Gui:ChangeText(p4.Selected.Title, v10.Name);
		p1.Gui:ChangeText(p4.Selected.Title, v10.Name);
		local v11 = p1.Lines:GetLines()[v10.Line];
		p1.Gui:ChangeText(p4.Selected.Purchase.Ready, "Purchase (\240\159\146\142" .. l__Utilities__1.AddComma(v10.Cost) .. ")");
		p1.Gui:ChangeText(p4.Selected.Description.Ready, v10.Description);
		l__Utilities__1.FastSpawn(function()
			while u2 == u2 and u1 == p5 do
				for v12, v13 in pairs(v11) do
					if u2 ~= u2 then
						break;
					end;
					if u1 ~= p5 then
						break;
					end;
					p1.Gui:AnimateSprite(p4.Selected.SkinImage, {
						Name = v13, 
						Skin = v10.Skin, 
						Gender = "M"
					}, true);
					l__Utilities__1.Halt(1);
				end;			
			end;
		end);
	end;
	local function u3(p6, p7)
		if p6.MinTextSize < p7 then
			p6.MaxTextSize = p7;
			p6.MinTextSize = p7;
			return;
		end;
		p6.MinTextSize = p7;
		p6.MaxTextSize = p7;
	end;
	function v2.UpdateTextSize(p8)
		local v14 = p8.UI.CashHolder.AbsoluteSize.Y / 3;
		u3(p8.UI.CashHolder.Cash.Label.UITextSizeConstraint, v14);
		u3(p8.UI.CashHolder.Gems.Label.UITextSizeConstraint, v14);
		u3(p8.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v14);
		u3(p8.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v14);
	end;
	function v2.UpdateCurrency(p9, p10, p11)
		if p10 == nil then
			local v15, v16, v17 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p9.Cash = v15;
			p9.Gems = v16;
			p9.ShopList = v17;
		else
			p9.Cash = p10;
			p9.Gems = p11;
		end;
		if p9.Cash then
			p1.Gui:ChangeText(p9.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p9.Cash));
		end;
		if p9.Gems then
			p1.Gui:ChangeText(p9.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p9.Gems));
		end;
	end;
	function v2.Hide(p12, p13)
		p12.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p12.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p12.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p12.UI.Visible = false;
		end);
		if not p13 then
			p1.RobuxShop:Show();
		end;
	end;
	function v2.Show(p14)
		p14:UpdateCurrency();
		p14:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p14.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p14.UI.Visible = true;
		p14.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	return v2.new();
end;
