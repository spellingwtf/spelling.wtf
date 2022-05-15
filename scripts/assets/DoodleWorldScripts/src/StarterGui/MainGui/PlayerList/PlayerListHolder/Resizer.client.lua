-- Decompiled with the Synapse X Luau decompiler.

function Resize()
	script.Parent.Size = UDim2.new(0, script.Parent.Parent.AbsoluteSize.X - 6, 0, script.Parent.Parent.AbsoluteSize.Y);
end;
Resize();
script.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	Resize();
end);
