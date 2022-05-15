-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local l__Network__2 = p1.Network;
	local u3 = nil;
	local v2 = l__Utilities__1.Class({
		ClassName = "SocialGui"
	}, function(p2)
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.UI = p2.maingui.Social;
		p2.Scroller = p2.UI.MainHolder.Scroller;
		p2.Holder = p2.Scroller.MaintainSize;
		p2.TextBox = p2.UI.TextBoxHolder.TextBox;
		p2.Requests = {};
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
			p2:Hide(true);
		end);
		l__Network__2:BindEvent("PlayerEvent", function(p3, p4)
			if p4 == "Join" then
				p2.Requests[p3] = {};
				p2:MakeButton(p3);
				return;
			end;
			if p4 == "Leave" then
				if u3 == p3 then
					p2:DestroyCurrentChallenge();
					p2:Show();
				end;
				p2:DestroyButton(p3);
				p2.Requests[p3] = nil;
			end;
		end);
		l__Network__2:BindEvent("UpdateSocial", function(p5, p6, p7)
			if not p2.Requests[p5] then
				p2.Requests[p5] = {};
			end;
			p2.Requests[p5][p6] = p7;
			if p6 == "Battle" then
				p2:UpdateChallengePrompt(p5);
			end;
			p2:UpdateButton(p5);
		end);
		p2.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
			p2:Search(p2.TextBox.Text);
		end);
		for v4, v5 in pairs(game.Players:GetPlayers()) do
			p2:MakeButton(v5, v4);
		end;
		return p2;
	end);
	function v2.DestroyCurrentChallenge(p8)
		if p8.CurrentChallenge then
			p8.CurrentChallenge:Destroy();
			p8.CurrentChallenge = nil;
		end;
		u3 = nil;
	end;
	local u4 = { 1, 1, 2, true, 1 };
	local u5 = { { 2, 1 } };
	function v2.CheckChallengeLegality(p9)
		local v6 = { u4[2], u4[3] };
		for v7, v8 in pairs(u5) do
			if v8[1] == v6[1] and v8[2] == v6[2] then
				return false;
			end;
		end;
		return true;
	end;
	local u6 = { "Competitive battles can't be set to level 5.", "Your team violates Item Clause. Make sure each Doodle has a unique item.", "Your team violates Species Clause. Make sure each Doodle is a unique species.", "Your team has a Doodle that cannot be obtained yet through normal means. You can't use: ", "Please re-open this prompt, something went wrong." };
	function v2.LegalCheck(p10)
		p10.CurrentChallenge.Action.Visible = false;
		p10.CurrentChallenge.NotAllowed.Visible = false;
		if not p10.CurrentChallenge then
			return;
		end;
		if not p10.Party then
			p10.CurrentChallenge.Action.Visible = false;
			p1.Gui:ChangeText(p10.CurrentChallenge.NotAllowed.Label, u6[4]);
			return;
		end;
		if not p10:CheckChallengeLegality() then
			p10.CurrentChallenge.Action.Visible = false;
			p1.Gui:ChangeText(p10.CurrentChallenge.NotAllowed.Label, u6[1]);
			p10.CurrentChallenge.NotAllowed.Visible = true;
			return;
		end;
		if u4[2] ~= 2 then
			p10.CurrentChallenge.Action.Visible = true;
			return;
		end;
		local v9 = l__Utilities__1.BannedList(p10.Party, p1.Blacklist);
		if not l__Utilities__1.ItemClauseCheck(p10.Party) then
			p1.Gui:ChangeText(p10.CurrentChallenge.NotAllowed.Label, u6[2]);
			p10.CurrentChallenge.NotAllowed.Visible = true;
			return;
		end;
		if not l__Utilities__1.SpeciesCheck(p10.Party) then
			p1.Gui:ChangeText(p10.CurrentChallenge.NotAllowed.Label, u6[3]);
			p10.CurrentChallenge.NotAllowed.Visible = true;
			return;
		end;
		if not v9 then
			p10.CurrentChallenge.Action.Visible = true;
			p10.CurrentChallenge.NotAllowed.Visible = false;
			return;
		end;
		p1.Gui:ChangeText(p10.CurrentChallenge.NotAllowed.Label, u6[4] .. table.concat(v9, ", ") .. ".");
		p10.CurrentChallenge.NotAllowed.Visible = true;
	end;
	local u7 = { {
			Name = "Format", 
			Settings = { "Singles", "Doubles" }
		}, {
			Name = "Ruleset", 
			Settings = { "Casual", "Competitive", "Random" }
		}, {
			Name = "Level", 
			Settings = { "Level 5", "Level 50", "Level 100", "Unchanged" }
		}, {
			Name = "Team Preview", 
			Settings = "Bool"
		}, {
			Name = "Time Limit", 
			Settings = { "5 Minutes", "15 Minutes", "Unlimited" }
		} };
	local u8 = {
		Singles = "Each player will only battle with one doodle out at a time.", 
		Doubles = "Each player will battle with two doodles out at a time.", 
		Casual = "Anything goes. No restrictions whatsoever.", 
		Competitive = "Every Doodle needs to be a unique species & needs to be holding a unique item.", 
		Random = "Each player will receive 6 random fully evolved Doodles. Unless set, their level will be proportional to their stats.", 
		["Level 5"] = "Every Doodle is set to level 5.", 
		["Level 50"] = "Every Doodle is set to level 50.", 
		["Level 100"] = "Every Doodle is set to level 100.", 
		Unchanged = "Every Doodle's level is unchanged.", 
		["Team Preview"] = "Each player can see a preview of the opponent's team before they battle.", 
		["5 Minutes"] = "The time limit for each player will be 5 minutes.", 
		["15 Minutes"] = "The time limit for each player will be 15 minutes", 
		Unlimited = "There is no time limit."
	};
	function v2.UpdateChallengePrompt(p11, p12)
		if p12 ~= u3 or not p11.CurrentChallenge then
			return;
		end;
		local l__Battle__10 = p11.Requests[p12].Battle;
		p11.CurrentChallenge.Action.Visible = false;
		p11.CurrentChallenge.Decline.Visible = false;
		p11.CurrentChallenge.Accept.Visible = false;
		p11.CurrentChallenge.NotAllowed.Visible = false;
		p11.CurrentChallenge.Retract.Visible = false;
		if l__Battle__10 == nil then
			p11:LegalCheck();
		elseif l__Battle__10.Type == "Sent" then
			p11.CurrentChallenge.Retract.Visible = true;
		elseif l__Battle__10.Type == "Request" then
			p11.CurrentChallenge.Decline.Visible = true;
			p11.CurrentChallenge.Accept.Visible = true;
		end;
		if l__Battle__10 and l__Battle__10.Data then
			for v11, v12 in pairs(u7) do
				local v13 = p11.CurrentChallenge.Holder.Scroller:FindFirstChild(v12.Name);
				if v13 then
					local v14 = l__Battle__10.Data[v11];
					if typeof(v12.Settings) == "table" then
						p1.Gui:ChangeText(v13.Desc.Label, u8[v12.Settings[v14]]);
						p1.Gui:ChangeText(v13.Choices.Label, v12.Settings[v14]);
					elseif typeof(v12.Settings) == "string" then
						v13.Bool.Label.Visible = l__Battle__10.Data[v11];
					end;
				end;
			end;
		end;
	end;
	function v2.MakeChallengePrompt(p13, p14, p15, p16)
		p13:DestroyCurrentChallenge();
		u3 = p14;
		p13.CurrentChallenge = p1.GuiObjs.Challenge:Clone();
		local v15 = p15 or u4;
		p1.Gui:Hover(p13.CurrentChallenge.Accept);
		p1.Gui:Hover(p13.CurrentChallenge.Decline);
		p1.Gui:Hover(p13.CurrentChallenge.Action);
		p1.Gui:Hover(p13.CurrentChallenge.Retract);
		if p13.Requests[p14] and p13.Requests[p14].Battle and p13.Requests[p14].Battle.Type == "Request" then
			p13.CurrentChallenge.Accept.Visible = true;
			p13.CurrentChallenge.Decline.Visible = true;
		elseif p13.Requests[p14] and p13.Requests[p14].Battle and p13.Requests[p14].Battle.Type == "Sent" then
			p13.CurrentChallenge.Retract.Visible = true;
		elseif p16 then
			p13:LegalCheck();
		end;
		local v16, v17, v18 = pairs(u7);
		while true do
			local v19 = nil;
			local v20, v21 = v16(v17, v18);
			if not v20 then
				break;
			end;
			v18 = v20;
			local v22 = p1.GuiObjs.ChallengeSetting:Clone();
			v22.Name = v21.Name;
			v22.Parent = p13.CurrentChallenge.Holder.Scroller;
			p1.Gui:ChangeText(v22.Label, v21.Name);
			v22.LayoutOrder = v20;
			v19 = function()
				return not p13.Requests[p14] or p13.Requests[p14] and not p13.Requests[p14].Battle;
			end;
			if typeof(v21.Settings) == "table" then
				v22.Choices.Visible = true;
				p1.Gui:ChangeText(v22.Desc.Label, u8[v21.Settings[v15[v20]]]);
				p1.Gui:ChangeText(v22.Choices.Label, v21.Settings[v15[v20]]);
				if p16 then
					p1.Gui:Hover(v22.Choices, nil, nil, v19);
					v22.Choices.MouseButton1Click:Connect(function()
						if p13.Requests[p14] and (not p13.Requests[p14] or not (not p13.Requests[p14].Battle)) then
							return;
						end;
						p1.Sound:Play("BasicClick");
						local v23 = v15[v20] + 1;
						if #v21.Settings < v23 then
							v23 = 1;
						end;
						u4[v20] = v23;
						p1.Gui:ChangeText(v22.Choices.Label, v21.Settings[v23]);
						p1.Gui:ChangeText(v22.Desc.Label, u8[v21.Settings[v23]]);
						p13:LegalCheck();
					end);
				end;
			elseif typeof(v21.Settings) == "string" then
				v22.Bool.Visible = true;
				v22.Bool.Label.Visible = v15[v20];
				p1.Gui:ChangeText(v22.Desc.Label, u8[v21.Name]);
				if p16 then
					p1.Gui:Hover(v22.Bool, nil, nil, v19);
					v22.Bool.MouseButton1Click:Connect(function()
						if not p13.Requests[p14] or p13.Requests[p14] and not p13.Requests[p14].Battle then
							p1.Sound:Play("BasicClick");
							u4[v20] = not u4[v20];
							v22.Bool.Label.Visible = u4[v20];
							p13:LegalCheck();
						end;
					end);
				end;
			end;		
		end;
		p13.CurrentChallenge.Close.MouseEnter:Connect(function()
			p13.CurrentChallenge.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p13.CurrentChallenge.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		p13.CurrentChallenge.Close.MouseLeave:Connect(function()
			p13.CurrentChallenge.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p13.CurrentChallenge.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p13.CurrentChallenge.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p13.CurrentChallenge.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p13.CurrentChallenge.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			p13.CurrentChallenge:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
				p13:DestroyCurrentChallenge();
			end);
			l__Utilities__1.Halt(0.2);
			p13:Show();
		end);
		if not p13.Requests[p14] or p13.Requests[p14] and not p13.Requests[p14].Battle then
			p1.Gui:ChangeText(p13.CurrentChallenge.Label, "Challenge " .. p14.DisplayName);
		end;
		p13.CurrentChallenge.Action.MouseButton1Click:Connect(function()
			if not p13.Requests[p14] or p13.Requests[p14] and not p13.Requests[p14].Battle then
				p1.Sound:Play("BasicClick");
				l__Network__2:post("RequestBattle", p14, u4);
			end;
		end);
		p13.CurrentChallenge.Retract.MouseButton1Click:Connect(function()
			if p13.Requests[p14].Battle and p13.Requests[p14].Battle.Type == "Sent" then
				p1.Sound:Play("BasicClick");
				l__Network__2:post("RequestBattle", p14, "Retract");
			end;
		end);
		local u9 = v15;
		p13.CurrentChallenge.Decline.MouseButton1Click:Connect(function()
			if p13.Requests[p14].Battle and p13.Requests[p14].Battle.Type == "Request" then
				p1.Sound:Play("BasicClick");
				l__Network__2:post("RequestBattle", p14, "Decline");
				u9 = u4;
			end;
		end);
		p13.CurrentChallenge.Accept.MouseButton1Click:Connect(function()
			if p13.Requests[p14].Battle and p13.Requests[p14].Battle.Type == "Request" then
				p1.Sound:Play("BasicClick");
				l__Network__2:post("RequestBattle", p14, "Accept");
			end;
		end);
		p13.CurrentChallenge.PlayerPortrait.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p14.UserId .. "&width=60&height=60&format=png";
		p13.CurrentChallenge.Holder.Scroller.CanvasSize = UDim2.new(0, 0, 0, p13.CurrentChallenge.Holder.Scroller.UIGridLayout.AbsoluteContentSize.Y);
		p13.CurrentChallenge.Parent = p13.maingui;
		p13.CurrentChallenge.Position = UDim2.new(0.5, 0, -1, -18);
		p13.CurrentChallenge.Visible = true;
		p13.CurrentChallenge:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
	end;
	local u10 = {};
	function v2.Search(p17, p18)
		if p18 == "Search" or p18 == "" then
			for v24, v25 in pairs(u10) do
				v25.Visible = true;
			end;
		else
			for v26, v27 in pairs(u10) do
				if v26.DisplayName:lower():find(p18:lower()) or v26.Name:lower():find(p18:lower()) then
					v27.Visible = true;
				else
					v27.Visible = false;
				end;
			end;
		end;
		p17.Scroller.CanvasSize = UDim2.new(0, 0, 0, p17.Holder.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v2.DestroyButton(p19, p20)
		if not u10[p20] then
			return;
		end;
		u10[p20]:Destroy();
		u10[p20] = nil;
		p19.Scroller.CanvasSize = UDim2.new(0, 0, 0, p19.Holder.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v2.UpdateButton(p21, p22)
		if not u10[p22] then
			return;
		end;
		if p21.Requests[p22] then
			local v28 = u10[p22];
			if p21.Requests[p22].Battle then
				if p21.Requests[p22].Battle.Type == "Request" then
					p1.Gui:ChangeText(v28.ButtonHolder.Battle.Label, "See Challenge");
				elseif p21.Requests[p22].Battle.Type == "Sent" then
					p1.Gui:ChangeText(v28.ButtonHolder.Battle.Label, "Challenged");
				end;
			else
				p1.Gui:ChangeText(v28.ButtonHolder.Battle.Label, "Battle");
			end;
			if p21.Requests[p22].Trade then
				if p21.Requests[p22].Trade.Type == "Sent" then
					p1.Gui:ChangeText(v28.ButtonHolder.Trade.Label, "Retract Trade");
					return;
				end;
				if p21.Requests[p22].Trade.Type == "Request" then
					p1.Gui:ChangeText(v28.ButtonHolder.Trade.Label, "Accept Trade");
					return;
				end;
			else
				p1.Gui:ChangeText(v28.ButtonHolder.Trade.Label, "Send Trade");
			end;
		end;
	end;
	local u11 = nil;
	function v2.MakeButton(p23, p24)
		if u10[p24] then
			return;
		end;
		local v29 = p1.GuiObjs.SocialPlayer:Clone();
		u10[p24] = v29;
		local v30 = 1;
		if p24 == game.Players.LocalPlayer then
			v30 = -10;
		end;
		p1.Gui:ChangeText(v29.Label, p24.DisplayName);
		v29.PlayerPortrait.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p24.UserId .. "&width=60&height=60&format=png";
		for v31, v32 in pairs(v29.ButtonHolder:GetChildren()) do
			if v32:IsA("GuiObject") then
				p1.Gui:Hover(v32);
			end;
		end;
		if p24 == game.Players.LocalPlayer then
			v29.ButtonHolder.Battle.Visible = false;
			v29.ButtonHolder.Trade.Visible = false;
		end;
		local u12 = false;
		v29.ButtonHolder.Trade.MouseButton1Click:Connect(function()
			if u12 == false then
				u12 = true;
				p1.Sound:Play("BasicClick");
				p23:TradeRequest(p24, v29);
				wait(0.5);
				u12 = false;
			end;
		end);
		v29.ButtonHolder.Battle.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p23:Hide();
			if p23.Requests[p24] then
				local v33 = p23.Requests[p24].Battle and p23.Requests[p24].Battle.Data or nil;
			else
				v33 = nil;
			end;
			p23:MakeChallengePrompt(p24, v33, true);
		end);
		v29.ButtonHolder.Passport.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p23:Hide();
			if u11 then
				u11:Destroy();
			end;
			u11 = p1.Passport.new({
				Player = p24, 
				Type = "Social"
			});
		end);
		v29.LayoutOrder = v30;
		v29.Parent = p23.Holder;
		p23.Scroller.CanvasSize = UDim2.new(0, 0, 0, p23.Holder.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v2.TradeRequest(p25, p26, p27)
		if p25.Requests[p26] and p25.Requests[p26].Trade and p25.Requests[p26].Trade.Type == "Request" then
			l__Network__2:post("RequestTrade", p26, "Accept");
			return;
		end;
		if p25.Requests[p26] and p25.Requests[p26].Trade and p25.Requests[p26].Trade.Type == "Sent" then
			l__Network__2:post("RequestTrade", p26, "Retract");
			return;
		end;
		l__Network__2:post("RequestTrade", p26, "Send");
	end;
	local u13 = nil;
	function v2.Show(p28)
		u13 = nil;
		p1.Gui:ChangeText(p28.TextBox, "Search");
		l__Utilities__1.Halt(0.2);
		p28.UI.Position = UDim2.new(0.5, 0, -1, 0);
		p28.UI.Visible = true;
		p28.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		l__Utilities__1.FastSpawn(function()
			p28.Party = p1.ClientDatabase:PDSFunc("GetParty");
		end);
		return p28;
	end;
	function v2.Hide(p29, p30)
		if u11 and u11.Destroy then
			u11:Destroy();
		else
			u11 = nil;
		end;
		p29:DestroyCurrentChallenge();
		p29.Close.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p29.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p29.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p29.UI.Visible = false;
		end);
		if p30 then
			l__Utilities__1.Halt(0.2);
			p1.Menu:EnableActive();
		end;
	end;
	local u14 = {};
	local function u15(p31)
		for v34, v35 in pairs(p31:GetDescendants()) do
			if v35:IsA("BasePart") or v35:IsA("Decal") then
				if v35.Transparency < 1 then
					u14[v35] = v35.Transparency;
					v35.Transparency = 1;
				end;
			elseif v35:IsA("TextLabel") and v35.Visible == true then
				u14[v35] = v35.Visible;
				v35.Visible = false;
			end;
		end;
	end;
	game.Players.PlayerAdded:Connect(function(p32)
		if p32 == game.Players.LocalPlayer then
			return;
		end;
		p32.CharacterAdded:Connect(function(p33)
			p33.Parent = workspace.TargetFilter;
			if p1.InCutscene then
				u15(p33);
			end;
		end);
	end);
	for v36, v37 in pairs(game.Players:GetPlayers()) do
		if v37.Character then
			v37.Character.Parent = workspace.TargetFilter;
		end;
	end;
	local function u16()
		for v38, v39 in pairs(u14) do
			if v38:IsDescendantOf(game) then
				if v38:IsA("BasePart") or v38:IsA("Decal") then
					v38.Transparency = v39;
				elseif v38:IsA("TextLabel") then
					v38.Visible = v39;
				end;
			end;
		end;
		u14 = {};
	end;
	function v2.PlayerVisibility(p34)
		if p34 then
			local l__TargetFilter__40 = workspace.TargetFilter;
		end;
		if p34 then
			if p34 then
				u16();
			end;
			return;
		end;
		for v41, v42 in pairs(game.Players:GetPlayers()) do
			if v42.Character and v42 ~= game.Players.LocalPlayer then
				u15(v42.Character);
			end;
		end;
	end;
	return v2.new();
end;
