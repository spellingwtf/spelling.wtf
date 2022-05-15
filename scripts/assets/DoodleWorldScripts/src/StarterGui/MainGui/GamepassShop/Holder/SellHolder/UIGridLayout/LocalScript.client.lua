-- Decompiled with the Synapse X Luau decompiler.

function resize()
	local v1 = script.Parent.Parent.AbsoluteSize.X / 4;
	script.Parent.CellSize = UDim2.new(0, v1 - 10, 0, v1 - 10);
end;
wait();
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	resize();
end);
