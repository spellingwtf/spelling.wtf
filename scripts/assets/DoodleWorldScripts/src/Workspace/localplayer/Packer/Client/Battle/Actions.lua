-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Signal();
	local u1 = {};
	local u2 = nil;
	local u3 = nil;
	local u4 = {};
	local u5 = nil;
	local function u6()
		for v3, v4 in pairs(u4) do
			if typeof(v4) == "RBXScriptConnection" then
				v4:Disconnect();
			end;
		end;
	end;
	local function u7()
		for v5, v6 in pairs(u1) do
			if typeof(v6) == "RBXScriptConnection" then
				v6:Disconnect();
			end;
		end;
		u1 = {};
	end;
	local u8 = {};
	local function u9()
		if u2 then
			u2:Disconnect();
		end;
		if u3 then
			u3:Disconnect();
		end;
	end;
	local function u10()
		if u5 then
			u5.Visible = false;
		end;
		u6();
		u7();
		for v7, v8 in pairs(u8) do
			if typeof(v8) == "RBXScriptConnection" then
				v8:Disconnect();
			end;
		end;
		u8 = {};
	end;
	local u11 = {};
	local u12 = nil;
	local v9 = l__Utilities__1.Class({
		ClassName = "Action"
	}, function(p3)
		u9();
		u10();
		u11 = {};
		u12 = false;
		p3.TargetUI = p3.Gui.BottomBar.SelectTarget;
		p3.TargetUI.Visible = false;
		p3.FinalAction = {};
		for v10, v11 in pairs(p3.OutDoodles) do
			if v11.currenthp > 0 then
				p3:CreateBottomBar(v11);
				local v12 = p1.SelectedAction:Wait();
				l__Utilities__1.Halt(0.26);
				if v12 then
					break;
				end;
			end;
		end;
		return p3;
	end);
	local function u13(p4)
		if (not p4.Wrapped or not (p4.Wrapped > 0)) and not p4.Trapped then
			return false;
		end;
		return true;
	end;
	function v9.CreateBottomBar(p5, p6)
		u10();
		p5.Doodle = p6;
		p5.Moves = p5.Doodle.Moves;
		if u5 then
			u5.Visible = false;
		end;
		local v13, v14, v15 = p2.Funcs:GetDoodleGui(p5.Doodle, p5.Gui, p5.BattleData);
		if v15 and v14 then
			p2.BGui:AnimateBobble(v14.Parent);
		end;
		p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p6.Name .. " do?");
		p5.BattleType = p5.BattleData.BattleType;
		p5:SetupMoves();
		u8.Back = p5.Gui.BottomBar.Back.Button.MouseButton1Click:Connect(function()
			p5.Gui.BottomBar.Back.Visible = false;
			p5.Gui.BottomBar.SelectTarget.Visible = false;
			p5.Gui.BottomBar.MoveDescription.Visible = false;
			p5.Gui.BottomBar.Actions.Visible = true;
			p5.Gui.BottomBar.Moves.Visible = true;
		end);
		u8.Fight = p5.Gui.BottomBar.Actions.Fight.MouseButton1Click:Connect(function()
			p5.Gui.BottomBar.MoveDescription.Visible = false;
			p1.TypeChart:Close();
			if not p2.Funcs:CheckUses(p5.Doodle) then
				p5:MadeAction({
					User = p5.Doodle.ID, 
					ActionType = "Attack", 
					Action = "Desperation", 
					Target = "RandomTarget"
				});
				return;
			end;
			p1.Sound:Play("BasicClick");
			p1.Gui:ChangeText(p5.Gui.BottomBar.Say, "");
			p5.Gui.BottomBar.Moves.Visible = true;
		end);
		u8.Run = p5.Gui.BottomBar.Actions.Run.MouseButton1Click:Connect(function()
			p1.TypeChart:Close();
			if not u12 then
				p5.Gui.BottomBar.Actions.Visible = false;
				p5.Gui.BottomBar.Moves.Visible = false;
				p5.Gui.BottomBar.MoveDescription.Visible = false;
				if p5.BattleData.nocatch then
					u12 = true;
					p1.Gui:Say(p5.Gui.BottomBar.Say, "A strange force is preventing you from running away!");
					l__Utilities__1.Halt(0.5);
					p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p5.Doodle.Name .. " do?");
					p5.Gui.BottomBar.Actions.Visible = true;
					u12 = false;
					return;
				end;
				if p5.BattleData.BattleType == "PvP" then
					p1.Sound:Play("BasicClick");
					p5:MadeAction({
						User = p5.Doodle.ID, 
						ActionType = "Run", 
						Target = "RunAway"
					}, true);
					return;
				end;
				if not u13(p5.Doodle) then
					if p5.BattleData.BattleType == "Wild" then
						p1.Sound:Play("BasicClick");
						p5:MadeAction({
							User = p5.Doodle.ID, 
							ActionType = "Run", 
							Target = "RunAway"
						});
						return;
					else
						u12 = true;
						p1.Gui:Hover(p5.Gui.BottomBar.Yes);
						p1.Gui:Hover(p5.Gui.BottomBar.No);
						u9();
						p1.Gui:Say(p5.Gui.BottomBar.Say, "Do you want to forfeit this battle?");
						u2 = p5.Gui.BottomBar.Yes.MouseButton1Click:Connect(function()
							p5.Gui.BottomBar.Yes.Visible = false;
							p5.Gui.BottomBar.No.Visible = false;
							p1.Sound:Play("BasicClick");
							p5:MadeAction({
								User = p5.Doodle.ID, 
								ActionType = "Forfeit", 
								Target = "RunAway"
							});
						end);
						u3 = p5.Gui.BottomBar.No.MouseButton1Click:Connect(function()
							p5.Gui.BottomBar.Yes.Visible = false;
							p5.Gui.BottomBar.No.Visible = false;
							p1.Sound:Play("BasicClick");
							l__Utilities__1.Halt(0.5);
							p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p5.Doodle.Name .. " do?");
							p5.Gui.BottomBar.Actions.Visible = true;
							u12 = false;
						end);
						p5.Gui.BottomBar.Yes.Visible = true;
						p5.Gui.BottomBar.No.Visible = true;
						return;
					end;
				end;
			else
				return;
			end;
			u12 = true;
			p1.Gui:Say(p5.Gui.BottomBar.Say, "You can't run away because " .. p5.Doodle.Name .. " is trapped!");
			l__Utilities__1.Halt(0.5);
			p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p5.Doodle.Name .. " do?");
			p5.Gui.BottomBar.Actions.Visible = true;
			u12 = false;
		end);
		u8.Party = p5.Gui.BottomBar.Actions.Switch.MouseButton1Click:Connect(function()
			p1.TypeChart:Close();
			if not u12 then
				if u13(p5.Doodle) then
					p5.Gui.BottomBar.Moves.Visible = false;
					p5.Gui.BottomBar.Actions.Visible = false;
					p5.Gui.BottomBar.MoveDescription.Visible = false;
					u12 = true;
					p1.Gui:Say(p5.Gui.BottomBar.Say, "You can't switch because " .. p5.Doodle.Name .. " is trapped!");
					l__Utilities__1.Halt(0.5);
					p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p5.Doodle.Name .. " do?");
					p5.Gui.BottomBar.Actions.Visible = true;
					u12 = false;
					return;
				end;
				p1.guiholder.MainBattle.Visible = false;
				local v16 = nil;
				local v17 = nil;
				if p5.BattleData.BattleType == "PvP" and p5.BattleData.TimeLimit ~= 3 then
					local v18 = p1.Spectating == p5.BattleData.Player1 and p5.BattleData.Player1 or p5.BattleData.Player2;
					v16 = v18:FindFirstChild("PvPTimer");
					v17 = (v18 == p5.BattleData.Player1 and p5.BattleData.Player2 or p5.BattleData.Player1):FindFirstChild("PvPTimer");
				end;
				p1.ActionParty = p1.Party.new({
					DoodleBattling = p5.Doodle, 
					PlayerTimer = v16, 
					OtherTimer = v17, 
					CloseFunction = function(p7, p8)
						if not p5 or not p5.SetupMoves or not (not p8) then
							p5.MadeSwitch = p8;
							return;
						end;
						p5.Moves = p7;
						p5:SetupMoves();
					end, 
					MadeSwitch = p5.MadeSwitch, 
					Party = p2.Funcs:GetPlayerParty(p5.BattleData), 
					String = "Do you want to switch doodles?", 
					Battle = p5, 
					BattleData = p5.BattleData, 
					Manual = true, 
					NoColorList = true
				});
			end;
		end);
		u8.Items = p5.Gui.BottomBar.Actions.Items.MouseButton1Click:Connect(function()
			p1.TypeChart:Close();
			if not u12 then
				if p5.BattleData.BattleType ~= "PvP" then
					p1.guiholder.MainBattle.Visible = false;
					p1.Items.new({
						Battle = p5, 
						Items = p1.ClientDatabase:PDSFunc("GetItems"), 
						Party = p2.Funcs:GetPlayerParty(p5.BattleData), 
						String = "Pick an item to use!", 
						DoodleBattling = p5.Doodle
					});
					return;
				end;
			else
				return;
			end;
			p5.Gui.BottomBar.Actions.Visible = false;
			p5.Gui.BottomBar.Moves.Visible = false;
			p5.Gui.BottomBar.MoveDescription.Visible = false;
			u12 = true;
			p1.Gui:Say(p5.Gui.BottomBar.Say, "You can't use items against other players!");
			l__Utilities__1.Halt(0.5);
			p1.Gui:Say(p5.Gui.BottomBar.Say, "[LAST]What will " .. p5.Doodle.Name .. " do?");
			u12 = false;
			p5.Gui.BottomBar.Actions.Visible = true;
		end);
		p5.Gui.BottomBar.Actions.Visible = true;
	end;
	function v9.MakeTargetInvisible(p9)
		for v19, v20 in pairs(p9.TargetUI:GetChildren()) do
			if v20:IsA("GuiObject") then
				v20.Visible = false;
			end;
		end;
	end;
	local u14 = {
		Front1Box = "Front1", 
		Front2Box = "Front2", 
		Back1Box = "Front3", 
		Back2Box = "Front4"
	};
	local u15 = {
		CanTarget = Color3.fromRGB(0, 87, 131), 
		NoTarget = Color3.fromRGB(40, 40, 40), 
		ForceTarget = Color3.fromRGB(17, 131, 0)
	};
	function v9.SetupTargets(p10, p11)
		u7();
		p10:MakeTargetInvisible();
		local l__Target__21 = p1.Moves[p11].Target;
		local v22 = {};
		for v23, v24 in pairs(p10.BattleData.Out1) do
			if v24.currenthp > 0 then
				table.insert(v22, {
					Position = v23, 
					Doodle = v24
				});
			end;
		end;
		for v25, v26 in pairs(p10.BattleData.Out2) do
			if v26.currenthp > 0 then
				table.insert(v22, {
					Position = v25, 
					Doodle = v26
				});
			end;
		end;
		u11 = {};
		local v27, v28, v29 = pairs(v22);
		while true do
			local v30 = nil;
			local v31, v32 = v27(v28, v29);
			if not v31 then
				break;
			end;
			v29 = v31;
			local v33, v34 = p2.Funcs:FindSpriteFromDoodle(p10.Gui, p10.BattleData, v32.Doodle);
			local v35 = v34.Name:find("Back");
			v30 = p10.Doodle;
			if l__Target__21 == "Self" then
				if v30.ID == v32.Doodle.ID then
					u11[v34] = "CanTarget";
				else
					u11[v34] = "NoTarget";
				end;
			elseif l__Target__21 == "All" then
				u11[v34] = "ForceTarget";
			elseif l__Target__21 == "AllFoes" then
				if v35 then
					u11[v34] = "NoTarget";
				else
					u11[v34] = "ForceTarget";
				end;
			elseif l__Target__21 == "Single" then
				if v30.ID == v32.Doodle.ID then
					u11[v34] = "NoTarget";
				else
					u11[v34] = "CanTarget";
				end;
			elseif l__Target__21 == "AllOthers" then
				if v30.ID == v32.Doodle.ID then
					u11[v34] = "NoTarget";
				else
					u11[v34] = "ForceTarget";
				end;
			end;		
		end;
		for v36, v37 in pairs(v22) do
			local v38, v39 = p2.Funcs:FindSpriteFromDoodle(p10.Gui, p10.BattleData, v37.Doodle);
			local v40 = p10.TargetUI[u14[v39.Name]];
			p1.Gui:ChangeText(v40.DoodleName, l__Utilities__1.GetRealName(v37.Doodle));
			p1.Gui:StaticImage(v40.DoodleImage, v37.Doodle, true, nil);
			local v41 = u11[v39];
			v40.BackgroundColor3 = u15[v41];
			v40.AutoButtonColor = false;
			u1[v40.Name .. "MouseEnter"] = v40.MouseEnter:Connect(function()
				if v41 == "NoTarget" then
					return;
				end;
				if v41 == "CanTarget" then
					v40.BackgroundColor3 = Color3.new(u15[v41].r * 0.6, u15[v41].g * 0.6, u15[v41].b * 0.6);
				end;
			end);
			u1[v40.Name .. "MouseLeave"] = v40.MouseLeave:Connect(function()
				if v41 == "NoTarget" then
					return;
				end;
				if v41 == "CanTarget" then
					v40.BackgroundColor3 = u15[v41];
				end;
			end);
			local u16 = {};
			u1[v40.Name .. "InputBegan"] = v40.InputBegan:Connect(function(p12)
				if p12.UserInputType == Enum.UserInputType.MouseMovement or p12.UserInputType == Enum.UserInputType.Touch then
					if v41 == "ForceTarget" and not table.find(u16, v40) then
						table.insert(u16, v40);
					end;
					if #u16 > 0 and v41 == "ForceTarget" then
						local v42 = Color3.new(u15[v41].r * 0.5, u15[v41].g * 0.5, u15[v41].b * 0.5);
						for v43, v44 in pairs(u11) do
							if v44 == "ForceTarget" then
								p10.TargetUI[u14[v43.Name]].BackgroundColor3 = v42;
							end;
						end;
					end;
				end;
			end);
			u1[v40.Name .. "InputChanged"] = v40.InputChanged:Connect(function(p13)
				if p13.UserInputType == Enum.UserInputType.MouseMovement or p13.UserInputType == Enum.UserInputType.Touch then
					if v41 == "ForceTarget" and not table.find(u16, v40) then
						table.insert(u16, v40);
					end;
					if #u16 > 0 and v41 == "ForceTarget" then
						local v45 = Color3.new(u15[v41].r * 0.5, u15[v41].g * 0.5, u15[v41].b * 0.5);
						for v46, v47 in pairs(u11) do
							if v47 == "ForceTarget" then
								p10.TargetUI[u14[v46.Name]].BackgroundColor3 = v45;
							end;
						end;
					end;
				end;
			end);
			u1[v40.Name .. "InputEnded"] = v40.InputEnded:Connect(function(p14)
				if p14.UserInputType == Enum.UserInputType.MouseMovement or p14.UserInputType == Enum.UserInputType.Touch then
					if v41 == "ForceTarget" and table.find(u16, v40) then
						table.remove(u16, table.find(u16, v40));
					end;
					if #u16 == 0 and v41 == "ForceTarget" then
						local v48 = u15[v41];
						for v49, v50 in pairs(u11) do
							if v50 == "ForceTarget" then
								p10.TargetUI[u14[v49.Name]].BackgroundColor3 = v48;
							end;
						end;
					end;
				end;
			end);
			u1[v40.Name .. "Click"] = v40.MouseButton1Click:Connect(function()
				if v41 == "NoTarget" then
					p1.Sound:Play("NotEnough");
					return;
				end;
				if v41 == "CanTarget" then
					p10.TargetUI.Visible = false;
					u7();
					p1.Sound:Play("Boop");
					p10:MadeAction({
						User = p10.Doodle.ID, 
						ActionType = "Attack", 
						Action = p11, 
						Target = v37.Doodle.ID
					});
					return;
				end;
				if v41 ~= "ForceTarget" then
					return;
				end;
				p10.TargetUI.Visible = false;
				u7();
				p1.Sound:Play("Boop");
				p10:MadeAction({
					User = p10.Doodle.ID, 
					ActionType = "Attack", 
					Action = p11, 
					Target = l__Target__21
				});
			end);
			v40.Effective.Visible = false;
			if v41 == "CanTarget" or v41 == "ForceTarget" then
				p2.BGui:SetEffectiveIcon(v40, p11, p10.Doodle, v37.Doodle);
			end;
			v40.Visible = true;
		end;
		p10.TargetUI.Visible = true;
		p10.Gui.BottomBar.Back.Visible = true;
	end;
	local u17 = nil;
	local function u18(p15, p16, p17)
		if u5 then
			u5.Visible = false;
		end;
		u5 = p15;
		local v51 = p1.Moves[p16.Name];
		local l__Type__52 = v51.Type;
		local v53 = v51.Category;
		if v53 == "Passive" then
			v53 = "Support";
		end;
		local v54 = p1.Typings:GetColor(l__Type__52);
		p1.Gui:ChangeText(p15.MoveName.Label, p16.Name, v54);
		p15.MoveName.Size = UDim2.new(0, p15.MoveName.Label.TextBounds.X + 10, 0.3, 0);
		p1.Gui:ChangeText(p15.MoveCategory.Label, v53);
		p15.MoveCategory.Size = UDim2.new(0, p15.MoveCategory.Label.TextBounds.X + 5, 0.3, 0);
		p1.Gui:ChangeText(p15.Desc, v51.Desc);
		local v55 = math.floor(p15.StatHolder.AbsoluteSize.Y);
		for v56, v57 in pairs(p15.StatHolder:GetDescendants()) do
			if v57:FindFirstChild("ChangeSize") then
				v57.TextSize = v55;
			end;
		end;
		if typeof(v51.Power) ~= "number" then
			local v58 = v51.Power == "Varies" and v51.Power or "--";
		else
			v58 = v51.Power or "--";
		end;
		p1.Gui:ChangeText(p15.StatHolder.Power.Desc.Label, v58);
		if v51.Accuracy == true then
			local v59 = "--";
		else
			v59 = v51.Accuracy .. "%";
		end;
		p1.Gui:ChangeText(p15.StatHolder.Accuracy.Desc.Label, v59);
		p1.Gui:ChangeText(p15.StatHolder.Type.Desc.Label, l__Type__52);
		p1.Gui:ChangeText(p15.StatHolder.Type.Label, "Type", v54);
		for v60, v61 in pairs({ p15.StatHolder.Accuracy, p15.StatHolder.Power, p15.StatHolder.Type }) do
			v61.Desc.Size = UDim2.new(0, v61.Desc.Label.TextBounds.X + 7, 1, 0);
		end;
		p15.Visible = true;
	end;
	function v9.SetupMoves(p18)
		if not p18.Gui then
			return;
		end;
		local l__Moves__62 = p18.Gui.BottomBar.Moves;
		for v63, v64 in pairs(l__Moves__62:GetChildren()) do
			v64.Visible = false;
		end;
		for v65, v66 in pairs(p18.Moves) do
			if v65 < 5 then
				local v67 = l__Moves__62:FindFirstChild("Move" .. v65);
				p2.BGui:MoveButton(v67, v66, p18.BattleData);
				if u4[v67] then
					u4[v67]:Disconnect();
				end;
				if u4[v67.Name .. "roight"] then
					u4[v67.Name .. "roight"]:Disconnect();
				end;
				if u4[v67.Name .. "Enter"] then
					u4[v67.Name .. "Enter"]:Disconnect();
				end;
				u4[v67.Name .. "roight"] = v67.MouseButton2Click:Connect(function()
					u17 = v66.Name;
					u18(p18.Gui.BottomBar.MoveDescription, v66);
					if u5 then
						u5.Position = UDim2.new(0.125 + v67.Position.X.Scale, 0, -0.25, 0);
					end;
				end);
				u4[v67.Name .. "Enter"] = v67.MouseEnter:Connect(function()
					if u17 ~= v66.Name and u5 then
						u5.Visible = false;
					end;
				end);
				u4[v67] = v67.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					p1.TypeChart:Close();
					p18.Gui.BottomBar.Actions.Visible = false;
					p18.Gui.BottomBar.Moves.Visible = false;
					p18.Gui.BottomBar.MoveDescription.Visible = false;
					if p18.Doodle.DisabledMoves and table.find(p18.Doodle.DisabledMoves, v66.Name) then
						p1.Gui:Say(p18.Gui.BottomBar.Say, p18.Doodle.Name .. " can't use " .. v66.Name .. " right now!");
						l__Utilities__1.Halt(0.5);
						p1.Gui:Say(p18.Gui.BottomBar.Say, "[LAST]What will " .. p18.Doodle.Name .. " do?");
						p18.Gui.BottomBar.Actions.Visible = true;
						return;
					end;
					if not p2.Funcs:CheckMove(p18.Doodle, v66.Name) then
						p1.Gui:Say(p18.Gui.BottomBar.Say, v66.Name .. " has no uses left!");
						l__Utilities__1.Halt(0.5);
						p1.Gui:Say(p18.Gui.BottomBar.Say, "[LAST]What will " .. p18.Doodle.Name .. " do?");
						p18.Gui.BottomBar.Actions.Visible = true;
						return;
					end;
					if p18.BattleData.Format == "Singles" then
						local v68, v69 = p2.Funcs:GetOutDoodles(p18.BattleData);
						p18:MadeAction({
							User = p18.Doodle.ID, 
							ActionType = "Attack", 
							Action = v66.Name, 
							Target = v69.ID
						});
						return;
					end;
					local v70 = p1.Moves[v66.Name];
					if v70.Target ~= "Self" and v70.Target ~= "RandomEnemy" then
						p18:SetupTargets(v66.Name);
						return;
					end;
					p18:MadeAction({
						User = p18.Doodle.ID, 
						ActionType = "Attack", 
						Action = v66.Name, 
						Target = p18.Doodle.ID
					});
				end);
				v67.Visible = true;
			end;
		end;
	end;
	function v9.Clear(p19)
		p19.Moves = nil;
		p19.BattleData = nil;
	end;
	function v9.MadeAction(p20, p21, p22)
		p1.SelectedAction:Fire(p22);
		p20.Gui.BottomBar.Moves.Visible = false;
		p20.Gui.BottomBar.Back.Visible = false;
		p20.Gui.BottomBar.MoveDescription.Visible = false;
		p2.BGui:StopBobble();
		table.insert(p20.FinalAction, p21);
		local v71 = true;
		for v72, v73 in pairs(p20.OutDoodles) do
			if v73.currenthp > 0 then
				local v74 = false;
				for v75, v76 in pairs(p20.FinalAction) do
					if v76.User == v73.ID then
						v74 = true;
					end;
				end;
				if v74 == false then
					v71 = false;
					break;
				end;
			end;
		end;
		if v71 or p22 then
			p20:FinalMadeAction();
		end;
	end;
	function v9.FinalMadeAction(p23)
		u9();
		p23.Gui.Visible = true;
		p23.Gui.BottomBar.Actions.Visible = false;
		p23.Gui.BottomBar.Moves.Visible = false;
		p23.Gui.BottomBar.Back.Visible = false;
		p1.Sound:Play("BasicClick");
		p1.Network:post("BattleAction", p23.FinalAction);
		p1.Gui:ChangeText(p23.Gui.BottomBar.Say, "...");
		u10();
		p23.OutDoodle = nil;
		p23.Doodle = nil;
		for v77, v78 in pairs(p23) do
			p23[v77] = nil;
		end;
	end;
	return v9;
end;
