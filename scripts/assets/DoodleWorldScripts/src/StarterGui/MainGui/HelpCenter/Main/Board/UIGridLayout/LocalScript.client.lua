-- Decompiled with the Synapse X Luau decompiler.

function resize()
	script.Parent.CellSize = UDim2.new(0, script.Parent.Parent.AbsoluteSize.X / 4 - 10, 0, script.Parent.Parent.AbsoluteSize.Y / 2 - 10);
end;
wait();
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	resize();
end);
