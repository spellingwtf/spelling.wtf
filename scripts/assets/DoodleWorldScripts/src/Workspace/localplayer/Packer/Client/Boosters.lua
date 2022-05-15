-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	p1.CurrentBoosters = {};
	p1.BoosterSettings = {};
	local u1 = {
		MisprintChance = {
			Title = "2x Misprint Chance", 
			Desc = "This booster increases the chance of encountering Misprints by 2x.", 
			Type = "mp", 
			Color = Color3.fromRGB(85, 170, 255)
		}, 
		ExpBoost = {
			Title = "2x Exp Boost", 
			Desc = "This booster increases the experience you gain every battle by 2x.", 
			Type = "expg", 
			Color = Color3.fromRGB(85, 170, 127)
		}, 
		Mythic = {
			Title = "2x Roaming Mythics", 
			Desc = "This booster increases the chance you can find a roaming mythic by 2x.", 
			Type = "mytg", 
			Color = Color3.fromRGB(255, 85, 0)
		}, 
		NoEncounters = {
			Title = "No Wild Encounters", 
			Desc = "This booster stops you from encountering wild Doodles. You can toggle this booster on and off.", 
			Type = "nwe", 
			Color = Color3.fromRGB(53, 26, 80)
		}
	};
	local u2 = nil;
	local u3 = {
		[true] = "ON", 
		[false] = "OFF"
	};
	local u4 = {
		Type1 = {
			Length = "5 minutes", 
			Gems = 150
		}, 
		Type2 = {
			Length = "30 minutes", 
			Gems = 850
		}, 
		Type3 = {
			Length = "1 hour", 
			Gems = 1600
		}, 
		Type4 = {
			Length = "3 hours", 
			Gems = 4600
		}
	};
	local v2 = l__Utilities__1.Class({
		ClassName = "BoosterShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.BoosterShop;
		local l__Close__3 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__3;
		p2.Holder = p2.UI.Holder;
		p2.SellHolder = p2.Holder.SellHolder;
		p2.Selected = p2.Holder.Selected;
		for v4, v5 in pairs(p2.SellHolder:GetChildren()) do
			if v5:IsA("GuiObject") then
				p1.Gui:PushButton(v5.ItemButton);
				p1.Gui:Hover(v5.ItemButton.Bool);
				if u1[v5.Name] then
					local u5 = u1[v5.Name];
					v5.ItemButton.MouseButton1Click:Connect(function()
						p1.Sound:Play("BasicClick");
						if u2 ~= u5.Type then
							p2:SetPrompt(u5);
						end;
					end);
					v5.ItemButton.Bool.MouseButton1Click:Connect(function()
						p1.Sound:Play("BasicClick");
						local l__Label__6 = v5.ItemButton.Bool.Label;
						l__Label__6.Visible = not l__Label__6.Visible;
						p1.Gui:ChangeText(v5.ItemButton.Toggle, u3[l__Label__6.Visible]);
						p1.ClientDatabase:PDSEvent("ToggleBooster", u5.Type, l__Label__6.Visible);
					end);
				end;
			end;
		end;
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
		local l__Purchase__7 = p2.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__8 = p2.UI.CashHolder.Gems.Icon.Purchase;
		l__Purchase__7.MouseEnter:Connect(function()
			l__Purchase__7.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__7.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__7.MouseLeave:Connect(function()
			l__Purchase__7.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__7.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__7.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Cash");
		end);
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
			p1.CurrencyShop:Show("Gems");
		end);
		local u6 = {
			mp = "MisprintChance", 
			expg = "ExpBoost", 
			mytg = "Mythic"
		};
		p1.Network:BindEvent("UpdateBoosts", function(p3, p4)
			local v9, v10, v11 = pairs(u6);
			while true do
				local v12, v13 = v9(v10, v11);
				if not v12 then
					break;
				end;
				local v14 = p2.SellHolder:FindFirstChild(v13);
				local v15 = p3[v12] and 0;
				p1.Gui:ChangeText(v14.ItemButton.Timer, p1.Gui:SecondsToTimer(v15));
				if u2 == v12 then
					p1.Gui:ChangeText(p2.Selected.Timer, p1.Gui:SecondsToTimer(v15));
				end;
				if v12 == nil then
					v12 = false;
				end;
				local v16 = p4[v12];
				v14.ItemButton.Bool.Label.Visible = v16;
				p1.Gui:ChangeText(v14.ItemButton.Toggle, u3[v16]);			
			end;
			p1.BoosterSettings = p4;
			p1.CurrentBoosters = p3;
		end);
		for v17, v18 in pairs(p2.Selected.PurchaseHolder:GetChildren()) do
			if v18:IsA("GuiObject") then
				p1.Gui:PushButton(v18.Purchase);
				local u7 = u4[v18.Name];
				v18.Purchase.MouseButton1Click:Connect(function()
					if not p2.Gems or not (u7.Gems <= p2.Gems) then
						p2:Hide();
						p1.CurrencyShop:Show("Gems");
						return;
					end;
					p1.Sound:Play("BasicClick", 0.8);
					p1.Network:BindEvent("TimerPurchase", function(p5)
						p1.Network:UnbindEvent("TimerPurchase");
						if p5 then
							p1.Sound:Play("PurchaseSuccess");
						end;
					end);
					p1.Network:post("TimerPurchase", u2, v18.Name);
				end);
			end;
		end;
		p2:SetPrompt(u1.MisprintChance);
		return p2;
	end);
	function v2.SetPrompt(p6, p7)
		u2 = p7.Type;
		p1.Gui:ChangeText(p6.Selected.Title, p7.Title);
		p1.Gui:ChangeText(p6.Selected.Description.Ready, p7.Desc);
		if p1.CurrentBoosters then
			p1.Gui:ChangeText(p6.Selected.Timer, p1.Gui:SecondsToTimer(p1.CurrentBoosters[u2] and 0));
		end;
	end;
	local function u8(p8, p9)
		if p8.MinTextSize < p9 then
			p8.MaxTextSize = p9;
			p8.MinTextSize = p9;
			return;
		end;
		p8.MinTextSize = p9;
		p8.MaxTextSize = p9;
	end;
	function v2.UpdateTextSize(p10)
		local v19 = p10.UI.CashHolder.AbsoluteSize.Y / 3;
		u8(p10.UI.CashHolder.Cash.Label.UITextSizeConstraint, v19);
		u8(p10.UI.CashHolder.Gems.Label.UITextSizeConstraint, v19);
		u8(p10.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v19);
		u8(p10.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v19);
	end;
	function v2.UpdateCurrency(p11, p12, p13)
		if p12 == nil then
			local v20, v21, v22 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p11.Cash = v20;
			p11.Gems = v21;
			p11.ShopList = v22;
		else
			p11.Cash = p12;
			p11.Gems = p13;
		end;
		if p11.Cash then
			p1.Gui:ChangeText(p11.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p11.Cash));
		end;
		if p11.Gems then
			p1.Gui:ChangeText(p11.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p11.Gems));
		end;
	end;
	function v2.Hide(p14, p15)
		u2 = nil;
		p14.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p14.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p14.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p14.UI.Visible = false;
		end);
		if not p15 then
			p1.RobuxShop:Show();
		end;
	end;
	function v2.Show(p16)
		p16:UpdateCurrency();
		p16:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p16.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p16.UI.Visible = true;
		p16.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	return v2.new();
end;
