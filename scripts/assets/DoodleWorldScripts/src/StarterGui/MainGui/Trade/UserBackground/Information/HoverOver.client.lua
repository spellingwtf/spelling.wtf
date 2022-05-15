-- Decompiled with the Synapse X Luau decompiler.

for v1, v2 in ipairs(script.Parent:GetChildren()) do
	if v2:IsA("TextButton") then
		v2.MouseEnter:connect(function()
			v2.TextColor3 = Color3.new(0.2549019607843137, 0.2549019607843137, 0.2549019607843137);
		end);
		v2.MouseLeave:connect(function()
			v2.TextColor3 = Color3.new(1, 1, 1);
		end);
	end;
end;
