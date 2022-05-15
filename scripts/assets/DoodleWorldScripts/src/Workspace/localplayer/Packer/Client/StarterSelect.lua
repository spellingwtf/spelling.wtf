-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local u1 = nil;
	local u2 = {
		Pupskey = "Balanced", 
		Vipember = "Bulky Mage", 
		Tabbolt = "Speedster", 
		Skrappey = "Bulky Attacker"
	};
	function v1.SetupSelection(p2, p3)
		u1 = p3;
		local v2 = p1.ClientDatabase:GetDoodleInfo(p3).Type[1];
		p1.Gui:AnimateSprite(p2.Doodle.DoodleLabel, {
			Name = p3
		}, true);
		p1.Gui:ChangeText(p2.Doodle.DoodleType, "Type: " .. v2);
		p2.Doodle.DoodleType.TextColor3 = p1.Typings.Visual[v2].Color;
		p1.Gui:ChangeText(p2.Doodle.DoodleName, p3);
		p1.Gui:ChangeText(p2.Doodle.DoodleStrengths, u2[p3]);
	end;
	local u3 = { "Pupskey", "Vipember", "Tabbolt", "Skrappey" };
	local l__Utilities__4 = p1.Utilities;
	local l__Tween__5 = p1.Tween;
	local function u6(p4)
		for v3, v4 in pairs(u3) do
			if v4 == p4 then
				return v3;
			end;
		end;
	end;
	local u7 = {
		Vipember = 1197967014, 
		Tabbolt = 1197967122, 
		Skrappey = 1197967124, 
		Pupskey = 1197967123
	};
	function v1.Boot(p5, p6)
		p1.ObjectiveUI:Hide();
		local v5 = l__Utilities__4.Signal();
		local u8 = true;
		local u9 = "Booting";
		l__Utilities__4.FastSpawn(function()
			while u8 == true do
				for v6 = 1, 3 do
					p1.Gui:ChangeText(p5.Booting, u9 .. string.rep(".", v6));
					l__Utilities__4.Halt(0.15);
				end;			
			end;
		end);
		l__Tween__5:MakeTween(p5.Background.ProgressBar.Clipping, {
			Size = UDim2.new(1, 0, 1, 0)
		}, true, 4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		l__Utilities__4.Halt(1);
		u9 = "Setting up colors";
		l__Utilities__4.Halt(1);
		u9 = "Retrieving doodle data";
		l__Utilities__4.Halt(1);
		u9 = "Almost finished";
		l__Utilities__4.Halt(1);
		u8 = false;
		l__Utilities__4.Halt(1.5);
		u9 = "All done!";
		p1.Gui:ChangeText(p5.Booting, u9);
		l__Utilities__4.Halt(2);
		p1.Gui:Hover(p5.Left);
		p1.Gui:Hover(p5.Right);
		p5.Left.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			local v7 = u6(u1) - 1;
			if v7 <= 0 then
				v7 = 4;
			end;
			v1.SetupSelection(p5, u3[v7]);
		end);
		p5.Right.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			local v8 = u6(u1) + 1;
			if #u3 < v8 then
				v8 = 1;
			end;
			v1.SetupSelection(p5, u3[v8]);
		end);
		local v9 = UDim2.new(0.5, 0, 0.5, 6);
		local u10 = UDim2.new(0.9, 0, 0.95, 0);
		p5.Pick.MouseButton1Down:Connect(function()
			if p6 == "FirstStarter" then
				p1.Sound:Play("Boop", 1);
				p5.Pick:TweenPosition(u10 + UDim2.new(0, 0, 0, 6), "Out", "Linear", 0.1, true);
				p5.Pick.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
				v5:Fire();
			end;
		end);
		p5.Pick.MouseButton1Up:Connect(function()
			p5.Pick:TweenPosition(u10, "Out", "Linear", 0.1, true);
			p5.Pick.Border:TweenPosition(v9, "Out", "Linear", 0.1, true);
		end);
		p5.Pick.MouseLeave:Connect(function()
			p5.Pick:TweenPosition(u10, "Out", "Linear", 0.1, true);
			p5.Pick.Border:TweenPosition(v9, "Out", "Linear", 0.1, true);
		end);
		p5.Purchase.MouseButton1Down:Connect(function()
			if p6 == "Purchase" then
				p1.Sound:Play("Boop", 1);
				p5.Purchase:TweenPosition(u10 + UDim2.new(0, 0, 0, 6), "Out", "Linear", 0.1, true);
				p5.Purchase.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
				if p1.ClientDatabase:PDSFunc("IsMaximum") then
					p1.Gui:TextAnnouncement("You have no space for any more Doodles.");
					return;
				end;
			else
				return;
			end;
			p1.Services.MarketplaceService:PromptProductPurchase(p1.p, u7[u1]);
		end);
		p5.Purchase.MouseButton1Up:Connect(function()
			p5.Purchase:TweenPosition(u10, "Out", "Linear", 0.1, true);
			p5.Purchase.Border:TweenPosition(v9, "Out", "Linear", 0.1, true);
		end);
		p5.Purchase.MouseLeave:Connect(function()
			p5.Purchase:TweenPosition(u10, "Out", "Linear", 0.1, true);
			p5.Purchase.Border:TweenPosition(v9, "Out", "Linear", 0.1, true);
		end);
		p5.Close.MouseButton1Down:Connect(function()
			p5.Purchase.Visible = false;
			p5.Close.Visible = false;
			v5:Fire();
		end);
		p5.Background.ProgressBar.Visible = false;
		p5.Booting.Visible = false;
		v1.SetupSelection(p5, "Pupskey");
		p5.Doodle.Visible = true;
		p5.Left.Visible = true;
		p5.Right.Visible = true;
		if p6 == "FirstStarter" then
			p5.Pick.Visible = true;
		else
			p5.Purchase.Visible = true;
			p5.Close.Visible = true;
		end;
		v5:Wait();
		p1.ObjectiveUI:Show();
		return u1;
	end;
	return v1;
end;
