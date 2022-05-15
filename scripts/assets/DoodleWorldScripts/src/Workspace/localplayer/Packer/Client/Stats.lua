--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = {};
	local function u3()
		p1.guiholder.Dragging:ClearAllChildren();
		for v2, v3 in pairs(u2) do
			if typeof(v3) == "table" or typeof(v3) == "RBXScriptConnection" then
				v3:Disconnect();
			end;
		end;
		u2 = {};
	end;
	local function u4()
		for v4, v5 in pairs(u1) do
			if typeof(v5) == "table" or typeof(v5) == "RBXScriptConnection" then
				v5:Disconnect();
			end;
		end;
		u1 = {};
	end;
	local u5 = {};
	local u6 = nil;
	local u7 = "Info";
	local function u8()
		u3();
		u4();
		for v6, v7 in pairs(u5) do
			if typeof(v7) == "RBXScriptConnection" or typeof(v7) == "table" then
				v7:Disconnect();
			end;
		end;
		u5 = {};
	end;
	local function u9(p2, p3)
		for v8, v9 in pairs(p2) do
			if v9.ID == p3 then
				return v8;
			end;
		end;
	end;
	local function u10(p4, p5, p6)
		local v10 = nil;
		for v11, v12 in pairs(p4) do
			if v12.ID == p5 then
				v10 = tonumber(v11);
			end;
		end;
		local v13 = 1;
		local v14 = 1;
		for v15 = 25, 1, -1 do
			if p4[tostring(v15)] then
				v13 = v15;
			end;
		end;
		for v16 = 1, 25 do
			if p4[tostring(v16)] then
				v14 = v16;
			end;
		end;
		if v10 then
			if p6 == "Left" then
				local v17 = nil;
				local v18 = nil;
				local v19 = nil;
				local v20 = nil;
				local v21 = nil;
				local v22 = nil;
				if v10 ~= 1 then
					for v23 = v10 - 1, 1, -1 do
						local v24 = tostring(v23);
						if p4[v24] and p4[v24].Name then
							return v24;
						end;
					end;
					v18 = tostring;
					v17 = v14;
					v19 = v17;
					v20 = v18;
					v21 = v19;
					v22 = v20(v21);
					return v22;
				else
					v18 = tostring;
					v17 = v14;
					v19 = v17;
					v20 = v18;
					v21 = v19;
					v22 = v20(v21);
					return v22;
				end;
			end;
			if p6 ~= "Right" then
				return;
			end;
		else
			return;
		end;
		if v10 ~= 25 then
			for v25 = v10 + 1, 25 do
				local v26 = tostring(v25);
				if p4[v26] and p4[v26].Name then
					return v26;
				end;
			end;
		end;
		return tostring(v13);
	end;
	local v27 = l__Utilities__1.Class({
		StatName = "StatPage"
	}, function(p7, p8)
		u6 = p1.ColorAnim;
		p7.Doodle = p8;
		if u7 == "Customize" and p7.Battle then
			u7 = "Info";
		end;
		p7.DoodleInfo = p1.DoodleInfo[p8.RealName or p8.Name];
		p7.Gui = p1.guiholder:WaitForChild("Stats");
		p1.Sound:Play("PageFlip", 1, 3);
		u8();
		if p7.BattleAppear then
			p7:PageFlip("Moves");
		else
			p7:PageFlip(u7);
		end;
		p7:GlobalHalf();
		p7:SetupTabs();
		if not (not p7.Battle) or not (not p7.TeamPreview) or p7.Trading then
			p7.Gui.Tabs.Customize.Visible = false;
		else
			p7.Gui.Tabs.Customize.Visible = true;
		end;
		p7.Gui.Left.Visible = false;
		p7.Gui.Right.Visible = false;
		p7.Gui.Left.Position = UDim2.new(-0.1, 0, 0.5, 0);
		p7.Gui.Right.Position = UDim2.new(1.1, 0, 0.5, 0);
		if not p1.Gui:IsGuiOnScreen(p7.Gui.Left) then
			p7.Gui.Left.Position = UDim2.new(-0.05, 0, 0.5, 0);
			p7.Gui.Right.Position = UDim2.new(1.05, 0, 0.5, 0);
		end;
		p1.Gui:Hover(p7.Gui.Left);
		p1.Gui:Hover(p7.Gui.Right);
		if p7.PlayerParty or p7.Box then
			local u11 = p7.PlayerParty or p7.Box;
			u5.Left = p7.Gui.Left.MouseButton1Click:Connect(function()
				if p7.CloseFunc then
					p7.CloseFunc(p7.Doodle, p7.PlayerParty);
				end;
				local v28 = u9(u11, p7.Doodle.ID);
				if u11 == p7.PlayerParty then
					if v28 == 1 then
						v28 = #p7.PlayerParty;
					else
						v28 = v28 - 1;
					end;
				elseif u11 == p7.Box then
					v28 = u10(u11, p7.Doodle.ID, "Left");
				end;
				local v29 = p7:GetSentTable(v28);
				u8();
				if p7 and p7.Destroy then
					p7:Destroy(true);
				end;
				p1.Stats.new(v29, u11[v28]);
			end);
			u5.Right = p7.Gui.Right.MouseButton1Click:Connect(function()
				if p7.CloseFunc then
					p7.CloseFunc(p7.Doodle, p7.PlayerParty);
				end;
				local v30 = u9(u11, p7.Doodle.ID);
				if u11 == p7.PlayerParty then
					if v30 == #p7.PlayerParty then
						v30 = 1;
					else
						v30 = v30 + 1;
					end;
				elseif u11 == p7.Box then
					v30 = u10(u11, p7.Doodle.ID, "Right");
				end;
				local v31 = p7:GetSentTable(v30);
				u8();
				if p7 and p7.Destroy then
					p7:Destroy(true);
				end;
				p1.Stats.new(v31, u11[v30]);
			end);
			p7.Gui.Left.Visible = true;
			p7.Gui.Right.Visible = true;
		end;
		u5.CloseClick = p7.Gui.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p7.Gui.Visible = false;
			p7.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p7.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			u8();
			if p7.CloseFunc then
				p7.CloseFunc(p7.Doodle);
			elseif p7.PC then
				p7.PC:Show(p7.Doodle, p7.CurrentBox);
			elseif p7.BattleAppear then
				p7.BattleAppear(p7.Doodle);
			end;
			if p7.Party and not p7.PC then
				p7.Party:Show(p7.Doodle);
			end;
			if p7.TeamPreview then
				p7.TeamPreview.Show();
			elseif p7.Trading then
				if p7.Trading.CurrentChoice then
					p7.Trading.CurrentChoice.Visible = true;
				end;
				p7.Trading.TradeGui.Visible = true;
			elseif p7.Results then
				p7.Results.Visible = true;
				p7.Roulette.Visible = true;
			elseif p7.Roulette then
				p7.Roulette.Visible = true;
			end;
			if p7 and p7.Destroy then
				p7:Destroy();
			end;
		end);
		u5.CloseHover = p7.Gui.Close.MouseEnter:Connect(function()
			p7.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p7.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u5.CloseLeave = p7.Gui.Close.MouseLeave:Connect(function()
			p7.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p7.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p7.Gui.Visible = true;
		return p7;
	end);
	function v27.GetSentTable(p9, p10)
		if p9.PC then
			return {
				PlayerParty = p9.PlayerParty and nil, 
				Box = p9.Box and nil, 
				CurrentBox = p9.CurrentBox, 
				ColorList = p9.ColorList, 
				SkinList = p9.SkinList, 
				Party = p9.Party, 
				PC = p9.PC
			};
		end;
		if p9.TeamPreview then
			local v32 = {
				PlayerParty = p9.PlayerParty and nil, 
				TeamPreview = p9.TeamPreview, 
				ColorList = p9.ColorList
			};
			function v32.CloseFunc(p11)
				p9.PlayerParty[p10] = p11;
			end;
			return v32;
		end;
		if p9.Results then
			return {
				PlayerParty = p1.Roulette.NewDoodleTable, 
				ColorList = p9.ColorList, 
				SkinList = p9.SkinList, 
				Results = p9.Results, 
				Roulette = p9.Roulette, 
				CloseFunc = CloseFunc
			};
		end;
		if p9.Trading then
			return {
				Trading = p9.Trading, 
				PlayerParty = p9.PlayerParty, 
				Other = p9.Other
			};
		end;
		local v33 = {
			ColorList = p9.ColorList, 
			PC = p9.PC, 
			PlayerParty = p9.PlayerParty, 
			SkinList = p9.SkinList, 
			ColorList = p9.ColorList, 
			PartyGui = p9.PartyGui, 
			PartyButton = p9.PartyGui and p9.PartyGui:FindFirstChild("Party" .. p10), 
			Party = p9.Party, 
			Battle = p9.Battle
		};
		function v33.CloseFunc(p12)
			p9.Party[p10] = p12;
			if p9.PartyButton then
				p1.ColorAnim.Create(p9.PartyGui:FindFirstChild("Party" .. p10).DoodleName.Label, p12.NameColor);
				p1.Gui:ChangeText(p9.PartyGui:FindFirstChild("Party" .. p10).DoodleName.Label, p12.Nickname or p12.Name);
			end;
		end;
		return v33;
	end;
	function v27.ChangeColor(p13, p14, p15)
		p14 = Color3.new(p14.r / 3, p14.g / 3, p14.b / 3);
		for v34, v35 in pairs(p13.Gui.PaperFront.GlobalHalf:GetDescendants()) do
			if v35:FindFirstChild("TextColor") then
				v35.TextColor3 = p14;
			elseif v35:FindFirstChild("ImgColor") then
				v35.ImageColor3 = p14;
			end;
		end;
		for v36, v37 in pairs(p15:GetDescendants()) do
			if v37:FindFirstChild("TextColor") then
				v37.TextColor3 = p14;
			elseif v37:FindFirstChild("ImgColor") then
				v37.ImageColor3 = p14;
			end;
		end;
	end;
	local u12 = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1));
	local u13 = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1));
	function v27.ActiveTab(p16, p17)
		for v38, v39 in pairs(p16.Gui.Tabs:GetChildren()) do
			v39.UIGradient.Color = u12;
			v39.ZIndex = 2;
			v39.Title.Underline.Visible = false;
		end;
		p17.UIGradient.Color = u13;
		p17.ZIndex = 3;
		p17.Title.Underline.Size = UDim2.new(0, p17.Title.TextBounds.X, 0, 1);
		p17.Title.Underline.Visible = true;
	end;
	local u14 = nil;
	function v27.HideAll(p18)
		if u14 then
			u14:Destroy();
		end;
		for v40, v41 in pairs(p18.Gui.PaperFront:GetChildren()) do
			if v41.Name ~= "GlobalHalf" then
				v41.Visible = false;
			end;
		end;
	end;
	function v27.SetupCurrentChoice(p19, p20, p21)
		local v42 = nil;
		if p19.Doodle.Equip[p20] then
			u14 = p1.GuiObjs.EquipChoice:Clone();
			v42 = true;
		else
			u14 = p1.GuiObjs.EquipTwoChoice:Clone();
		end;
		for v43, v44 in pairs(u14:GetChildren()) do
			if v44:IsA("ImageButton") then
				p1.Gui:TextHover(v44.Label);
				p1.Gui:Hover(v44);
			end;
		end;
		local l__mouse__45 = p1.p:GetMouse();
		u14.Position = UDim2.new(0, l__mouse__45.X, 0, l__mouse__45.Y);
		u14.Equip.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			u14:Destroy();
			p19.Gui.Visible = false;
			p1.Equip.new({
				Doodle = p19.Doodle, 
				Stats = p19, 
				ForcePage = p20, 
				Party = p19.Party, 
				PC = p19.PC, 
				CurrentBox = p19.CurrentBox
			});
		end);
		u14.Cancel.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			u14:Destroy();
		end);
		if v42 then
			u14.Unequip.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick");
				u14:Destroy();
				p1.Network:post("TakeEquipment", p19.Doodle.ID, p20);
				p1.Network:BindEvent("TakeEquipment", function(p22)
					p1.Network:UnbindEvent("TakeEquipment");
					p19.Doodle = p22;
					p19:UpdateHealth();
					if p19 then
						local v46 = p19.Party:UpdateDoodle(p22, p19.CurrentBox);
						if not p19.PC then
							p19.Party:SetupBox(p19.Party.PartyGui["Party" .. v46]);
						end;
					end;
				end);
				p19.Doodle.Equip[p20] = nil;
				p1.Gui:ChangeText(p21.Info.EquipmentTitle, p20);
				p1.Gui:ChangeText(p21.Info.EquipStats, "Nothing equipped");
				p21.Background.Icon.Visible = false;
			end);
		end;
		u14.Parent = p1.guiholder;
	end;
	local u15 = {
		Info = Color3.fromRGB(0, 85, 127), 
		Moves = Color3.fromRGB(0, 170, 255), 
		Stats = Color3.fromRGB(0, 143, 69), 
		Customize = Color3.fromRGB(170, 85, 255), 
		Equipment = Color3.fromRGB(231, 76, 60)
	};
	function v27.EquipPage(p23)
		p23:HideAll();
		u4();
		u7 = "Equipment";
		local l__Equipment__47 = u15.Equipment;
		p23.Gui.PaperFront.ImageColor3 = l__Equipment__47;
		local l__Equipment__48 = p23.Gui.PaperFront:FindFirstChild("Equipment");
		p23:ActiveTab(p23.Gui.Tabs.Equipment);
		local l__Holder__49 = l__Equipment__48:FindFirstChild("Holder");
		local l__Locked__50 = l__Equipment__48:FindFirstChild("Locked");
		local l__HeldItem__51 = l__Equipment__48:FindFirstChild("HeldItem");
		l__HeldItem__51.Visible = false;
		p23:ChangeColor(l__Equipment__47, l__Equipment__48);
		if p1.EquipUnlocked then
			for v52, v53 in pairs(l__Holder__49:GetChildren()) do
				v53.Info.EquipStats.TextSize = v53.Info.EquipStats.AbsoluteSize.Y / 2.25;
				v53.Info.EquipStats.DropShadow.TextSize = v53.Info.EquipStats.TextSize;
				if p23.Doodle.Equip[v53.Name] == nil then
					p1.Gui:ChangeText(v53.Info.EquipmentTitle, v53.Name);
					p1.Gui:ChangeText(v53.Info.EquipStats, "Nothing equipped");
					v53.Background.Icon.Visible = false;
				else
					local v54 = p1.Equipment:LookUp(p23.Doodle.Equip[v53.Name], v53.Name);
					p1.Gui:ChangeText(v53.Info.EquipmentTitle, v54.Name);
					p1.Gui:ChangeText(v53.Info.EquipStats, v54.Info);
					v53.Background.Icon.Image = v54.Image;
					v53.Background.Icon.Visible = true;
				end;
				u1[v53.Name .. "Enter"] = v53.Background.MouseEnter:Connect(function()
					if not p23.Battle and not p23.TeamPreview and not p23.Trading and not p23.LearningMove then
						v53.Background.ImageColor3 = Color3.fromRGB(13, 13, 13);
						v53.Background.Icon.ImageColor3 = Color3.fromRGB(85, 85, 85);
					end;
				end);
				u1[v53.Name .. "Leave"] = v53.Background.MouseLeave:Connect(function()
					if not p23.Battle and not p23.TeamPreview and not p23.Trading and not p23.LearningMove then
						v53.Background.ImageColor3 = Color3.fromRGB(39, 39, 39);
						v53.Background.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
					end;
				end);
				u1[v53.Name .. "Click"] = v53.Background.MouseButton1Click:Connect(function()
					if not p23.Battle and not p23.TeamPreview and not p23.Trading and not p23.LearningMove then
						if u14 then
							u14:Destroy();
						end;
						p1.Sound:Play("BasicClick");
						p23:SetupCurrentChoice(v53.Name, v53);
					end;
				end);
			end;
			if p23.Doodle.HeldItem then
				local v55 = p1.ItemList[p23.Doodle.HeldItem];
				if v55 then
					p1.Gui:ChangeText(l__HeldItem__51.ItemName, p23.Doodle.HeldItem, v55.Color3 or Color3.fromRGB(255, 255, 255));
					p1.Gui:ChangeText(l__HeldItem__51.ItemDesc, v55.Description);
					l__HeldItem__51.Visible = true;
				end;
			end;
			l__Locked__50.Visible = false;
			l__Holder__49.Visible = true;
		else
			l__Holder__49.Visible = false;
			l__Locked__50.Visible = true;
		end;
		l__Equipment__48.Visible = true;
	end;
	function v27.InfoPage(p24)
		p24:HideAll();
		u7 = "Info";
		local l__Info__56 = u15.Info;
		p24.Gui.PaperFront.ImageColor3 = l__Info__56;
		local l__Info__57 = p24.Gui.PaperFront:FindFirstChild("Info");
		p24:ActiveTab(p24.Gui.Tabs.Info);
		local l__Holder__58 = l__Info__57:FindFirstChild("Holder");
		p24:ChangeColor(l__Info__56, l__Info__57);
		p1.Gui:ChangeText(l__Holder__58.DateMet.Title, l__Utilities__1:ConvertDate(p24.Doodle));
		p1.Gui:ChangeText(l__Holder__58.LC.Title, "Lv. " .. p24.Doodle.LevelMet);
		if not p24.NoTamer then
			p1.Gui:ChangeText(l__Holder__58.OT.Title, l__Utilities__1.GetNameFromUserId(p24.Doodle.OriginalOwner));
		else
			p1.Gui:ChangeText(l__Holder__58.OT.Title, "No one");
		end;
		p1.Gui:ChangeText(l__Holder__58.SizeG.Title, p24.Doodle.Size * 100 .. "%");
		l__Holder__58.Tint.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
		local v59 = "None";
		if p24.Doodle.Tint and p24.Doodle.Tint ~= 0 then
			if #p24.Doodle.Tint == 1 then
				v59 = p1.MiscDB.Tints[p24.Doodle.Tint[1]].Name;
			else
				l__Holder__58.Tint.Title.TextColor3 = Color3.fromRGB(255, 215, 0);
				v59 = #p24.Doodle.Tint .. " tints!";
			end;
		end;
		p1.Gui:ChangeText(l__Holder__58.Tint.Title, v59);
		local v60 = l__Holder__58.TintTitle.AbsoluteSize.Y * 0.4;
		for v61, v62 in pairs(l__Holder__58:GetDescendants()) do
			if v62.Name == "Title" then
				v62.TextSize = v60;
				v62.DropShadow.TextSize = v60;
			end;
		end;
		l__Info__57.Visible = true;
	end;
	local function u16(p25)
		for v63, v64 in pairs(p25:GetChildren()) do
			if v64:IsA("GuiObject") then
				v64:Destroy();
			end;
		end;
	end;
	function v27.CustomizePage(p26)
		p26:HideAll();
		u7 = "Customize";
		local l__Customize__65 = u15.Customize;
		p26.Gui.PaperFront.ImageColor3 = l__Customize__65;
		local l__Customize__66 = p26.Gui.PaperFront:FindFirstChild("Customize");
		p26.ButtonHolder = l__Customize__66:WaitForChild("ButtonHolder");
		p26.ColorScroller = l__Customize__66:WaitForChild("ColorScroller");
		p26.SkinScroller = l__Customize__66:WaitForChild("SkinScroller");
		u16(p26.ColorScroller);
		p26:ActiveTab(p26.Gui.Tabs.Customize);
		p26:ChangeColor(l__Customize__65, l__Customize__66);
		p1.Gui:ChangeText(p26.ButtonHolder.NameColor.Equipped, p1.Colors[p26.Doodle.NameColor].Name);
		p1.ColorAnim.Create(p26.ButtonHolder.NameColor.Equipped, p26.Doodle.NameColor);
		p1.Gui:Hover(p26.ButtonHolder.NameColor);
		p1.Gui:Hover(p26.ButtonHolder.Skin);
		p26.BackButton = l__Customize__66.Back;
		l__Customize__66.Back.Visible = false;
		if p26.Doodle.Skin == 0 then
			p1.Gui:ChangeText(p26.ButtonHolder.Skin.Equipped, "None");
		else
			p1.Gui:ChangeText(p26.ButtonHolder.Skin.Equipped, p1.Skins.Sprites[p26.Doodle.Name][p26.Doodle.Skin].Name);
		end;
		p26.ColorScroller.Visible = false;
		p26.SkinScroller.Visible = false;
		p26.ButtonHolder.Visible = true;
		if not u5.NameColorChange then
			u5.NameColorChange = p26.ButtonHolder.NameColor.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick");
				p26.ButtonHolder.Visible = false;
				p26:MakeSquares();
			end);
		end;
		if not u5.Skin then
			if p26.SkinList then
				if not p26.Doodle.SL then
					u5.Skin = p26.ButtonHolder.Skin.MouseButton1Click:Connect(function()
						p1.Sound:Play("BasicClick");
						p26.ButtonHolder.Visible = false;
						p26:MakeSkinSquares();
					end);
					p1.Gui:ChangeText(p26.ButtonHolder.Skin.Label, "Skin:");
				else
					p1.Gui:ChangeText(p26.ButtonHolder.Skin.Label, "LOCKED:");
				end;
				p26.ButtonHolder.Skin.Visible = true;
			else
				p26.ButtonHolder.Skin.Visible = false;
			end;
		end;
		if p26.BackEnabled == nil then
			p26.BackEnabled = true;
			p26.SearchButton = l__Customize__66.Search;
			p26.SearchBox = l__Customize__66.SearchTextBox;
			p1.Gui:Hover(p26.SearchButton);
			if not u5.BackClick then
				u5.BackClick = l__Customize__66.Back.MouseButton1Click:Connect(function()
					p1.Sound:Play("Boop", 0.8);
					l__Customize__66.Back.Visible = false;
					p26.ColorScroller.Visible = false;
					p26.SkinScroller.Visible = false;
					p26:ResetSearch();
					u16(p26.ColorScroller);
					u16(p26.SkinScroller);
					p26.ButtonHolder.Visible = true;
				end);
				u5.BackHover = l__Customize__66.Back.MouseEnter:Connect(function()
					l__Customize__66.Back.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
					l__Customize__66.Back.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
				end);
				u5.BackLeave = l__Customize__66.Back.MouseLeave:Connect(function()
					l__Customize__66.Back.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
					l__Customize__66.Back.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
				end);
				u5.ClickSearch = p26.SearchButton.MouseButton1Click:Connect(function()
					p26.SearchBox:TweenSize(UDim2.new(0.65, 0, 0.074, 0), "Out", "Bounce", 0.35, true);
				end);
				u5.FocusLost = p26.SearchBox.TextBox.FocusLost:Connect(function()
					p26.SearchString = p26.SearchBox.TextBox.Text;
					p26:Search(p26.SearchString);
				end);
			end;
		end;
		p26:ResetSearch();
		l__Customize__66.Visible = true;
	end;
	function v27.EnableSearch(p27)
		p27.SearchButton.Visible = true;
		p27.SearchBox.Visible = true;
	end;
	function v27.ResetSearch(p28)
		p28.SearchButton.Visible = false;
		p28.SearchBox.Visible = false;
		p28.SearchString = nil;
		p28:Search("");
		p1.Gui:ChangeText(p28.SearchBox.TextBox, "Search");
		p28.SearchBox.Size = UDim2.new(0, 0, 0.035, 0);
	end;
	function v27.Search(p29, p30, p31)
		if not p30 then
			p30 = "";
		end;
		local v67 = p30:lower();
		local v68 = nil;
		if p29.ColorScroller.Visible == true then
			v68 = p29.ColorScroller;
		elseif p29.SkinScroller.Visible == true then
			v68 = p29.SkinScroller;
		end;
		if v68 then
			for v69, v70 in pairs(v68:GetChildren()) do
				if v70:IsA("GuiObject") then
					if v70.Equipped.Visible == true or v70.Name == "0" or v70.Name:lower():find(v67) then
						v70.Visible = true;
					else
						v70.Visible = false;
					end;
				end;
			end;
			p1.Services.RunService.Heartbeat:wait();
			v68.CanvasSize = UDim2.new(0, 0, 0, v68.UIGridLayout.AbsoluteContentSize.Y);
			if v68.UIGridLayout.AbsoluteCellCount.Y > 1 then
				v68.UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
				return;
			end;
			v68.UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
		end;
	end;
	function v27.ChangeColorEquipped(p32)
		for v71, v72 in pairs(p32.ColorScroller:GetChildren()) do
			if v72:IsA("GuiObject") and v72:FindFirstChild("Equipped") then
				if v72.Equipped.Visible == true then
					v72.LayoutOrder = v72.LayoutOrder + 100;
				end;
				v72.Equipped.Visible = false;
			end;
		end;
	end;
	function v27.ColorSquare(p33, p34)
		local v73 = p1.GuiObjs.StatsSquare:Clone();
		v73.LayoutOrder = p34;
		p1.Gui:ChangeText(v73.Label, p1.Colors.GetColorName(p34), p1.MiscDB.Rarities[p1.Colors.GetColorRarity(p34)]);
		if p33.Doodle.NameColor == p34 then
			v73.Equipped.Visible = true;
			v73.LayoutOrder = v73.LayoutOrder - 100;
		else
			v73.Equipped.Visible = false;
		end;
		v73.Name = p1.Colors.GetColorName(p34);
		v73.Parent = p33.ColorScroller;
		u6.Create(v73, p34);
		p1.Gui:Hover(v73);
		v73.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p33:ChangeColorEquipped();
			v73.Equipped.Visible = true;
			v73.LayoutOrder = v73.LayoutOrder - 100;
			p33.Doodle.NameColor = p34;
			p33.Doodle = p1.Network:get("ChangeDoodleNameColor", p33.Doodle.ID, p34);
			p33.Doodle.NameColor = p34;
			p1.Gui:ChangeText(p33.ButtonHolder.NameColor.Equipped, p1.Colors[p33.Doodle.NameColor].Name);
			p1.ColorAnim.Create(p33.ButtonHolder.NameColor.Equipped, p33.Doodle.NameColor);
			p33.NameGradient = u6.Create(p33.Gui.PaperFront.GlobalHalf.DoodleName, p33.Doodle.NameColor);
		end);
	end;
	local u17 = false;
	function v27.MakeEquipSkin(p35, p36, p37)
		if typeof(p36) == "number" then
			local v74 = 1;
		else
			v74 = p36.Amount;
		end;
		local v75 = typeof(p36) == "number" and p36 or p36.Skin;
		if v75 == 0 then
			return;
		end;
		if p35.SkinScroller:FindFirstChild(v75) then
			local v76 = p35.SkinScroller:FindFirstChild(v75);
		else
			v76 = p1.GuiObjs.SkinSquare:Clone();
			v76.Name = v75;
			v76.MouseButton1Click:Connect(function()
				if u17 then
					return;
				end;
				if p35.Doodle.Skin == v75 then
					return;
				end;
				u17 = true;
				p1.Sound:Play("BasicClick");
				p1.Network:BindEvent("ChangeSkin", function(p38, p39)
					p1.Network:UnbindEvent("ChangeSkin");
					p35.Doodle = p38;
					if p35 and p35.Party and p35.Party.UpdateDoodle then
						local v77 = p35.Party:UpdateDoodle(p38, p35.CurrentBox);
						if not p35.PC then
							p35.Party:SetupBox(p35.Party.PartyGui["Party" .. v77]);
						end;
					end;
					p1.Gui:AnimateSprite(p35.Gui.PaperFront:FindFirstChild("GlobalHalf").DoodleImage.DoodleLabel, p35.Doodle, true);
					if p35.Doodle.Skin == 0 then
						p1.Gui:ChangeText(p35.ButtonHolder.Skin.Equipped, "None");
					else
						p1.Gui:ChangeText(p35.ButtonHolder.Skin.Equipped, p1.Skins.Sprites[p35.Doodle.Name][p35.Doodle.Skin].Name);
					end;
					u17 = false;
					p35.SkinList = p39;
					if p35.MakeSkinList then
						p35:MakeSkinList(p39);
					end;
				end);
				p1.Network:post("ChangeSkin", p35.Doodle.ID, v75);
			end);
		end;
		v76.Visible = true;
		if v74 <= 0 then
			v76:Destroy();
			return v76;
		end;
		p1.Gui:Hover(v76);
		p1.Gui:ChangeText(v76.Label, p1.Skins.Sprites[p35.Doodle.Name][v75].Name);
		p1.Gui:ChangeText(v76.Amount, "x" .. v74);
		v76.DoodleLabel.Image = p1.Gui:GetSkinFront(p35.Doodle.Name, p35.Doodle.Shiny, p35.Doodle.Gender, v75);
		v76.Parent = p35.SkinScroller;
		if p35.Doodle.Skin ~= v75 then
			v76.Equipped.Visible = false;
			v76.Amount.Visible = true;
			v76.LayoutOrder = p37 + 1;
			return v76;
		end;
		v76.Equipped.Visible = true;
		v76.Amount.Visible = false;
		v76.LayoutOrder = p37 + 1 - 100;
		return v76;
	end;
	function v27.MakeSkinList(p40, p41)
		if p40.SkinScroller:FindFirstChild(0) then
			local v78 = p40.SkinScroller:FindFirstChild(0);
		else
			v78 = p1.GuiObjs.SkinSquare:Clone();
			v78.MouseButton1Click:Connect(function()
				if u17 then
					return;
				end;
				if p40.Doodle.Skin == 0 then
					return;
				end;
				u17 = true;
				p1.Sound:Play("BasicClick");
				p1.Network:BindEvent("ChangeSkin", function(p42, p43)
					p1.Network:UnbindEvent("ChangeSkin");
					p40.Doodle = p42;
					if p40 and p40.Party and p40.Party.UpdateDoodle then
						local v79 = p40.Party:UpdateDoodle(p42, p40.CurrentBox);
						if not p40.PC then
							p40.Party:SetupBox(p40.Party.PartyGui["Party" .. v79]);
						end;
					end;
					p1.Gui:AnimateSprite(p40.Gui.PaperFront:FindFirstChild("GlobalHalf").DoodleImage.DoodleLabel, p40.Doodle, true);
					if p40.Doodle.Skin == 0 then
						p1.Gui:ChangeText(p40.ButtonHolder.Skin.Equipped, "None");
					else
						p1.Gui:ChangeText(p40.ButtonHolder.Skin.Equipped, p1.Skins.Sprites[p40.Doodle.Name][p40.Doodle.Skin].Name);
					end;
					u17 = false;
					p40.SkinList = p43;
					p40:MakeSkinList(p43);
				end);
				p1.Network:post("ChangeSkin", p40.Doodle.ID, 0);
			end);
		end;
		p1.Gui:Hover(v78);
		p1.Gui:ChangeText(v78.Label, "No skin");
		if p40.Doodle.Skin == 0 then
			v78.Equipped.Visible = true;
			v78.LayoutOrder = -99;
		else
			v78.Equipped.Visible = false;
			v78.LayoutOrder = 1;
		end;
		v78.Name = 0;
		v78.Amount.Visible = false;
		v78.DoodleLabel.Image = p1.Gui:GetSkinFront(p40.Doodle.Name, p40.Doodle.Shiny, p40.Doodle.Gender, 0);
		v78.Parent = p40.SkinScroller;
		v78.Visible = true;
		local v80 = l__Utilities__1.FindLineTable(p1.Lines:GetLines(), p40.Doodle);
		if p41[v80] then
			for v81, v82 in pairs(p41[v80]) do
				p40:MakeEquipSkin(v82, v81);
			end;
		end;
		p40:MakeEquipSkin(p40.Doodle.Skin, -100);
	end;
	function v27.MakeSquares(p44)
		local v83 = p44.ColorScroller.AbsoluteSize.X / 4;
		p44.ColorScroller.UIGridLayout.CellSize = UDim2.new(0, v83 - 10, 0, v83 - 10);
		u16(p44.ColorScroller);
		for v84, v85 in pairs(p44.ColorList) do
			p44:ColorSquare(v85);
		end;
		p44.ColorScroller.CanvasSize = UDim2.new(0, 0, 0, p44.ColorScroller.UIGridLayout.AbsoluteContentSize.Y);
		p44.BackButton.Visible = true;
		p44.ColorScroller.Visible = true;
		p44:EnableSearch();
	end;
	function v27.MakeSkinSquares(p45)
		local v86 = p45.SkinScroller.AbsoluteSize.X / 3;
		p45.SkinScroller.UIGridLayout.CellSize = UDim2.new(0, v86 - 10, 0, v86 - 10);
		u16(p45.SkinScroller);
		p45:MakeSkinList(p45.SkinList);
		p45.SkinScroller.CanvasSize = UDim2.new(0, 0, 0, p45.SkinScroller.UIGridLayout.AbsoluteContentSize.Y);
		p45.BackButton.Visible = true;
		p45.SkinScroller.Visible = true;
		p45:EnableSearch();
	end;
	local v87 = { "hp", "atk", "def", "matk", "mdef", "spe" };
	local u18 = {
		hp = "HP", 
		atk = "ATK", 
		def = "DEF", 
		matk = "MATK", 
		mdef = "MDEF", 
		spe = "SPEED"
	};
	function v27.StatsPage(p46)
		p46:HideAll();
		u7 = "Stats";
		local l__Stats__88 = u15.Stats;
		p46:ActiveTab(p46.Gui.Tabs.Stats);
		p46.Gui.PaperFront.ImageColor3 = l__Stats__88;
		local l__Stats__89 = p46.Gui.PaperFront:FindFirstChild("Stats");
		local l__Holder__90 = l__Stats__89:FindFirstChild("Holder");
		local l__StatHolder__91 = l__Holder__90:FindFirstChild("StatHolder");
		p46:ChangeColor(l__Stats__88, l__Stats__89);
		for v92, v93 in pairs((l__Utilities__1:GetStats(p46.Doodle))) do
			local v94 = l__StatHolder__91:FindFirstChild(u18[v92]);
			p1.Gui:ChangeText(v94.Title, v93);
			v94.Title.Text = v93;
		end;
		for v95, v96 in pairs(u18) do
			l__Holder__90:FindFirstChild(v96 .. "Title").Title.TextColor3 = Color3.fromRGB(255, 255, 255);
		end;
		local v97, v98, v99 = pairs(p46.Doodle.StatBoosts);
		while true do
			local v100 = nil;
			local v101, v102 = v97(v98, v99);
			if not v101 then
				break;
			end;
			v99 = v101;
			v100 = l__Holder__90:FindFirstChild(u18[v101] .. "Title");
			if v102 == 1 then
				v100.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
			elseif v102 == 0.95 then
				v100.Title.TextColor3 = Color3.fromRGB(255, 85, 0);
			elseif v102 == 0.9 then
				v100.Title.TextColor3 = Color3.fromRGB(255, 0, 0);
			elseif v102 == 1.05 then
				v100.Title.TextColor3 = Color3.fromRGB(85, 255, 0);
			elseif v102 == 1.1 then
				v100.Title.TextColor3 = Color3.fromRGB(96, 198, 254);
			end;		
		end;
		local v103 = p46.Doodle.Ability and "No trait";
		p1.Gui:ChangeText(l__Holder__90.Trait.TraitDesc, p1.Traits[v103].Description);
		p1.Gui:ChangeText(l__Holder__90.Trait.TraitName, " " .. v103);
		local v104 = l__Holder__90.SPEEDTitle.AbsoluteSize.Y * 0.9;
		for v105, v106 in pairs(l__Holder__90:GetDescendants()) do
			if v106.Name == "Title" then
				v106.TextSize = v104;
				v106.DropShadow.TextSize = v104;
			end;
		end;
		if p46.Doodle.Ability == p1.DoodleInfo[l__Utilities__1.GetRealName(p46.Doodle)].HiddenAbility then
			l__Holder__90.Trait.HA.Visible = true;
			u5[l__Holder__90.Trait.HA] = p1.Tooltip.new({
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}, l__Holder__90.Trait.HA, "Hidden Trait");
		else
			l__Holder__90.Trait.HA.Visible = false;
		end;
		l__Stats__89.Visible = true;
	end;
	local u19 = nil;
	function v27.ResetMoves(p47, p48)
		for v107, v108 in pairs(p47.Doodle.Moves) do
			local v109 = p48.Holder:FindFirstChild("Move" .. v107);
			if v109 then
				local v110 = Color3.fromRGB(48, 48, 48);
				if v108.Uses <= 0 then
					v110 = Color3.fromRGB(231, 76, 60);
				end;
				v109.ImageColor3 = v110;
			end;
		end;
	end;
	local u20 = nil;
	local function u21(p49, p50, p51)
		u19 = p50;
		local v111 = p1.Moves[p50.Name];
		local l__Type__112 = v111.Type;
		local v113 = v111.Category;
		if v113 == "Passive" then
			v113 = "Support";
		end;
		for v114, v115 in pairs({ 0.5, 0.384, 0.3, 0.275, 0.25, 0.225, 0.2, 0.175, 0.15 }) do
			p49.Size = UDim2.new(0.941, 0, v115, 0);
			if p1.Gui:IsGuiOnScreen(p49) then
				p49.Position = UDim2.new(-0.125, p49.AbsoluteSize.X * -0.25, 0.028 + p51.Position.Y.Scale * 5 * 0.17);
				break;
			end;
		end;
		local v116 = p1.Typings:GetColor(l__Type__112);
		p1.Gui:ChangeText(p49.MoveName.Label, p50.Name, v116);
		p49.MoveName.Size = UDim2.new(0, p49.MoveName.Label.TextBounds.X + 10, 0.3, 0);
		p1.Gui:ChangeText(p49.MoveCategory.Label, v113);
		p49.MoveCategory.Size = UDim2.new(0, p49.MoveCategory.Label.TextBounds.X + 5, 0.3, 0);
		p1.Gui:ChangeText(p49.Desc, v111.Desc);
		local v117 = math.floor(p49.StatHolder.AbsoluteSize.Y);
		for v118, v119 in pairs(p49.StatHolder:GetDescendants()) do
			if v119:FindFirstChild("ChangeSize") then
				v119.TextSize = v117;
			end;
		end;
		if typeof(v111.Power) ~= "number" then
			local v120 = v111.Power == "Varies" and v111.Power or "--";
		else
			v120 = v111.Power or "--";
		end;
		p1.Gui:ChangeText(p49.StatHolder.Power.Desc.Label, v120);
		if v111.Accuracy == true then
			local v121 = "--";
		else
			v121 = v111.Accuracy .. "%";
		end;
		p1.Gui:ChangeText(p49.StatHolder.Accuracy.Desc.Label, v121);
		p1.Gui:ChangeText(p49.StatHolder.Type.Desc.Label, l__Type__112);
		p1.Gui:ChangeText(p49.StatHolder.Type.Label, "Type", v116);
		for v122, v123 in pairs({ p49.StatHolder.Accuracy, p49.StatHolder.Power, p49.StatHolder.Type }) do
			v123.Desc.Size = UDim2.new(0, v123.Desc.Label.TextBounds.X + 7, 1, 0);
		end;
		p49.Visible = true;
	end;
	local u22 = false;
	function v27.SetupMoves(p52, p53)
		p53.MoveDescription.Visible = false;
		u19 = nil;
		u20 = nil;
		for v124, v125 in pairs({ 0.5, 0.384, 0.3, 0.275, 0.25, 0.225, 0.2, 0.175, 0.15 }) do
			p53.MoveDescription.Size = UDim2.new(0.941, 0, v125, 0);
			if p1.Gui:IsGuiOnScreen(p53.MoveDescription) then
				p53.MoveDescription.Position = UDim2.new(-0.125, p53.MoveDescription.AbsoluteSize.X * -0.25, 0.028 + p53.Position.Y.Scale * 5 * 0.17);
				break;
			end;
		end;
		p52.AllowedChecks = {};
		for v126, v127 in pairs(p53.Holder:GetChildren()) do
			if v127.Name:find("Move") or v127.Name == "Under5" then
				v127.Visible = false;
				if v127.Name ~= "Under5" then
					table.insert(p52.AllowedChecks, v127);
				end;
			end;
		end;
		if p52.Doodle.Moves[5] then
			p53.Holder.Under5.Visible = true;
			p53.Holder.Underline.Visible = true;
		else
			p53.Holder.Under5.Visible = false;
			p53.Holder.Underline.Visible = false;
		end;
		for v128, v129 in pairs(p52.Doodle.Moves) do
			local v130 = p53.Holder:FindFirstChild("Move" .. v128);
			if v130 then
				local v131 = Color3.fromRGB(48, 48, 48);
				if v129.Uses <= 0 then
					v131 = Color3.fromRGB(231, 76, 60);
				end;
				v130.ImageColor3 = v131;
				local v132 = p1.Moves[v129.Name];
				local l__Type__133 = v132.Type;
				p1.Gui:ChangeText(v130.MoveName, v129.Name, (p1.Typings:GetColor(l__Type__133)));
				p1.Gui:ChangeText(v130.EnergyLabel, v129.Uses .. "/" .. v132.Uses + v129.PPUp);
				p1.Gui:TypeImage(v130.Type, l__Type__133);
				v130.Visible = true;
				u2[v130.Name .. "CursorEnter"] = v130.InputBegan:Connect(function(p54)
					if l__Utilities__1.IsValidEnter(p54) and tonumber(v130.Name:match("%d+")) ~= u20 then
						v130.ImageColor3 = Color3.new(v131.r * 1.3, v131.g * 1.3, v131.b * 1.3);
					end;
					if u19 ~= v129 and (p54.UserInputType == Enum.UserInputType.Touch or p54.UserInputType == Enum.UserInputType.MouseMovement) then
						u21(p53.MoveDescription, v129, v130);
					end;
				end);
				u2[v130.Name .. "CursorChanged"] = v130.InputChanged:Connect(function(p55)
					if l__Utilities__1.IsValidEnter(p55) and tonumber(v130.Name:match("%d+")) ~= u20 then
						v130.ImageColor3 = Color3.new(v131.r * 1.3, v131.g * 1.3, v131.b * 1.3);
					end;
				end);
				u2[v130.Name .. "CursorEnded"] = p53.Holder:FindFirstChild("Under" .. v128).InputEnded:Connect(function(p56)
					if l__Utilities__1.IsValidEnter(p56) and u19 == v129 and tonumber(v130.Name:match("%d+")) ~= u20 then
						p53.MoveDescription.Visible = false;
						u19 = nil;
						v130.ImageColor3 = v131;
					end;
				end);
				if not p52.Trading and not p52.NoMoveSwap then
					local v134 = {
						NotBigger = true
					};
					function v134.IfNoDragging(p57)
						if u22 == true then
							return;
						end;
						if u20 == nil then
							v130.ImageColor3 = Color3.fromRGB(120, 120, 120);
							u20 = tonumber(v130.Name:match("%d+"));
							return;
						end;
						if u20 == tonumber(v130.Name:match("%d+")) then
							u20 = nil;
							return;
						end;
						if u20 and u20 ~= tonumber(v130.Name:match("%d+")) then
							u22 = true;
							local v135, v136, v137 = p1.Network:get("SwapMoves", p52.Doodle.ID, tonumber(v130.Name:match("%d+")), u20);
							p52.Doodle = v137;
							local v138 = p53.Holder:FindFirstChild("Move" .. v135);
							local v139 = p53.Holder:FindFirstChild("Move" .. v136);
							p1.guiholder.Dragging:ClearAllChildren();
							v138.Visible = true;
							v139.Visible = true;
							v138:TweenPosition(v139.Position, "Out", "Bounce", 0.5, true);
							v139:TweenPosition(v138.Position, "Out", "Bounce", 0.5, true);
							v138.Name = v139.Name;
							v139.Name = v138.Name;
							l__Utilities__1.Halt(0.5);
							u22 = false;
							u20 = nil;
							if p52.ResetMoves then
								p52:ResetMoves(p53);
							end;
						end;
					end;
					function v134.Function(p58)
						if u22 == false then
							u22 = true;
							local u23 = tonumber(v130.Name:match("%d+"));
							local u24 = tonumber(p58.Name:match("%d+"));
							l__Utilities__1.FastSpawn(function()
								local v140, v141, v142 = p1.Network:get("SwapMoves", p52.Doodle.ID, u23, u24);
								p52.Doodle = v142;
								local v143 = p53.Holder:FindFirstChild("Move" .. v140);
								local v144 = p53.Holder:FindFirstChild("Move" .. v141);
								v143:TweenPosition(v144.Position, "Out", "Bounce", 0.5, true);
								v144:TweenPosition(v143.Position, "Out", "Bounce", 0.5, true);
								v143.Name = v144.Name;
								v144.Name = v143.Name;
								l__Utilities__1.Halt(0.5);
								u22 = false;
								u20 = nil;
								p52:ResetMoves(p53);
							end);
						end;
					end;
					v134.Collide = p52.AllowedChecks;
					table.insert(u2, (p1.GuiDragging.new(v134, v130)));
				end;
			else
				warn("Move" .. v128 .. " did not exist for " .. p52.Doodle.Name);
			end;
		end;
	end;
	function v27.MovesPage(p59)
		u3();
		p59:HideAll();
		u7 = "Moves";
		local l__Moves__145 = u15.Moves;
		p59:ActiveTab(p59.Gui.Tabs.Moves);
		p59.Gui.PaperFront.ImageColor3 = l__Moves__145;
		local l__Moves__146 = p59.Gui.PaperFront:FindFirstChild("Moves");
		p59:ChangeColor(l__Moves__145, l__Moves__146);
		p59:SetupMoves(l__Moves__146, p59.Doodle);
		l__Moves__146.Visible = true;
	end;
	function v27.ClearStars(p60)
		for v147, v148 in pairs(p60.Gui.PaperFront:FindFirstChild("GlobalHalf").DoodleImage.Rank:GetChildren()) do
			if v148:IsA("GuiObject") then
				v148:Destroy();
			end;
		end;
	end;
	function v27.SetupStars(p61)
		local l__Rank__149 = p61.Gui.PaperFront:FindFirstChild("GlobalHalf").DoodleImage.Rank;
		local v150 = l__Rank__149.AbsoluteSize.Y / 3 * 2;
		for v151 = 1, p61.Doodle.Star do
			p1.GuiObjs.Star:Clone().Parent = l__Rank__149;
		end;
		l__Rank__149.UIGridLayout.CellSize = UDim2.new(0, v150, 0, v150);
	end;
	function v27.UpdateHealth(p62)
		local l__GlobalHalf__152 = p62.Gui.PaperFront:FindFirstChild("GlobalHalf");
		local v153 = l__Utilities__1:GetStats(p62.Doodle);
		p1.Gui:ChangeText(l__GlobalHalf__152.TotalHealth.HealthText, p62.Doodle.currenthp .. " / " .. v153.hp);
		l__GlobalHalf__152.TotalHealth.HealthLeft.Size = UDim2.new(p62.Doodle.currenthp / v153.hp, 0, 1, 0);
		p1.Gui:HealthColor(l__GlobalHalf__152.TotalHealth.HealthLeft);
	end;
	function v27.GlobalHalf(p63)
		p63.TextEditing = nil;
		p63:ClearStars();
		p63:SetupStars();
		local l__GlobalHalf__154 = p63.Gui.PaperFront:FindFirstChild("GlobalHalf");
		p1.Gui:AnimateSprite(l__GlobalHalf__154.DoodleImage.DoodleLabel, p63.Doodle, true);
		l__GlobalHalf__154.DoodleImage.Sparkles.Visible = p63.Doodle.Shiny;
		p1.Gui:SetGenderIcon(p63.Doodle, l__GlobalHalf__154.GenderSign);
		p1.Gui:ChangeText(l__GlobalHalf__154.DoodleName, p63.Doodle.Nickname or p63.Doodle.Name);
		p63.NameGradient = u6.Create(l__GlobalHalf__154.DoodleName, p63.Doodle.NameColor);
		p1.Gui:ChangeText(l__GlobalHalf__154.LevelLabel, "Lv. " .. p63.Doodle.Level);
		l__GlobalHalf__154.Type1.Visible = false;
		l__GlobalHalf__154.Type2.Visible = false;
		l__GlobalHalf__154.DoodleImage.TradeLock.Visible = false;
		if p63.Doodle.TL then
			l__GlobalHalf__154.DoodleImage.TradeLock.Visible = true;
			u5[l__GlobalHalf__154.DoodleImage] = p1.Tooltip.new({}, l__GlobalHalf__154.DoodleImage.TradeLock, "Trade Locked");
		elseif not p1.TradeAllowed and p63.Doodle.RM then
			l__GlobalHalf__154.DoodleImage.TradeLock.Visible = true;
			u5[l__GlobalHalf__154.DoodleImage] = p1.Tooltip.new({}, l__GlobalHalf__154.DoodleImage.TradeLock, "Trade Locked (Country Law)");
		end;
		for v155, v156 in pairs(p63.DoodleInfo.Type) do
			local v157 = l__GlobalHalf__154:FindFirstChild("Type" .. v155);
			if v157 then
				p1.Gui:TypeImage(v157.TypeImage, v156);
				v157.Visible = true;
				u5[v157] = p1.Tooltip.new({
					TextColor3 = p1.Typings:GetColor(v156)
				}, v157, v156);
			end;
		end;
		local v158 = p63.Doodle.Capsule and "Basic";
		l__GlobalHalf__154.DoodleImage.HeldItem.ImageColor3 = Color3.fromRGB(255, 255, 255);
		if p63.Doodle.HeldItem then
			local l__HeldItem__159 = p63.Doodle.HeldItem;
			local v160 = p1.ItemList[l__HeldItem__159];
			if table.find(p1.ScrollList, l__HeldItem__159) then
				v160 = p1.ItemList.Scroll;
				local v161 = p1.Typings.Visual[p1.Moves[l__HeldItem__159].Type].Color;
				l__GlobalHalf__154.DoodleImage.HeldItem.ImageColor3 = v161;
			else
				v161 = v160.Color3;
			end;
			l__GlobalHalf__154.DoodleImage.HeldItem.Image = v160.Image;
			u5[l__GlobalHalf__154.DoodleImage.HeldItem] = p1.Tooltip.new({
				TextColor3 = v161
			}, l__GlobalHalf__154.DoodleImage.HeldItem, "Item: " .. p63.Doodle.HeldItem);
			l__GlobalHalf__154.DoodleImage.HeldItem.Visible = true;
		else
			l__GlobalHalf__154.DoodleImage.HeldItem.Visible = false;
		end;
		u5[l__GlobalHalf__154.DoodleImage.CapsuleSprite] = p1.Tooltip.new({
			TextColor3 = p1.MiscDB.Capsules[v158].Color3
		}, l__GlobalHalf__154.DoodleImage.CapsuleSprite, v158 .. " Capsule");
		local v162 = p1.ClientDatabase:GetNextLevel(p63.Doodle, p63.Doodle.Level + 1);
		local v163 = v162 - p1.ClientDatabase:GetNextLevel(p63.Doodle, p63.Doodle.Level);
		if p63.Doodle.Level ~= 100 then
			p1.Gui:ChangeText(l__GlobalHalf__154.NextExp, "Next level: " .. v162 - p63.Doodle.Experience .. " exp");
			l__GlobalHalf__154.NextExp.Visible = true;
		else
			l__GlobalHalf__154.NextExp.Visible = false;
		end;
		l__GlobalHalf__154.Experience.TotalExp.Size = UDim2.new((v163 - (v162 - p63.Doodle.Experience)) / v163, 0, 1, 0);
		local l__TextBounds__164 = l__GlobalHalf__154.DoodleName.TextBounds;
		if not p63.Battle and not p63.TeamPreview and not p63.Trading then
			u5[l__GlobalHalf__154.Rename] = p1.Tooltip.new({
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}, l__GlobalHalf__154.Rename, "Rename");
			u5.Rename = l__GlobalHalf__154.Rename.MouseButton1Click:Connect(function()
				if not p63.TextEditing then
					p63.TextEditing = true;
					l__GlobalHalf__154.DoodleName.Visible = false;
					l__GlobalHalf__154.TextBox.TextEditable = true;
					l__GlobalHalf__154.TextBox.Text = p63.Doodle.Nickname or p63.Doodle.Name;
					l__GlobalHalf__154.TextBox.Visible = true;
					l__GlobalHalf__154.TextBox:CaptureFocus();
				end;
			end);
			l__GlobalHalf__154.Rename.Visible = true;
		else
			l__GlobalHalf__154.Rename.Visible = false;
		end;
		p1.Gui:Hover(l__GlobalHalf__154.Rename);
		u5.FocusLostEvent = l__GlobalHalf__154.TextBox.FocusLost:Connect(function()
			l__GlobalHalf__154.TextBox.TextEditable = false;
			local v165 = p1.Network:get("Nickname", p63.Doodle.ID, l__GlobalHalf__154.TextBox.Text);
			p63.TextEditing = nil;
			if v165 then
				p63.Doodle.Nickname = v165;
				p1.Gui:ChangeText(l__GlobalHalf__154.DoodleName, v165);
			end;
			l__GlobalHalf__154.TextBox.Visible = false;
			l__GlobalHalf__154.DoodleName.Visible = true;
		end);
		l__GlobalHalf__154.TextBox.Visible = false;
		l__GlobalHalf__154.DoodleName.Visible = true;
		local v166 = l__Utilities__1:GetStats(p63.Doodle);
		p1.Gui:ChangeText(l__GlobalHalf__154.TotalHealth.HealthText, p63.Doodle.currenthp .. " / " .. v166.hp);
		l__GlobalHalf__154.TotalHealth.HealthLeft.Size = UDim2.new(p63.Doodle.currenthp / v166.hp, 0, 1, 0);
		p1.Gui:HealthColor(l__GlobalHalf__154.TotalHealth.HealthLeft);
	end;
	function v27.PageFlip(p64, p65)
		u3();
		u4();
		if p65 == "Info" then
			p64:InfoPage();
			return;
		end;
		if p65 == "Stats" then
			p64:StatsPage();
			return;
		end;
		if p65 == "Moves" then
			p64:MovesPage();
			return;
		end;
		if p65 == "Customize" then
			p64:CustomizePage();
			return;
		end;
		if p65 == "Equipment" then
			p64:EquipPage();
		end;
	end;
	local function u25(p66)
		for v167, v168 in pairs(p66:GetChildren()) do
			v168.ImageColor3 = u15[v168.Name];
		end;
	end;
	function v27.SetupTabs(p67)
		local l__Tabs__169 = p67.Gui:FindFirstChild("Tabs");
		for v170, v171 in pairs(p67.Gui.Tabs:GetChildren()) do
			local v172 = u15[v171.Name];
			v171.ImageColor3 = v172;
			u5[v171.Name .. "Began"] = v171.MouseButton1Click:Connect(function()
				if v171.Name ~= u7 then
					v171.ImageColor3 = Color3.fromRGB(v172.r / 1.5, v172.g / 1.5, v172.b / 1.5);
				end;
				if v171.Name ~= u7 then
					u25(l__Tabs__169);
					p1.Sound:Play("PageFlip", 1, 3);
					p67:PageFlip(v171.Name);
				end;
			end);
			u5[v171.Name .. "Ended"] = v171.InputEnded:Connect(function(p68)
				if l__Utilities__1.IsValidEnter(p68) then
					v171.ImageColor3 = v172;
				end;
			end);
			u5[v171.Name .. "Changed"] = v171.InputChanged:Connect(function(p69)
				if l__Utilities__1.IsValidEnter(p69) and v171.Name ~= u7 then
					v171.ImageColor3 = Color3.fromRGB(v172.r / 1.5, v172.g / 1.5, v172.b / 1.5);
				end;
			end);
		end;
	end;
	function v27.Destroy(p70, p71)
		if u14 then
			u14:Destroy();
		end;
		if p70.NameGradient then
			p70.NameGradient:Destroy();
		end;
		if p70.TextBoxGradient then
			p70.TextBoxGradient:Destroy();
		end;
		for v173, v174 in pairs(p70.Gui.PaperFront.Customize:GetDescendants()) do
			if v174:IsA("UIGradient") then
				v174:Destroy();
			end;
		end;
		if p70.Party and p70.SkinList then
			p70.Party.SkinList = p70.SkinList;
		end;
		u8();
		if not p71 then
			p70.Gui.Visible = false;
		end;
		p70.Doodle = nil;
		setmetatable(p70, nil);
	end;
	return v27;
end;
