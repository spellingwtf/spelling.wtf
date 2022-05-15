-- Decompiled with the Synapse X Luau decompiler.

function resize()
	local l__Y__1 = script.Parent.Parent.AbsoluteSize.Y;
	script.Parent.CellSize = UDim2.new(0, l__Y__1 - 15, 0, l__Y__1 - 15);
end;
wait();
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	resize();
end);
