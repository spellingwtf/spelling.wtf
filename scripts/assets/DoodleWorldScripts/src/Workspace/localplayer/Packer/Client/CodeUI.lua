-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = nil;
	local v2 = l__Utilities__1.Class({
		ClassName = "GemShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.Codes;
		local l__Purchase__3 = p2.UI.CashHolder.Cash.Icon.Purchase;
		local l__Purchase__4 = p2.UI.CashHolder.Gems.Icon.Purchase;
		local l__Close__5 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__5;
		p2.Holder = p2.UI.Holder;
		p2.MainHolder = p2.Holder.MainHolder;
		p2.Code = p2.MainHolder.Code;
		p2.TextBox = p2.Code.TextBox;
		p2.Submit = p2.MainHolder.Submit;
		p1.Gui:PushButton(p2.Submit);
		p2.Submit.MouseButton1Click:Connect(function()
			if not u1 then
				u1 = true;
				local v6, v7, v8 = p1.ClientDatabase:PDSFunc("SubmitCode", p2.TextBox.Text);
				if v8 then
					p1.Sound:Play(v8);
				end;
				if v6 then
					p1.Dialogue:SaySimple(v6);
				else
					p1.Dialogue:SaySimple("Code database error.");
				end;
				if v7 then
					p2.UI.Visible = false;
					p1.Stats.new({
						CloseFunc = function()
							p2:Show();
						end
					}, v7);
				end;
				u1 = nil;
			end;
		end);
		l__Close__5.MouseEnter:Connect(function()
			l__Close__5.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Close__5.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		l__Close__5.MouseLeave:Connect(function()
			l__Close__5.ImageColor3 = Color3.fromRGB(170, 0, 0);
			l__Close__5.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		l__Close__5.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			p1.Sound:Play("Boop", 0.8);
			p2:Hide();
		end);
		l__Purchase__3.MouseEnter:Connect(function()
			l__Purchase__3.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__3.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__3.MouseLeave:Connect(function()
			l__Purchase__3.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__3.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__3.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Cash");
		end);
		l__Purchase__4.MouseEnter:Connect(function()
			l__Purchase__4.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			l__Purchase__4.ImageColor3 = Color3.fromRGB(14, 14, 22);
		end);
		l__Purchase__4.MouseLeave:Connect(function()
			l__Purchase__4.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			l__Purchase__4.ImageColor3 = Color3.fromRGB(39, 39, 59);
		end);
		l__Purchase__4.MouseButton1Click:Connect(function()
			if u1 then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p2:Hide(true);
			p1.CurrencyShop:Show("Gems");
		end);
		return p2;
	end);
	local function u2(p3, p4)
		if p3.MinTextSize < p4 then
			p3.MaxTextSize = p4;
			p3.MinTextSize = p4;
			return;
		end;
		p3.MinTextSize = p4;
		p3.MaxTextSize = p4;
	end;
	function v2.UpdateTextSize(p5)
		local v9 = p5.UI.CashHolder.AbsoluteSize.Y / 3;
		u2(p5.UI.CashHolder.Cash.Label.UITextSizeConstraint, v9);
		u2(p5.UI.CashHolder.Gems.Label.UITextSizeConstraint, v9);
		u2(p5.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v9);
		u2(p5.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v9);
	end;
	function v2.UpdateCurrency(p6, p7, p8)
		if p7 == nil then
			local v10, v11, v12 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p6.Cash = v10;
			p6.Gems = v11;
			p6.ShopList = v12;
		else
			p6.Cash = p7;
			p6.Gems = p8;
		end;
		if p6.Cash then
			p1.Gui:ChangeText(p6.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p6.Cash));
		end;
		if p6.Gems then
			p1.Gui:ChangeText(p6.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p6.Gems));
		end;
	end;
	function v2.Hide(p9, p10)
		p9.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p9.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p9.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p9.UI.Visible = false;
		end);
		if not p10 then
			p1.RobuxShop:Show();
		end;
	end;
	function v2.Show(p11)
		p11.TextBox.Text = "Code";
		p11:UpdateCurrency();
		p11:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p11.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p11.UI.Visible = true;
		p11.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	return v2.new();
end;
