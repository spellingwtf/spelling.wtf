-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	p1.Process = false;
	local u1 = false;
	local u2 = nil;
	local u3 = false;
	local u4 = {};
	local u5 = {};
	local u6 = l__Utilities__1.Signal();
	local u7 = l__Utilities__1.Signal();
	local function u8(p2, p3)
		p2.Moves[5] = {
			Name = p3, 
			PPUp = 0, 
			Uses = p1.Moves[p3].Uses
		};
	end;
	local function u9(p4, p5)
		for v2, v3 in pairs(p4) do
			if v3.ID == p5 then
				return v3;
			end;
		end;
		return nil;
	end;
	local function u10(p6, p7, p8)
		local v4 = nil;
		local v5, v6, v7 = pairs(p7);
		while true do
			local v8, v9 = v5(v6, v7);
			if not v8 then
				break;
			end;
			local v10 = false;
			for v11, v12 in pairs(p6) do
				if v9.Name == v12.Name then
					v10 = true;
					break;
				end;
			end;
			if not v10 then
				v4 = v9.Name;
				break;
			end;		
		end;
		if v4 ~= nil and v4 ~= p8 then
			return "MoveForgotten", v4;
		end;
		return "DidNotLearn";
	end;
	local v13 = l__Utilities__1.Class({
		ClassName = "PartyUI"
	}, function(p9)
		u1 = false;
		p1.ClientDatabase:PDSEvent("ToggleBusy", true);
		if not p9.NoColorList then
			local v14, v15 = p1.ClientDatabase:PDSFunc("GetColorList");
			p9.ColorList = v14;
			p9.SkinList = v15;
		end;
		u2 = p1.ColorAnim;
		u3 = false;
		p9.PartyGui = p1.guiholder.PartyUI;
		p9.PartyGui.OtherTimer.Visible = false;
		p9.PartyGui.PlayerTimer.Visible = false;
		if p9.PlayerTimer then
			p9.PartyGui.PlayerTimer.TimerLabel.Text = l__Utilities__1.ConvertTimer(p9.PlayerTimer.Value);
			u4.PlayerTimer = p9.PlayerTimer.Changed:Connect(function()
				p9.PartyGui.PlayerTimer.TimerLabel.Text = l__Utilities__1.ConvertTimer(p9.PlayerTimer.Value);
			end);
			p9.PartyGui.PlayerTimer.Visible = true;
		end;
		if p9.OtherTimer then
			p9.PartyGui.OtherTimer.TimerLabel.Text = l__Utilities__1.ConvertTimer(p9.OtherTimer.Value);
			u4.OtherTimer = p9.OtherTimer.Changed:Connect(function()
				p9.PartyGui.OtherTimer.TimerLabel.Text = l__Utilities__1.ConvertTimer(p9.OtherTimer.Value);
			end);
			p9.PartyGui.OtherTimer.Visible = true;
		end;
		p1.Gui:ResetSay();
		p9.PartyGui.Position = UDim2.new(0.5, 0, 0.5, -36);
		if p9.Menu then
			p9.PartyGui.Position = UDim2.new(0.5, 0, -1, -36);
		end;
		u4.CloseEnter = p9.PartyGui.CloseBar.Cancel.MouseEnter:Connect(function()
			p9.PartyGui.CloseBar.Cancel.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		u4.CloseLeave = p9.PartyGui.CloseBar.Cancel.MouseLeave:Connect(function()
			p9.PartyGui.CloseBar.Cancel.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p9.AllowedChecks = {};
		for v16, v17 in pairs(p9.PartyGui:GetChildren()) do
			if v17.Name:find("Party") then
				table.insert(p9.AllowedChecks, v17);
				if not u5[v17.Name] then
					u5[v17.Name] = v17.Position;
				else
					v17.Position = u5[v17.Name];
				end;
			end;
		end;
		p9:Setup(p9.Party);
		if p9.Manual or p9.Picker then
			u4.Close = p9.PartyGui.CloseBar.Cancel.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick");
				p9:Destroy();
				if p9.Picker then
					p1.GlobalSignal:Fire("None");
					return;
				end;
				if p9.Menu then
					p9.Party = nil;
					p1.Menu:EnableActive();
					return;
				end;
				if p9.Item then
					u6:Fire();
					p9.Item:Show(p9.Party, p9.CurrentItems);
					return;
				end;
				if p9.Battle then
					p1.guiholder.MainBattle.Visible = true;
				end;
			end);
			p9.PartyGui.CloseBar.Cancel.Visible = true;
		else
			p9.PartyGui.CloseBar.Cancel.Visible = false;
		end;
		p9.CurrentlyClicked = nil;
		if p9.String then
			if p9.Menu then
				p1.Gui:ChangeText(p9.PartyGui.BottomBar.Say, p9.String);
			else
				l__Utilities__1.FastSpawn(function()
					p1.Gui:Say(p9.PartyGui.BottomBar.Say, p9.String, 3);
				end);
			end;
		end;
		p1.Network:BindEvent("MoveLearn", function(p10, p11, p12, p13, p14)
			u7:Wait();
			p1.Process = true;
			local v18 = nil;
			for v19, v20 in pairs(p9.Party) do
				if v20.ID == p10 then
					v18 = v20;
					break;
				end;
			end;
			if v18 then
				for v21, v22 in pairs(p11) do
					p1.Gui:SayText("", l__Utilities__1.GetName(v18) .. " learned " .. v22 .. "!", nil, true);
					p1.Talky.Visible = false;
				end;
				local v23 = nil;
				if p12 and #p12 > 0 then
					for v24, v25 in pairs(p12) do
						local u11 = v23;
						p1.Gui:SayChoiceText("", l__Utilities__1.GetName(v18) .. " wants to learn " .. v25 .. " but can't learn more than 4 moves. Make room for " .. v25 .. "?", nil, function()
							p1.Dialogue:Hide();
							u11 = u11 or l__Utilities__1:deepCopy(v18.Moves);
							p1.Menu.Blur();
							p9:Close();
							v18.Moves = u11;
							u8(v18, v25);
							local v26 = {};
							local u12 = l__Utilities__1:deepCopy(v18.Moves);
							function v26.CloseFunc(p15)
								local v27, v28 = p1.Network:get("RemoveExtraMove", p15.ID);
								local v29 = u9(v27, p15.ID);
								if v29 then
									p9:Show(p15);
									local v30, v31 = u10(v29.Moves, u12, v25);
									if v30 == "DidNotLearn" then
										p1.Gui:SayText("", l__Utilities__1.GetName(p15) .. " did not learn " .. v25 .. ".", nil, true);
									elseif v30 == "MoveForgotten" then
										p1.Gui:SayText("", l__Utilities__1.GetName(p15) .. " forgot " .. v31 .. " and learned " .. v25 .. "!", nil, true);
									end;
									p15.Moves[5] = nil;
									u11 = l__Utilities__1:deepCopy(p15.Moves);
									p1.MoveLearn:Fire(v27, v28);
								end;
							end;
							v26.BattleAppear = true;
							v26.LearningMove = true;
							p1.Stats.new(v26, v18);
						end, function()
							l__Utilities__1.FastSpawn(function()
								p1.Gui:SayText("", l__Utilities__1.GetName(v18) .. " did not learn " .. v25 .. ".", nil, true);
								p1.Network:get("RemoveExtraMove", v18.ID);
								p1.MoveLearn:Fire();
							end);
						end, true);
						p1.MoveLearn:Wait();
						if p14 == "MoveRelearner" then

						end;
						p1.Talky.Visible = false;
					end;
				end;
				if p13 then
					p9:Close();
					if p1.Evolution.new({
						Party = p9, 
						Doodle = v18, 
						ItemEvolution = true, 
						Item = p9.UsingItem
					}).Evolved then

					end;
					p1.Camera:Return();
					p1.Gui:FadeFromBlack();
				end;
			end;
			local v32 = false;
			if not p9.Battle and p9.Item then
				u6:Fire();
				local v33 = p1.ItemList[p9.UsingItem];
				if v33 and v33.LevelupItem and p9.CurrentItems[v33.Category][p9.UsingItem] and p9.CurrentItems[v33.Category][p9.UsingItem].Amount > 0 then
					v32 = true;
				end;
				if not v32 then
					p9.Item:Show(p9.Party, p9.CurrentItems);
				end;
			end;
			p1.Process = false;
			p9.LevelingUp = nil;
			if not v32 then
				p9.UsingItem = nil;
				p9.Item = nil;
				p9:Destroy();
			else
				p9:Show();
				p9.PartyGui.CloseBar.Cancel.Visible = true;
				p1.Gui:Say(p9.PartyGui.BottomBar.Say, "Who do you want to use " .. p9.UsingItem .. " on?", 3);
			end;
		end);
		if p9.Menu then
			p9.PartyGui:TweenPosition(UDim2.new(0.5, 0, 0.5, -36), "Out", "Quad", 0.5, true);
		end;
		if p9.WaitForSwitch then
			p1.Switch:Wait();
		end;
		return p9;
	end);
	function v13.Action(p16, p17, p18)
		p1.guiholder.MainBattle.BottomBar.Actions.Visible = false;
		p1.guiholder.MainBattle.BottomBar.Moves.Visible = false;
		p1.Sound:Play("BasicClick");
		p1.Network:post(p18, p17);
		p1.Gui:ChangeText(p1.guiholder.MainBattle.BottomBar.Say, "...");
		p1.Switch:Fire();
	end;
	function v13.Close(p19)
		p19.PartyGui.Visible = false;
	end;
	function v13.UpdateDoodle(p20, p21)
		if not p21 then
			return;
		end;
		for v34, v35 in pairs(p20.Party) do
			if v35.ID == p21.ID then
				p20.Party[v34] = p21;
				return v34;
			end;
		end;
	end;
	function v13.Show(p22, p23)
		u1 = false;
		p22:UpdateDoodle(p23);
		p22.PartyGui.Visible = true;
	end;
	function v13.AutoSwitch(p24, p25, p26, p27)
		local v36, v37, v38 = p1.ClientDatabase:PDSFunc("SwapParty", p25, p26);
		if v36 and v37 then
			if p27 then
				l__Utilities__1.Halt(0.3);
			end;
			local v39 = p24.PartyGui:FindFirstChild("Party" .. v36);
			local v40 = p24.PartyGui:FindFirstChild("Party" .. v37);
			local l__Position__41 = v39.Position;
			local l__Position__42 = v40.Position;
			local l__Name__43 = v39.Name;
			local l__Name__44 = v40.Name;
			v39:TweenPosition(u5[l__Name__44], "Out", "Quad", 0.3, true);
			v40:TweenPosition(u5[l__Name__43], "Out", "Quad", 0.3, true);
			v39.Name = l__Name__44;
			v40.Name = l__Name__43;
		end;
		if v38 then
			p24.Party = v38;
		end;
	end;
	local function u13(p28)
		return tonumber(p28.Name:match("%d"));
	end;
	local u14 = nil;
	function v13.SetDraggable(p29, p30)
		local v45 = u13(p30);
		local v46 = {
			NotBigger = true
		};
		function v46.Function(p31)
			if u3 == false then
				u3 = true;
				p29:AutoSwitch(tonumber(p30.Name:match("%d+")), (tonumber(p31.Name:match("%d+"))));
				u3 = false;
			end;
		end;
		v46.Collide = p29.AllowedChecks;
		local u15 = v45;
		local u16 = p29.Party[v45];
		function v46.IfNoDragging(p32)
			u15 = u13(p30);
			if not p29.Battle and p29.CurrentlyClicked and p29.CurrentlyClicked ~= u15 then
				l__Utilities__1.Halt(0.1);
				l__Utilities__1.FastSpawn(function()
					p29:AutoSwitch(p29.CurrentlyClicked, u15, true);
				end);
				p29.CurrentlyClicked = nil;
				l__Utilities__1.FastSpawn(function()
					p1.Gui:Say(p29.PartyGui.BottomBar.Say, "What else do you want to do?", 3);
				end);
				return;
			end;
			if not p29.Battle and not p32 then
				p29:SetupChoice(p30, p1.p:GetMouse());
				l__Utilities__1.FastSpawn(function()
					p1.Gui:Say(p29.PartyGui.BottomBar.Say, "You have selected " .. u16.Name .. ".", 3);
				end);
			end;
		end;
		function v46.StartDraggingFunc()
			if u14 then
				u14:Destroy();
			end;
		end;
		table.insert(u4, (p1.GuiDragging.new(v46, p30)));
	end;
	function v13.DestroyChoice(p33)
		if u14 then
			u14:Destroy();
		end;
	end;
	function v13.UpdateHealth(p34)
		for v47 = 1, 6 do
			if p34.Party[v47] then
				local v48 = p34.Party[v47];
				local v49 = l__Utilities__1:GetStats(v48);
				local v50 = p34.PartyGui["Party" .. v47];
				local v51 = p1.MiscDB.StatusInfo[v48.Status];
				if v48.Status and v48.Status ~= "Faint" then
					v50.Sparkles.Visible = false;
					v50.Status.Image = v51.Icon;
					v50.Status.Visible = true;
					u4[v50.Status] = p1.Tooltip.new({
						TextColor3 = v51.Color
					}, v50.Status, v48.Status);
				else
					v50.Status.Visible = false;
				end;
				if v48.Status and v48.Status ~= "Faint" then
					v50.DoodleImage.ImageColor3 = v51.Color;
				else
					v50.DoodleImage.ImageColor3 = Color3.fromRGB(255, 255, 255);
				end;
				p1.Gui:ChangeText(p34.PartyGui["Party" .. v47].Health.HealthNumber, v48.currenthp .. " / " .. v49.hp);
				p1.Gui:ChangeText(p34.PartyGui["Party" .. v47].Level.Label, "Lv. " .. v48.Level);
				p34.PartyGui["Party" .. v47].Health.Clipping:TweenSize(UDim2.new(v48.currenthp / v49.hp, 0, 1, 0), "Out", "Linear", 0.5, true);
			end;
		end;
		l__Utilities__1.Halt(0.75);
	end;
	function v13.ItemCheck(p35, p36, p37, p38)
		local v52 = p1.ItemList[p38];
		local v53 = v52.Target == "Party" and p36 or "Opponent";
		if p38 == "Stat Candy" and not p35.Battle then
			p35.PartyGui.Visible = false;
			p1.StatCandy.new({
				Doodle = v53, 
				Party = p35, 
				Amount = p35.Amount, 
				Item = p35.Item
			});
			p1.Process = false;
			u1 = false;
			u6:Fire();
			return;
		end;
		if not v52.Function then
			p1.Gui:Say(p35.PartyGui.BottomBar.Say, "You can't use " .. p38 .. " right now!", 3);
			p1.Process = nil;
			u1 = false;
			return;
		end;
		local v54, v55, v56 = v52.Function(v53);
		if v55 ~= true then
			p1.Gui:Say(p35.PartyGui.BottomBar.Say, v54, 3);
			p1.Process = nil;
			u1 = false;
			return;
		end;
		p35.PartyGui.CloseBar.Cancel.Visible = false;
		if p37 ~= nil then
			p35.Battle:MadeAction({
				User = p35.DoodleBattling.ID, 
				ActionType = "Item", 
				Action = p38, 
				Target = v53.ID
			});
			p35.Item:Destroy();
			p35:Destroy();
			p1.guiholder.MainBattle.Visible = true;
			p1.Process = false;
			return;
		end;
		if v56 then
			p1.Sound:Play(v56);
		end;
		p1.Gui:Say(p35.PartyGui.BottomBar.Say, v54, 3);
		p1.Network:BindEvent("ItemParty", function(p39, p40)
			p1.Process = true;
			p35.LevelingUp = true;
			p35.Party = p39;
			p35.CurrentItems = p40;
			p1.Network:UnbindEvent("ItemParty");
			p35:UpdateHealth();
			if not v52.DontCloseImmediately then
				if not p35.Battle and p35.Item then
					u6:Fire();
					p35.Item:Show(p39, p40);
				end;
				p35.LevelingUp = nil;
				p35:Destroy();
			end;
			u7:Fire();
			p1.Process = false;
		end);
		p1.Network:post("UseItem", v53.ID, p38);
	end;
	local l__PartyTIChoice__17 = p1.GuiObjs:WaitForChild("PartyTIChoice");
	local l__PartyChoice__18 = p1.GuiObjs:WaitForChild("PartyChoice");
	function v13.SetupChoice(p41, p42, p43)
		if u14 then
			u14:Destroy();
		end;
		if p1.Process then
			return;
		end;
		local v57 = nil;
		local v58 = p41.Party[u13(p42)];
		if not p41.Battle and v58 and v58.HeldItem and v58.HeldItem ~= "" and not p41.UsingItem then
			u14 = l__PartyTIChoice__17:Clone();
			v57 = true;
		else
			u14 = l__PartyChoice__18:Clone();
		end;
		if p41.UsingItem then
			p1.Gui:ChangeText(u14.Switch.Label, "Use");
		elseif p41.Picker then
			p1.Gui:ChangeText(u14.Switch.Label, "Pick");
		end;
		for v59, v60 in pairs(u14:GetChildren()) do
			if v60:IsA("ImageButton") then
				p1.Gui:TextHover(v60.Label);
				p1.Gui:Hover(v60);
			end;
		end;
		u14.Cancel.MouseButton1Click:Connect(function()
			p41:DestroyChoice();
		end);
		local u19 = p41.Party[p42];
		local function u20(p44, p45)
			local v61 = false;
			if p45.Format == "Singles" then
				if p44[1].ID == u19.ID then
					return true;
				end;
			elseif p45.Format == "Doubles" then
				if p44[1].ID == u19.ID then
					return true;
				end;
				if p44[2] and p44[2].ID == u19.ID then
					v61 = true;
				end;
			end;
			return v61;
		end;
		u14.Switch.MouseButton1Click:Connect(function()
			if u1 == false then
				p1.Sound:Play("BasicClick");
				p1.Process = true;
				u1 = true;
				u19 = p41.Party[u13(p42)];
				p41:DestroyChoice();
				if p41.UsingItem then
					p41:ItemCheck(u19, p41.Battle, p41.UsingItem);
					u6:Wait();
				elseif p41.Battle then
					if u19.currenthp > 0 then
						if p41.DoodleBattling.ID ~= u19.ID then
							if p41.Manual then
								if u20(p41.Party, p41.BattleData) then
									local u21 = false;
									l__Utilities__1.FastSpawn(function()
										u21 = true;
										p1.Gui:Say(p41.PartyGui.BottomBar.Say, u19.Name .. " is already out!", 3);
									end);
								elseif p41.MadeSwitch == u19.ID then
									local u22 = false;
									l__Utilities__1.FastSpawn(function()
										u22 = true;
										p1.Gui:Say(p41.PartyGui.BottomBar.Say, "You are already sending out " .. u19.Name .. "!", 3);
									end);
								else
									p41.Battle:MadeAction({
										User = p41.DoodleBattling.ID, 
										ActionType = "Switch", 
										Target = u19.ID
									});
								end;
							else
								if u20(p41.Party, p41.Battle) then
									local u23 = false;
									l__Utilities__1.FastSpawn(function()
										u23 = true;
										p1.Gui:Say(p41.PartyGui.BottomBar.Say, u19.Name .. " is already out!", 3);
									end);
								end;
								if not false then
									p41:Action({
										User = p41.DoodleBattling.ID, 
										ActionType = "ForceSwitch", 
										Target = u19.ID
									}, "ForceSwitch");
								else
									l__Utilities__1.FastSpawn(function()
										p1.Gui:Say(p41.PartyGui.BottomBar.Say, u19.Name .. " is already out!", 3);
									end);
								end;
							end;
							if not false then
								p41:Destroy(u19.ID);
								p1.guiholder.MainBattle.Visible = true;
							end;
						else
							l__Utilities__1.FastSpawn(function()
								p1.Gui:Say(p41.PartyGui.BottomBar.Say, u19.Name .. " is already out!", 3);
							end);
						end;
					else
						l__Utilities__1.FastSpawn(function()
							p1.Gui:Say(p41.PartyGui.BottomBar.Say, "You can't send out a fainted Doodle!", 3);
						end);
					end;
				elseif p41.Picker then
					p41:Destroy();
					p1.GlobalSignal:Fire(u19);
				else
					p41.CurrentlyClicked = l__Utilities__1:GetIndexFromID(u19, p41.Party);
					l__Utilities__1.FastSpawn(function()
						p1.Gui:Say(p41.PartyGui.BottomBar.Say, "Who do you want to switch with " .. u19.Name .. "?", 3);
					end);
				end;
				p1.Process = false;
				u1 = false;
			end;
		end);
		u14.Stats.MouseButton1Click:Connect(function()
			if p1.Process then
				return;
			end;
			p41:DestroyChoice();
			local v62 = u13(p42);
			u19 = p41.Party[u13(p42)];
			local v63 = {
				ColorList = p41.ColorList, 
				SkinList = p41.SkinList, 
				PlayerParty = p41.Party, 
				PartyGui = p41.PartyGui, 
				PartyButton = p41.PartyGui:FindFirstChild("Party" .. v62), 
				Party = p41, 
				Battle = p41.Battle
			};
			function v63.CloseFunc(p46)
				p41.Party[u13(p42)] = p46;
				p1.ColorAnim.Create(p41.PartyGui:FindFirstChild("Party" .. v62).DoodleName.Label, p46.NameColor);
				p1.Gui:ChangeText(p41.PartyGui:FindFirstChild("Party" .. v62).DoodleName.Label, p46.Nickname or p46.Name);
			end;
			p41:Close();
			p1.ActionStats = p1.Stats.new(v63, u19);
		end);
		if v57 then
			u14.TakeItem.MouseButton1Click:Connect(function()
				if not u1 then
					u1 = true;
					p1.Sound:Play("BasicClick");
					p41:DestroyChoice();
					v58.HeldItem = nil;
					p42.HeldItem.Visible = false;
					p1.Network:post("TakeItem", v58.ID);
					p1.Gui:Say(p41.PartyGui.BottomBar.Say, "You took " .. v58.HeldItem .. " from " .. l__Utilities__1.GetName(v58) .. ".", 3);
					u1 = false;
				end;
			end);
		end;
		u14.Position = UDim2.new(0, p43.X, 0, p43.Y);
		u14.Parent = p1.guiholder;
	end;
	function v13.UpdateSprite(p47, p48, p49)
		p1.Gui:AnimateSprite(p48.DoodleImage.DoodleLabel, p49, true);
		p1.Gui:ChangeText(p48.DoodleName.Label, p49.Nickname or p49.Name);
	end;
	local l__DoodleMovepool__24 = p1.DoodleMovepool;
	local l__ScrollList__25 = p1.ScrollList;
	function v13.SetupBox(p50, p51)
		local v64 = u13(p51);
		local v65 = p50.Party[v64];
		p1.Gui:AnimateSprite(p51.DoodleImage.DoodleLabel, v65, true);
		p51.Sparkles.Visible = v65.Shiny;
		p1.Gui:ChangeText(p51.DoodleName.Label, v65.Nickname or v65.Name);
		local v66 = p1.MiscDB.StatusInfo[v65.Status];
		if v65.Status and v65.Status ~= "Faint" then
			p51.Sparkles.Visible = false;
			p51.Status.Image = v66.Icon;
			p51.Status.Visible = true;
			u4[p51.Status] = p1.Tooltip.new({
				TextColor3 = v66.Color
			}, p51.Status, v65.Status);
		else
			p51.Status.Visible = false;
		end;
		if v65.Status and v65.Status ~= "Faint" then
			p51.DoodleImage.ImageColor3 = v66.Color;
		else
			p51.DoodleImage.ImageColor3 = Color3.fromRGB(255, 255, 255);
		end;
		local v67 = Color3.fromRGB(48, 48, 48);
		if v65.Status == "Faint" then
			v67 = Color3.fromRGB(231, 76, 60);
		end;
		p51.ImageColor3 = v67;
		p51.DoodleName.ImageColor3 = v67;
		p51.DoodleName.Frame.BackgroundColor3 = v67;
		p51.Level.ImageColor3 = v67;
		if p50.UsingItem and not p50.Scroll then
			local v68 = p1.ItemList[p50.UsingItem];
			if v68.Type == "OverworldOnly" then
				p1.Gui:ChangeText(p51.DoodleName.Label, "No effect");
				if v68.EvolveItem then
					local v69 = p1.DoodleInfo[v65.Name];
					if v69.Evolve and v69.Evolve.Item then
						if v69.Evolve.Item[p50.UsingItem] and p50.HeldItem ~= "Laminate" then
							p1.Gui:ChangeText(p51.DoodleName.Label, "Can evolve");
						else
							p1.Gui:ChangeText(p51.DoodleName.Label, "No effect right now");
						end;
					end;
				else
					p1.Gui:ChangeText(p51.DoodleName.Label, v65.Nickname or v65.Name);
				end;
			end;
		elseif p50.Scroll then
			local v70 = false;
			for v71, v72 in pairs(v65.Moves) do
				if v72.Name == p50.Scroll then
					v70 = true;
				end;
			end;
			if v70 then
				p1.Gui:ChangeText(p51.DoodleName.Label, "Already learned");
			elseif table.find(l__DoodleMovepool__24[l__Utilities__1.GetRealName(v65)].Scroll, p50.Scroll) then
				p1.Gui:ChangeText(p51.DoodleName.Label, "Can learn");
			else
				p1.Gui:ChangeText(p51.DoodleName.Label, "Cannot learn");
			end;
		else
			p1.Gui:ChangeText(p51.DoodleName.Label, v65.Nickname or v65.Name);
		end;
		u2.Create(p51.DoodleName.Label, v65.NameColor);
		p1.Gui:ChangeText(p51.Level.Label, "Lv. " .. v65.Level);
		p1.Gui:SetGenderIcon(v65, p51.DoodleName.GenderSign);
		if v65.HeldItem == nil then
			p51.HeldItem.Visible = false;
		else
			if table.find(l__ScrollList__25, v65.HeldItem) then
				p51.HeldItem.Image = p1.ItemList.Scroll.Image;
				p51.HeldItem.ImageColor3 = p1.Typings.Visual[p1.Moves[v65.HeldItem].Type].Color;
			else
				p51.HeldItem.Image = p1.ItemList[v65.HeldItem].Image;
				p51.HeldItem.ImageColor3 = Color3.fromRGB(255, 255, 255);
			end;
			p51.HeldItem.Visible = true;
		end;
		if not u4[p51] then
			u4[p51] = p51.Health.Clipping:GetPropertyChangedSignal("Size"):Connect(function()
				local v73 = l__Utilities__1:GetStats(p50.Party[v64]);
				p51.Health.Clipping.TotalHealth.Size = UDim2.new(0, p51.Health.AbsoluteSize.X, 0, p51.Health.AbsoluteSize.Y);
				p1.Gui:ChangeText(p51.Health.HealthNumber, math.floor(p51.Health.Clipping.Size.X.Scale * v73.hp + 0.5) .. " / " .. v73.hp);
				local l__Scale__74 = p51.Health.Clipping.Size.X.Scale;
				if l__Scale__74 > 0.75 then
					p51.Health.Clipping.TotalHealth.ImageColor3 = Color3.fromRGB(46, 204, 113);
					return;
				end;
				if l__Scale__74 > 0.5 then
					p51.Health.Clipping.TotalHealth.ImageColor3 = Color3.fromRGB(241, 196, 15);
					return;
				end;
				if l__Scale__74 > 0.25 then
					p51.Health.Clipping.TotalHealth.ImageColor3 = Color3.fromRGB(243, 156, 18);
					return;
				end;
				p51.Health.Clipping.TotalHealth.ImageColor3 = Color3.fromRGB(231, 76, 60);
			end);
		end;
		local l__currenthp__75 = v65.currenthp;
		local l__hp__76 = l__Utilities__1:GetStats(v65).hp;
		p1.Gui:ChangeText(p51.Health.HealthNumber, l__currenthp__75 .. " / " .. l__hp__76);
		p51.Health.Clipping.Size = UDim2.new(l__currenthp__75 / l__hp__76, 0, 1, 0);
		p51.Health.Clipping.TotalHealth.Size = UDim2.new(0, p51.Health.AbsoluteSize.X, 0, p51.Health.AbsoluteSize.Y);
		local v77 = p1.ClientDatabase:GetNextLevel(v65, v65.Level + 1);
		local v78 = v77 - p1.ClientDatabase:GetNextLevel(v65, v65.Level);
		p51.Experience.Clipping.TotalExp.Size = UDim2.new(0, p51.Experience.AbsoluteSize.X, 1, 0);
		p51.Experience.Clipping.Size = UDim2.new((v78 - (v77 - v65.Experience)) / v78, 0, 1, 0);
		if not p50.Battle and not p50.UsingItem and not p50.GivingItem and not p50.Scroll and not p50.Picker then
			p50:SetDraggable(p51);
		elseif not u4[p51.Name .. "Click"] then
			u4[p51.Name .. "Click"] = p51.Activated:Connect(function()
				local v79 = p50.Party[v64];
				if p1.Process then
					return;
				end;
				if p50.GivingDeb ~= nil then
					return;
				end;
				if p50.LevelingUp then
					return;
				end;
				if p50.GivingItem then
					p50.GivingDeb = true;
					p50.PartyGui.CloseBar.Cancel.Visible = false;
					if table.find(l__ScrollList__25, p50.GivingItem) then
						p51.HeldItem.Image = p1.ItemList.Scroll.Image;
						p51.HeldItem.ImageColor3 = p1.Typings.Visual[p1.Moves[p50.GivingItem].Type].Color;
					else
						p51.HeldItem.Image = p1.ItemList[p50.GivingItem].Image;
						p51.HeldItem.ImageColor3 = Color3.fromRGB(255, 255, 255);
					end;
					p51.HeldItem.Visible = true;
					p1.Network:post("GiveItem", v79.ID, p50.GivingItem);
					p1.Network:BindEvent("GiveItem", function(p52, p53, p54)
						p1.Network:UnbindEvent("GiveItem");
						p1.Gui:Say(p50.PartyGui.BottomBar.Say, "You gave " .. p50.GivingItem .. " to " .. l__Utilities__1.GetName(v79) .. ".");
						if p54 then
							p1.Gui:Say(p50.PartyGui.BottomBar.Say, "You got " .. p54 .. " from " .. l__Utilities__1.GetName(v79) .. ".");
						end;
						p50:Destroy();
						if p50.Item then
							u6:Fire();
							p50.Item:Show(p52, p53);
						end;
						p50.GivingDeb = nil;
					end);
					return;
				end;
				if p50.Scroll then
					local v80 = nil;
					for v81, v82 in pairs(v79.Moves) do
						if v82.Name == p50.Scroll then
							v80 = "AlreadyLearned";
						end;
					end;
					if not v80 and table.find(l__DoodleMovepool__24[l__Utilities__1.GetRealName(v79)].Scroll, p50.Scroll) then
						v80 = "CanLearn";
					elseif not v80 then
						v80 = "CannotLearn";
					end;
					if v80 == "CannotLearn" then
						p1.Gui:Say(p50.PartyGui.BottomBar.Say, v79.Name .. " cannot learn " .. p50.Scroll .. "!");
						return;
					end;
					if v80 == "AlreadyLearned" then
						p1.Gui:Say(p50.PartyGui.BottomBar.Say, v79.Name .. " has already learned " .. p50.Scroll .. "!");
						return;
					end;
					if v80 == "CanLearn" then
						p50.PartyGui.CloseBar.Cancel.Visible = false;
						p50.GivingDeb = true;
						p1.Network:BindEvent("ScrollMove", function(p55, p56, p57)
							p1.Network:UnbindEvent("ScrollMove");
							if p55 == "LessThanFour" then
								p1.Gui:SayText("", l__Utilities__1.GetName(v79) .. " learned " .. p50.Scroll .. "!", nil, true);
								p1.Dialogue:Hide();
							elseif not p55 or p55 == "Glitch" then
								p1.Gui:SayText("", "The server could not validate this request. Try again.", nil, true);
								p1.Dialogue:Hide();
							elseif p55 == "FourMoves" then
								u7:Fire();
								local v83, v84 = p1.MoveLearn:Wait();
								p56 = v83;
								p57 = v84;
							end;
							p50:Destroy();
							if p50.Item then
								u6:Fire();
								p50.Item:Show(p56, p57);
							end;
							p50.GivingDeb = nil;
						end);
						p1.Network:post("ScrollMove", v79.ID, p50.Scroll);
						return;
					end;
				else
					p50:SetupChoice(p51, (p1.p:GetMouse()));
				end;
			end);
		end;
		p51.Visible = true;
	end;
	function v13.UpdateAll(p58)
		p58.Party = p1.ClientDatabase:PDSFunc("GetParty");
		p58:Setup(p58.Party, true);
	end;
	function v13.Setup(p59, p60, p61)
		for v85 = 1, 6 do
			if p60[v85] then
				p59:SetupBox(p59.PartyGui["Party" .. v85]);
			else
				p59.PartyGui["Party" .. v85].Visible = false;
			end;
			p1.Gui:Hover(p59.PartyGui["Party" .. v85], { p59.PartyGui["Party" .. v85].DoodleName.Frame, p59.PartyGui["Party" .. v85].DoodleName, p59.PartyGui["Party" .. v85].Level }, true);
		end;
		p1.Gui:ChangeText(p59.PartyGui.BottomBar.Say, "");
		if p61 then
			return;
		end;
		if not p59.Temp then
			p59.PartyGui.Visible = true;
		end;
	end;
	function v13.Disconnect(p62)
		for v86, v87 in pairs(u4) do
			if typeof(v87) == "RBXScriptConnection" then
				v87:Disconnect();
			elseif typeof(v87) == "table" and v87.Disconnect then
				v87:Disconnect();
			elseif v87:IsA("Instance") then
				v87:Destroy();
			end;
		end;
		u4 = {};
	end;
	function v13.Destroy(p63, p64)
		p1.ClientDatabase:PDSEvent("ToggleBusy", false);
		for v88, v89 in pairs(p63.PartyGui:GetDescendants()) do
			if v89:IsA("UIGradient") then
				v89:Destroy();
			end;
		end;
		p1.Network:UnbindEvent("ScrollMove");
		p1.Network:UnbindEvent("MoveLearn");
		if u14 then
			u14:Destroy();
		end;
		if p63.Menu then
			p63.PartyGui:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.5, true);
			l__Utilities__1.Halt(0.35);
		end;
		if p63.CloseFunction then
			local v90 = nil;
			if p63.DoodleBattling then
				for v91, v92 in pairs(p63.Party) do
					if v92.ID == p63.DoodleBattling.ID then
						v90 = v91;
						break;
					end;
				end;
			end;
			p63.CloseFunction(p63.Party[v90].Moves, p64);
		end;
		p63.PartyGui.Visible = false;
		p63:Disconnect();
		p63 = nil;
	end;
	return v13;
end;
