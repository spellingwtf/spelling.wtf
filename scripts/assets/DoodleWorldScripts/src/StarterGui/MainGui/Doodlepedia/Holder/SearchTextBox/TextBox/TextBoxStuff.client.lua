-- Decompiled with the Synapse X Luau decompiler.

script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
	script.Parent.DropShadow.Text = script.Parent.Text;
end);
