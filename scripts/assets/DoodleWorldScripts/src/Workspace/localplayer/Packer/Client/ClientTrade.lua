-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local function u2()
		for v2, v3 in pairs(u1) do
			if v3 and v3.Disconnect then
				v3:Disconnect();
			end;
		end;
	end;
	local u3 = {};
	local function u4()
		u2();
		for v4, v5 in pairs(u3) do
			v5:Disconnect();
		end;
	end;
	local function u5(p2, p3)
		if p2.Player1 == p3 then
			return p2.Player1Side, p2.Player2Side;
		end;
		if p2.Player2 ~= p3 then
			return;
		end;
		return p2.Player2Side, p2.Player1Side;
	end;
	local l__Network__6 = p1.Network;
	local v6 = l__Utilities__1.Class({
		ClassName = "Trade"
	}, function(p4, p5)
		u4();
		p1.Menu:CloseAll();
		p1.Menu.Blur();
		p1.Menu:Disable();
		p4.GuiIDs = {};
		p4:UpdateTrade();
		p4.TradeData = p5;
		p4.TradeIndex = p4.TradeData.Index;
		local v7, v8 = u5(p5, game.Players.LocalPlayer);
		p4.SelfSide = v7;
		p4.OtherSide = v8;
		p4.Player = p4.SelfSide.Player;
		p4.Player2 = p4.OtherSide.Player;
		p4.Party = p4.SelfSide.Party;
		p4.Party2 = p4.OtherSide.Party;
		p4.OfferIDs = {
			[p4.Player] = {}, 
			[p4.Player2] = {}
		};
		l__Network__6:BindEvent("EndTrade" .. p4.TradeIndex, function(p6)
			p4:End(p6);
		end);
		p4.TradeGui = p1.guiholder:WaitForChild("Trade");
		p4.Offers = p4.TradeGui.Offers;
		p4.UserBg = p4.TradeGui.UserBackground;
		p4.OppBg = p4.TradeGui.OppBackground;
		p4.Close = p4.TradeGui.CancelButton;
		p4.Confirmation = p4.TradeGui.Confirmation;
		p4.Confirmation.Visible = false;
		p4:ReadyCheck();
		p4:SetupEvents();
		p4:ConfirmationEvents();
		p4:SetupTrade(p4.TradeGui, p5);
		p4.TradeGui.Position = UDim2.new(0.5, 0, -3, 0);
		p4.TradeGui.Visible = true;
		p4.TradeGui:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
		u3.Yes = p4.Confirmation.Yes.MouseButton1Click:Connect(function()
			if p4.Confirming then
				p1.Sound:Play("Boop", 0.8);
				p4.Confirmation.Yes.Visible = false;
				p4.Confirmation.No.Visible = false;
				l__Network__6:post("FinalReady" .. p4.TradeIndex, "Yes");
			end;
		end);
		u3.No = p4.Confirmation.No.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			l__Network__6:post("FinalReady" .. p4.TradeIndex, "No");
			p4.Confirming = nil;
		end);
		l__Network__6:BindEvent("Confirmation" .. p4.TradeIndex, function(p7)
			p4:DestroyCurrentChoice();
			if p7 ~= "Begin" then
				if p7 == "End" then
					p4.Confirmation:TweenPosition(UDim2.new(0, 0, -2.5, 0), "Out", "Quad", 0.5, true, function()
						p4.Confirmation.Visible = false;
					end);
					p4.Confirming = nil;
				end;
				return;
			end;
			p4.Confirming = true;
			p4.Confirmation.Yes.Visible = true;
			p4.Confirmation.No.Visible = true;
			p4.Confirmation.Position = UDim2.new(0, 0, -2.5, 0);
			p4.Confirmation.Visible = true;
			p4.Confirmation:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
		end);
		return p4;
	end);
	function v6.UpdateVariables(p8)
		local v9, v10 = u5(p8.TradeData, game.Players.LocalPlayer);
		p8.SelfSide = v9;
		p8.OtherSide = v10;
		p8.Player = p8.SelfSide.Player;
		p8.Player2 = p8.OtherSide.Player;
		p8.Party = p8.SelfSide.Party;
		p8.Party2 = p8.OtherSide.Party;
	end;
	function v6.DoodleOfferCheck(p9, p10, p11)
		for v11, v12 in pairs(p10) do
			if v12.ID == p11 then
				return v11;
			end;
		end;
		return nil;
	end;
	local u7 = { "Amulet", "Artifact", "Helmet" };
	local function u8(p12, p13)
		for v13, v14 in pairs(u7) do
			if p12.Equip[v14] ~= nil then
				local v15 = p1.Equipment:LookUp(p12.Equip[v14], v14);
				p13[v14].Image = v15.Image;
				p13[v14].Visible = true;
				p1.Tooltip.new({}, p13[v14], v14 .. ": " .. v15.Name);
			else
				p13[v14].Visible = false;
			end;
		end;
	end;
	function v6.UpdateTrade(p14)
		l__Network__6:BindEvent("UpdateTrade", function(p15)
			p14.TradeData = p15;
			p14:UpdateVariables();
			p14:ReadyCheck();
			for v16, v17 in pairs(p14.SelfSide.Offer) do
				if not table.find(p14.OfferIDs[p14.Player], v17.ID) then
					table.insert(p14.OfferIDs[p14.Player], v17.ID);
					local v18 = p14.GuiIDs[v17.ID];
					local v19 = v18.DoodleLabel:Clone();
					v6.Visibility(v18, false);
					v19.Size = UDim2.new(0, v18.DoodleLabel.AbsoluteSize.X, 0, v18.DoodleLabel.AbsoluteSize.Y);
					v19.Position = UDim2.new(0, v18.DoodleLabel.AbsolutePosition.X, 0, v18.DoodleLabel.AbsolutePosition.Y);
					v19.Visible = true;
					v19.ZIndex = 8;
					p1.Gui:StaticImage(v19, v17, true);
					v19.Parent = p1.guiholder;
					local v20 = p14.Offers["userDoodle" .. #p14.OfferIDs[p14.Player]];
					v20.FrontBorder.Visible = true;
					local l__AbsoluteSize__21 = v20.DoodleLabel.AbsoluteSize;
					local l__AbsolutePosition__22 = v20.DoodleLabel.AbsolutePosition;
					v19:TweenSizeAndPosition(UDim2.new(0, l__AbsoluteSize__21.X, 0, l__AbsoluteSize__21.Y), UDim2.new(0, l__AbsolutePosition__22.X + l__AbsoluteSize__21.X * 0.5, 0, l__AbsolutePosition__22.Y + l__AbsoluteSize__21.Y * 0.5), "Out", "Quad", 0.35);
					l__Utilities__1.Halt(0.35);
					p1.Gui:AnimateSprite(v20.DoodleLabel, v17, true);
					p1.Gui:ChangeText(v20.Lvl, v17.Level);
					v6.Visibility(v20, true);
					v20.Sparkles.Visible = v17.Shiny;
					v19:Destroy();
					p1.Gui:LoadingIconOff();
					p14.CurrentMoving = nil;
				end;
			end;
			for v23, v24 in pairs(p14.OtherSide.Offer) do
				if not table.find(p14.OfferIDs[p14.Player2], v24.ID) then
					table.insert(p14.OfferIDs[p14.Player2], v24.ID);
					local v25 = p14.GuiIDs[v24.ID];
					local v26 = v25.DoodleLabel:Clone();
					v6.Visibility(v25, false);
					v26.Size = UDim2.new(0, v25.DoodleLabel.AbsoluteSize.X, 0, v25.DoodleLabel.AbsoluteSize.Y);
					v26.Position = UDim2.new(0, v25.DoodleLabel.AbsolutePosition.X, 0, v25.DoodleLabel.AbsolutePosition.Y);
					v26.Visible = true;
					v26.ZIndex = 8;
					p1.Gui:StaticImage(v26, v24, true);
					v26.Parent = p1.guiholder;
					local v27 = p14.Offers["oppDoodle" .. #p14.OfferIDs[p14.Player2]];
					v27.FrontBorder.Visible = true;
					local l__AbsoluteSize__28 = v27.DoodleLabel.AbsoluteSize;
					local l__AbsolutePosition__29 = v27.DoodleLabel.AbsolutePosition;
					v26:TweenSizeAndPosition(UDim2.new(0, l__AbsoluteSize__28.X, 0, l__AbsoluteSize__28.Y), UDim2.new(0, l__AbsolutePosition__29.X + l__AbsoluteSize__28.X * 0.5, 0, l__AbsolutePosition__29.Y + l__AbsoluteSize__28.Y * 0.5), "Out", "Quad", 0.35);
					l__Utilities__1.FastSpawn(function()
						l__Utilities__1.Halt(0.35);
						p1.Gui:AnimateSprite(v27.DoodleLabel, v24, true);
						p1.Gui:ChangeText(v27.Lvl, v24.Level);
						v6.Visibility(v27, true);
						v27.Sparkles.Visible = v24.Shiny;
						v26:Destroy();
					end);
				end;
			end;
			local v30 = nil;
			local v31 = nil;
			for v32, v33 in pairs(p14.OfferIDs[p14.Player]) do
				if not p14:DoodleOfferCheck(p14.SelfSide.Offer, v33) then
					v30 = true;
					local v34 = l__Utilities__1:GetDoodleFromID(p14.SelfSide.Party, v33);
					table.remove(p14.OfferIDs[p14.Player], v32);
					local v35 = p14.Offers["userDoodle" .. v32];
					local v36 = p14.GuiIDs[v34.ID];
					local v37 = v35.DoodleLabel:Clone();
					v6.Visibility(v35, false);
					v37.Size = UDim2.new(0, v35.DoodleLabel.AbsoluteSize.X, 0, v35.DoodleLabel.AbsoluteSize.Y);
					v37.Position = UDim2.new(0, v35.DoodleLabel.AbsolutePosition.X, 0, v35.DoodleLabel.AbsolutePosition.Y);
					v37.Visible = true;
					v37.ZIndex = 8;
					p1.Gui:StaticImage(v37, v34, true);
					v37.Parent = p1.guiholder;
					v36.FrontBorder.Visible = true;
					local l__AbsoluteSize__38 = v36.DoodleLabel.AbsoluteSize;
					local l__AbsolutePosition__39 = v36.DoodleLabel.AbsolutePosition;
					v37:TweenSizeAndPosition(UDim2.new(0, l__AbsoluteSize__38.X, 0, l__AbsoluteSize__38.Y), UDim2.new(0, l__AbsolutePosition__39.X + l__AbsoluteSize__38.X * 0.5, 0, l__AbsolutePosition__39.Y + l__AbsoluteSize__38.Y * 0.5), "Out", "Quad", 0.35);
					l__Utilities__1.FastSpawn(function()
						l__Utilities__1.Halt(0.35);
						p1.Gui:AnimateSprite(v36.DoodleLabel, v34, true);
						p1.Gui:ChangeText(v36.Lvl, "Lvl. " .. v34.Level);
						v6.Visibility(v36, true);
						u8(v34, v36);
						v36.Sparkles.Visible = v34.Shiny;
						v37:Destroy();
						p14.CurrentMoving = nil;
						p1.Gui:LoadingIconOff();
					end);
				end;
			end;
			for v40, v41 in pairs(p14.OfferIDs[p14.Player2]) do
				if not p14:DoodleOfferCheck(p14.OtherSide.Offer, v41) then
					v31 = true;
					local v42 = l__Utilities__1:GetDoodleFromID(p14.OtherSide.Party, v41);
					table.remove(p14.OfferIDs[p14.Player2], v40);
					local v43 = p14.Offers["oppDoodle" .. v40];
					local v44 = p14.GuiIDs[v42.ID];
					local v45 = v43.DoodleLabel:Clone();
					v6.Visibility(v43, false);
					v45.Size = UDim2.new(0, v43.DoodleLabel.AbsoluteSize.X, 0, v43.DoodleLabel.AbsoluteSize.Y);
					v45.Position = UDim2.new(0, v43.DoodleLabel.AbsolutePosition.X, 0, v43.DoodleLabel.AbsolutePosition.Y);
					v45.Visible = true;
					v45.ZIndex = 8;
					p1.Gui:StaticImage(v45, v42, true);
					v45.Parent = p1.guiholder;
					v44.FrontBorder.Visible = true;
					local l__AbsoluteSize__46 = v44.DoodleLabel.AbsoluteSize;
					local l__AbsolutePosition__47 = v44.DoodleLabel.AbsolutePosition;
					v45:TweenSizeAndPosition(UDim2.new(0, l__AbsoluteSize__46.X, 0, l__AbsoluteSize__46.Y), UDim2.new(0, l__AbsolutePosition__47.X + l__AbsoluteSize__46.X * 0.5, 0, l__AbsolutePosition__47.Y + l__AbsoluteSize__46.Y * 0.5), "Out", "Quad", 0.35);
					l__Utilities__1.FastSpawn(function()
						l__Utilities__1.Halt(0.35);
						p1.Gui:AnimateSprite(v44.DoodleLabel, v42, true);
						p1.Gui:ChangeText(v44.Lvl, "Lvl. " .. v42.Level);
						v6.Visibility(v44, true);
						u8(v42, v44);
						v44.Sparkles.Visible = v42.Shiny;
						v45:Destroy();
						p14.CurrentMoving = nil;
					end);
				end;
			end;
			if not p14.MovingStuff then
				p14.MovingStuff = true;
				for v48, v49 in pairs(p14.Offers:GetChildren()) do
					if v49.Name:find("userDoodle") then
						if v30 then
							v6.Visibility(v49, false);
							p14.OfferIDs[p14.Player] = {};
						end;
					elseif v49.Name:find("oppDoodle") and v31 then
						v6.Visibility(v49, false);
						p14.OfferIDs[p14.Player2] = {};
					end;
				end;
			end;
			if v30 then
				for v50, v51 in pairs(p14.SelfSide.Offer) do
					local v52 = p14.Offers["userDoodle" .. v50];
					p1.Gui:AnimateSprite(v52.DoodleLabel, v51, true);
					p1.Gui:ChangeText(v52.Lvl, v51.Level);
					v6.Visibility(v52, true);
					v52.Sparkles.Visible = v51.Shiny;
					table.insert(p14.OfferIDs[p14.Player], v51.ID);
				end;
			end;
			if v31 then
				for v53, v54 in pairs(p14.OtherSide.Offer) do
					local v55 = p14.Offers["oppDoodle" .. v53];
					p1.Gui:AnimateSprite(v55.DoodleLabel, v54, true);
					p1.Gui:ChangeText(v55.Lvl, v54.Level);
					v6.Visibility(v55, true);
					v55.Sparkles.Visible = v54.Shiny;
					table.insert(p14.OfferIDs[p14.Player2], v54.ID);
				end;
			end;
			p14.MovingStuff = nil;
		end);
	end;
	function v6.Visibility(p16, p17)
		for v56, v57 in pairs(p16:GetChildren()) do
			v57.Visible = p17;
		end;
		if p16:FindFirstChild("DoodleLabel") then
			p16.DoodleLabel.Visible = false;
		end;
	end;
	function v6.ConfirmationEvents(p18)
		u3.UpdateTimer = game.Players.LocalPlayer.PvPTimer.Changed:Connect(function()
			local v58 = "seconds";
			if game.Players.LocalPlayer.PvPTimer.Value == 1 then
				v58 = "second";
			end;
			p1.Gui:ChangeText(p18.Confirmation.Timer, "You have " .. game.Players.LocalPlayer.PvPTimer.Value .. " " .. v58 .. ".");
		end);
		p1.Gui:PushButton(p18.Confirmation.No);
		p1.Gui:PushButton(p18.Confirmation.Yes);
	end;
	function v6.SetupEvents(p19)
		u3.CloseEnter = p19.Close.MouseEnter:Connect(function()
			p19.Close.ImageColor3 = Color3.fromRGB(154, 50.666666666666664, 40);
		end);
		u3.CloseLeave = p19.Close.MouseLeave:Connect(function()
			p19.Close.ImageColor3 = Color3.fromRGB(231, 76, 60);
		end);
		local u9 = nil;
		u3.CloseClick = p19.Close.MouseButton1Click:Connect(function()
			if not u9 and p19.Confirmed == nil then
				u9 = true;
				p1.Sound:Play("Boop", 0.8);
				l__Network__6:post("EndTrade" .. p19.TradeIndex);
			end;
		end);
		local l__TradeButton__59 = p19.TradeGui.TradeButton;
		local u10 = false;
		local u11 = UDim2.new(0.35, 0, 0.997, -4);
		u3.TradebuttonDown = l__TradeButton__59.MouseButton1Down:Connect(function()
			if not p19.Confirming and not u10 then
				u10 = true;
				p1.Sound:Play("Boop", 1);
				l__TradeButton__59:TweenPosition(u11 + UDim2.new(0, 0, 0, 6), "Out", "Linear", 0.1, true);
				l__TradeButton__59.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
				l__Network__6:post("Ready" .. p19.TradeIndex);
				l__Utilities__1.Halt(0.25);
				u10 = false;
			end;
		end);
		local u12 = UDim2.new(0.5, 0, 0.5, 6);
		u3.TradebuttonUp = l__TradeButton__59.MouseButton1Up:Connect(function()
			l__TradeButton__59:TweenPosition(u11, "Out", "Linear", 0.1, true);
			l__TradeButton__59.Border:TweenPosition(u12, "Out", "Linear", 0.1, true);
		end);
		u3.TradebuttonLeave = l__TradeButton__59.MouseLeave:Connect(function()
			l__TradeButton__59:TweenPosition(u11, "Out", "Linear", 0.1, true);
			l__TradeButton__59.Border:TweenPosition(u12, "Out", "Linear", 0.1, true);
		end);
	end;
	function v6.DestroyCurrentChoice(p20)
		if p20.CurrentChoice then
			p20.CurrentChoice:Destroy();
		end;
		p20.CurrentChoice = nil;
		p20.CurrentDoodle = nil;
	end;
	local u13 = nil;
	function v6.SetupChoice(p21, p22, p23, p24, p25)
		if u13 then
			return;
		end;
		p21.CurrentChoice = p24 and p1.GuiObjs.UserChoice:Clone() or p1.GuiObjs.OppChoice:Clone();
		for v60, v61 in pairs(p21.CurrentChoice:GetChildren()) do
			if v61:IsA("ImageButton") then
				p1.Gui:Hover(v61);
			end;
		end;
		p21.CurrentChoice.Stats.MouseButton1Click:Connect(function()
			p21.CurrentChoice.Visible = false;
			p1.Sound:Play("BasicClick");
			p21.TradeGui.Visible = false;
			p1.Stats.new({
				PlayerParty = p24 and p21.Party or p21.Party2, 
				Trading = p21, 
				Other = p24 ~= p1.p
			}, p22);
		end);
		p21.CurrentChoice.Cancel.MouseButton1Click:Connect(function()
			p21:DestroyCurrentChoice();
		end);
		if p24 then
			if p25 then
				p1.Gui:ChangeText(p21.CurrentChoice.Offer.Label, "Remove");
			end;
			if p21.Confirming then
				p21.CurrentChoice.Offer.Label.TextColor3 = Color3.fromRGB(128, 128, 128);
			end;
			p21.CurrentChoice.Offer.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick");
				if p22.TL then
					p21:DestroyCurrentChoice();
					if not u13 then
						u13 = true;
						p1.Gui:SayText("", "This Doodle can't be traded away!", nil, true);
						u13 = nil;
						p1.Dialogue:Hide();
					end;
					return;
				end;
				if not p1.TradeAllowed and p22.RM then
					if not u13 then
						u13 = true;
						p1.Gui:SayText("", "You can't trade this Doodle away due to your country's laws.", nil, true);
						u13 = nil;
						p1.Dialogue:Hide();
					end;
					return;
				end;
				if not p21.Confirming then
					p21:DestroyCurrentChoice();
					p1.Gui:LoadingIcon();
					if not p25 then
						p1.Network:post("AddOffer" .. p21.TradeIndex, p22.ID);
						return;
					end;
				else
					return;
				end;
				p1.Network:post("RemoveOffer" .. p21.TradeIndex, p22.ID);
			end);
		end;
		p21.CurrentDoodle = p22;
		p21.CurrentChoice.Position = UDim2.new(0, p23.X, 0, p23.Y);
		p21.CurrentChoice.Parent = p1.guiholder;
	end;
	function v6.MakeCollideTable(p26)
		local v62 = {};
		for v63, v64 in pairs(p26.Offers:GetChildren()) do
			if v64.Name:find("userDoodle") then
				table.insert(v62, v64);
			end;
		end;
		return v62;
	end;
	function v6.OfferDraggable(p27, p28)
		local v65 = Color3.fromRGB(56, 179, 255);
		local v66 = p27.Player2;
		local v67 = p27.OtherSide;
		local v68 = p28.Name:find("user");
		if v68 then
			v67 = p27.SelfSide;
			v66 = p27.Player;
			v65 = Color3.fromRGB(85, 133, 255);
		end;
		local u14 = tonumber(p28.Name:match("%d+"));
		u3[p28.Name .. "Enter"] = p28.MouseEnter:Connect(function()
			local v69 = l__Utilities__1:GetDoodleFromID(v67.Party, p27.OfferIDs[v66][u14]);
			if v69 and (not p27.CurrentDoodle or p27.CurrentDoodle and p27.CurrentDoodle.ID ~= v69.ID) then
				p28.FrontBorder.ImageColor3 = p1.Gui:DarkerColor(v65);
			end;
		end);
		u3[p28.Name .. "Leave"] = p28.MouseLeave:Connect(function()
			local v70 = l__Utilities__1:GetDoodleFromID(v67.Party, p27.OfferIDs[v66][u14]);
			if v70 and (not p27.CurrentDoodle or p27.CurrentDoodle and not p27.CurrentDoodle.ID ~= v70.ID) then
				p28.FrontBorder.ImageColor3 = v65;
			end;
		end);
		if not v68 then
			u3[p28.Name .. "Click"] = p28.MouseButton1Click:Connect(function()
				local v71 = l__Utilities__1:GetDoodleFromID(v67.Party, p27.OfferIDs[v66][u14]);
				if v71 then
					p28.FrontBorder.ImageColor3 = v65;
					p1.Sound:Play("BasicClick");
					p27:DestroyCurrentChoice();
					p27:SetupChoice(v71, p1.p:GetMouse(), v68);
				end;
			end);
		else
			local v72 = {
				NotBigger = true, 
				Collide = { p27.UserBg, p27.OppBg }, 
				Requirement = function()
					if not table.find(p27.OfferIDs[p27.Player], p27.OfferIDs[v66][u14]) then
						return false;
					end;
					return true;
				end, 
				Function = function(p29)
					if not p27.Confirming and not p27.CurrentMoving then
						p27.CurrentMoving = true;
						p27:DestroyCurrentChoice();
						p1.Gui:LoadingIcon();
						p1.Network:post("RemoveOffer" .. p27.TradeIndex, p27.OfferIDs[v66][u14]);
					end;
				end, 
				StartDraggingFunc = function()
					p27:DestroyCurrentChoice();
				end
			};
			function v72.IfNoDragging()
				local v73 = l__Utilities__1:GetDoodleFromID(v67.Party, p27.OfferIDs[v66][u14]);
				if table.find(p27.OfferIDs[p27.Player], v73.ID) then
					p28.FrontBorder.ImageColor3 = v65;
					p27:SetupChoice(v73, p1.p:GetMouse(), v68, "Remove");
				end;
			end;
			table.insert(u1, (p1.GuiDragging.new(v72, p28)));
		end;
	end;
	local l__ScrollList__15 = p1.ScrollList;
	function v6.MakeButton(p30, p31, p32, p33)
		local v74 = p30.OppBg;
		local v75 = Color3.fromRGB(56, 179, 255);
		if p33 then
			v74 = p30.UserBg;
			v75 = Color3.fromRGB(85, 133, 255);
		end;
		local v76 = v74["Doodle" .. p31];
		p1.Gui:ChangeText(v76.Lvl, "Lvl. " .. p32.Level);
		p1.Gui:ChangeText(v76.DoodleName, l__Utilities__1.GetName(p32));
		p1.Gui:AnimateSprite(v76.DoodleLabel, p32, true);
		if p32.HeldItem == nil then
			v76.Item.Visible = false;
		else
			if table.find(l__ScrollList__15, p32.HeldItem) then
				v76.Item.Image = p1.ItemList.Scroll.Image;
				v76.Item.ImageColor3 = p1.Typings.Visual[p1.Moves[p32.HeldItem].Type].Color;
			else
				v76.Item.Image = p1.ItemList[p32.HeldItem].Image;
				v76.Item.ImageColor3 = Color3.fromRGB(255, 255, 255);
			end;
			v76.Item.Visible = true;
		end;
		u8(p32, v76);
		v76.Sparkles.Visible = p32.Shiny;
		u3[p32.ID .. "Enter"] = v76.MouseEnter:Connect(function()
			if not p30.CurrentDoodle or p30.CurrentDoodle and p30.CurrentDoodle.ID ~= p32.ID then
				v76.FrontBorder.ImageColor3 = p1.Gui:DarkerColor(v75);
			end;
		end);
		u3[p32.ID .. "Leave"] = v76.MouseLeave:Connect(function()
			if not p30.CurrentDoodle or p30.CurrentDoodle and p30.CurrentDoodle.ID ~= p32.ID then
				v76.FrontBorder.ImageColor3 = v75;
			end;
		end);
		p30.GuiIDs[p32.ID] = v76;
		if not p33 then
			u3[p32.ID .. "Click"] = v76.MouseButton1Click:Connect(function()
				if not p30.Confirming and not table.find(p30.OfferIDs[p30.Player], p32.ID) and not table.find(p30.OfferIDs[p30.Player2], p32.ID) then
					v76.FrontBorder.ImageColor3 = v75;
					p1.Sound:Play("BasicClick");
					p30:DestroyCurrentChoice();
					p30:SetupChoice(p32, p1.p:GetMouse(), p33);
				end;
			end);
		else
			local v77 = {
				NotBigger = true, 
				Collide = p30:MakeCollideTable(), 
				Requirement = function()
					if u13 then
						return false;
					end;
					if not p30.Confirming and not table.find(p30.OfferIDs[p30.Player], p32.ID) then
						return true;
					end;
					return false;
				end, 
				Function = function(p34)
					if p32.TL then
						p30:DestroyCurrentChoice();
						if not u13 then
							u13 = true;
							p1.Gui:SayText("", "This Doodle can't be traded away!", nil, true);
							u13 = nil;
							p1.Dialogue:Hide();
						end;
						return;
					end;
					if not p1.TradeAllowed and p32.RM then
						if not u13 then
							u13 = true;
							p1.Gui:SayText("", "You can't trade this Doodle away due to your country's laws.", nil, true);
							u13 = nil;
							p1.Dialogue:Hide();
						end;
						return;
					end;
					if not p30.Confirming and not p30.CurrentMoving then
						p30.CurrentMoving = true;
						p30:DestroyCurrentChoice();
						p1.Gui:LoadingIcon();
						p1.Network:post("AddOffer" .. p30.TradeIndex, p32.ID);
					end;
				end, 
				StartDraggingFunc = function()
					p30:DestroyCurrentChoice();
				end
			};
			function v77.IfNoDragging()
				if not p30.Confirming and not table.find(p30.OfferIDs[p30.Player], p32.ID) and not table.find(p30.OfferIDs[p30.Player2], p32.ID) then
					v76.FrontBorder.ImageColor3 = v75;
					p30:SetupChoice(p32, p1.p:GetMouse(), p33);
				end;
			end;
			table.insert(u1, (p1.GuiDragging.new(v77, v76)));
		end;
		v76.Visible = true;
	end;
	function v6.ReadyCheck(p35)
		local v78 = {
			[true] = {
				String = "Ready", 
				Color = Color3.fromRGB(0, 147, 0), 
				Tradebutton = "Unready"
			}, 
			[false] = {
				String = "Not Ready", 
				Color = Color3.fromRGB(147, 0, 0), 
				Tradebutton = "Trade"
			}
		};
		local l__Ready__79 = p35.SelfSide.Ready;
		p35.Offers.userReady.Ready.TextColor3 = v78[l__Ready__79].Color;
		p1.Gui:ChangeText(p35.Offers.userReady.Ready, v78[l__Ready__79].String);
		p1.Gui:ChangeText(p35.TradeGui.TradeButton.Ready, v78[l__Ready__79].Tradebutton);
		local l__Ready__80 = p35.OtherSide.Ready;
		p35.Offers.oppReady.Ready.TextColor3 = v78[l__Ready__80].Color;
		p1.Gui:ChangeText(p35.Offers.oppReady.Ready, v78[l__Ready__80].String);
	end;
	function v6.SetupTrade(p36)
		for v81, v82 in pairs(p36.TradeGui.UserBackground:GetChildren()) do
			if v82:IsA("ImageButton") then
				p36.Visibility(v82, true);
				v82.Visible = false;
			end;
		end;
		for v83, v84 in pairs(p36.TradeGui.OppBackground:GetChildren()) do
			if v84:IsA("ImageButton") then
				p36.Visibility(v84, true);
				v84.Visible = false;
			end;
		end;
		for v85, v86 in pairs(p36.TradeGui.Offers:GetChildren()) do
			if v86.Name:find("Doodle") then
				p36:OfferDraggable(v86);
				p36.Visibility(v86, false);
			end;
		end;
		p36.TradeGui.UserBackground.Title.Text = p36.Player.DisplayName .. "'s Doodles";
		p36.TradeGui.OppBackground.Title.Text = p36.Player2.DisplayName .. "'s Doodles";
		p36.TradeGui.userImage.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&username=" .. p36.Player.Name;
		p36.TradeGui.oppImage.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&username=" .. p36.Player2.Name;
		for v87, v88 in pairs(p36.SelfSide.Party) do
			p36:MakeButton(v87, v88, true);
		end;
		for v89, v90 in pairs(p36.OtherSide.Party) do
			p36:MakeButton(v89, v90, false);
		end;
	end;
	function v6.CloseTrade(p37)
		u4();
		l__Network__6:UnbindEvent("UpdateTrade");
		l__Network__6:UnbindEvent("Confirmation" .. p37.TradeIndex);
		l__Network__6:UnbindEvent("EndTrade" .. p37.TradeIndex);
		p37:DestroyCurrentChoice();
		p1.Controls:ToggleWalk(true);
		p1.Menu.DisableBlur();
		p1.Battle.CurrentBattle = nil;
		p37.TradeData = nil;
		p37 = nil;
	end;
	function v6.End(p38, p39)
		p1.guiholder.Dragging:ClearAllChildren();
		p38.TradeGui:TweenPosition(UDim2.new(0.5, 0, 3, 0), "Out", "Quad", 0.5, true, function()
			p38.TradeGui.Visible = false;
		end);
		if p39 == nil then
			p38:CloseTrade();
		elseif p39 then
			local l__TradeResult__91 = p1.guiholder.TradeResult;
			p38.Confirmed = false;
			u3.Confirm = l__TradeResult__91.Confirm.MouseButton1Click:Connect(function()
				if not p38.Confirmed then
					p38:CloseTrade();
					p38.Confirmed = true;
					p1.Sound:Play("BasicClick");
					l__TradeResult__91:TweenPosition(UDim2.new(0.5, 0, 2.5, 0), "Out", "Quad", 0.5, true, function()
						l__TradeResult__91.Visible = false;
					end);
				end;
			end);
			p1.Gui:PushButton(l__TradeResult__91.Confirm);
			for v92, v93 in pairs(l__TradeResult__91:GetChildren()) do
				if v93.Name:find("Doodle") then
					v93.Visible = false;
				end;
			end;
			l__TradeResult__91.Confirm.Visible = false;
			for v94, v95 in pairs(u5(p39.Data, game.Players.LocalPlayer).Offer) do
				local v96 = l__TradeResult__91["Doodle" .. v94];
				p1.Gui:AnimateSprite(v96.DoodleLabel, v95, true);
				p1.Gui:ChangeText(v96.Lvl, v95.Level);
				p1.Gui:ChangeText(v96.DoodleName, l__Utilities__1.GetName(v95));
				v96.Sparkles.Visible = v95.Shiny;
				if v95.HeldItem == nil then
					v96.Item.Visible = false;
				else
					if table.find(l__ScrollList__15, v95.HeldItem) then
						v96.Item.Image = p1.ItemList.Scroll.Image;
						v96.Item.ImageColor3 = p1.Typings.Visual[p1.Moves[v95.HeldItem].Type].Color;
					else
						v96.Item.Image = p1.ItemList[v95.HeldItem].Image;
						v96.Item.ImageColor3 = Color3.fromRGB(255, 255, 255);
					end;
					v96.Item.Visible = true;
				end;
				v96.Visible = true;
			end;
			l__TradeResult__91.Position = UDim2.new(0.5, 0, 2.5, 0);
			l__TradeResult__91.Visible = true;
			l__TradeResult__91:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
			l__Utilities__1.Halt(3);
			l__TradeResult__91:TweenPosition(UDim2.new(0.5, 0, -2.5, 0), "Out", "Quad", 0.5, true);
			l__Utilities__1.Halt(0.5);
			for v97, v98 in pairs(l__TradeResult__91:GetChildren()) do
				if v98.Name:find("Doodle") then
					v98.Visible = false;
				end;
			end;
			l__TradeResult__91.Confirm.Visible = true;
			for v99, v100 in pairs(p39.Result) do
				local l__Doodle__101 = v100.Doodle;
				local v102 = l__TradeResult__91["Doodle" .. v99];
				p1.Gui:AnimateSprite(v102.DoodleLabel, l__Doodle__101, true);
				p1.Gui:ChangeText(v102.Lvl, l__Doodle__101.Level);
				p1.Gui:ChangeText(v102.DoodleName, v100.Location);
				v102.Sparkles.Visible = l__Doodle__101.Shiny;
				if l__Doodle__101.HeldItem == nil then
					v102.Item.Visible = false;
				else
					if table.find(l__ScrollList__15, l__Doodle__101.HeldItem) then
						v102.Item.Image = p1.ItemList.Scroll.Image;
						v102.Item.ImageColor3 = p1.Typings.Visual[p1.Moves[l__Doodle__101.HeldItem].Type].Color;
					else
						v102.Item.Image = p1.ItemList[l__Doodle__101.HeldItem].Image;
						v102.Item.ImageColor3 = Color3.fromRGB(255, 255, 255);
					end;
					v102.Item.Visible = true;
				end;
				v102.DoodleName.Visible = true;
				v102.Visible = true;
			end;
			l__TradeResult__91:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true);
		end;
		p1.guiholder.Dragging:ClearAllChildren();
	end;
	l__Network__6:BindEvent("Trade", function(p40)
		p1.Battle.CurrentBattle = true;
		l__Utilities__1.FastSpawn(function()
			p1.Social:Hide();
		end);
		p1.CurrentTrade = v6.new({}, p40);
	end);
end;
