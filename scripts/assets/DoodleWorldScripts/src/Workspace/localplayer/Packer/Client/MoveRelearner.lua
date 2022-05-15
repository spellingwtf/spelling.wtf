-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = nil;
	local function u3()
		for v2, v3 in pairs(u1) do
			v3:Disconnect();
		end;
		u1 = {};
	end;
	local function u4()
		for v4, v5 in pairs(u2.Scroller:GetChildren()) do
			if v5:IsA("GuiObject") then
				v5:Destroy();
			end;
		end;
	end;
	local u5 = nil;
	local u6 = {};
	function u6.Show(p2, p3)
		u2 = p1.guiholder.MoveRelearner;
		u3();
		u4();
		u5 = p1.ClientDatabase:PDSFunc("GetMoney");
		u6:UpdateMoney();
		p1.Gui:AnimateSprite(u2.DoodleImage.DoodleLabel, p3, true);
		p1.Gui:ChangeText(u2.DoodleName, l__Utilities__1.GetName(p3));
		p1.ColorAnim.Create(u2.DoodleName, p3.NameColor);
		u6:ClearStars();
		u6:SetupStars(p3);
		u2.DoodleImage.Sparkles.Visible = p3.Shiny;
		u1.CloseHover = u2.Close.MouseEnter:Connect(function()
			u2.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			u2.Close.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = u2.Close.MouseLeave:Connect(function()
			u2.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
			u2.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u1.CloseClick = u2.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			u6:Hide();
		end);
		u6:MakeMoveList(p3);
		u2.Visible = true;
	end;
	function u6.NotLearned(p4, p5, p6)
		for v6, v7 in pairs(p5.Moves) do
			if v7.Name == p6 then
				return false;
			end;
		end;
		return true;
	end;
	local u7 = l__Utilities__1.Signal();
	function u6.MakeMoveList(p7, p8)
		local v8 = nil;
		local l__MoveRelearnerMove__9 = p1.GuiObjs.MoveRelearnerMove;
		local l__Level__10 = p8.Level;
		for v11, v12 in pairs(p1.DoodleMovepool[l__Utilities__1.GetRealName(p8)].Levelup) do
			if v11 <= l__Level__10 then
				for v13, v14 in pairs(v12) do
					if u6:NotLearned(p8, v14) then
						local v15 = l__MoveRelearnerMove__9:Clone();
						v15.Size = UDim2.new(1, -20, 0, u2.AbsoluteSize.Y / 10);
						p1.Gui:ChangeText(v15.MoveName, v14);
						p1.Gui:ChangeText(v15.Cost, "$" .. v11 * 300);
						v15.LayoutOrder = v11 + v13;
						local l__Type__16 = p1.Moves[v14].Type;
						local l__Color__17 = p1.Typings.Visual[l__Type__16].Color;
						v15.ImageColor3 = Color3.new(l__Color__17.r * 0.8, l__Color__17.g * 0.8, l__Color__17.b * 0.8);
						p1.Gui:TypeImage(v15.Cost.TypeImage, l__Type__16);
						p1.Gui:Hover(v15);
						v15.Parent = u2.Scroller;
						local u8 = v8;
						v15.MouseButton1Down:Connect(function()
							if u8 then
								return;
							end;
							if not (v11 * 300 <= u5) then
								p1.Sound:Play("PurchaseFail");
								p1.Gui:SayText("MoveRelearner", "You don't have enough cash...", nil, true);
								p1.Dialogue:Hide();
								return;
							end;
							u8 = true;
							p1.Sound:Play("BasicClick");
							p1.Network:BindEvent("MoveRelearner", function(p9)
								p1.Network:UnbindEvent("MoveRelearner");
								if p9 ~= "LessThanFour" then
									if p9 == "FourMoves" then
										u7:Fire();
									end;
									return;
								end;
								p1.Sound:Play("PurchaseSuccess");
								p1.GlobalSignal:Fire("I've taught your " .. p8.Name .. " the move " .. v14 .. "!");
							end);
							u2.Visible = false;
							p1.Network:post("MoveRelearner", p8.ID, v14);
						end);
					end;
				end;
			end;
		end;
		u2.Scroller.CanvasSize = UDim2.new(0, 0, 0, u2.Scroller.UIListLayout.AbsoluteContentSize.Y);
	end;
	function u6.UpdateMoney(p10)
		if not u5 then
			p1.Gui:ChangeText(u2.Cash, "");
			return;
		end;
		p1.Gui:ChangeText(u2.Cash, "$" .. l__Utilities__1.AddComma(u5));
	end;
	function u6.ClearStars(p11)
		for v18, v19 in pairs(u2.DoodleImage.Rank:GetChildren()) do
			if v19:IsA("GuiObject") then
				v19:Destroy();
			end;
		end;
	end;
	function u6.SetupStars(p12, p13)
		local l__Rank__20 = u2.DoodleImage.Rank;
		local v21 = l__Rank__20.AbsoluteSize.Y / 3 * 2;
		for v22 = 1, p13.Star do
			p1.GuiObjs.Star:Clone().Parent = l__Rank__20;
		end;
		l__Rank__20.UIGridLayout.CellSize = UDim2.new(0, v21, 0, v21);
	end;
	function u6.Hide(p14)
		u2.Visible = false;
		p1.GlobalSignal:Fire("None");
	end;
	local function u9(p15, p16)
		p15.Moves[5] = {
			Name = p16, 
			PPUp = 0, 
			Uses = p1.Moves[p16].Uses
		};
	end;
	local function u10(p17, p18)
		for v23, v24 in pairs(p17) do
			if v24.ID == p18 then
				return v24;
			end;
		end;
		return nil;
	end;
	local function u11(p19, p20, p21)
		local v25 = nil;
		local v26, v27, v28 = pairs(p20);
		while true do
			local v29, v30 = v26(v27, v28);
			if not v29 then
				break;
			end;
			local v31 = false;
			for v32, v33 in pairs(p19) do
				if v30.Name == v33.Name then
					v31 = true;
					break;
				end;
			end;
			if not v31 then
				v25 = v30.Name;
				break;
			end;		
		end;
		if v25 ~= nil and v25 ~= p21 then
			return "MoveForgotten", v25;
		end;
		return "DidNotLearn";
	end;
	p1.Network:BindEvent("MoveRelearner4", function(p22, p23, p24)
		u7:Wait();
		local v34 = nil;
		local v35 = nil;
		for v36, v37 in pairs(p24) do
			if v37.ID == p22 then
				v35 = v37;
				break;
			end;
		end;
		if v35 then
			local v38 = nil;
			if p23 and #p23 > 0 then
				for v39, v40 in pairs(p23) do
					local u12 = v38;
					local u13 = v34;
					p1.Gui:SayChoiceText("Move Relearner", l__Utilities__1.GetName(v35) .. " wants to learn " .. v40 .. " but can't learn more than 4 moves. Make room for " .. v40 .. "?", nil, function()
						p1.Dialogue:Hide();
						u12 = u12 or l__Utilities__1:deepCopy(v35.Moves);
						p1.Menu.Blur();
						v35.Moves = u12;
						u9(v35, v40);
						local v41 = {};
						local u14 = l__Utilities__1:deepCopy(v35.Moves);
						function v41.CloseFunc(p25)
							local v42, v43 = p1.Network:get("RemoveExtraMove", p25.ID);
							local v44 = u10(v42, p25.ID);
							if v44 then
								local v45, v46 = u11(v44.Moves, u14, v40);
								if v45 == "DidNotLearn" then
									p1.Gui:SayText("Move Relearner", l__Utilities__1.GetName(p25) .. " did not learn " .. v40 .. ".", nil, true);
								elseif v45 == "MoveForgotten" then
									p1.Sound:Play("PurchaseSuccess");
									p1.Gui:SayText("Move Relearner", l__Utilities__1.GetName(p25) .. " forgot " .. v46 .. " and learned " .. v40 .. "!", nil, true);
									u13 = true;
								end;
								p25.Moves[5] = nil;
								u12 = l__Utilities__1:deepCopy(p25.Moves);
								p1.MoveLearn:Fire();
							end;
						end;
						v41.BattleAppear = true;
						v41.LearningMove = true;
						p1.Stats.new(v41, v35);
					end, function()
						l__Utilities__1.FastSpawn(function()
							p1.Gui:SayText("Move Relearner", l__Utilities__1.GetName(v35) .. " did not learn " .. v40 .. ".", nil, true);
							p1.Network:get("RemoveExtraMove", v35.ID);
							p1.MoveLearn:Fire();
						end);
					end, true);
					p1.MoveLearn:Wait();
					p1.Talky.Visible = false;
					p1.Menu.DisableBlur();
					if u13 then
						p1.GlobalSignal:Fire("NoMessage");
					else
						p1.GlobalSignal:Fire("Don't waste my time!");
					end;
				end;
			end;
		end;
	end);
	return u6;
end;
