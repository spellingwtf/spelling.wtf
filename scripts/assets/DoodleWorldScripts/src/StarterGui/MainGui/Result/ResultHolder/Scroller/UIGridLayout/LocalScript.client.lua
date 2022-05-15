-- Decompiled with the Synapse X Luau decompiler.

function resize()
	local v1 = script.Parent.Parent.AbsoluteSize.X / 5;
	script.Parent.CellSize = UDim2.new(0, v1 - 12, 0, v1 - 12);
end;
wait();
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	resize();
end);
