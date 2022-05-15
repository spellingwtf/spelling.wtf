-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {};
	function v2.Start()
		p1.InCutscene = true;
		p1.Controls:ToggleWalk(false);
	end;
	function v2.TakePicture(p2)
		local l__GameBlur__3 = p1.Services.Lighting:FindFirstChild("GameBlur");
		v2.Start();
		p1.Gui:FadeToBlack();
		p1.guiholder.Blackscreen.ZIndex = 10;
		p1.guiholder.CameraEffect.Visible = true;
		l__GameBlur__3.Enabled = true;
		l__GameBlur__3.Size = 40;
		p1.Camera:Scriptable(p2, true);
		p1.guiholder.Blackscreen.ZIndex = 1;
		p1.Gui:FadeFromBlack();
	end;
	function v2.StopPicture()
		local l__GameBlur__4 = p1.Services.Lighting:FindFirstChild("GameBlur");
		v2.Start();
		p1.guiholder.Blackscreen.ZIndex = 10;
		p1.Gui:FadeToBlack();
		p1.guiholder.CameraEffect.Visible = false;
		p1.guiholder.Blackscreen.ZIndex = 1;
		l__GameBlur__4.Enabled = false;
		l__GameBlur__4.Size = 12;
		p1.Camera:Return();
		p1.InCutscene = false;
		p1.Gui:FadeFromBlack();
	end;
	local l__Tween__1 = p1.Tween;
	local u2 = l__Utilities__1.Signal();
	function v2.CameraMinigame()
		local l__GameBlur__5 = p1.Services.Lighting:FindFirstChild("GameBlur");
		local v6 = p1.GuiObjs:FindFirstChild("CameraMinigame"):Clone();
		v6.Position = UDim2.new(0.5, 0, 1.2, 0);
		v6.Line.Position = UDim2.new(0.025, 0, 0.5, 0);
		p1.Gui:Hover(v6.TakePicture);
		v6.Parent = p1.guiholder;
		v6:TweenPosition(UDim2.new(0.5, 0, 0.95, 0), "Out", "Quad", 0.5, true);
		local u3 = true;
		local u4 = l__Tween__1:MakeTween(v6.Line, {
			Position = UDim2.new(0.025, 0, 0.5, 0)
		}, false, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		local u5 = nil;
		local u6 = l__Tween__1:MakeTween(v6.Line, {
			Position = UDim2.new(0.975, 0, 0.5, 0)
		}, false, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		l__Utilities__1.FastSpawn(function()
			while u3 do
				u4:Play();
				u5 = u4;
				l__Utilities__1.Halt(1.5);
				if u3 then
					u6:Play();
					u5 = u6;
					l__Utilities__1.Halt(1.5);
				end;			
			end;
		end);
		v6.Line:GetPropertyChangedSignal("Position"):Connect(function()
			l__GameBlur__5.Size = 84.21052631578948 * math.abs(v6.Line.Position.X.Scale - 0.5);
		end);
		v6.TakePicture.MouseButton1Down:Connect(function()
			if u3 == true then
				v6.TakePicture.Visible = false;
				u5:Cancel();
				u3 = false;
				p1.Sound:Play("CameraClick");
				u2:Fire(l__GameBlur__5.Size);
			end;
		end);
		return u2:Wait(), v6;
	end;
	return v2;
end;
