-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local function u2()
		for v2, v3 in pairs(u1) do
			v3:Disconnect();
		end;
	end;
	local v4 = l__Utilities__1.Class({
		ClassName = "SkinInventory"
	}, function(p2)
		u2();
		local v5, v6 = p1.ClientDatabase:PDSFunc("GetColorList");
		p2.ColorList = v5;
		p2.SkinList = v6;
		p2.UI = p1.guiholder:WaitForChild("SkinInventory");
		p2.Holder = p2.UI.Holder;
		p2.Scroller = p2.Holder.Scroller;
		p2.UIGridLayout = p2.Scroller.UIGridLayout;
		local v7 = p2.Holder.SizeMatcher.AbsoluteSize.Y / 2 - 5;
		p2.UIGridLayout.CellSize = UDim2.new(0, v7, 0, v7);
		u1.CloseEnter = p2.UI.Close.MouseEnter:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		u1.CloseLeave = p2.UI.Close.MouseLeave:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		u1.CloseClick = p2.UI.Close.MouseButton1Click:Connect(function()
			if p2.Equipping then
				return;
			end;
			p1.Sound:Play("Boop", 0.8);
			p2:Destroy();
		end);
		u1.FocusLost = p2.UI.SearchTextBox.TextBox.FocusLost:Connect(function()
			p2:Search(p2.UI.SearchTextBox.TextBox.Text);
		end);
		p2:MakeButtons();
		p2.UI.Visible = true;
		p1.Gui:ChangeText(p2.UI.BottomBar.SkinInfo, "Click on a skin to see who can use it!");
		p1.Gui:ChangeText(p2.UI.SearchTextBox.TextBox, "Search");
		return p2;
	end);
	function v4.ClearSkins(p3)
		for v8, v9 in pairs(p3.Scroller:GetChildren()) do
			if v9:IsA("GuiObject") then
				v9:Destroy();
			end;
		end;
	end;
	local u3 = {};
	function v4.Search(p4, p5)
		local v10 = p5:lower();
		if p5 == "search" then
			v10 = "";
		end;
		for v11, v12 in pairs(u3) do
			v11.Visible = false;
		end;
		for v13, v14 in pairs(u3) do
			for v15, v16 in pairs(v14) do
				if v16:lower():find(v10) then
					v13.Visible = true;
				end;
			end;
		end;
	end;
	local function u4(p6)
		table.sort(p6, function(p7, p8)
			local l__DoodleInfo__17 = p1.DoodleInfo;
			if l__DoodleInfo__17[p7].Num < l__DoodleInfo__17[p8].Num then
				return true;
			end;
			return false;
		end);
	end;
	function v4.MakeButtons(p9)
		p9:ClearSkins();
		local l__Sprites__18 = p1.Skins.Sprites;
		for v19, v20 in pairs(p9.SkinList) do
			for v21, v22 in pairs(v20) do
				local v23 = p1.GuiObjs.SkinInventorySquare:Clone();
				v23.DoodleLabel.Image = p1.Gui:GetSkinFront(v19, false, "M", v22.Skin);
				local l__Name__24 = l__Sprites__18[v19][v22.Skin].Name;
				p1.Gui:ChangeText(v23.Label, l__Name__24);
				p1.Gui:ChangeText(v23.Amount, "x" .. v22.Amount);
				p1.Gui:Hover(v23);
				v23.LayoutOrder = p1.DoodleInfo[v19].Num + v22.Skin;
				v23.Parent = p9.Scroller;
				local v25 = p1.Lines:GetLines()[v19];
				u4(v25);
				local v26 = l__Utilities__1:shallowCopy(v25);
				table.insert(v26, l__Name__24);
				u3[v23] = v26;
				v23.MouseButton1Click:Connect(function()
					if #v25 == 1 then
						p1.Gui:ChangeText(p9.UI.BottomBar.SkinInfo, "This " .. l__Name__24 .. " skin can be equipped by " .. v25[1] .. "!");
						return;
					end;
					if #v25 == 2 then
						p1.Gui:ChangeText(p9.UI.BottomBar.SkinInfo, "This " .. l__Name__24 .. " skin can be equipped by " .. v25[1] .. " and " .. v25[2] .. "!");
						return;
					end;
					if #v25 == 3 then
						p1.Gui:ChangeText(p9.UI.BottomBar.SkinInfo, "This " .. l__Name__24 .. " skin can be equipped by " .. v25[1] .. ", " .. v25[2] .. ", and " .. v25[3] .. "!");
					end;
				end);
				l__Utilities__1.FastSpawn(function()
					while v23:IsDescendantOf(game) do
						for v27, v28 in pairs(v25) do
							if not v23:IsDescendantOf(game) then
								break;
							end;
							v23.DoodleLabel.Image = p1.Gui:GetSkinFront(v28, false, "M", v22.Skin);
							l__Utilities__1.Halt(0.75);
						end;					
					end;
				end);
			end;
		end;
		p9.Scroller.CanvasSize = UDim2.new(0, 0, 0, p9.UIGridLayout.AbsoluteContentSize.Y);
	end;
	function v4.Destroy(p10)
		p10:ClearSkins();
		u3 = {};
		p10.UI.Visible = false;
		if p10.Bag then
			p10.Bag.ItemUI.Visible = true;
		end;
		setmetatable(p10, nil);
	end;
	return v4;
end;
