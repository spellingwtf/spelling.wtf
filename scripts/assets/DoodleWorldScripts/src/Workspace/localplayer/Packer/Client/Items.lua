-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = "Capsules";
	local v2 = l__Utilities__1.Class({
		ClassName = "ItemPage"
	}, function(p2)
		p2.ItemUI = p1.guiholder.ItemUI;
		p2.ItemUI.Position = UDim2.new(0.5, 0, 0.5, -18);
		if p2.Menu then
			p2.ItemUI.Position = UDim2.new(0.5, 0, -1, 0);
		end;
		p1.Gui:ChangeText(p2.ItemUI.BottomBar.Say, "");
		p2.ItemHolder = p2.ItemUI.ItemHolder;
		p2.Scroller = p2.ItemHolder.Scroller;
		for v3, v4 in pairs(p2.ItemUI.TopBar.ButtonHolder:GetChildren()) do
			if v4:IsA("GuiObject") then
				v4.Border.Bottom.Visible = true;
				v4.AutoButtonColor = true;
				u1[v4] = v4.MouseButton1Click:Connect(function()
					if u2 ~= v4.Name then
						p2:ResetButtons();
						p2:Page(v4.Name);
					end;
				end);
			end;
		end;
		p2:ResetButtons();
		p2:Page(u2);
		u1.CloseEnter = p2.ItemUI.Close.MouseEnter:Connect(function()
			p2.ItemUI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		u1.CloseLeave = p2.ItemUI.Close.MouseLeave:Connect(function()
			p2.ItemUI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u1.CloseClick = p2.ItemUI.Close.MouseButton1Click:Connect(function()
			if p1.Process then
				return;
			end;
			p1.Sound:Play("BasicClick");
			p2:Destroy();
			if p2.Battle then
				p1.guiholder.MainBattle.Visible = true;
				return;
			end;
			p1.Menu:EnableActive();
		end);
		p2.ItemUI.Visible = true;
		l__Utilities__1.FastSpawn(function()
			if p2.Menu then
				p1.Gui:ChangeText(p2.ItemUI.BottomBar.Say, p2.String);
				return;
			end;
			p1.Gui:Say(p2.ItemUI.BottomBar.Say, p2.String, 3);
		end);
		if p2.Menu then
			p2.ItemUI:TweenPosition(UDim2.new(0.5, 0, 0.5, -54), "Out", "Quad", 0.5, true);
		end;
		return p2;
	end);
	function v2.GetButton(p3, p4)
		return p3.ItemUI.TopBar.ButtonHolder[p4];
	end;
	function v2.ResetButtons(p5)
		for v5, v6 in pairs(p5.ItemUI.TopBar.ButtonHolder:GetChildren()) do
			if v6:IsA("GuiObject") then
				v6.Border.Bottom.Visible = true;
				v6.AutoButtonColor = true;
				if v6.Border:FindFirstChild("Right") then
					v6.Border.Right.Visible = true;
				end;
			end;
		end;
	end;
	local u3 = {};
	function v2.Wipe(p6)
		for v7, v8 in pairs(u3) do
			v7:Destroy();
		end;
		u3 = {};
	end;
	local u4 = nil;
	function v2.DestroyChoice(p7)
		if u4 then
			u4:Destroy();
		end;
	end;
	function v2.Resize(p8)
		local l__UIGridLayout__9 = p8.Scroller.UIGridLayout;
		local v10 = p8.ItemHolder.AbsoluteSize.X / 6;
		l__UIGridLayout__9.CellPadding = UDim2.new(0, 10, 0, 10);
		l__UIGridLayout__9.CellSize = UDim2.new(0, v10 - 5 - 12, 0, v10 - 5 - 12);
	end;
	function v2.Hide(p9)
		p9:DestroyChoice();
		p9.ItemUI.Visible = false;
	end;
	function v2.Show(p10, p11, p12)
		p10.Party = p11 or p10.Party;
		p10.Items = p12 or p10.Items;
		p10:Page(u2);
		p10.ItemUI.Visible = true;
	end;
	function v2.Update(p13, p14, p15)
		p13.Party = p14 or p13.Party;
		p13.Items = p15 or p13.Items;
		p13:Page(u2, true);
	end;
	function v2.GridSize(p16)
		p16.Scroller.CanvasSize = UDim2.new(0, 0, 0, p16.Scroller.UIGridLayout.AbsoluteContentSize.Y);
	end;
	local l__OverworldChoice__5 = p1.GuiObjs.OverworldChoice;
	local l__ScrollList__6 = p1.ScrollList;
	function v2.OverworldChoice(p17, p18, p19, p20)
		p17:DestroyChoice();
		u4 = l__OverworldChoice__5:Clone();
		for v11, v12 in pairs(u4:GetChildren()) do
			if v12:IsA("ImageButton") then
				p1.Gui:TextHover(v12.Label);
				p1.Gui:Hover(v12);
			end;
		end;
		u4.Cancel.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p17:DestroyChoice();
		end);
		u4.Give.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p17:DestroyChoice();
			p17:Hide();
			p1.Party.new({
				Manual = true, 
				Item = p17, 
				Party = p17.Party, 
				String = "Which Doodle should hold " .. p18 .. "?", 
				GivingItem = p18
			});
		end);
		local u7 = false;
		u4.Use.MouseButton1Click:Connect(function()
			if u7 == false and not p1.Process then
				u7 = true;
				p1.Sound:Play("BasicClick");
				local v13 = p1.ItemList[p18];
				if table.find(l__ScrollList__6, p18) then
					p17:Hide();
					p1.Party.new({
						Manual = true, 
						Item = p17, 
						Party = p17.Party, 
						String = "Who should learn " .. p18 .. "?", 
						Scroll = p18
					});
				elseif p18 ~= "Roulette Ticket" then
					if v13.BattleOnly then
						p1.Gui:Say(p17.ItemUI.BottomBar.Say, "You can only use this item in battles!", 3);
					elseif v13.Type == "HeldItem" then
						p1.Gui:Say(p17.ItemUI.BottomBar.Say, "You can only give this item to a Doodle!", 3);
					else
						p17:Hide();
						p1.Party.new({
							Manual = true, 
							Item = p17, 
							Party = p17.Party, 
							String = "Who do you want to use " .. p18 .. " on?", 
							UsingItem = p18, 
							Amount = p20
						});
					end;
				end;
				u7 = false;
			end;
		end);
		u4.Position = UDim2.new(0, p19.X, 0, p19.Y);
		u4.Parent = p1.guiholder;
	end;
	local l__BattleChoice__8 = p1.GuiObjs.BattleChoice;
	local u9 = {
		[true] = "On", 
		[false] = "Off"
	};
	function v2.BattleChoice(p21, p22, p23, p24, p25)
		p21:DestroyChoice();
		local v14 = p1.ItemList[p22];
		u4 = l__BattleChoice__8:Clone();
		for v15, v16 in pairs(u4:GetChildren()) do
			if v16:IsA("ImageButton") then
				p1.Gui:TextHover(v16.Label);
				p1.Gui:Hover(v16);
			end;
		end;
		if v14 and v14.Type == "Toggleable" then
			p1.Gui:ChangeText(u4.Use.Label, "Toggle");
		end;
		u4.Cancel.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p21:DestroyChoice();
		end);
		local u10 = false;
		u4.Use.MouseButton1Click:Connect(function()
			if u10 == false then
				u10 = true;
				p1.Sound:Play("BasicClick");
				if p25 == "Scrolls" then
					if p21.Battle ~= nil then
						p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You can't use scrolls while in battle!", 3);
					else
						p21:Hide();
						p1.Party.new({
							Manual = true, 
							Item = p21, 
							Party = p21.Party, 
							String = "Who should learn " .. p22 .. "?", 
							Scroll = p22
						});
					end;
				elseif v14.Type == "OverworldOnly" and p21.Battle ~= nil then
					p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You can't use this item while in battle!", 3);
				elseif v14.LocalFunction then
					p21:DestroyChoice();
					v14.LocalFunction(p1, p21);
				elseif v14.SpecialFunction then
					p21:DestroyChoice();
					v14.SpecialFunction(p1, p21);
				elseif v14.Type == "Toggleable" then
					if p21.Battle == nil then
						local v17 = p1.Network:get("ToggleItem", p22);
						if p24 then
							p1.Gui:ChangeText(p24.Amount, u9[v17]);
						end;
						if v17 == true then
							p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You have turned " .. p22 .. " on.");
						else
							p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You have turned " .. p22 .. " off.");
						end;
					else
						p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You can't change the " .. p22 .. "'s settings while in battle!");
					end;
				elseif v14.Target == "Capsule" then
					if p21.Battle and p21.Battle.BattleData.nocatch then
						p1.Gui:Say(p21.ItemUI.BottomBar.Say, "For some reason, you can't use capsules in this battle!", 3);
					elseif p21.Battle.BattleType == "Wild" then
						if not p1.ClientDatabase:PDSFunc("IsMaximum") then
							p21.Battle:MadeAction({
								User = p21.DoodleBattling.ID, 
								ActionType = "Item", 
								Action = p22
							});
							p21:Destroy();
							p1.guiholder.MainBattle.Visible = true;
						else
							p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You have no space left for any Doodles!", 3);
						end;
					elseif v14.Type == "HeldItem" then
						p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You can't use this item in battle!", 3);
					else
						p1.Gui:Say(p21.ItemUI.BottomBar.Say, "You can't capture other tamer's doodles!", 5);
					end;
				elseif v14.Target == "Out" then
					p21.Battle:MadeAction({
						User = p21.DoodleBattling.ID, 
						ActionType = "Item", 
						Action = p22, 
						Target = p21.DoodleBattling.ID
					});
					p21:Destroy();
					p1.guiholder.MainBattle.Visible = true;
				elseif v14.NonPartyFunc then
					v14.NonPartyFunc(p1, p21);
				else
					p21:Hide();
					p1.Party.new({
						DoodleBattling = p21.DoodleBattling, 
						Manual = true, 
						Battle = p21.Battle, 
						Item = p21, 
						Party = p21.Party, 
						String = "Who do you want to use " .. p22 .. " on?", 
						UsingItem = p22
					});
				end;
				u10 = false;
			end;
		end);
		u4.Position = UDim2.new(0, p23.X, 0, p23.Y);
		u4.Parent = p1.guiholder;
	end;
	local l__Item__11 = p1.GuiObjs.Item;
	local l__Moves__12 = p1.Moves;
	function v2.CreateButton(p26, p27, p28)
		local l__Amount__18 = p28.Amount;
		local v19 = p28.LO;
		local v20 = l__Item__11:Clone();
		local v21 = p1.ItemList[p27];
		local v22 = Color3.fromRGB(255, 255, 255);
		local v23 = nil;
		if table.find(l__ScrollList__6, p27) then
			v21 = p1.ItemList.Scroll;
			v23 = l__Moves__12[p27];
			v22 = p1.Typings.Visual[v23.Type].Color;
			v19 = table.find(l__ScrollList__6, p27);
		end;
		v20.LayoutOrder = v19;
		u3[v20] = p27;
		v20.Icon.Image = v21.Image;
		p1.Gui:ChangeText(v20.Title, p27);
		v20.Icon.ImageColor3 = v22;
		if v21.InfiniteUses == true then
			v20.Amount.Visible = false;
		elseif typeof(l__Amount__18) == "boolean" then
			v20.Amount.Size = UDim2.new(0.5, 0, 0.4, 0);
			p1.Gui:ChangeText(v20.Amount, u9[l__Amount__18]);
		else
			p1.Gui:ChangeText(v20.Amount, "x" .. l__Amount__18);
		end;
		local u13 = p1.Gui:DarkerColor(v22);
		v20.MouseEnter:Connect(function()
			v20.Icon.ImageColor3 = u13;
		end);
		v20.MouseLeave:Connect(function()
			v20.Icon.ImageColor3 = v22;
		end);
		v20.MouseButton1Click:Connect(function()
			if p1.Process then
				return;
			end;
			p1.Sound:Play("BasicClick");
			if not (not p26.Battle) or v21.Type == "Toggleable" or v21.Category == "Key Items" or v21.Category == "Scrolls" or p27 == "Roulette Ticket" then
				p26:BattleChoice(p27, p1.p:GetMouse(), v20, v21.Category);
			else
				p26:OverworldChoice(p27, p1.p:GetMouse(), l__Amount__18);
			end;
			l__Utilities__1.FastSpawn(function()
				if v23 then
					if p26.Battle then
						return;
					end;
				else
					p1.Gui:Say(p26.ItemUI.BottomBar.Say, v21.Description, 5);
					return;
				end;
				p1.Gui:Say(p26.ItemUI.BottomBar.Say, "Teaches a Doodle the move " .. p27 .. ".", 5);
			end);
		end);
		v20.Parent = p26.Scroller;
	end;
	function v2.Page(p29, p30, p31)
		if not p31 then
			p1.Sound:Play("PageFlip");
		end;
		u2 = p30;
		local v24 = p29:GetButton(p30);
		if v24.Border:FindFirstChild("Right") then
			v24.Border.Right.Visible = false;
		end;
		v24.Border.Bottom.Visible = false;
		v24.AutoButtonColor = false;
		p29.ItemUI.BackgroundColor3 = v24.BackgroundColor3;
		p29.ItemUI.TopBar.ButtonHolder.BackgroundColor3 = v24.BackgroundColor3;
		p29:DestroyChoice();
		p29:Wipe();
		p29:Resize();
		p1.Gui:ResetSay();
		p1.Gui:ChangeText(p29.ItemUI.BottomBar.Say, "");
		p1.Gui:ChangeText(p29.ItemUI.TopBar.Title, p30);
		for v25, v26 in pairs(p29.Items[p30]) do
			p29:CreateButton(v25, v26, p30);
		end;
		p29:GridSize();
	end;
	function v2.Disconnect(p32)
		for v27, v28 in pairs(u1) do
			if typeof(v28) == "RBXScriptConnection" then
				v28:Disconnect();
			elseif typeof(v28) == "table" then
				v28:Disconnect();
			elseif v28:IsA("Instance") then
				v28:Destroy();
			end;
		end;
	end;
	function v2.Destroy(p33)
		p33.DestroyChoice();
		if p33.Menu then
			p33.ItemUI:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.5, true);
			l__Utilities__1.Halt(0.35);
		end;
		p33:Wipe();
		p33:Disconnect();
		p33.ItemUI.Visible = false;
		p33.Items = nil;
	end;
	return v2;
end;
