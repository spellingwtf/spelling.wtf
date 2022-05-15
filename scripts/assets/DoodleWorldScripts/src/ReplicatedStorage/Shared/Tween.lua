-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__TweenService__1 = game:GetService("TweenService");
function v1.TweenCFrame(p1, p2, p3, p4, p5, p6, p7)
	local v2 = l__TweenService__1:Create(p2, TweenInfo.new(p5, p6, p7), {
		CFrame = p3
	});
	if p4 then
		v2:Play();
	end;
	return v2;
end;
function v1.TweenModel(p8, p9, p10, p11, p12, p13, p14)
	local v3 = l__TweenService__1:Create(p9, TweenInfo.new(p12, p13, p14), {
		Value = p10
	});
	if p11 then
		v3:Play();
	end;
	return v3;
end;
function v1.MakeTween(p15, p16, p17, p18, p19, p20, p21)
	local v4 = l__TweenService__1:Create(p16, TweenInfo.new(p19, p20, p21), p17);
	if p18 then
		v4:Play();
	end;
	return v4;
end;
function v1.Faint(p22, p23)
	return v1:TweenCFrame(p23, p23.CFrame - Vector3.new(0, p23.Size.Y + 5, 0), true, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
end;
function v1.PlayTween(p24, p25, p26, p27, p28, p29, p30)
	local v5 = l__TweenService__1:Create(p25, TweenInfo.new(p28, p29, p30), p26);
	if p27 then
		v5:Play();
	end;
	return v5;
end;
function v1.FOV(p31)

end;
function MakeKeypoint(p32, p33)
	return NumberSequenceKeypoint.new(p32, p33);
end;
return v1;
