-- Decompiled with the Synapse X Luau decompiler.

local u1 = {
	Cash = {
		Price1 = 1157092574, 
		Price2 = 1157092632, 
		Price3 = 1157092633, 
		Price4 = 1157092630, 
		Price5 = 1157092631
	}, 
	Gems = {
		Price1 = 1157274171, 
		Price2 = 1157274174, 
		Price3 = 1157274172, 
		Price4 = 1157274173, 
		Price5 = 1157274175
	}
};
return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Class({
		ClassName = "CurrencyShop"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.CurrencyShop;
		local l__Close__3 = p2.UI:WaitForChild("Close");
		p2.Close = l__Close__3;
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
		p2.CashFrame = p2.UI.ShopHolder.CashFrame;
		p2.GemFrame = p2.UI.ShopHolder.GemFrame;
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
			p1.Sound:Play("BasicClick");
			p2.CashFrame.Visible = true;
			p2.GemFrame.Visible = false;
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
			p1.Sound:Play("BasicClick");
			p2.CashFrame.Visible = false;
			p2.GemFrame.Visible = true;
		end);
		for v6, v7 in pairs(p2.CashFrame:GetChildren()) do
			p1.Gui:PushButton(v7);
			if v7.Name:find("Price") then
				v7.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					p1.Services.MarketplaceService:PromptProductPurchase(p1.p, u1.Cash[v7.Name]);
				end);
			else
				v7.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					p2.CashFrame.Visible = false;
					p2.GemFrame.Visible = true;
				end);
			end;
		end;
		for v8, v9 in pairs(p2.GemFrame:GetChildren()) do
			p1.Gui:PushButton(v9);
			if v9.Name:find("Price") then
				v9.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					p1.Services.MarketplaceService:PromptProductPurchase(p1.p, u1.Gems[v9.Name]);
				end);
			else
				v9.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					p2.GemFrame.Visible = false;
					p2.CashFrame.Visible = true;
				end);
			end;
		end;
		return p2;
	end);
	function v2.UpdateCurrency(p3, p4, p5)
		local v10, v11, v12 = p1.ClientDatabase:PDSFunc("GetMoney", true);
		p3.Cash = v10;
		p3.Gems = v11;
		p3.ShopList = v12;
		if p4 == nil then
			local v13, v14, v15 = p1.ClientDatabase:PDSFunc("GetMoney", true);
			p3.Cash = v13;
			p3.Gems = v14;
			p3.ShopList = v15;
		else
			p3.Cash = p4;
			p3.Gems = p5;
		end;
		if p3.Cash then
			p1.Gui:ChangeText(p3.UI.CashHolder.Cash.Label, "$" .. l__Utilities__1.AddComma(p3.Cash));
		end;
		if p3.Gems then
			p1.Gui:ChangeText(p3.UI.CashHolder.Gems.Label, l__Utilities__1.AddComma(p3.Gems));
		end;
	end;
	local function u2(p6, p7)
		if p6.MinTextSize < p7 then
			p6.MaxTextSize = p7;
			p6.MinTextSize = p7;
			return;
		end;
		p6.MinTextSize = p7;
		p6.MaxTextSize = p7;
	end;
	function v2.UpdateTextSize(p8)
		local v16 = p8.UI.CashHolder.AbsoluteSize.Y / 3;
		u2(p8.UI.CashHolder.Cash.Label.UITextSizeConstraint, v16);
		u2(p8.UI.CashHolder.Gems.Label.UITextSizeConstraint, v16);
		u2(p8.UI.CashHolder.Cash.Label.DropShadow.UITextSizeConstraint, v16);
		u2(p8.UI.CashHolder.Gems.Label.DropShadow.UITextSizeConstraint, v16);
	end;
	function v2.Show(p9, p10)
		p9.CashFrame.Visible = false;
		p9.GemFrame.Visible = false;
		if p10 == "Gems" then
			p9.GemFrame.Visible = true;
		elseif p10 == "Cash" then
			p9.CashFrame.Visible = true;
		end;
		p9:UpdateCurrency();
		p9:UpdateTextSize();
		l__Utilities__1.Halt(0.2);
		p9.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p9.UI.Visible = true;
		p9.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	function v2.Hide(p11, p12)
		p11.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p11.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p11.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p11.UI.Visible = false;
		end);
		p1.RobuxShop:Show();
	end;
	return v2.new();
end;
