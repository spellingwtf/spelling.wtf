-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local l__Network__2 = p1.Network;
	p1.ShopClosed = l__Utilities__1.Signal();
	local u1 = {};
	local u2 = {};
	local u3 = false;
	local v3 = l__Utilities__1.Class({
		ClassName = "NormalShop"
	}, function(p2)
		local v4, v5, v6 = p1.ClientDatabase:PDSFunc("GetMoney");
		p2.Cash = v4;
		p2.Gems = v5;
		p2.ShopList = v6;
		p2.ShopGui = p1.guiholder:WaitForChild("NormalShop");
		p2.Scroller = p2.ShopGui.Holder.Scroller;
		p2.Prompt = p2.ShopGui.Prompt;
		p1.Gui:PushButton(p2.Prompt.Buy);
		p1.Gui:PushButton(p2.Prompt.Cancel);
		p2.Prompt.Visible = false;
		p2:UpdateMoney();
		u1.CloseClick = p2.ShopGui.Close.MouseButton1Click:Connect(function()
			if p2.PromptShown then
				u3 = false;
				p1.Sound:Play("Boop", 0.8);
				p2.Prompt:TweenPosition(UDim2.new(0.5, 0, -2, 0), "Out", "Quad", 0.5, true);
				p2.PromptShown = nil;
				return;
			end;
			u3 = false;
			p1.Sound:Play("Boop", 0.8);
			p2.ShopGui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.ShopGui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			p2:Destroy();
		end);
		u1.CloseHover = p2.ShopGui.Close.MouseEnter:Connect(function()
			p2.ShopGui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p2.ShopGui.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = p2.ShopGui.Close.MouseLeave:Connect(function()
			p2.ShopGui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.ShopGui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p2.Prompt = p2.ShopGui.Prompt;
		p2.Desc = p2.Prompt.ItemInfo.Desc;
		p2.Prompt.Visible = false;
		p2.ShopGui.Position = UDim2.new(0.5, 0, -1.5, 0);
		p2.ShopGui.Visible = true;
		u1.ChangeSize = p2.ShopGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p2:UISize();
		end);
		p2:UISize();
		p2:FillOut();
		p2.ShopGui:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
		return p2;
	end);
	local l__ItemList__4 = p1.ItemList;
	function v3.GetTotalPrice(p3, p4)
		return l__Utilities__1.AddComma(p4 * l__ItemList__4[p3].Price);
	end;
	local function u5()
		for v7, v8 in pairs(u2) do
			v8:Disconnect();
		end;
	end;
	local u6 = false;
	function v3.SetPrompt(p5, p6, p7)
		p7 = p7 or {};
		u5();
		p5.PromptShown = true;
		local l__ItemInfo__9 = p5.Prompt.ItemInfo;
		local l__PromptInfo__10 = p5.Prompt.PromptInfo;
		local l__TextBox__11 = l__PromptInfo__10.Amount.TextBox;
		local v12 = l__ItemList__4[p6];
		l__TextBox__11.Text = 1;
		if v12.RobuxOnly then
			l__PromptInfo__10.Amount.Visible = false;
			l__PromptInfo__10.Label.Visible = false;
		else
			l__PromptInfo__10.Amount.Visible = true;
			l__PromptInfo__10.Label.Visible = true;
		end;
		p1.Gui:ChangeText(l__ItemInfo__9.Desc.ItemName, p6);
		p1.Gui:ChangeText(l__ItemInfo__9.Desc.ItemDescription, v12.Description);
		if v12.RobuxOnly then
			p1.Gui:ChangeText(l__PromptInfo__10.Cost, "Cost: R$ " .. p5.GetTotalPrice(p6, 1));
		else
			p1.Gui:ChangeText(l__PromptInfo__10.Cost, "Cost: $" .. p5.GetTotalPrice(p6, 1));
		end;
		l__ItemInfo__9.Item.Icon.Image = v12.Image;
		local u7 = 1;
		u2.Focused = l__TextBox__11.Focused:Connect(function()
			u3 = true;
			while u3 do
				if l__TextBox__11.Text == "" then
					l__Utilities__1.Halt();
				else
					local l__Text__13 = l__TextBox__11.Text;
					local v14 = tonumber(l__TextBox__11.Text:match("%d+"));
					if v14 == nil then
						l__TextBox__11.Text = 1;
					elseif v14 <= 0 then
						l__TextBox__11.Text = 1;
					elseif v14 > 100 then
						l__TextBox__11.Text = 100;
					end;
					local v15 = math.floor(tonumber(l__TextBox__11.Text:match("%d+")));
					if v15 then
						u7 = v15;
						l__TextBox__11.Text = v15;
						p1.Gui:ChangeText(l__PromptInfo__10.Cost, "Cost: $" .. p5.GetTotalPrice(p6, u7));
						tonumber(l__TextBox__11.Text:match("%d+"));
					end;
					l__Utilities__1.Halt();
				end;			
			end;
		end);
		u2.FocusLost = l__TextBox__11.FocusLost:Connect(function()
			if l__TextBox__11.Text == "" then
				l__TextBox__11.Text = 1;
			end;
			u3 = false;
		end);
		u2.Purchased = p5.Prompt.Buy.MouseButton1Click:Connect(function()
			if u6 == false then
				u6 = true;
				if v12.RobuxOnly and v12.DevProduct then
					p1.Services.MarketplaceService:PromptProductPurchase(p1.p, v12.DevProduct);
				elseif p5.Cash < u7 * v12.Price then
					p1.Sound:Play("PurchaseFail");
					p1.Gui:SayText("Shopkeeper", "You don't have enough cash...", nil, true);
					p1.Dialogue:Hide();
				else
					p1.Gui:LoadingIcon();
					local v16, v17 = p1.Network:get("PurchaseItem", p6, u7);
					p1.Gui:LoadingIconOff();
					if v16 == true then
						p1.Sound:Play("PurchaseSuccess");
						p5.Cash = v17;
						p5:UpdateMoney();
						p1.Gui:SayText("Shopkeeper", "Thank you for your purchase!", nil, true);
						p1.Dialogue:Hide();
					else
						p1.Sound:Play("PurchaseFail");
					end;
				end;
				u6 = false;
			end;
		end);
		u2.Cancel = p5.Prompt.Cancel.MouseButton1Click:Connect(function()
			if u6 == true then
				return;
			end;
			u3 = false;
			p1.Sound:Play("Boop", 0.8);
			p5.Prompt:TweenPosition(UDim2.new(0.5, 0, -2, 0), "Out", "Quad", 0.5, true);
			p5.PromptShown = nil;
		end);
		p5.Prompt.Position = UDim2.new(0.5, 0, -2, 0);
		p5.Prompt.Visible = true;
	end;
	function v3.FillOut(p8)
		local v18 = false;
		if p8.ShopList then
			local v19, v20, v21 = pairs(p8.ShopList);
			while true do
				local v22, v23 = v19(v20, v21);
				if not v22 then
					break;
				end;
				local v24 = v23[1];
				local v25 = v23[2];
				local v26 = l__ItemList__4[v24];
				local v27 = p1.GuiObjs.ItemFrame:Clone();
				v27.Name = v24;
				if v25 % 2 == 1 then
					v27.BackgroundColor3 = Color3.fromRGB(171, 137, 74);
				else
					v27.BackgroundColor3 = Color3.fromRGB(0, 85, 127);
				end;
				local v28 = "$";
				if v26.RobuxOnly then
					v28 = "R$ ";
				end;
				p1.Gui:ChangeText(v27.Desc.ItemName, v24);
				p1.Gui:ChangeText(v27.Desc.Price, v28 .. l__Utilities__1.AddComma(v26.Price));
				v27.Item.Icon.Image = v26.Image;
				v27.LayoutOrder = v25;
				v27.Parent = p8.Scroller;
				local u8 = v18;
				v27.MouseButton1Click:Connect(function()
					if u8 == false and not v26.RobuxOnly then
						u8 = true;
						p1.Sound:Play("BasicClick");
						p8:SetPrompt(v24);
						p1.Services.RunService.RenderStepped:wait();
						p8.Prompt:TweenPosition(UDim2.new(0.5, 0, 0.551, 0), "Out", "Quad", 0.5, true);
						u8 = false;
						l__Utilities__1.Halt(0.5);
						return;
					end;
					if u8 == false and v26.RobuxOnly then
						u8 = true;
						p1.Sound:Play("BasicClick");
						p8:SetPrompt(v24, v26);
						p1.Services.RunService.RenderStepped:wait();
						p8.Prompt:TweenPosition(UDim2.new(0.5, 0, 0.551, 0), "Out", "Quad", 0.5, true);
						l__Utilities__1.Halt(0.5);
						u8 = false;
					end;
				end);			
			end;
		end;
		p8.Scroller.CanvasSize = UDim2.new(0, 0, 0, p8.Scroller.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v3.UpdateMoney(p9)
		p1.Gui:ChangeText(p9.ShopGui.Holder.Cash, "$" .. l__Utilities__1.AddComma(p9.Cash));
	end;
	function v3.UISize(p10)
		local l__Y__29 = p10.Desc.ItemName.TextBounds.Y;
		p10.Desc.ItemDescription.TextSize = l__Y__29;
		p10.Desc.ItemDescription.DropShadow.TextSize = l__Y__29;
	end;
	local function u9()
		for v30, v31 in pairs(u1) do
			v31:Disconnect();
		end;
	end;
	local function u10(p11)
		for v32, v33 in pairs(p11:GetChildren()) do
			if v33:IsA("GuiObject") then
				v33:Destroy();
			end;
		end;
	end;
	function v3.Destroy(p12)
		u5();
		u9();
		p12.ShopGui:TweenPosition(UDim2.new(0.5, 0, -1.5, 0), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.5);
		u10(p12.Scroller);
		p12.ShopGui.Visible = false;
		p1.ShopClosed:Fire();
		p12.Cash = nil;
		p12.ShopList = nil;
		setmetatable(p12, nil);
	end;
	return v3;
end;
