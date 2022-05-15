-- Decompiled with the Synapse X Luau decompiler.

function resize()
	local l__AbsoluteSize__1 = script.Parent.Parent.AbsoluteSize;
	script.Parent.Size = UDim2.new(0, l__AbsoluteSize__1.X, 0, l__AbsoluteSize__1.Y);
end;
resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	resize();
end);
