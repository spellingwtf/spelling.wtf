-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = false;
	p1.Network:BindEvent("ShutdownSoon", function(p2)
		if not p1.guiholder then
			return;
		end;
		local l__ShutdownWarning__2 = p1.guiholder:FindFirstChild("ShutdownWarning");
		if not l__ShutdownWarning__2 then
			return;
		end;
		if not u1 then
			l__ShutdownWarning__2.Position = UDim2.new(-0.25, 0, 0.5, 0);
			l__ShutdownWarning__2.Visible = true;
			l__ShutdownWarning__2:TweenPosition(UDim2.new(0, 0, 0.5, 0), "Out", "Quad", 0.75, true);
			u1 = true;
		end;
		l__ShutdownWarning__2.Label.Text = p2;
	end);
	return {};
end;
