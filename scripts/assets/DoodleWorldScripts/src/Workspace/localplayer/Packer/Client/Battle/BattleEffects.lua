-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local u1 = nil;
	function v1.DisableAll(p2)
		u1 = false;
		p2.Effects.ReverseSingularity.Visible = false;
	end;
	function v1.Check(p3, p4)
		if not p4.ReverseSingularity then
			u1 = nil;
			p3.Effects.ReverseSingularity.Visible = false;
		end;
	end;
	local l__Utilities__2 = p1.Utilities;
	local l__UDim2__3 = UDim2;
	local l__Tween__4 = p1.Tween;
	function v1.ReverseSingularity(p5)
		if u1 then
			return;
		end;
		u1 = true;
		local l__ReverseSingularity__2 = p5.Effects.ReverseSingularity;
		l__ReverseSingularity__2.Visible = true;
		l__Utilities__2.FastSpawn(function()
			while u1 do
				local v3 = l__Utilities__2:Create("ImageLabel")({
					Name = "Rs", 
					ZIndex = 1, 
					BackgroundTransparency = 1, 
					ImageTransparency = 1, 
					Image = p5.Background.Image, 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					Size = l__UDim2__3.new(3, 0, 3, 0), 
					Position = l__UDim2__3.new(0.5, 0, 0.5, 0), 
					Parent = l__ReverseSingularity__2
				});
				l__Tween__4:MakeTween(v3, {
					ImageTransparency = 0, 
					Size = l__UDim2__3.new(1, 0, 1, 0)
				}, true, 3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
				l__Utilities__2.Halt(4);
				if v3:IsDescendantOf(game) then
					l__Tween__4:MakeTween(v3, {
						ImageTransparency = 1, 
						Size = l__UDim2__3.new(3, 0, 3, 0)
					}, true, 3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
				end;
				l__Utilities__2.Halt(3);
				if v3:IsDescendantOf(game) then
					v3:Destroy();
				end;			
			end;
			l__Utilities__2.Halt(8);
			l__ReverseSingularity__2:ClearAllChildren();
			l__ReverseSingularity__2.Visible = false;
		end);
	end;
	function v1.ReverseSingularity2(p6)
		if u1 then
			return;
		end;
		u1 = true;
		local l__ReverseSingularity__4 = p6.Effects.ReverseSingularity;
		l__ReverseSingularity__4.Visible = true;
		local u5 = Instance.new("Folder", l__ReverseSingularity__4);
		l__Utilities__2.FastSpawn(function()
			while u1 do
				for v5 = 1, 19 do
					local u6 = l__Utilities__2:Create("Frame")({
						Name = "BorderY", 
						BorderSizePixel = 0, 
						Size = l__UDim2__3.new(0, 0, 0, 1), 
						Position = l__UDim2__3.new(0, 0, 0.05 * v5, 0), 
						BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
						ZIndex = 1, 
						Parent = u5
					});
					l__Utilities__2.FastSpawn(function()
						u6:TweenSize(l__UDim2__3.new(1, 0, 0, 1), "Out", "Quad", 2.5, true);
						l__Utilities__2.Halt(2.5);
						if u6:IsDescendantOf(game) then
							u6:TweenSize(l__UDim2__3.new(0, 0, 0, 1), "Out", "Quad", 2.5, true);
						end;
					end);
				end;
				for v6 = 1, 19 do
					local u7 = l__Utilities__2:Create("Frame")({
						Name = "BorderX", 
						BorderSizePixel = 0, 
						Size = l__UDim2__3.new(0, 1, 0, 0), 
						Position = l__UDim2__3.new(0.05 * v6, 0, 0, 0), 
						BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
						ZIndex = 1, 
						Parent = u5
					});
					l__Utilities__2.FastSpawn(function()
						u7:TweenSize(l__UDim2__3.new(0, 1, 1, 0), "Out", "Quad", 2.5, true);
						if u7:IsDescendantOf(game) then
							l__Utilities__2.Halt(2.5);
							u7:TweenSize(l__UDim2__3.new(0, 1, 0, 0), "Out", "Quad", 2.5, true);
						end;
					end);
				end;
				l__Utilities__2.Halt(8);
				u5:ClearAllChildren();			
			end;
			u5:Destroy();
			l__ReverseSingularity__4.Visible = false;
		end);
	end;
	return v1;
end;
