-- Decompiled with the Synapse X Luau decompiler.

function resize()
	local v1 = script.Parent.Parent.AbsoluteSize.X / 3;
	script.Parent.CellSize = UDim2.new(0, v1 - 5, 0, v1 - 5);
end;
wait();
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	resize();
end);
