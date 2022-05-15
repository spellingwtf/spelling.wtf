-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local u2 = p1.DoodleOrder;
	local function u3(p2, p3)
		return p2 + 10 - p2 % (p3 and 1);
	end;
	local u4 = false;
	local function u5()
		local v2 = 0;
		for v3, v4 in pairs(u2) do
			if v2 < v3 then
				v2 = v3;
			end;
		end;
		return u3(v2, 10);
	end;
	local u6 = false;
	local u7 = {};
	local u8 = nil;
	local u9 = 1;
	local u10 = "Stats";
	local u11 = nil;
	local function u12(p4)
		local v5 = p4.LeftHolder.ListHolder.Number1.AbsoluteSize.Y * 0.75;
		for v6, v7 in pairs(p4.LeftHolder.ListHolder:GetChildren()) do
			if v7:IsA("GuiObject") then
				v7.Title.TextSize = v5;
				v7.Number.TextSize = v5;
				v7.Checkmark.TextSize = v5;
			end;
		end;
	end;
	local v8 = l__Utilities__1.Class({
		ClassName = "Doodlepedia"
	}, function(p5)
		if ChangedSize then
			ChangedSize:Disconnect();
		end;
		p5.Highest = u5();
		u4 = false;
		u6 = false;
		u7 = {};
		u8 = nil;
		p5.UI = p1.guiholder.Doodlepedia;
		local v9, v10 = p1.ClientDatabase:PDSFunc("GetDoodlepedia");
		p5.Seen = v9;
		p5.Achievements = v10;
		p5.UI.Position = UDim2.new(0.5, 0, -1, -18);
		p5.UI.Visible = true;
		p5.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		p1.Gui:Hover(p5.UI.Close);
		p5.distance = 0.8 * (10 / p5.Highest);
		p5.RightHolder = p5.UI.RightHolder;
		p5.LeftHolder = p5.UI.LeftHolder;
		p5.DoodleName = p5.UI.DoodleName;
		p5.SkinHolder = p5.UI.Skins;
		p5.SkinScroller = p5.SkinHolder.SkinBackground.SkinScroller;
		p5.SkinButton = p5.UI.SkinToggle;
		p5.LeftHolder.ScrollBar.Size = UDim2.new(0.1, 0, math.min(0.8, p5.distance), 0);
		p5.LeftHolder.ScrollBar.Position = UDim2.new(1, 0, 0.1, 0);
		p5.SearchTextBox = p5.UI.SearchTextBox;
		p5.Search = p5.SearchTextBox.TextBox;
		p5.Search.Text = "Search";
		p1.Gui:Hover(p5.LeftHolder.ScrollDown);
		p1.Gui:Hover(p5.LeftHolder.ScrollUp);
		p1.Gui:TextHover(p5.RightHolder.Entry.Label);
		p1.Gui:TextHover(p5.RightHolder.Tasks.Label);
		p5:Stats();
		u9 = 1;
		p5:Update(u9, true);
		for v11, v12 in pairs(p5.LeftHolder.ListHolder:GetChildren()) do
			if v12:IsA("ImageButton") then
				v12.ImageColor3 = Color3.fromRGB(255, 255, 255);
				v12.Number.TextColor3 = Color3.fromRGB(67, 59, 50);
				u1[v12.Name .. "Enter"] = v12.MouseEnter:Connect(function()
					v12.ImageColor3 = Color3.fromRGB(128, 128, 128);
					v12.Number.TextColor3 = Color3.fromRGB(121, 106, 90);
				end);
				u1[v12.Name .. "Leave"] = v12.MouseLeave:Connect(function()
					v12.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v12.Number.TextColor3 = Color3.fromRGB(67, 59, 50);
				end);
				u1[v12.Name .. "Click"] = v12.MouseButton1Click:Connect(function()
					if u7[v12] then
						p1.Sound:Play("PageFlip");
						if u10 ~= "Stats" then
							p5:Tasks(u7[v12]);
							return;
						end;
					else
						return;
					end;
					p5:Stats(u7[v12]);
				end);
			end;
		end;
		u1.Entry = p5.RightHolder.Entry.MouseButton1Click:Connect(function()
			if u11 then
				p1.Sound:Play("PageFlip");
				p5:Stats({
					Doodle = u11, 
					Type = p5.Seen[tostring(p1.DoodleInfo[u11].Num)]
				});
			end;
		end);
		u1.Tasks = p5.RightHolder.Tasks.MouseButton1Click:Connect(function()
			if u11 then
				p1.Sound:Play("PageFlip");
				p5:Tasks({
					Doodle = u11, 
					Type = p5.Seen[tostring(p1.DoodleInfo[u11].Num)]
				});
			end;
		end);
		u1.ScrollUp = p5.LeftHolder.ScrollUp.MouseButton1Click:Connect(function()
			if u9 ~= 1 then
				p5.LeftHolder.ScrollBar.Position = p5.LeftHolder.ScrollBar.Position - UDim2.new(0, 0, p5.distance, 0);
				p1.Sound:Play("Flip");
				u9 = u9 - 10;
				p5:Update(u9);
			end;
		end);
		u1.ScrollDown = p5.LeftHolder.ScrollDown.MouseButton1Click:Connect(function()
			if u9 + 10 < p5.Highest then
				p5.LeftHolder.ScrollBar.Position = p5.LeftHolder.ScrollBar.Position + UDim2.new(0, 0, p5.distance, 0);
				p1.Sound:Play("Flip");
				u9 = u9 + 10;
				p5:Update(u9);
			end;
		end);
		p1.Tooltip.new({}, p5.UI.ShinyToggle, "Toggle Misprint");
		u1.ShinyToggle = p5.UI.ShinyToggle.MouseButton1Click:Connect(function()
			if u11 then
				p1.Sound:Play("Flip");
				local v13 = p1.DoodleInfo[u11];
				if p5.Seen[tostring(p1.DoodleInfo[u11].Num)] == 3 then
					u4 = not u4;
					p5.UI.ShinyToggle.Shiny.ImageColor3 = u4 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(102, 102, 102);
					p5.RightHolder.DoodleImage.DoodleLabel.Image = u4 and v13.SFSprite or v13.FrontSprite;
					if p5.SkinHolder.Visible then
						for v14, v15 in pairs(p5.SkinScroller:GetChildren()) do
							if v15:IsA("GuiObject") then
								p1.Gui:AnimateSprite(v15.DoodleLabel, {
									Name = u11, 
									Skin = tonumber(v15.Name), 
									Gender = "M", 
									Shiny = u4
								}, true);
							end;
						end;
					end;
				end;
			end;
		end);
		u1.ShinyEnter = p5.UI.ShinyToggle.MouseEnter:Connect(function()
			p5.UI.ShinyToggle.Roundify.ImageColor3 = Color3.fromRGB(82, 124, 124);
		end);
		u1.ShinyLeave = p5.UI.ShinyToggle.MouseLeave:Connect(function()
			p5.UI.ShinyToggle.Roundify.ImageColor3 = Color3.fromRGB(170, 255, 255);
		end);
		p1.Tooltip.new({}, p5.SkinButton, "Toggle Skin List");
		u1.SkinList = p5.SkinButton.MouseButton1Click:Connect(function()
			local v16 = nil;
			if u11 then
				p1.Sound:Play("Flip");
				v16 = p1.DoodleInfo[u11].Num;
				if p5.Seen[tostring(v16)] >= 1 then
					if not u6 then
						u6 = true;
						p5:ShowSkins(u11);
						return;
					end;
				else
					return;
				end;
			else
				return;
			end;
			u6 = nil;
			p5:Stats({
				Doodle = u11, 
				Type = p5.Seen[tostring(v16)]
			});
		end);
		u1.SkinEnter = p5.SkinButton.MouseEnter:Connect(function()
			p5.SkinButton.Roundify.ImageColor3 = Color3.fromRGB(130, 84, 84);
		end);
		u1.SkinLeave = p5.SkinButton.MouseLeave:Connect(function()
			p5.SkinButton.Roundify.ImageColor3 = Color3.fromRGB(255, 165, 165);
		end);
		u1.Close = p5.UI.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p5.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p5.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			p5:Destroy();
		end);
		u1.CloseEnter = p5.UI.Close.MouseEnter:Connect(function()
			p5.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p5.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = p5.UI.Close.MouseLeave:Connect(function()
			p5.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p5.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u1.Search = p5.Search.FocusLost:Connect(function()
			local v17 = {};
			local v18 = p5.Search.Text;
			if v18:lower() == "search" then
				v18 = "";
			end;
			for v19, v20 in pairs(p1.DoodleInfo) do
				if v19:lower():find(v18:lower()) then
					table.insert(v17, v19);
				end;
			end;
			table.sort(v17, function(p6, p7)
				if p1.DoodleInfo[p6].Num < p1.DoodleInfo[p7].Num then
					return true;
				end;
				return false;
			end);
			u8 = v17;
			u9 = 1;
			p5:Update(u9, true);
		end);
		p5.UI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			u12(p5.UI);
		end);
		u12(p5.UI);
	end);
	local function u13(p8, p9)
		return math.floor(p8 * 10 ^ p9) / 10 ^ p9;
	end;
	local function u14(p10)
		local v21 = tostring(p10);
		if #v21 ~= 1 then
			return v21;
		end;
		return "0" .. p10;
	end;
	local l__Achievements__15 = p1.Achievements;
	local u16 = {
		Capture = "Capture", 
		Experience = "Gain experience", 
		MaxFriendship = "Max friendship", 
		Evolve = "Evolve DoodleName", 
		Status = "Inflict StatusEffect", 
		Faint = "Knock out DoodleName", 
		Damage = "Do damage", 
		CauseFaint = "Knock out with DoodleName", 
		Breed = "Breed", 
		CaptureMisprint = "Capture Misprint", 
		Levelup = "Level up", 
		UseMove = "Use MoveName"
	};
	function v8.Tasks(p11, p12)
		u10 = "Tasks";
		local v22 = p1.DoodleInfo[p12.Doodle];
		if not l__Achievements__15[v22.Num] then
			warn("Not found Achievements for " .. p12.Doodle);
			return;
		end;
		local l__TaskBar__23 = p11.RightHolder.TaskBar;
		local l__Information__24 = l__TaskBar__23.Information;
		if l__TaskBar__23.Label.Reward:FindFirstChild("UIGradient") then
			l__TaskBar__23.Label.Reward.UIGradient:Destroy();
		end;
		local v25, v26, v27 = pairs(l__Achievements__15[v22.Num].Tasks);
		while true do
			local v28, v29 = v25(v26, v27);
			if not v28 then
				break;
			end;
			local v30 = l__Information__24["Task" .. v28];
			v30.ProgressBar.Clipping.TotalProgress.Size = UDim2.new(0, v30.ProgressBar.AbsoluteSize.X, 1, 0);
			local v31 = u16[v29.Type];
			if v29.StatusEffect then
				v31 = v31:gsub("StatusEffect", v29.StatusEffect);
			end;
			if v29.Move then
				v31 = v31:gsub("MoveName", v29.Move);
			end;
			local v32 = p12.Doodle;
			if not p11.Seen[tostring(v22.Num)] then
				v32 = "???";
			end;
			p1.Gui:ChangeText(v30.Task, (v31:gsub("DoodleName", v32)));
			local v33 = "0 / " .. l__Utilities__1.AddComma(v29.Amount);
			local v34 = 0;
			if p11.Achievements[tostring(v22.Num)] and p11.Achievements[tostring(v22.Num)][tostring(v28)] then
				v33 = l__Utilities__1.AddComma(p11.Achievements[tostring(v22.Num)][tostring(v28)][1]) .. " / " .. l__Utilities__1.AddComma(v29.Amount);
				v34 = p11.Achievements[tostring(v22.Num)][tostring(v28)][1] / v29.Amount;
				if p11.Achievements[tostring(v22.Num)][tostring(v28)][2] == true then
					v33 = "Completed";
					v34 = 1;
				end;
			end;
			v30.ProgressBar.Clipping.Size = UDim2.new(math.clamp(v34, 0, 1), 0, 1, 0);
			p1.Gui:ChangeText(v30.Progress, v33);		
		end;
		local l__Number__35 = l__Achievements__15[v22.Num].Reward.Number;
		local v36 = l__Number__35;
		local l__Type__37 = l__Achievements__15[v22.Num].Reward.Type;
		local l__Amount__38 = l__Achievements__15[v22.Num].Reward.Amount;
		if l__Type__37 == "Color" then
			p1.ColorAnim.Create(l__TaskBar__23.Label.Reward, l__Number__35);
			v36 = p1.Colors.GetColorName(l__Number__35) .. " color";
		elseif l__Type__37 == "Title" then
			v36 = p1.Titles[l__Number__35] .. " title";
		elseif l__Type__37 == "Cash" then
			v36 = "$" .. l__Utilities__1.AddComma(l__Number__35) .. " cash";
		elseif l__Type__37 == "Gems" then
			v36 = l__Utilities__1.AddComma(l__Number__35) .. " gems";
		elseif l__Type__37 == "Item" then
			v36 = l__Number__35 .. " item";
			if l__Amount__38 and l__Amount__38 > 1 then
				v36 = l__Amount__38 .. " " .. v36 .. "s";
			end;
		elseif l__Type__37 == "Equipment" then
			v36 = p1.Equipment:LookUp(l__Number__35, l__Achievements__15[v22.Num].Reward.EquipType).Name .. " equipment";
			if l__Amount__38 and l__Amount__38 > 1 then
				v36 = l__Amount__38 .. " " .. v36 .. "s";
			end;
		end;
		p1.Gui:ChangeText(l__TaskBar__23.Label.Reward, v36);
		p11:Stats(p12, true);
		p11.RightHolder.TaskBar.Visible = true;
		p11.RightHolder.Bottom.Visible = false;
	end;
	function v8.ClearSkins(p13)
		for v39, v40 in pairs(p13.SkinScroller:GetChildren()) do
			if v40:IsA("GuiObject") then
				v40:Destroy();
			end;
		end;
	end;
	local function u17(p14, p15, p16)
		local v41 = p1.GuiObjs.SkinSquare:Clone();
		v41.ImageColor3 = Color3.fromRGB(0, 0, 0);
		v41.ImageTransparency = 0.5;
		v41.Amount.Visible = false;
		v41.Equipped.Visible = false;
		v41.LayoutOrder = p15;
		if p1.Skins.Sprites[p14][p15].Name == "Prestige" then
			v41.LayoutOrder = -2;
		elseif p1.Skins.Sprites[p14][p15].Event and not p1.Skins.Sprites[p14][p15].Discontinued then
			v41.LayoutOrder = 1000 + p15;
		elseif p1.Skins.Sprites[p14][p15].Discontinued then
			v41.LayoutOrder = 2000 + p15;
		end;
		v41.DoodleLabel.ZIndex = 16;
		v41.ZIndex = 15;
		v41.Visible = true;
		v41.Name = p15;
		p1.Gui:ChangeText(v41.Label, p1.Skins.Sprites[p14][p15].Name);
		if p1.Skins.Sprites[p14][p15].Event then
			v41.Label.Size = UDim2.new(0.9, 0, 0.3, 0);
		end;
		if p1.Skins.Sprites[p14][p15].Event then
			v41.Discontinued.TextColor3 = Color3.fromRGB(255, 255, 0);
			v41.Discontinued.Size = UDim2.new(0.9, 0, 0.1, 0);
			p1.Gui:ChangeText(v41.Discontinued, "Event");
			v41.Discontinued.Visible = true;
		elseif p1.Skins.Sprites[p14][p15].Discontinued then
			v41.Discontinued.Visible = true;
		end;
		v41.Parent = p16;
		p1.Gui:AnimateSprite(v41.DoodleLabel, {
			Name = p14, 
			Skin = p15, 
			Gender = "M", 
			Shiny = u4
		}, true);
		return v41;
	end;
	function v8.ShowSkins(p17, p18)
		p17:ClearSkins();
		if not p1.Skins.Sprites[p18] then
			return;
		end;
		for v42, v43 in pairs(p1.Skins.Sprites[p18]) do
			local v44 = u17(p18, v42, p17.SkinScroller);
		end;
		p17.SkinScroller.CanvasSize = UDim2.new(0, 0, 0, p17.SkinScroller.UIGridLayout.AbsoluteContentSize.Y);
		p17.RightHolder.Visible = false;
		p17.SkinHolder.Visible = true;
	end;
	local u18 = nil;
	local u19 = nil;
	local function u20(p19)
		local v45 = math.floor(p19 / 12);
		if p1.Settings:Get("Measurements") ~= "Metric" then
			return v45 .. "'" .. u14(p19 % 12) .. "\"";
		end;
		return u13(p19 / 39.27, 2) .. " m";
	end;
	local function u21(p20)
		if p1.Settings:Get("Measurements") ~= "Metric" then
			return p20 .. " lbs";
		end;
		p20 = p20 / 2.205;
		p20 = u13(p20, 2);
		return p20 .. " kg";
	end;
	function v8.Stats(p21, p22, p23)
		p21.SkinHolder.Visible = false;
		p21.RightHolder.Visible = true;
		u4 = false;
		u6 = false;
		p21.UI.ShinyToggle.Shiny.ImageColor3 = u4 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(102, 102, 102);
		if u18 then
			u18:Disconnect();
		end;
		if u19 then
			u19:Disconnect();
		end;
		p1.Gui:ChangeText(p21.DoodleName, "???");
		p1.Gui:ChangeText(p21.RightHolder.Height.Label, "???");
		p1.Gui:ChangeText(p21.RightHolder.Weight.Label, "???");
		p21.RightHolder.DoodleImage.DoodleLabel.Image = "";
		p21.RightHolder.DoodleImage.Type1.Visible = false;
		p21.RightHolder.DoodleImage.Type2.Visible = false;
		p21.RightHolder.Bottom.Label.TextSize = p21.RightHolder.Bottom.AbsoluteSize.Y / 8;
		p21.RightHolder.Bottom.Label.DropShadow.TextSize = p21.RightHolder.Bottom.Label.TextSize;
		p21.RightHolder.DoodleImage.DoodleLabel.ImageColor3 = Color3.fromRGB(0, 0, 0);
		p21.UI.ShinyToggle.Visible = false;
		p21.SkinButton.Visible = false;
		p1.Gui:ChangeText(p21.RightHolder.Bottom.Label, "You have not encountered this Doodle yet.");
		if p22 then
			u11 = p22.Doodle;
			local v46 = p1.DoodleInfo[p22.Doodle];
			p21.RightHolder.DoodleImage.DoodleLabel.Image = v46.FrontSprite;
			u18 = p1.Tooltip.new({
				TextColor3 = p1.Typings:GetColor(v46.Type[1])
			}, p21.RightHolder.DoodleImage.Type1, v46.Type[1]);
			p1.Gui:TypeImage(p21.RightHolder.DoodleImage.Type1.TypeImage, v46.Type[1]);
			p21.RightHolder.DoodleImage.Type1.Visible = true;
			if v46.Type[2] then
				u19 = p1.Tooltip.new({
					TextColor3 = p1.Typings:GetColor(v46.Type[2])
				}, p21.RightHolder.DoodleImage.Type2, v46.Type[2]);
				p1.Gui:TypeImage(p21.RightHolder.DoodleImage.Type2.TypeImage, v46.Type[2]);
				p21.RightHolder.DoodleImage.Type2.Visible = true;
			end;
			if p22.Type then
				p21.RightHolder.DoodleImage.DoodleLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
				p1.Gui:ChangeText(p21.DoodleName, p22.Doodle);
				if p22.Type == 1 then
					p1.Gui:ChangeText(p21.RightHolder.Bottom.Label, "You have not captured " .. p22.Doodle .. " yet.");
				else
					p1.Gui:ChangeText(p21.RightHolder.Bottom.Label, v46.Desc);
					p1.Gui:ChangeText(p21.RightHolder.Height.Label, u20(v46.Height));
					p1.Gui:ChangeText(p21.RightHolder.Weight.Label, u21(v46.Weight));
				end;
				if p22.Type == 3 then
					p21.UI.ShinyToggle.Visible = true;
				end;
				if p22.Type >= 1 and p1.Skins.Sprites[p22.Doodle] then
					p21.SkinButton.Visible = true;
				end;
			end;
		end;
		if not p23 then
			u10 = "Stats";
			p21.RightHolder.TaskBar.Visible = false;
			p21.RightHolder.Bottom.Visible = true;
		end;
	end;
	local function u22(p24)
		local v47 = tostring(p24);
		if #v47 == 1 then
			return "#00" .. v47;
		end;
		if #v47 == 2 then
			return "#0" .. v47;
		end;
		if #v47 ~= 3 then
			return;
		end;
		return "#" .. v47;
	end;
	function v8.Update(p25, p26, p27)
		if p26 == 1 then
			p25.LeftHolder.ScrollBar.Size = UDim2.new(0.1, 0, math.min(0.8, p25.distance), 0);
		end;
		for v48 = p26, p26 + 9 do
			local v49 = 0;
			if p26 ~= 1 then
				v49 = p26 - 1;
			end;
			if u8 then
				u2 = u8;
				p25.Highest = #u8;
				if p27 then
					p25.distance = 0.8 * (10 / p25.Highest);
					p25.LeftHolder.ScrollBar.Size = UDim2.new(0.1, 0, math.min(0.8, p25.distance), 0);
					p25.LeftHolder.ScrollBar.Position = UDim2.new(1, 0, 0.1, 0);
				end;
			else
				u2 = p1.DoodleOrder;
				p25.Highest = u5();
				if p27 then
					p25.distance = 0.8 * (10 / p25.Highest);
					p25.LeftHolder.ScrollBar.Size = UDim2.new(0.1, 0, math.min(0.8, p25.distance), 0);
					p25.LeftHolder.ScrollBar.Position = UDim2.new(1, 0, 0.1, 0);
				end;
			end;
			local v50 = p25.LeftHolder.ListHolder["Number" .. v48 - v49];
			u7[v50] = nil;
			v50.Checkmark.Visible = false;
			if u2[v48] then
				u7[v50] = {
					Doodle = u2[v48], 
					Type = p25.Seen[tostring(v48)]
				};
				v50.DoodleImage.Image = p1.DoodleInfo[u2[v48]].FrontSprite;
				v50.DoodleImage.ImageRectSize = Vector2.new(300, 300);
				v50.DoodleImage.Position = UDim2.new(0, 0, 0.5, 0);
				v50.DoodleImage.Size = UDim2.new(1, 0, 1, 0);
				v50.DoodleImage.ImageColor3 = Color3.fromRGB(0, 0, 0);
				v50.DoodleImage.Visible = true;
				if p25.Achievements[tostring(p1.DoodleInfo[u2[v48]].Num)] and typeof(p25.Achievements[tostring(p1.DoodleInfo[u2[v48]].Num)].reward) == "table" and p25.Achievements[tostring(p1.DoodleInfo[u2[v48]].Num)].reward[1] == 2 then
					v50.Checkmark.Visible = true;
				end;
				if p25.Seen[tostring(v48)] then
					v50.DoodleImage.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v50.Title.Text = u2[v48];
				else
					v50.Title.Text = "???";
				end;
			else
				v50.DoodleImage.Visible = false;
				v50.Title.Text = "???";
			end;
			if u8 and p1.DoodleInfo[u2[v48]] then
				p1.Gui:ChangeText(v50.Number, u22(p1.DoodleInfo[u2[v48]].Num));
			elseif u8 then
				p1.Gui:ChangeText(v50.Number, "#???");
			else
				p1.Gui:ChangeText(v50.Number, u22(v48));
			end;
		end;
	end;
	local function u23()
		for v51, v52 in pairs(u1) do
			v52:Disconnect();
		end;
	end;
	function v8.Destroy(p28)
		u11 = nil;
		u23();
		p28.UI:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true);
		l__Utilities__1.Halt(0.2);
		p28.UI.Visible = false;
		p1.Menu:EnableActive();
		p28.Seen = nil;
		p28.Achievements = nil;
		setmetatable(p28, nil);
	end;
	return v8;
end;
