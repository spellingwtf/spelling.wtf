-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Titles__1 = p1.Titles;
	local v2 = {};
	local l__Utilities__1 = p1.Utilities;
	function v2.Anim(p2, p3, p4)
		l__Utilities__1.FastSpawn(function()
			if not p2:IsDescendantOf(game) then
				p2.AncestryChanged:wait();
			end;
			local v3 = Instance.new("Color3Value", p2);
			v3.Changed:Connect(function(p5)
				p2.Color = ColorSequence.new(p5);
			end);
			if p3 == "Rotation" then
				while p2:IsDescendantOf(game) do
					p1.Services.RunService.Heartbeat:wait();
					p2.Rotation = p2.Rotation + 2;				
				end;
			elseif p3 == "Fade" then
				while p2:IsDescendantOf(game) do
					for v4, v5 in pairs(p4) do
						p1.Tween:MakeTween(v3, {
							Value = v5
						}, true, 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						l__Utilities__1.Halt(0.75);
					end;				
				end;
			elseif p3 == "Movement" then
				local v6 = #p4;
				local v7 = 1 / v6;
				while p2:IsDescendantOf(game) do
					local v8 = tick() % 3 / 3;
					local v9 = {};
					local v10 = false;
					for v11 = 1, v6 + 1 do
						local v12 = v8 + (v11 - 1) / v6;
						if v12 > 1 then
							v12 = v12 - 1;
						end;
						if v12 == 0 or v12 == 1 then
							v10 = true;
						end;
						table.insert(v9, ColorSequenceKeypoint.new(v12, p4[v11] or p4[v11 - v6]));
					end;
					if not v10 then
						local v13 = (1 - v8) / v7 + 1;
						local v14 = p4[math.floor(v13)]:Lerp(p4[math.ceil(v13)] or p4[1], v13 % 1);
						table.insert(v9, ColorSequenceKeypoint.new(0, v14));
						table.insert(v9, ColorSequenceKeypoint.new(1, v14));
					end;
					table.sort(v9, function(p6, p7)
						return p6.Time < p7.Time;
					end);
					pcall(function()
						if #v9 > 0 then
							p2.Color = ColorSequence.new(v9);
						end;
						p1.Services.RunService.Heartbeat:wait();
					end);				
				end;
			end;
		end);
	end;
	local l__Colors__2 = p1.Colors;
	function v2.Create(p8, p9)
		if p8:FindFirstChild("UIGradient") then
			p8:FindFirstChild("UIGradient"):Destroy();
		end;
		local v15, v16 = l__Colors__2.GetColorTable(p9);
		local v17 = l__Utilities__1:Create("UIGradient")({
			Parent = p8, 
			Color = l__Utilities__1.CreateColorSequence(v15, v16), 
			Rotation = 0
		});
		if v16 then
			v2.Anim(v17, v16, v15);
		end;
	end;
	return v2;
end;
