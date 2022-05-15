-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = nil;
	local u2 = {};
	local function u3()
		if u1 then
			u1:Disconnect();
		end;
		for v2, v3 in pairs(u2) do
			v3:Disconnect();
		end;
		u2 = {};
	end;
	local u4 = "Helmet";
	local v4 = l__Utilities__1.Class({
		ClassName = "EquipPage"
	}, function(p2)
		u3();
		local v5 = UDim2.new(0.9, 0, 0.5, 0);
		local v6 = UDim2.new(0.5, 0, 0.5, 4);
		u4 = p2.ForcePage;
		p2.Equipment = p1.ClientDatabase:PDSFunc("GetEquipment");
		p2.UI = p1.guiholder:WaitForChild("EquipmentUI");
		p2.Holder = p2.UI.Holder;
		p2.Scroller = p2.Holder.Scroller;
		p1.Gui:PushButton(p2.UI.UnequipAll);
		u2.UnequipAll = p2.UI.UnequipAll.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p1.Network:BindEvent("UpdateEquipment", function(p3, p4)
				p1.Network:UnbindEvent("UpdateEquipment");
				p2.Equipment = p3;
				p2:Page(u4);
				if p4 then
					if p2.Stats then
						p2.Stats.Doodle = p4;
						p2.Stats:UpdateHealth();
						p2.Stats:EquipPage();
					end;
					if p2 and p2.Party and p2.Party.UpdateDoodle then
						local v7 = p2.Party:UpdateDoodle(p4, p2.CurrentBox);
						if not p2.PC then
							p2.Party:UpdateAll();
							return;
						end;
						if p2.PC then
							p2.PC:UpdatePC();
						end;
					end;
				end;
			end);
			if not p2.Doodle then
				p1.Network:post("UnequipAll", u4);
				return;
			end;
			p1.Network:post("UnequipAll", u4, p2.Doodle.ID);
		end);
		u2.CloseEnter = p2.UI.Close.MouseEnter:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		u2.CloseLeave = p2.UI.Close.MouseLeave:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u2.CloseClick = p2.UI.Close.MouseButton1Click:Connect(function()
			if p2.Equipping then
				return;
			end;
			p1.Sound:Play("Boop", 0.8);
			p2:Destroy();
		end);
		u2.EquipDown = p2.UI.BottomBar.Equip.MouseButton1Down:Connect(function()
			p2.UI.BottomBar.Equip:TweenPosition(v5 + UDim2.new(0, 0, 0, 4), "Out", "Linear", 0.1, true);
			p2.UI.BottomBar.Equip.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
		end);
		u2.EquipUp = p2.UI.BottomBar.Equip.MouseButton1Up:Connect(function()
			p2.UI.BottomBar.Equip:TweenPosition(v5, "Out", "Linear", 0.1, true);
			p2.UI.BottomBar.Equip.Border:TweenPosition(v6, "Out", "Linear", 0.1, true);
		end);
		u2.EquipLeave = p2.UI.BottomBar.Equip.MouseLeave:Connect(function()
			p2.UI.BottomBar.Equip:TweenPosition(v5, "Out", "Linear", 0.1, true);
			p2.UI.BottomBar.Equip.Border:TweenPosition(v6, "Out", "Linear", 0.1, true);
		end);
		for v8, v9 in pairs(p2.UI.TopBar.ButtonHolder:GetChildren()) do
			if v9:IsA("GuiObject") then
				v9.Border.Bottom.Visible = true;
				v9.AutoButtonColor = true;
				u2[v9] = v9.MouseButton1Click:Connect(function()
					if u4 ~= v9.Name then
						p2:ResetButtons();
						p2:Page(v9.Name);
					end;
				end);
			end;
		end;
		p2:Page(u4);
		p2.UI.Visible = true;
		return p2;
	end);
	function v4.Destroy(p5)
		u3();
		p5.UI.Visible = false;
		if p5.Stats then
			p5.Stats.Gui.Visible = true;
		elseif p5.Bag then
			p5.Bag.ItemUI.Visible = true;
		end;
		setmetatable(p5, nil);
	end;
	function v4.Page(p6, p7)
		p1.Sound:Play("PageFlip");
		u4 = p7;
		p1.Gui:ChangeText(p6.UI.UnequipAll.Ready, "Unequip All " .. p7 .. "s");
		local v10 = p6:GetButton(p7);
		if v10.Border:FindFirstChild("Right") then
			v10.Border.Right.Visible = false;
		end;
		v10.Border.Bottom.Visible = false;
		v10.AutoButtonColor = false;
		p6.UI.BackgroundColor3 = v10.BackgroundColor3;
		p6.UI.TopBar.ButtonHolder.BackgroundColor3 = v10.BackgroundColor3;
		p6:Wipe();
		p6:Resize();
		p1.Gui:ResetSay();
		p6.UI.BottomBar.Equip.Visible = false;
		p1.Gui:ChangeText(p6.UI.BottomBar.EquipName, "");
		p1.Gui:ChangeText(p6.UI.BottomBar.EquipStats, "");
		p1.Gui:ChangeText(p6.UI.TopBar.Title, p7);
		for v11, v12 in pairs(p6.Equipment[p7]) do
			p6:CreateButton(v11, v12, p7);
		end;
		p6:GridSize();
	end;
	local l__Item__5 = p1.GuiObjs.Item;
	local u6 = {};
	function v4.CreateButton(p8, p9, p10, p11)
		local v13 = p1.Equipment:LookUp(p9, p11);
		if not v13 then
			return;
		end;
		local l__Name__14 = v13.Name;
		local v15 = l__Item__5:Clone();
		local v16 = Color3.fromRGB(255, 255, 255);
		v15.LayoutOrder = p10.LO;
		u6[v15] = l__Name__14;
		v15.Icon.Image = v13.Image;
		p1.Gui:ChangeText(v15.Title, l__Name__14);
		v15.Icon.ImageColor3 = v16;
		p1.Gui:ChangeText(v15.Amount, "x" .. p10.Amount);
		local u7 = p1.Gui:DarkerColor(v16);
		v15.MouseEnter:Connect(function()
			v15.Icon.ImageColor3 = u7;
		end);
		v15.MouseLeave:Connect(function()
			v15.Icon.ImageColor3 = v16;
		end);
		v15.MouseButton1Click:Connect(function()
			p8.UI.BottomBar.Equip.Visible = false;
			if p1.Process then
				return;
			end;
			p1.Sound:Play("BasicClick");
			l__Utilities__1.FastSpawn(function()
				p1.Gui:Say(p8.UI.BottomBar.EquipName, v13.Name, 5);
			end);
			if not p8.Doodle then
				p1.Gui:Say(p8.UI.BottomBar.EquipStats, v13.Info .. ". Go to a Doodle's stat page to equip this item!", 5);
				return;
			end;
			p8.UI.BottomBar.Equip.Visible = true;
			if u1 then
				u1:Disconnect();
			end;
			u1 = p8.UI.BottomBar.Equip.MouseButton1Click:Connect(function()
				if not p8.Doodle then
					return;
				end;
				if p8.Equipping then
					return;
				end;
				p1.Sound:Play("Boop", 0.8);
				p8.Equipping = true;
				if p8.Doodle.Equip[p11] ~= p9 then
					p1.Network:BindEvent("GiveEquipment", function(p12)
						p1.Network:UnbindEvent("GiveEquipment");
						if p8.Stats then
							p8.Stats.Doodle = p12;
							p8.Stats:UpdateHealth();
							p8.Stats:EquipPage();
						end;
						if p8 and p8.Party and p8.Party.UpdateDoodle then
							local v17 = p8.Party:UpdateDoodle(p12, p8.CurrentBox);
							if not p8.PC then
								p8.Party:SetupBox(p8.Party.PartyGui["Party" .. v17]);
							end;
						end;
						p8:Destroy();
						p8.Equipping = false;
					end);
					p1.Network:post("GiveEquipment", p8.Doodle.ID, p9, p11);
					return;
				end;
				p1.Gui:SayText("", l__Utilities__1.GetName(p8.Doodle) .. " already has " .. l__Name__14 .. " equipped!", nil, true);
				p1.Dialogue:Hide();
				p8.Equipping = false;
			end);
			p1.Gui:Say(p8.UI.BottomBar.EquipStats, v13.Info, 5);
		end);
		v15.Parent = p8.Scroller;
	end;
	function v4.Resize(p13)
		local l__UIGridLayout__18 = p13.Scroller.UIGridLayout;
		local v19 = p13.Holder.AbsoluteSize.X / 6;
		l__UIGridLayout__18.CellPadding = UDim2.new(0, 10, 0, 10);
		l__UIGridLayout__18.CellSize = UDim2.new(0, v19 - 5 - 12, 0, v19 - 5 - 12);
	end;
	function v4.GridSize(p14)
		p14.Scroller.CanvasSize = UDim2.new(0, 0, 0, p14.Scroller.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v4.ResetButtons(p15)
		for v20, v21 in pairs(p15.UI.TopBar.ButtonHolder:GetChildren()) do
			if v21:IsA("GuiObject") then
				v21.Border.Bottom.Visible = true;
				v21.AutoButtonColor = true;
				if v21.Border:FindFirstChild("Right") then
					v21.Border.Right.Visible = true;
				end;
			end;
		end;
	end;
	function v4.GetButton(p16, p17)
		return p16.UI.TopBar.ButtonHolder[p17];
	end;
	function v4.Wipe(p18)
		for v22, v23 in pairs(u6) do
			v22:Destroy();
		end;
		u6 = {};
	end;
	return v4;
end;
