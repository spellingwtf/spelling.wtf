-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	p1.PCClosed = l__Utilities__1.Signal();
	local u1 = {};
	local u2 = {};
	local function u3()
		for v2, v3 in pairs(u1) do
			if v3 and v3.Disconnect then
				v3:Disconnect();
			end;
		end;
	end;
	local u4 = nil;
	local u5 = nil;
	local u6 = nil;
	local u7 = false;
	local function u8()
		for v4, v5 in pairs(u2) do
			v5:Disconnect();
		end;
		u3();
		if u4 then
			u4:Destroy();
		end;
		if u5 then
			p1.Network:UnbindEvent("SwapPC");
		end;
		if u6 then
			p1.Network:UnbindEvent("AddNewBox");
		end;
	end;
	local u9 = nil;
	local u10 = {};
	local u11 = {};
	local u12 = false;
	local function u13(p2)
		for v6, v7 in pairs(p2:GetChildren()) do
			if v7:IsA("GuiObject") and v7.Name ~= "Border" then
				v7.Visible = false;
			end;
		end;
	end;
	local v8 = l__Utilities__1.Class({
		ClassName = "PC"
	}, function(p3)
		u7 = nil;
		p1.ClientDatabase:PDSEvent("ToggleBusy", true);
		p3.Enabled = true;
		u8();
		u9 = nil;
		u10 = {};
		u11 = {};
		p1.guiholder.NPCTalk.Visible = false;
		if u12 then
			u12:Destroy();
			u12 = nil;
		end;
		p1.Menu:Disable();
		p1.Menu.Blur();
		p1.ObjectiveUI:Hide();
		p1.PlayerList:Hide();
		p1.Controls:ToggleWalk(false);
		p3.TextEditing = false;
		p3.DoodleSelected = nil;
		p3.PCUI = p1.guiholder.PCUI;
		p3.BoxUI = p3.PCUI.Box;
		p3.PartyPC = p3.PCUI.Party;
		p3.CurrentBox = 1;
		p3.BoxList = p3.PCUI.BoxList;
		p3.LeftButton = p3.BoxUI.Background.TopBar.Left;
		p3.RightButton = p3.BoxUI.Background.TopBar.Right;
		p1.Gui:ChangeText(p3.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release");
		p1.Gui:TextHover(p3.RightButton.Label, Color3.fromRGB(255, 255, 0));
		p1.Gui:TextHover(p3.LeftButton.Label, Color3.fromRGB(255, 255, 0));
		p1.Gui:LoadingIcon();
		p3.PlayerData = p1.ClientDatabase:PDSFunc("GetData");
		p3.BoxUI.Background.TopBar.NewBox.Visible = false;
		p3.ColorList = p3.PlayerData.ColorList;
		p3.SkinList = p3.PlayerData.Skins;
		p1.Gui:LoadingIconOff();
		u2.Left = p3.LeftButton.MouseButton1Click:Connect(function()
			if p3.Enabled == true then
				p1.Sound:Play("BasicClick", 0.9);
				p3:ChangeBox("Left");
			end;
		end);
		u2.Right = p3.RightButton.MouseButton1Click:Connect(function()
			if p3.Enabled == true then
				p1.Sound:Play("BasicClick", 1.1);
				p3:ChangeBox("Right");
			end;
		end);
		u2.ChangeSize = p3.BoxUI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p3.BoxList.CanvasSize = UDim2.new(0, 0, 0, p3.BoxList.UIListLayout.AbsoluteContentSize.Y);
			p3:UISize();
		end);
		p1.Gui:Hover(p3.BoxUI.Background.TopBar.BulkRelease);
		p1.Gui:Hover(p3.BoxUI.Background.TopBar.Close);
		p1.Gui:Hover(p3.BoxUI.Background.TopBar.NewBox);
		u2.Close = p3.BoxUI.Background.TopBar.Close.MouseButton1Click:Connect(function()
			if p3.Enabled then
				p1.Sound:Play("Boop");
				p3.PCUI.Visible = false;
				p3:Destroy();
				p1.Menu.DisableBlur();
				p1.PCClosed:Fire();
				p1.guiholder.Dragging:ClearAllChildren();
			end;
		end);
		u2.BulkReleaseActivate = p3.BoxUI.Background.TopBar.BulkRelease.MouseButton1Click:Connect(function()
			if p3.Enabled then
				p1.Sound:Play("Boop");
				p3.Enabled = false;
				if not u9 then
					p3:DestroyChoice();
					p1.Gui:SayText("", "You are now on Bulk Release Mode. Click on all the Doodles you want to release, and then press the 'Bulk Release' button to release them all.", nil, true);
					p1.Dialogue:Hide();
					u9 = true;
					p1.Gui:ChangeText(p3.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release Off");
				elseif #u10 > 0 then
					p1.Gui:SayChoiceText("", "[NONEXT]Do you want to release all " .. #u10 .. " Doodles you've selected into the wild?", nil, function()
						p1.Gui:SayChoiceText("", "[NONEXT]Are you ABSOLUTELY sure you want to release all " .. #u10 .. " Doodles you've selected into the wild? This decision cannot be undone.", nil, function()
							p1.Gui:SayText("", "Goodbye, friends!", nil, true);
							p1.Dialogue:Hide();
							local v9 = p1.Network:get("BulkReleaseDoodle", u10);
							if v9 then
								p3.PlayerData = p3:UpdatePlayerDataPacket(v9);
								local v10, v11 = p1.ClientDatabase:PDSFunc("GetColorList");
								p3.ColorList = v10;
								p3.SkinList = v11;
								p3:MakeBoxList();
								p3:SetupBox(p3.CurrentBox);
							end;
							u9 = false;
							u10 = {};
							for v12, v13 in pairs(u11) do
								v13.ImageColor3 = Color3.fromRGB(255, 255, 255);
							end;
							u11 = {};
						end, function()
							p1.Gui:SayText("", "Bulk Release Mode has been turned off.", nil, true);
							p1.Dialogue:Hide();
							u9 = false;
							u10 = {};
							for v14, v15 in pairs(u11) do
								v15.ImageColor3 = Color3.fromRGB(255, 255, 255);
							end;
							u11 = {};
							p1.Gui:ChangeText(p3.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release");
						end);
					end, function()
						p1.Gui:SayText("", "Bulk Release Mode has been turned off.", nil, true);
						p1.Dialogue:Hide();
						u9 = false;
						u10 = {};
						for v16, v17 in pairs(u11) do
							v17.ImageColor3 = Color3.fromRGB(255, 255, 255);
						end;
						u11 = {};
						p1.Gui:ChangeText(p3.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release");
					end);
				else
					u9 = false;
					p1.Gui:SayText("", "Bulk Release Mode is turned off.", nil, true);
					p1.Dialogue:Hide();
					p1.Gui:ChangeText(p3.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release");
				end;
				p3.Enabled = true;
			end;
		end);
		p1.Network:BindEvent("SwapPC", function(p4, p5, p6, p7)
			u7 = true;
			local v18 = 0.2;
			p7 = p3:UpdatePlayerDataPacket(p7);
			if p6 ~= nil then
				for v19, v20 in pairs(p4) do
					local v21, v22 = p3:GetDoodleGui(p3.PlayerData, v19);
					local v23, v24 = p3:GetDoodleGui(p7, v19);
					if v22 and v24 then
						local v25 = v22:FindFirstChild("NewDoodleLabel") or v22:FindFirstChild("DoodleLabel");
						local l__AbsolutePosition__26 = v25.AbsolutePosition;
						local l__AbsoluteSize__27 = v25.AbsoluteSize;
						local l__AbsolutePosition__28 = (v24:FindFirstChild("NewDoodleLabel") or v24:FindFirstChild("DoodleLabel")).AbsolutePosition;
						if not u12 then
							local v29 = v25:Clone();
							p1.Gui:AnimateSprite(v29, v21, true, true);
							if p5.ID == v19 and p6 then
								v18 = 0.1;
								v29.Position = p6;
							else
								v29.Position = UDim2.new(0, l__AbsolutePosition__26.X, 0, l__AbsolutePosition__26.Y);
							end;
							u13(v22);
							v29.Size = UDim2.new(0, l__AbsoluteSize__27.X, 0, l__AbsoluteSize__27.Y);
							v29.AnchorPoint = Vector2.new(0, 0);
							v29.Parent = p1.guiholder.Dragging;
							v29.Visible = true;
							v29:TweenPosition(UDim2.new(0, l__AbsolutePosition__28.X, 0, l__AbsolutePosition__28.Y), "Out", "Linear", v18);
						else
							u12:TweenPosition(UDim2.new(0, l__AbsolutePosition__28.X, 0, l__AbsolutePosition__28.Y), "Out", "Linear", v18);
						end;
					end;
				end;
				l__Utilities__1.Halt(0.2);
			end;
			u7 = false;
			p1.guiholder.Dragging:ClearAllChildren();
			if u12 then
				u12:Destroy();
				u12 = nil;
			end;
			p1.Gui:LoadingIconOff();
			p3.PlayerData = p7;
			p3:MakeBoxList();
			p3:SetupBox(p3.CurrentBox);
		end);
		p1.Network:BindEvent("AddNewBox", function(p8, p9, p10)
			p3.PlayerData.PC[p8] = p9;
			p3.PlayerData.PCCustomization[tostring(p8)] = p10;
			p3:MakeSpecificBoxList(p8);
			if p8 >= 30 then
				p3.BoxUI.Background.TopBar.NewBox.Visible = false;
			end;
		end);
		u6 = true;
		u5 = true;
		p3:MakeBoxList();
		p3:SetupBox(p3.CurrentBox);
		p3.BoxList.CanvasSize = UDim2.new(0, 0, 0, p3.BoxList.UIListLayout.AbsoluteContentSize.Y + 15);
		if #p3.PlayerData.PC < 30 then
			u2.NewBoxClick = p3.BoxUI.Background.TopBar.NewBox.MouseButton1Click:Connect(function()
				if p3.Enabled then
					p1.Sound:Play("Boop");
					p1.Services.MarketplaceService:PromptProductPurchase(p1.p, 1235019884);
				end;
			end);
			p3.BoxUI.Background.TopBar.NewBox.Visible = true;
		end;
		p3.PCUI.Visible = true;
	end);
	function v8.UpdatePC(p11)
		p11.PlayerData = p1.ClientDatabase:PDSFunc("GetData");
		p11:SetupBox(p11.CurrentBox);
		p11:SetupParty();
	end;
	function v8.UpdatePlayerDataPacket(p12, p13)
		local l__PlayerData__30 = p12.PlayerData;
		local v31, v32, v33 = pairs(p13);
		while true do
			local v34 = nil;
			local v35 = nil;
			v35, v34 = v31(v32, v33);
			if not v35 then
				break;
			end;
			v33 = v35;
			if v35 == "Party" then
				l__PlayerData__30.Party = v34;
			else
				l__PlayerData__30.PC[tonumber(v35)] = v34;
			end;		
		end;
		return l__PlayerData__30;
	end;
	local u14 = nil;
	function v8.DestroyChoice(p14)
		if u14 then
			u14:Destroy();
		end;
		if u4 then
			u4:Destroy();
		end;
	end;
	function v8.GetDoodleGui(p15, p16, p17)
		local v36, v37, v38 = pairs(p16.Party);
		while true do
			local v39, v40 = v36(v37, v38);
			if not v39 then
				break;
			end;
			if v40.ID == p17 then
				local v41 = p15.PartyPC:FindFirstChild("Doodle" .. v39);
				if v41 then
					return v40, v41;
				end;
			end;
			for v42, v43 in pairs(p16.PC[p15.CurrentBox]) do
				if v43.ID == p17 then
					local v44 = p15.BoxUI:FindFirstChild("Doodle" .. v42);
					if v44 then
						return v43, v44;
					end;
				end;
			end;		
		end;
	end;
	function v8.AllowedChecks(p18, p19)
		local v45 = {};
		for v46, v47 in pairs(p18.PartyPC:GetChildren()) do
			if v47.Name:find("Doodle") then
				table.insert(v45, v47);
			end;
		end;
		for v48, v49 in pairs(p18.BoxUI:GetChildren()) do
			if v49.Name:find("Doodle") then
				table.insert(v45, v49);
			end;
		end;
		for v50, v51 in pairs(p18.BoxList:GetChildren()) do
			if v51:IsA("GuiObject") then
				table.insert(v45, v51);
			end;
		end;
		return v45;
	end;
	function v8.ConvertLocation(p20, p21)
		if p21.Name == "Party" then
			return "Party";
		end;
		if p21.Name ~= "Box" then
			return nil;
		end;
		return p20.CurrentBox;
	end;
	function v8.GetDoodle(p22, p23)

	end;
	function v8.FindEmptySlot(p24, p25)
		local v52 = p24.PlayerData.PC[p25];
		local v53 = 1 - 1;
		while v52[tostring(v53)] and v52[tostring(v53)].Name ~= nil do
			if 0 <= 1 then
				if not (v53 < 25) then
					return false;
				end;
			elseif not (v53 > 25) then
				return false;
			end;
			v53 = v53 + 1;		
		end;
		return v53;
	end;
	function v8.EmptySlot(p26, p27, p28)
		if p28 == "Party" then
			if p26.PlayerData.Party[p27] and p26.PlayerData.Party[p27].Name then
				return false;
			end;
		elseif p26.PlayerData.PC[p26.CurrentBox][tostring(p27)] and p26.PlayerData.PC[p26.CurrentBox][tostring(p27)].Name then
			return false;
		end;
		return true;
	end;
	local function u15(p29, p30)
		if p30 == "Party" then
			return tonumber(p29);
		end;
		return tostring(p29);
	end;
	local function u16(p31)
		return p31.Name:match("%d+");
	end;
	function v8.SetDraggable(p32, p33, p34)
		local v54 = {
			NotBigger = true, 
			Collide = p32:AllowedChecks(p33), 
			UpdateCollide = p32.AllowedChecks
		};
		function v54.Requirement()
			if p32.Enabled and not u7 and not u9 then
				return true;
			end;
			return false;
		end;
		local u17 = nil;
		function v54.Function(p35, p36)
			local v55 = p32:ConvertLocation(p33.Parent.Parent);
			if not u7 and p32.Enabled then
				if p35.Parent == p32.BoxList then
					if v55 == "Party" and #p32.PlayerData.Party == 1 then
						return;
					end;
					local v56 = p32:FindEmptySlot(tonumber(p35.Name));
					if v56 then
						p33.Visible = false;
						local v57 = u15(p33.Parent.Name:match("%d+"), v55);
						local v58 = tonumber(p35.Name);
						local v59 = u15(v56, v58);
						local l__mouse__60 = p1.p:GetMouse();
						local v61 = UDim2.new(0, l__mouse__60.X, 0, l__mouse__60.Y);
						p1.Gui:LoadingIcon();
						u7 = true;
						p1.Network:post("SwapPC", v57, v55, v59, v58, v61);
						return;
					end;
				else
					local v62 = u15(p33.Parent.Name:match("%d+"), v55);
					local v63 = p32:ConvertLocation(p35.Parent);
					local v64 = u15(p35.Name:match("%d+"), v63);
					if v62 == v64 and v55 == v63 then
						p32:SetupChoice(p33.Parent, p34);
						return;
					end;
					if v55 == "Party" and #p32.PlayerData.Party == 1 and p32:EmptySlot(v64, v63) then
						return;
					end;
					if u12 then
						u12:Destroy();
					end;
					u17:ForceInvisible();
					p1.Gui:LoadingIcon();
					if p36 then
						u12 = p33:Clone();
						local l__AbsoluteSize__65 = p33.AbsoluteSize;
						u12.Position = p36;
						u12.Size = UDim2.new(0, l__AbsoluteSize__65.X, 0, l__AbsoluteSize__65.Y);
						u12.Visible = true;
						u12.Name = "MovingGui";
						u12.AnchorPoint = Vector2.new(0, 0);
						u12.Parent = p1.guiholder;
					end;
					u7 = true;
					p1.Network:post("SwapPC", v62, v55, v64, v63, p36);
				end;
			end;
		end;
		function v54.StartDraggingFunc()
			p32:DestroyChoice();
		end;
		function v54.IfNoDragging(p37)
			p32:SetupChoice(p33.Parent, p34);
		end;
		u17 = p1.GuiDragging.new(v54, p33, p32);
		table.insert(u1, (p33.MouseButton1Down:Connect(function()
			if p32.Enabled and not p34.NR and u9 and p34 and p33.Parent.Parent.Name ~= "Party" then
				local v66 = nil;
				p1.Sound:Play("BasicClick", 0.9);
				v66 = p32.BoxList:FindFirstChild(tostring(p32.CurrentBox)):FindFirstChild("Doodle" .. tostring((u16(p33.Parent)))).DoodleLabel;
				if not table.find(u10, p34.ID) then
					table.insert(u10, p34.ID);
					table.insert(u11, p33);
					p33.ImageColor3 = Color3.fromRGB(0, 0, 0);
					v66.ImageColor3 = Color3.fromRGB(0, 0, 0);
					table.insert(u11, v66);
				elseif table.find(u10, p34.ID) then
					p1.Sound:Play("BasicClick", 1.1);
					table.remove(u10, table.find(u10, p34.ID));
					table.remove(u11, table.find(u11, p33));
					p33.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v66.ImageColor3 = Color3.fromRGB(255, 255, 255);
					table.remove(u11, table.find(u11, v66));
				end;
				if #u10 == 0 then
					p1.Gui:ChangeText(p32.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release Off");
					return;
				end;
				p1.Gui:ChangeText(p32.BoxUI.Background.TopBar.BulkRelease.Label, "Bulk Release");
			end;
		end)));
		table.insert(u1, u17);
	end;
	function v8.Hide(p38)
		p38.PCUI.Visible = false;
	end;
	function v8.UpdateDoodle(p39, p40, p41)
		for v67, v68 in pairs(p39.PlayerData.Party) do
			if v68 and v68.ID == p40.ID then
				p39.PlayerData.Party[v67] = p40;
				return;
			end;
		end;
		for v69, v70 in pairs(p39.PlayerData.PC[p41]) do
			if v70 and v70.ID == p40.ID then
				p39.PlayerData.PC[p41][tostring(v69)] = p40;
				return;
			end;
		end;
	end;
	function v8.Show(p42, p43, p44)
		p42:UpdateDoodle(p43, p44);
		p42:SetupBox(p42.CurrentBox);
		p42.PCUI.Visible = true;
	end;
	local function u18(p45)
		for v71, v72 in pairs(p45:GetChildren()) do
			if v72:IsA("GuiObject") and v72.Visible == true then
				return v72;
			end;
		end;
		return u18;
	end;
	local u19 = {
		Doodle21 = true, 
		Doodle22 = true, 
		Doodle23 = true, 
		Doodle24 = true, 
		Doodle25 = true
	};
	function v8.SetupChoice(p46, p47, p48)
		p46:DestroyChoice();
		if not p46.Enabled then
			return;
		end;
		u4 = p1.GuiObjs.Backdrop:Clone();
		u4.Parent = p47;
		u14 = p1.GuiObjs.PCChoice:Clone();
		local l__AbsoluteSize__73 = p47.AbsoluteSize;
		local l__AbsolutePosition__74 = p47.DoodleLabel.AbsolutePosition;
		local v75 = { u14.Move, u14.TakeItem, u14.Stats };
		if p47.Parent.Name == "Party" then
			p1.Gui:ChangeText(u14.Release.Label, "Release", Color3.fromRGB(128, 128, 128));
			u14.Release.ImageColor3 = Color3.fromRGB(36, 75, 95);
		else
			table.insert(v75, u14.Release);
			p1.Gui:ChangeText(u14.Release.Label, "Release", Color3.fromRGB(255, 255, 255));
		end;
		if p46.DoodleSelected then
			p1.Gui:ChangeText(u14.Move.Label, "Swap");
		end;
		for v76, v77 in pairs(v75) do
			if v77:IsA("ImageButton") then
				p1.Gui:TextHover(v77.Label);
				p1.Gui:Hover(v77);
			end;
		end;
		local l__AbsolutePosition__20 = p47.AbsolutePosition;
		local u21 = 13;
		local u22 = nil;
		u22 = p47:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			if u14 ~= u14 then
				if u22 then
					u22:Disconnect();
				end;
				return;
			end;
			u14.Position = UDim2.new(0, l__AbsolutePosition__20.X + p47.AbsoluteSize.X - 6, 0, p47.AbsolutePosition.Y + u21);
		end);
		u14.TakeItem.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p46.Enabled = false;
			p46:DestroyChoice();
			if p48.HeldItem == nil then
				p1.Gui:TextAnnouncement(l__Utilities__1.GetName(p48) .. " doesn't have an item equipped.");
			else
				p1.Gui:TextAnnouncement("You took " .. p48.HeldItem .. " from " .. l__Utilities__1.GetName(p48) .. ".");
				p48.HeldItem = nil;
				p1.Network:post("TakeItem", p48.ID);
			end;
			p46.Enabled = true;
		end);
		u14.Release.MouseButton1Click:Connect(function()
			p46:DestroyChoice();
			if p47.Parent.Name == "Party" then
				p1.Sound:Play("BasicClick");
				return;
			end;
			p46.Enabled = false;
			if not p48.NR then
				p1.Gui:SayChoiceText("", "[NONEXT]Do you want to release " .. l__Utilities__1.GetName(p48) .. " back into the wild?", nil, function()
					p1.Gui:SayText("", "Goodbye, " .. l__Utilities__1.GetName(p48) .. "!", nil, true);
					p1.Dialogue:Hide();
					local v78 = u18(p47);
					v78:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
					l__Utilities__1.Halt(0.5);
					v78:Destroy();
					local v79 = p1.Network:get("ReleaseDoodle", p48.ID);
					if v79 then
						p46.PlayerData = p46:UpdatePlayerDataPacket(v79);
						local v80, v81 = p1.ClientDatabase:PDSFunc("GetColorList");
						p46.ColorList = v80;
						p46.SkinList = v81;
						p46:MakeBoxList();
						p46:SetupBox(p46.CurrentBox);
					end;
				end, function()
					p1.Gui:SayText("", "You did not release " .. l__Utilities__1.GetName(p48) .. ".", nil, true);
					p1.Dialogue:Hide();
				end);
				p46.Enabled = true;
				return;
			end;
			p1.Gui:SayText("", "You can't release " .. l__Utilities__1.GetName(p48) .. "!", nil, true);
			p1.Dialogue:Hide();
			p46.Enabled = true;
		end);
		u14.Stats.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop");
			p46:DestroyChoice();
			p46:Hide();
			p1.Stats.new({
				PlayerParty = p47.Parent.Name == "Party" and p46.PlayerData.Party or nil, 
				Box = p47.Parent.Name ~= "Party" and p46.PlayerData.PC[p46.CurrentBox] or nil, 
				CurrentBox = p46.CurrentBox, 
				ColorList = p46.ColorList, 
				SkinList = p46.SkinList, 
				Party = p46, 
				PC = p46
			}, p48);
		end);
		u14.Move.MouseButton1Click:Connect(function()
			local l__mouse__82 = p1.p:GetMouse();
			p46:DestroyChoice();
			p1.Sound:Play("BasicClick");
			if not p46.DoodleSelected then
				local v83 = p46:ConvertLocation(p47.Parent);
				p46.DoodleSelected = {
					Doodle = p48, 
					StartNumber = u15(p47.Name:match("%d+"), v83), 
					StartLocation = v83
				};
				return;
			end;
			local v84 = p46:ConvertLocation(p47.Parent);
			local v85 = u15(p47.Name:match("%d+"), v84);
			p1.Gui:LoadingIcon();
			p1.Network:post("SwapPC", p46.DoodleSelected.StartNumber, p46.DoodleSelected.StartLocation, v85, v84, nil);
			p46.DoodleSelected = nil;
		end);
		u14.Parent = p1.guiholder;
		u14.Position = UDim2.new(-10, l__AbsolutePosition__20.X + l__AbsoluteSize__73.X - 6, -10, l__AbsolutePosition__74.Y + u21);
		if u19[p47.Name] then
			u21 = -u14.AbsoluteSize.Y / 2 - 13;
			u14.Border.Separator.Position = UDim2.new(0, 0, 1, 0);
			u14.Border.Separator.AnchorPoint = Vector2.new(0.1, 1);
		end;
		u14.Position = UDim2.new(0, l__AbsolutePosition__20.X + l__AbsoluteSize__73.X - 6, 0, l__AbsolutePosition__74.Y + u21);
	end;
	function v8.SetDoodle(p49, p50, p51)
		if p50.Level:FindFirstChild("UIGradient") then
			p50.Level.UIGradient:Destroy();
		end;
		if p51 == nil or p51.Name == nil then
			p1.Gui:AnimateSprite(p50, nil, true);
			u1[p50] = p50.Parent.MouseButton1Click:Connect(function()
				if p49.DoodleSelected and p49.Enabled then
					local v86 = p49:ConvertLocation(p50.Parent.Parent);
					local v87 = u15(p50.Parent.Name:match("%d+"), v86);
					p1.Gui:LoadingIcon();
					p1.Network:post("SwapPC", p49.DoodleSelected.StartNumber, p49.DoodleSelected.StartLocation, v87, v86, p49.DoodleSelected.Position);
				end;
				p49.DoodleSelected = nil;
			end);
			return;
		end;
		p50.Level.Visible = false;
		local v88 = {};
		if p51.Name then
			p1.Gui:ChangeText(p50.Level, "Lv. " .. p51.Level);
			if p51.Shiny then
				table.insert(v88, Color3.fromRGB(255, 255, 0));
			end;
			if p51.Tint and p51.Tint ~= 0 then
				table.insert(v88, Color3.fromRGB(255, 170, 0));
			end;
			if p51.Ability == p1.DoodleInfo[p51.Name].HiddenAbility then
				table.insert(v88, Color3.fromRGB(0, 255, 255));
			end;
			if p51.Skin and p51.Skin ~= 0 then
				table.insert(v88, Color3.fromRGB(255, 0, 0));
			end;
			if #v88 > 0 then
				local v89 = l__Utilities__1:Create("UIGradient")({
					Parent = p50.Level, 
					Color = l__Utilities__1.CreateColorSequence(v88), 
					Rotation = 0
				});
			end;
			p50.Level.TextStrokeTransparency = 0;
			local v90 = p1.Gui:AnimateSprite(p50, p51, true);
			v90.Level.Visible = true;
			if table.find(u10, p51.ID) then
				v90.ImageColor3 = Color3.fromRGB(0, 0, 0);
			end;
			p1.Gui:Hover(v90, nil, nil, function()
				if not table.find(u10, p51.ID) then
					return true;
				end;
				return false;
			end);
			p49:SetDraggable(v90, p51);
		end;
	end;
	function v8.UISize(p52)
		if p52.PCUI and p52.BoxUI and p52.PartyPC then
			local l__X__91 = p52.BoxUI.Doodle1.DoodleLabel.AbsoluteSize.X;
			local v92 = l__X__91 * 4 / 3;
			local v93 = v92 * 2.5;
			local v94 = v92 / 8;
			p52.PartyPC.Size = UDim2.new(0, v93, 0, v92 * 3.75);
			p52.PartyPC.Position = UDim2.new(0, 10, 0.5, 0);
			p52.BoxList.Size = UDim2.new(0, v93, 0, p52.BoxUI.Background.AbsoluteSize.X);
			p52.BoxList.Position = UDim2.new(1, -10, 0.5, 0);
			for v95 = 1, 6 do
				local v96 = p52.PartyPC:FindFirstChild("Doodle" .. v95);
				if v96 then
					v96.Size = UDim2.new(0, v92, 0, v92);
					v96.DoodleLabel.Size = UDim2.new(0, l__X__91, 0, l__X__91);
					v96.Position = UDim2.new((v95 + 1) % 2 * 0.5, v94, math.floor(v95 / 2 - (v95 + 1) % 2) * 0.33, v94);
				end;
			end;
		end;
	end;
	function v8.GetBoxName(p53, p54)
		if not p53.PlayerData.PCCustomization[tostring(p54)] or not p53.PlayerData.PCCustomization[tostring(p54)].Name then
			return "Storage " .. p54;
		end;
		return p53.PlayerData.PCCustomization[tostring(p54)].Name;
	end;
	function v8.GetBackground(p55, p56)
		if not p55.PlayerData.PCCustomization[tostring(p56)] or not p55.PlayerData.PCCustomization[tostring(p56)].BGColor then
			return Color3.fromRGB(128, 128, 128);
		end;
		local l__BGColor__97 = p55.PlayerData.PCCustomization[tostring(p56)].BGColor;
		return Color3.new(l__BGColor__97.r, l__BGColor__97.g, l__BGColor__97.b);
	end;
	function v8.ChangeTop(p57, p58)
		p1.Gui:ChangeText(p57.BoxUI.Background.TopBar.Label, p57:GetBoxName(p58));
		p57.BoxUI.Background.ImageColor3 = p57:GetBackground(p58);
		local l__TopBar__98 = p57.BoxUI.Background.TopBar;
		p1.Gui:Hover(l__TopBar__98.Rename);
		p1.Gui:Hover(l__TopBar__98.Recolor);
		u1[l__TopBar__98.Rename] = p1.Tooltip.new({
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, l__TopBar__98.Rename, "Rename");
		u1[l__TopBar__98.Recolor] = p1.Tooltip.new({
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, l__TopBar__98.Recolor, "Background");
		u1.Rename = l__TopBar__98.Rename.MouseButton1Click:Connect(function()
			if not p57.TextEditing and p57.Enabled then
				p57.TextEditiing = true;
				l__TopBar__98.Label.Visible = false;
				l__TopBar__98.TextBox.TextEditable = true;
				l__TopBar__98.TextBox.Text = "Storage " .. p58;
				l__TopBar__98.TextBox.Visible = true;
				l__TopBar__98.TextBox:CaptureFocus();
			end;
		end);
		u1.FocusLost = l__TopBar__98.TextBox.FocusLost:Connect(function()
			l__TopBar__98.TextBox.TextEditable = false;
			local v99, v100 = p1.Network:get("NameBox", p58, l__TopBar__98.TextBox.Text);
			p57.TextEditing = nil;
			if v99 then
				p1.Gui:ChangeText(l__TopBar__98.Label, v99);
				if v100 then
					p57.PlayerData.PCCustomization = v100;
				end;
				if p57.BoxList:FindFirstChild(p58) then
					p1.Gui:ChangeText(p57.BoxList:FindFirstChild(p58).Background.Label, v99);
				end;
			end;
			l__TopBar__98.TextBox.Visible = false;
			l__TopBar__98.Label.Visible = true;
		end);
		u1.Recolor = l__TopBar__98.Recolor.MouseButton1Click:Connect(function()
			p57:DestroyChoice();
			if p57.ColorPickerFrame or not p57.Enabled then
				return;
			end;
			p57.Enabled = false;
			local l__ColorPickerFrame__101 = p57.BoxUI.Background.ColorPickerFrame;
			p57.ColorPickerFrame = nil;
			p57.ColorPickerFrame = p1.ColorGradientPicker.new({
				OnUpdate = function(p59)
					p57.BoxUI.Background.ImageColor3 = p59;
				end, 
				OnClose = function(p60)
					p57.Enabled = true;
					local v102 = p1.Network:get("ColorBox", p58, p60);
					if v102 then
						p57.PlayerData.PCCustomization = v102;
					end;
					p57:MakeBoxList();
					p57.ColorPickerFrame:Destroy();
					p57.ColorPickerFrame = nil;
				end
			}, l__ColorPickerFrame__101);
			l__ColorPickerFrame__101.Visible = true;
		end);
	end;
	function v8.ChangeBox(p61, p62)
		local v103 = nil;
		v103 = #p61.PlayerData.PC;
		if p62 == "Left" then
			p61.CurrentBox = p61.CurrentBox - 1 <= 0 and v103 or p61.CurrentBox - 1;
		elseif p62 == "Right" then
			if v103 < p61.CurrentBox + 1 then
				local v104 = 1;
			else
				v104 = p61.CurrentBox + 1;
			end;
			p61.CurrentBox = v104;
		end;
		p61:SetupBox(p61.CurrentBox);
	end;
	function v8.ClearBoxes(p63)
		for v105, v106 in pairs(p63.BoxList:GetChildren()) do
			if v106:IsA("GuiObject") then
				v106:Destroy();
			end;
		end;
	end;
	function v8.MakeSpecificBoxList(p64, p65)
		local v107 = p1.GuiObjs.TinyBox:Clone();
		v107.Background.ImageColor3 = p64:GetBackground(p65);
		p1.Gui:ChangeText(v107.Background.Label, p64:GetBoxName(p65));
		v107.Name = p65;
		for v108, v109 in pairs(v107:GetChildren()) do
			if v109.Name:find("Doodle") then
				v109.DoodleLabel.Visible = false;
			end;
		end;
		for v110, v111 in pairs(p64.PlayerData.PC[p65]) do
			local v112 = v107:FindFirstChild("Doodle" .. v110);
			if v112 and v111.Name then
				p1.Gui:StaticImage(v112.DoodleLabel, v111, true);
			end;
		end;
		p1.Gui:Hover(v107.Background);
		v107.Background.MouseButton1Click:Connect(function()
			if p64.Enabled then
				p1.Sound:Play("Boop");
				p64.CurrentBox = tonumber(v107.Name);
				p64:SetupBox(p64.CurrentBox);
			end;
		end);
		v107.Parent = p64.BoxList;
		p64.BoxList.CanvasSize = UDim2.new(0, 0, 0, p64.BoxList.UIListLayout.AbsoluteContentSize.Y + 15);
	end;
	function v8.MakeBoxList(p66)
		local u23 = nil;
		p66:ClearBoxes();
		for v113 = 1, #p66.PlayerData.PC do
			local v114 = p1.GuiObjs.TinyBox:Clone();
			v114.Background.ImageColor3 = p66:GetBackground(v113);
			p1.Gui:ChangeText(v114.Background.Label, p66:GetBoxName(v113));
			v114.Name = v113;
			for v115, v116 in pairs(v114:GetChildren()) do
				if v116.Name:find("Doodle") then
					v116.DoodleLabel.Visible = false;
				end;
			end;
			for v117, v118 in pairs(p66.PlayerData.PC[v113]) do
				local v119 = v114:FindFirstChild("Doodle" .. v117);
				if v119 and v118.Name then
					p1.Gui:StaticImage(v119.DoodleLabel, v118, true);
				end;
			end;
			p1.Gui:Hover(v114.Background);
			u23 = p66;
			v114.Background.MouseButton1Click:Connect(function()
				if u23.Enabled then
					p1.Sound:Play("Boop");
					u23.CurrentBox = tonumber(v114.Name);
					u23:SetupBox(u23.CurrentBox);
				end;
			end);
			v114.Parent = u23.BoxList;
		end;
		u23.BoxList.CanvasSize = UDim2.new(0, 0, 0, u23.BoxList.UIListLayout.AbsoluteContentSize.Y + 15);
	end;
	function v8.SetupBox(p67, p68)
		p67:DestroyChoice();
		u3();
		local v120 = p67.PlayerData.PC[p68];
		p67:ChangeTop(p68);
		for v121, v122 in pairs(p67.BoxUI:GetChildren()) do
			if v122.Name:find("Doodle") then
				v122.DoodleLabel.Visible = false;
			end;
		end;
		for v123 = 1, 25 do
			p67:SetDoodle(p67.BoxUI:FindFirstChild("Doodle" .. v123).DoodleLabel, v120[tostring(v123)]);
		end;
		p67:SetupParty();
	end;
	function v8.SetupParty(p69)
		p69:UISize();
		for v124, v125 in pairs(p69.PartyPC:GetChildren()) do
			if v125.Name:find("Doodle") then
				v125.DoodleLabel.Visible = false;
				p69:SetDoodle(v125.DoodleLabel, p69.PlayerData.Party[tonumber(v125.Name:match("%d+"))]);
			end;
		end;
	end;
	function v8.Destroy(p70)
		p1.ClientDatabase:PDSEvent("ToggleBusy", false);
		p1.ObjectiveUI:Show();
		p1.PlayerList:Show();
		for v126, v127 in pairs(p70.PCUI:GetDescendants()) do
			if v127:IsA("UIGradient") and v127.Name ~= "Rainbow" then
				v127:Destroy();
			end;
		end;
		if p70.ColorPickerFrame then
			p70.ColorPickerFrame:Destroy();
			p70.ColorPickerFrame = nil;
		end;
		p70:DestroyChoice();
		u8();
		p70:ClearBoxes();
		p70.PlayerData = nil;
		for v128, v129 in pairs(p70.PCUI.Box:GetChildren()) do
			if v129:FindFirstChild("NewDoodleLabel") then
				v129.NewDoodleLabel:Destroy();
			end;
		end;
		p1.guiholder.Dragging:ClearAllChildren();
		setmetatable(p70, nil);
	end;
	return v8;
end;
