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
		ClassName = "GradientPicker"
	}, function(p2, p3)
		u2();
		p2.MainFrame = p3;
		p2.Selecting = false;
		p2.PickerArea = p3.ColorPickerArea;
		p2.ColorShower = p3.ColorShower;
		p2.Picker = p2.PickerArea.Picker;
		p2.Gradient = p2.PickerArea:FindFirstChildWhichIsA("UIGradient");
		p2.ColorKeypoints = p2.Gradient.Color.Keypoints;
		p1.Gui:Hover(p3.Button);
		u1.InputBegan = p2.PickerArea.InputBegan:Connect(function(p4)
			if p4.UserInputType == Enum.UserInputType.MouseButton1 or p4.UserInputType == Enum.UserInputType.Touch then
				p2:beginSelection();
			end;
		end);
		u1.InputEnded = p2.PickerArea.InputEnded:Connect(function(p5)
			if p5.UserInputType == Enum.UserInputType.MouseButton1 or p5.UserInputType == Enum.UserInputType.Touch then
				p2:endSelection();
			end;
		end);
		u1.ButtonPress = p3.Button.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop");
			p3.Visible = false;
			u2();
			p2.OnClose(p2:GetColor());
			if p2.Destroy then
				p2:Destroy();
			end;
		end);
		return p2;
	end);
	function v4.Destroy(p6)
		p6.MainFrame.Visible = false;
		u2();
		setmetatable(p6, nil);
	end;
	local u3 = require(script:WaitForChild("GetOnGradientSlider"));
	function v4.GetColor(p7)
		return u3(p7.Picker.Position.X.Scale, p7.ColorKeypoints);
	end;
	local l__UserInputService__4 = p1.Services.UserInputService;
	function v4.SetColor(p8)
		local l__X__5 = p8.PickerArea.AbsolutePosition.X;
		local v6 = l__X__5 + p8.PickerArea.AbsoluteSize.X;
		local v7 = l__UserInputService__4:GetMouseLocation().X;
		if v7 < l__X__5 then
			v7 = l__X__5;
		elseif v6 < v7 then
			v7 = v6;
		end;
		p8.Picker.Position = UDim2.new((v7 - l__X__5) / (v6 - l__X__5), 0, 0, 0);
		return p8:GetColor();
	end;
	function v4.beginSelection(p9)
		p9.selecting = true;
		while true do
			l__Utilities__1.Halt();
			local v8 = p9:SetColor();
			p9.ColorShower.ImageColor3 = v8;
			if p9.OnUpdate then
				p9.OnUpdate(v8);
			end;
			if not p9.selecting then
				break;
			end;		
		end;
	end;
	function v4.endSelection(p10)
		p10.selecting = false;
	end;
	return v4;
end;
