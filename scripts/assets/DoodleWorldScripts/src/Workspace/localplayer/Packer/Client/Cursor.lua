-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = nil;
	local v2 = l__Utilities__1.Class({
		ClassName = "Cursor"
	}, function(p2)
		p2.EventList = {};
		p2.Gui = p1.guiholder.Cursor;
		p2.Use = false;
		p2.Mouse = p1.p:GetMouse();
		p1.Services.RunService.Heartbeat:Connect(function()
			local v3 = false;
			if p2.Mouse.Target and p2.Mouse.Hit and p1.NPCHolder then
				for v4, v5 in pairs(p1.NPCHolder:GetChildren()) do
					if p2.Mouse.Target:IsDescendantOf(v5) then
						if not p1.Menu:CheckActive() and not p1.InCutscene and not p1.Battle.CurrentBattle and not u1 and l__Utilities__1:GetDistance(8, p1.p.Character.HumanoidRootPart, p2.Mouse.Hit) then
							v3 = true;
							p2:Active();
							p2.Gui.Image = "http://www.roblox.com/asset/?id=4636537151";
						end;
						break;
					end;
				end;
				if v3 == false then
					p2:Inactive();
				end;
			end;
		end);
		p2.Mouse.Button1Down:Connect(function()
			if p2.Mouse.Target and p1.NPCHolder then
				for v6, v7 in pairs(p1.NPCHolder:GetChildren()) do
					if not p1.Menu:CheckActive() and p1.CurrentNPCs[v7] and p1.CurrentNPCs[v7].Event and not p1.CurrentlyTalking and p2.Mouse.Target and p2.Mouse.Hit and not p1.InCutscene and not p1.Battle.CurrentBattle and (p2.Mouse.Target:IsDescendantOf(v7) and not u1 and l__Utilities__1:GetDistance(8, p1.p.Character.HumanoidRootPart, p2.Mouse.Hit)) then
						u1 = true;
						p1.CurrentNPCs[v7].Event();
						u1 = false;
					end;
				end;
			end;
		end);
		return p2;
	end);
	function v2.SetTalking(p3, p4)
		u1 = p4;
	end;
	function v2.MouseMovement(p5, p6)
		p6.Position = UDim2.new(0, p5.Mouse.X - 15, 0, p5.Mouse.Y - 3);
	end;
	function v2.Active(p7)
		if p7.Use == false then
			p1.Services.UserInputService.MouseIconEnabled = false;
			p7.AlreadyActive = true;
			p7.Use = true;
			p7:Animate();
			p1.Services.RunService:BindToRenderStep("MouseMove", 1, function()
				p7:MouseMovement(p7.Gui);
			end);
			p7.Gui.Visible = true;
		end;
	end;
	function v2.Inactive(p8)
		if p8.Use == true then
			p1.Services.RunService:UnbindFromRenderStep("MouseMove");
		end;
		p1.Services.UserInputService.MouseIconEnabled = true;
		p8.AlreadyActive = false;
		p8.Use = false;
		p8.Gui.Visible = false;
	end;
	function v2.CanTalk(p9)
		if p9.Use then

		end;
	end;
	function v2.Animate(p10)
		l__Utilities__1.FastSpawn(function()
			while p10.Use == true do
				for v8 = 0, 200, 200 do
					l__Utilities__1.Halt(0.1);
					if p10.Use ~= true then
						break;
					end;
					p10.Gui.ImageRectOffset = Vector2.new(v8, 0);
				end;
				l__Utilities__1.Halt(0.1);
				p10.Gui.ImageRectOffset = Vector2.new(0, 200);			
			end;
		end);
	end;
	return v2;
end;
