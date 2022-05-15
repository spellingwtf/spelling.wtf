-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u2 = { "BackgroundTransparency", "BorderColor3", "LayoutOrder", "Image", "ImageColor3", "ImageRectOffset", "ImageRectSize", "ImageTransparency", "ClipsDescendants", "SizeConstraint", "ScaleType", "SliceCenter", "SliceScale" };
	local function u3(p2)
		for v1, v2 in pairs(p2:GetDescendants()) do
			if v2:IsA("GuiObject") then
				v2.ZIndex = v2.ZIndex + 100;
			end;
		end;
	end;
	local u4 = nil;
	local function u5(p3, p4)
		local v3 = p3:Clone();
		v3.Size = UDim2.new(1.2, 0, 1.2, 0);
		v3.Position = UDim2.new(0, 0, 0, 0);
		if p4 then
			local v4 = 1;
		else
			v4 = 1;
		end;
		local v5 = l__Utilities__1:Create("ImageLabel")({
			Size = UDim2.new(0, p3.AbsoluteSize.X * v4, 0, p3.AbsoluteSize.Y * v4), 
			Position = UDim2.new(0, p3.AbsolutePosition.X, 0, p3.AbsolutePosition.Y)
		});
		for v6, v7 in pairs(u2) do
			v5[v7] = v3[v7];
		end;
		for v8, v9 in pairs(v3:GetChildren()) do
			v9.Parent = v5;
		end;
		v5.ZIndex = v3.ZIndex + 100;
		u3(v5);
		v3:Destroy();
		return v5;
	end;
	local function u6(p5, p6)
		local l__AbsolutePosition__10 = p5.AbsolutePosition;
		local l__AbsoluteSize__11 = p5.AbsoluteSize;
		local l__Position__12 = p6.Position;
		local v13 = false;
		if l__AbsolutePosition__10.x < l__Position__12.X then
			v13 = false;
			if l__Position__12.X < l__AbsolutePosition__10.x + l__AbsoluteSize__11.x then
				v13 = false;
				if l__AbsolutePosition__10.y < l__Position__12.Y then
					v13 = l__Position__12.Y < l__AbsolutePosition__10.y + l__AbsoluteSize__11.y;
				end;
			end;
		end;
		return v13;
	end;
	local v14 = l__Utilities__1.Class({
		ClassName = "GuiDragging"
	}, function(p7, p8, p9)
		p7.CurrentDragging = nil;
		p7.CurrentInputType = nil;
		p7.DragStart = nil;
		p7.Input = nil;
		p7.DraggingGui = nil;
		p7.startPos = nil;
		p7.Dragging = false;
		p7.EventBegan = p8.InputBegan:Connect(function(p10)
			if p7.UpdateCollide then
				p7.Collide = p7.UpdateCollide(p9, p8);
			end;
			if p7.Requirement and not p7.Requirement() then
				return;
			end;
			if not (not u4) or not (not p7.CurrentDragging) or p10.UserInputType ~= Enum.UserInputType.MouseButton1 and p10.UserInputType ~= Enum.UserInputType.Touch then
				return;
			end;
			p7.Input = p10;
			u4 = true;
			p7.CurrentInputType = p10.UserInputType;
			p7.LengthClick = tick();
			if p7.StartDraggingFunc then
				p7.StartDraggingFunc();
			end;
			p7.CurrentInputType = p10.UserInputType;
			p1.Sound:Play("BasicClick", 1);
			p7.startPos = UDim2.new(0, p8.AbsolutePosition.X, 0, p8.AbsolutePosition.Y);
			p7.DraggingGui = u5(p8, p7.NotBigger);
			p7.CurrentDragging = p8;
			p7.DraggingGui.Parent = p1.guiholder.Dragging;
			p7.Dragging = true;
			p7.DragStart = p10.Position;
			p8.Visible = false;
			l__Utilities__1.Halt(0.1);
		end);
		p7.InputChanged = p1.Services.UserInputService.InputChanged:Connect(function(p11)
			if p7.DraggingGui ~= nil and p7.Dragging and p7.CurrentDragging and (p7.CurrentInputType == p11.UserInputType or p7.CurrentInputType == Enum.UserInputType.MouseButton1 and p11.UserInputType == Enum.UserInputType.MouseMovement) then
				p7:update(p7.DraggingGui, p11);
			end;
		end);
		p7.EventChanged = p8.InputChanged:Connect(function(p12)
			if p12.UserInputType == Enum.UserInputType.MouseMovement or p12.UserInputType == Enum.UserInputType.Touch then
				p7.Input = p12;
			end;
		end);
		p7.EventEnded = p8.InputEnded:Connect(function(p13)
			if p7.Requirement and not p7.Requirement() then
				return;
			end;
			if p13.UserInputType == Enum.UserInputType.MouseButton1 then
				p7.Dragging = false;
				local v15 = nil;
				for v16, v17 in pairs(p7.Collide) do
					if v17 ~= p8 and v17.Visible and u6(v17, p13) then
						p7.Function(v17, p7:GetGuiPosition(p13));
						v15 = true;
						break;
					end;
				end;
				if not v15 then
					if p7.LengthClick and tick() - p7.LengthClick < 0.15 and p7.IfNoDragging then
						p7.IfNoDragging();
						l__Utilities__1.Halt(0.05);
					end;
					if p7.DraggingGui and p7.DraggingGui:IsDescendantOf(game) then
						p7.DraggingGui:TweenPosition(p7.startPos, "Out", "Quad", 0.2, true);
					end;
					l__Utilities__1.Halt(0.2);
				end;
				if p7.ClearDragging then
					p7:ClearDragging();
					p7:Reset();
					return;
				end;
				p1.guiholder.Dragging:ClearAllChildren();
			end;
		end);
		p7.TouchEnded = p1.Services.UserInputService.TouchEnded:Connect(function(p14)
			if p7.Requirement and not p7.Requirement() then
				return;
			end;
			if p7.DraggingGui ~= nil and p14 == p7.Input and p7.Dragging then
				p7.Dragging = false;
				local v18 = nil;
				for v19, v20 in pairs(p7.Collide) do
					if v20 ~= p8 and v20.Visible and u6(v20, p14) and p7 and p7.ClearDragging then
						p7.Function(v20, p7:GetGuiPosition(p14), p7.CurrentDragging);
						v18 = true;
						p7:ClearDragging();
						p7:Reset();
						break;
					end;
				end;
				if not v18 then
					if p7.LengthClick and tick() - p7.LengthClick < 0.25 and p7.IfNoDragging then
						p7.IfNoDragging();
					end;
					if p7.DraggingGui and p7.DraggingGui:IsDescendantOf(game) then
						p7.DraggingGui:TweenPosition(p7.startPos, "Out", "Quad", 0.2, true);
					end;
					if p7.ClearDragging then
						p7:ClearDragging();
						p7:Reset();
						return;
					end;
				end;
			elseif p7.CurrentDragging then
				print("You shouldn't see this.");
			end;
		end);
		return p7;
	end);
	function v14.ForceInvisible(p15)
		p15.CurrentDragging = nil;
	end;
	function v14.update(p16, p17, p18)
		local v21 = p18.Position - p16.DragStart;
		p17.Position = UDim2.new(p16.startPos.X.Scale, p16.startPos.X.Offset + v21.X, p16.startPos.Y.Scale, p16.startPos.Y.Offset + v21.Y);
	end;
	function v14.GetGuiPosition(p19, p20)
		if not p19.DragStart then
			return;
		end;
		local v22 = p20.Position - p19.DragStart;
		return UDim2.new(p19.startPos.X.Scale, p19.startPos.X.Offset + v22.X, p19.startPos.Y.Scale, p19.startPos.Y.Offset + v22.Y);
	end;
	function v14.ClearDragging(p21)
		if p21.CurrentDragging then
			p21.CurrentDragging.Visible = true;
		end;
		p21.CurrentDragging = nil;
		p1.guiholder.Dragging:ClearAllChildren();
	end;
	function v14.Disconnect(p22)
		p22.EventBegan:Disconnect();
		p22.InputChanged:Disconnect();
		p22.EventChanged:Disconnect();
		p22.EventEnded:Disconnect();
		p22.TouchEnded:Disconnect();
		setmetatable(p22, nil);
	end;
	function v14.Reset(p23)
		u4 = false;
		p23.CurrentInputType = nil;
		p23.DragStart = nil;
		p23.Input = nil;
		p23.DraggingGui = nil;
		p23.startPos = nil;
		p23.LengthClick = nil;
		p23.UserInputType = nil;
		p23.Dragging = false;
	end;
	return v14;
end;
