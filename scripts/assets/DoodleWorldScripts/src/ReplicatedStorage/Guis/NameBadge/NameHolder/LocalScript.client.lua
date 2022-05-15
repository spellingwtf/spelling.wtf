-- Decompiled with the Synapse X Luau decompiler.

function Resize()
	local l__Y__1 = script.Parent.Parent.UserPicture.AbsoluteSize.Y;
	script.Parent.Size = UDim2.new(1, -l__Y__1, 1, 0);
	script.Parent.Position = UDim2.new(0, l__Y__1 + 10, 0, 0);
end;
Resize();
script.Parent.Parent.UserPicture:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	Resize();
end);
