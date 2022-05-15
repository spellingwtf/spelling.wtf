-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = {};
	local function u3()
		for v2, v3 in pairs(u2) do
			v3:Disconnect();
		end;
		u2 = {};
	end;
	local u4 = nil;
	local v4 = l__Utilities__1.Class({}, function(p2)
		u3();
		p2.Amount = p2.Amount and 0;
		u4 = nil;
		p2.UI = p1.guiholder.StatCandy;
		p1.Gui:PushButton(p2.UI.Reroll);
		p1.Gui:AnimateSprite(p2.UI.DoodleImage.DoodleLabel, p2.Doodle, true);
		p1.Gui:ChangeText(p2.UI.DoodleName, l__Utilities__1.GetName(p2.Doodle));
		p1.ColorAnim.Create(p2.UI.DoodleName, p2.Doodle.NameColor);
		p2.UI.DoodleImage.Sparkles.Visible = p2.Doodle.Shiny;
		p2:ClearStars();
		p2:SetupStars();
		u2.CloseHover = p2.UI.Close.MouseEnter:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p2.UI.Close.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u2.CloseLeave = p2.UI.Close.MouseLeave:Connect(function()
			p2.UI.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u2.CloseClick = p2.UI.Close.MouseButton1Click:Connect(function()
			if p2.items then
				p2.Item:Update(p2.newparty, p2.items);
			end;
			p1.Sound:Play("Boop", 0.8);
			p2.UI.Visible = false;
			p2.Party.PartyGui.Visible = true;
			l__Utilities__1.Halt(0.05);
			p2:Destroy();
		end);
		u2.Reroll = p2.UI.Reroll.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p1.Network:BindEvent("StatCandy", function(p3, p4, p5, p6)
				p2.newparty = p5;
				p2.items = p6;
				p1.Network:UnbindEvent("StatCandy");
				p2.Doodle = p3;
				p1.Gui:ChangeText(p2.UI.Reroll.Amount.Label, "x" .. p4);
				p2:UpdateStats();
				if p4 <= 0 then
					p2.Party:Destroy();
					p2.UI.Visible = false;
					p2.Item:Show(p5, p6);
					p2:Destroy();
				end;
			end);
			p1.Network:post("StatCandy", p2.Doodle.ID, u4);
		end);
		p1.Gui:ChangeText(p2.UI.Reroll.Amount.Label, "x" .. p2.Amount);
		p2:UpdateStats();
		p2.UI.Visible = true;
	end);
	local function u5()
		for v5, v6 in pairs(u1) do
			v6:disconnect();
		end;
	end;
	local u6 = { "hp", "atk", "def", "matk", "mdef", "spe" };
	local u7 = {
		eva = "Evasion", 
		acc = "Accuracy", 
		atk = "Attack", 
		def = "Defense", 
		mdef = "Magic Defense", 
		matk = "Magic Attack", 
		spe = "Speed", 
		hp = "Health"
	};
	local u8 = {
		[0.95] = "-5%", 
		[0.9] = "-10%", 
		[1.05] = "+5%", 
		[1.1] = "+10%"
	};
	local u9 = {
		[0.95] = Color3.fromRGB(255, 85, 0), 
		[0.9] = Color3.fromRGB(255, 0, 0), 
		[1.05] = Color3.fromRGB(85, 255, 0), 
		[1.1] = Color3.fromRGB(96, 198, 254)
	};
	function v4.UpdateStats(p7)
		local v7 = nil;
		u5();
		for v8, v9 in pairs(u6) do
			if p7.Doodle.StatBoosts[v9] then
				local v10 = p7.Doodle.StatBoosts[v9];
				if not v7 then
					v7 = true;
					local v11 = p7.UI.StatBoosts.Holder.Stat1;
				else
					v11 = p7.UI.StatBoosts.Holder.Stat2;
				end;
				if u4 == v9 then
					v11.Preserve.ImageTransparency = 0;
				else
					v11.Preserve.ImageTransparency = 0.8;
				end;
				local l__Label__12 = v11.Label;
				u1[v11.Name .. "Enter"] = v11.Preserve.MouseEnter:Connect(function()
					if u4 ~= v9 then
						v11.Preserve.ImageTransparency = 0;
					end;
				end);
				u1[v11.Name .. "Leave"] = v11.Preserve.MouseLeave:Connect(function()
					if u4 ~= v9 then
						v11.Preserve.ImageTransparency = 0.8;
					end;
				end);
				u1[v11.Name .. "Click"] = v11.Preserve.MouseButton1Click:Connect(function()
					if u4 ~= v9 then
						u4 = v9;
						p1.Sound:Play("BasicClick");
						p7:UpdateStats();
						return;
					end;
					u4 = nil;
					p1.Sound:Play("BasicClick");
					p7:UpdateStats();
				end);
				l__Label__12.TextColor3 = u9[v10];
				p1.Gui:ChangeText(l__Label__12, u8[v10] .. " " .. u7[v9]);
			end;
		end;
	end;
	function v4.ClearStars(p8)
		for v13, v14 in pairs(p8.UI.DoodleImage.Rank:GetChildren()) do
			if v14:IsA("GuiObject") then
				v14:Destroy();
			end;
		end;
	end;
	function v4.SetupStars(p9)
		local l__Rank__15 = p9.UI.DoodleImage.Rank;
		local v16 = l__Rank__15.AbsoluteSize.Y / 3 * 2;
		for v17 = 1, p9.Doodle.Star do
			p1.GuiObjs.Star:Clone().Parent = l__Rank__15;
		end;
		l__Rank__15.UIGridLayout.CellSize = UDim2.new(0, v16, 0, v16);
	end;
	function v4.Destroy(p10)
		u3();
		p10.Party:UpdateDoodle(p10.Doodle);
		for v18, v19 in pairs(p10) do
			p10[v18] = nil;
		end;
		setmetatable(p10, nil);
	end;
	return v4;
end;
