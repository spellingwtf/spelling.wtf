-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = false;
	local l__Network__3 = p1.Network;
	local u4 = {};
	local function u5(p2)
		local v2 = {};
		for v3, v4 in pairs(p2) do
			v2[v4] = true;
		end;
		return v2;
	end;
	local v5 = l__Utilities__1.Class({
		ClassName = "SpectateGui"
	}, function(p3)
		p3.UI = p1.guiholder.SpectateUI;
		p3.Holder = p3.UI.Holder;
		p3.Scroller = p3.Holder.Scroller;
		if u2 == false then
			u2 = true;
			u4 = u5((l__Network__3:get("CurrentBattles")));
			l__Network__3:BindEvent("UpdateBattlingPlayers", function(p4, p5)
				u4[p4] = p5;
				if p3.Scroller:FindFirstChild(p4.Name) and p5 == nil then
					p3.Scroller[p4.Name]:Destroy();
				end;
				p3:Update();
			end);
		end;
		u1.CloseClick = p3.UI.Close.MouseButton1Click:Connect(function()
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			if p3 and p3.Destroy then
				p3:Destroy("Closed");
			end;
		end);
		u1.CloseHover = p3.UI.Close.MouseEnter:Connect(function()
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = p3.UI.Close.MouseLeave:Connect(function()
			p3.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p3.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p3.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p3.UI.Visible = true;
		p3.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
		p3:Update();
		return p3;
	end);
	function v5.Update(p6)
		local v6 = 0;
		for v7, v8 in pairs(u4) do
			v6 = v6 + 1;
			p6:Create(v6, v7);
		end;
		p6.Scroller.CanvasSize = UDim2.new(0, 0, 0, p6.Scroller.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v5.Create(p7, p8, p9)
		if p9 == game.Players.LocalPlayer then
			return;
		end;
		if p7.Scroller:FindFirstChild(p9.Name) then
			local v9 = p7.Scroller:FindFirstChild(p9.Name);
			if p8 % 2 == 0 then
				v9.BackgroundColor3 = Color3.fromRGB(230, 126, 34);
			else
				v9.BackgroundColor3 = Color3.fromRGB(52, 152, 219);
			end;
			v9.Desc.Spectate.BackgroundColor3 = p1.Gui:DarkerColor(v9.BackgroundColor3);
			return;
		end;
		local v10 = p1.GuiObjs.PlayerFrame:Clone();
		if p8 % 2 == 0 then
			v10.BackgroundColor3 = Color3.fromRGB(230, 126, 34);
		else
			v10.BackgroundColor3 = Color3.fromRGB(52, 152, 219);
		end;
		v10.Name = p9.Name;
		p1.Gui:ChangeText(v10.Desc.ItemName, "@" .. p9.Name);
		v10.Icon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p9.UserId .. "&width=48&height=48&format=png";
		v10.Parent = p7.Scroller;
		v10.Desc.Spectate.BackgroundColor3 = p1.Gui:DarkerColor(v10.BackgroundColor3);
		v10.Desc.Spectate.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			if l__Network__3:get("SpectateBattle", p9, true) and p7 and p7.Destroy then
				p7:Destroy();
			end;
		end);
	end;
	function v5.ClearAll(p10)
		for v11, v12 in pairs(p10.Scroller:GetChildren()) do
			if v12:IsA("GuiObject") then
				v12:Destroy();
			end;
		end;
	end;
	local function u6()
		for v13, v14 in pairs(u1) do
			v14:Disconnect();
		end;
	end;
	function v5.Destroy(p11, p12)
		u6();
		p11.UI:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.35);
		p11.UI.Visible = false;
		p11:ClearAll();
		if p12 == "Closed" then
			p1.Sound:Play("Boop");
			p1.Items.new({
				Items = p1.ClientDatabase:PDSFunc("GetItems"), 
				Party = p1.ClientDatabase:PDSFunc("GetParty"), 
				Menu = true, 
				String = "This item allows you to spectate other people's battles."
			});
		end;
		p11 = nil;
	end;
	return v5;
end;
