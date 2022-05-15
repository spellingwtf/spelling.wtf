-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local l__Typings__1 = p1.Typings;
	local u2 = {};
	local u3 = nil;
	local function u4()
		for v2, v3 in pairs(u2) do
			v3:Disconnect();
		end;
		u2 = {};
	end;
	local function u5()
		return #l__Typings__1.TypeOrder;
	end;
	local l__TypeChartClose__6 = p1.GuiObjs.TypeChartClose;
	local v4 = l__Utilities__1.Class({
		ClassName = "TypeChart"
	}, function(p2)
		if u3 then
			u3:Destroy();
			p1.Tooltip:Clear();
			u3 = nil;
			if p2.CloseThing then
				return;
			end;
		end;
		u4();
		local l__PlayerGui__5 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
		local l__MainGui__6 = l__PlayerGui__5:WaitForChild("MainGui");
		u3 = l__Utilities__1:Create("ImageLabel")({
			Name = "TypeChart", 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			Size = UDim2.new(0.925, 0, 0.925, 0), 
			Position = UDim2.new(0.5, 0, 0.5, -18), 
			ZIndex = 500, 
			BackgroundTransparency = 1, 
			ImageColor3 = Color3.fromRGB(255, 255, 255), 
			SizeConstraint = Enum.SizeConstraint.RelativeYY, 
			Image = "rbxassetid://3570695787", 
			SliceCenter = Rect.new(100, 100, 100, 100), 
			SliceScale = 0.12, 
			ScaleType = Enum.ScaleType.Slice, 
			BorderSizePixel = 0
		});
		local v7 = Instance.new("Folder", u3);
		u3.Parent = l__PlayerGui__5:WaitForChild("MainGui");
		local v8 = u5() + 1;
		for v9 = 1, v8 - 1 do
			local v10 = l__Utilities__1:Create("Frame")({
				Name = "BorderY", 
				BorderSizePixel = 0, 
				Size = UDim2.new(1, 0, 0, 1), 
				Position = UDim2.new(0, 0, 1 / v8 * v9, 0), 
				BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
				ZIndex = 503, 
				Parent = v7
			});
		end;
		for v11 = 1, v8 - 1 do
			local v12 = l__Utilities__1:Create("Frame")({
				Name = "BorderX", 
				BorderSizePixel = 0, 
				Size = UDim2.new(0, 1, 1, 0), 
				Position = UDim2.new(1 / v8 * v11, 0, 0, 0), 
				BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
				ZIndex = 503, 
				Parent = v7
			});
		end;
		local v13 = Instance.new("Folder", u3);
		for v14, v15 in pairs(l__Typings__1.TypeOrder) do
			u2["Attacking" .. v15] = p1.Tooltip.new({
				TextColor3 = l__Typings__1.Visual[v15].Color
			}, l__Utilities__1:Create("ImageLabel")({
				Name = v15, 
				BorderSizePixel = 0, 
				Size = UDim2.new(1 / v8, 0, 1 / v8, 0), 
				Position = UDim2.new(0, 0, 1 / v8 * v14, 0), 
				BackgroundColor3 = l__Typings__1.Visual[v15].Color, 
				Image = l__Typings__1.Visual[v15].Image, 
				ZIndex = 502, 
				ImageRectSize = Vector2.new(200, 200), 
				Parent = v13
			}), v15);
		end;
		local v16 = Instance.new("Folder", u3);
		for v17, v18 in pairs(l__Typings__1.TypeOrder) do
			u2["Defending" .. v18] = p1.Tooltip.new({
				TextColor3 = l__Typings__1.Visual[v18].Color
			}, l__Utilities__1:Create("ImageLabel")({
				Name = v18, 
				BorderSizePixel = 0, 
				Size = UDim2.new(1 / v8, 0, 1 / v8, 0), 
				Position = UDim2.new(1 / v8 * v17, 0, 0, 0), 
				BackgroundColor3 = l__Typings__1.Visual[v18].Color, 
				Image = l__Typings__1.Visual[v18].Image, 
				ZIndex = 502, 
				ImageRectSize = Vector2.new(200, 200), 
				Parent = v16
			}), v18);
		end;
		local v19 = l__Utilities__1:Create("TextLabel")({
			Name = "AttackText", 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0, -18, 0.5, 0), 
			Rotation = -90, 
			Size = UDim2.new(0.5, 0, 0, 36), 
			Text = "Attacking", 
			Font = Enum.Font.GothamBold, 
			TextColor3 = Color3.fromRGB(255, 255, 255), 
			TextScaled = true, 
			Parent = u3, 
			TextStrokeTransparency = 0, 
			TextTransparency = 0, 
			ZIndex = 499
		});
		local v20 = l__Utilities__1:Create("TextLabel")({
			Name = "DefendText", 
			AnchorPoint = Vector2.new(0.5, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0.5, 0, 0, 0), 
			Size = UDim2.new(0.5, 0, 0, 36), 
			Text = "Defending", 
			Font = Enum.Font.GothamBold, 
			TextColor3 = Color3.fromRGB(255, 255, 255), 
			TextScaled = true, 
			Parent = u3, 
			TextStrokeTransparency = 0, 
			TextTransparency = 0, 
			ZIndex = 499
		});
		local u7 = {
			SE = Color3.fromRGB(0, 85, 0), 
			NVE = Color3.fromRGB(255, 0, 0), 
			NH = Color3.fromRGB(40, 40, 40)
		};
		local u8 = Instance.new("Folder", u3);
		local function v21(p3, p4, p5)
			local v22 = l__Typings__1.TypeOrder[p4];
			local v23 = l__Utilities__1:Create("Frame")({
				Name = p3, 
				BorderSizePixel = 0, 
				Size = UDim2.new(1 / v8, 0, 1 / v8, 0), 
				Position = UDim2.new(1 / v8 * p5, 0, 1 / v8 * p4, 0), 
				BackgroundColor3 = u7[p3], 
				ZIndex = 501, 
				Parent = u8
			});
			if p3 == "NH" then
				local v24 = l__Utilities__1:Create("TextLabel")({
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundTransparency = 1, 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0), 
					Text = "X", 
					Font = Enum.Font.GothamBlack, 
					TextColor3 = Color3.fromRGB(255, 255, 255), 
					TextScaled = true, 
					Parent = v23, 
					TextStrokeTransparency = 0, 
					TextTransparency = 0, 
					ZIndex = 502
				});
			end;
			u2[p4 .. p5] = p1.Tooltip.new({
				TextColor3 = l__Typings__1.Visual[v22].Color, 
				SuperLong = true
			}, v23, v22 .. "-type attacks" .. ({
				SE = " are super effective against ", 
				NVE = " are not very effective against ", 
				NH = " do not affect "
			})[p3] .. l__Typings__1.TypeOrder[p5] .. "-type Doodles.");
		end;
		for v25, v26 in pairs(l__Typings__1.TypeOrder) do
			for v27, v28 in pairs(l__Typings__1.TypeOrder) do
				local v29 = l__Typings__1.TypeChart[v26];
				if table.find(v29.SE, v28) then
					v21("SE", v25, v27);
				elseif table.find(v29.NVE, v28) then
					v21("NVE", v25, v27);
				elseif table.find(v29.NH, v28) then
					v21("NH", v25, v27);
				end;
			end;
		end;
		local v30 = l__TypeChartClose__6:Clone();
		v30.Parent = u3;
		v30.MouseEnter:Connect(function()
			v30.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
		end);
		v30.MouseLeave:Connect(function()
			v30.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		v30.MouseButton1Click:Connect(function()
			p1.Sound:Play("BasicClick");
			p2:Close();
		end);
		return p2;
	end);
	function v4.Close(p6)
		if u3 then
			u3:Destroy();
			p1.Tooltip:Clear();
			u3 = nil;
		end;
	end;
	return v4;
end;
