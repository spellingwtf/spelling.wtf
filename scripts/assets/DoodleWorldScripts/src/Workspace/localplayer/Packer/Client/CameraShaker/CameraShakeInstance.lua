-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
v1.__index = v1;
v1.CameraShakeState = {
	FadingIn = 0, 
	FadingOut = 1, 
	Sustained = 2, 
	Inactive = 3
};
local l__Vector3_new__1 = Vector3.new;
function v1.new(p1, p2, p3, p4)
	if p3 == nil then
		p3 = 0;
	end;
	if p4 == nil then
		p4 = 0;
	end;
	assert(type(p1) == "number", "Magnitude must be a number");
	assert(type(p2) == "number", "Roughness must be a number");
	assert(type(p3) == "number", "FadeInTime must be a number");
	assert(type(p4) == "number", "FadeOutTime must be a number");
	local v2 = {
		Magnitude = p1, 
		Roughness = p2, 
		PositionInfluence = l__Vector3_new__1(), 
		RotationInfluence = l__Vector3_new__1(), 
		DeleteOnInactive = true, 
		roughMod = 1, 
		magnMod = 1, 
		fadeOutDuration = p4, 
		fadeInDuration = p3, 
		sustain = p3 > 0
	};
	if p3 > 0 then
		local v3 = 0;
	else
		v3 = 1;
	end;
	v2.currentFadeTime = v3;
	v2.tick = Random.new():NextNumber(-100, 100);
	v2._camShakeInstance = true;
	return setmetatable(v2, v1);
end;
local l__math_noise__2 = math.noise;
function v1.UpdateShake(p5, p6)
	local l__tick__4 = p5.tick;
	local v5 = p5.currentFadeTime;
	if p5.fadeInDuration > 0 and p5.sustain then
		if v5 < 1 then
			v5 = v5 + p6 / p5.fadeInDuration;
		elseif p5.fadeOutDuration > 0 then
			p5.sustain = false;
		end;
	end;
	if not p5.sustain then
		v5 = v5 - p6 / p5.fadeOutDuration;
	end;
	if p5.sustain then
		p5.tick = l__tick__4 + p6 * p5.Roughness * p5.roughMod;
	else
		p5.tick = l__tick__4 + p6 * p5.Roughness * p5.roughMod * v5;
	end;
	p5.currentFadeTime = v5;
	return l__Vector3_new__1(l__math_noise__2(l__tick__4, 0) * 0.5, l__math_noise__2(0, l__tick__4) * 0.5, l__math_noise__2(l__tick__4, l__tick__4) * 0.5) * p5.Magnitude * p5.magnMod * v5;
end;
function v1.StartFadeOut(p7, p8)
	if p8 == 0 then
		p7.currentFadeTime = 0;
	end;
	p7.fadeOutDuration = p8;
	p7.fadeInDuration = 0;
	p7.sustain = false;
end;
function v1.StartFadeIn(p9, p10)
	if p10 == 0 then
		p9.currentFadeTime = 1;
	end;
	p9.fadeInDuration = p10 or p9.fadeInDuration;
	p9.fadeOutDuration = 0;
	p9.sustain = true;
end;
function v1.GetScaleRoughness(p11)
	return p11.roughMod;
end;
function v1.SetScaleRoughness(p12, p13)
	p12.roughMod = p13;
end;
function v1.GetScaleMagnitude(p14)
	return p14.magnMod;
end;
function v1.SetScaleMagnitude(p15, p16)
	p15.magnMod = p16;
end;
function v1.GetNormalizedFadeTime(p17)
	return p17.currentFadeTime;
end;
function v1.IsShaking(p18)
	local v6 = true;
	if not (p18.currentFadeTime > 0) then
		v6 = p18.sustain;
	end;
	return v6;
end;
function v1.IsFadingOut(p19)
	return not p19.sustain and p19.currentFadeTime > 0;
end;
function v1.IsFadingIn(p20)
	local v7 = false;
	if p20.currentFadeTime < 1 then
		v7 = p20.sustain and p20.fadeInDuration > 0;
	end;
	return v7;
end;
function v1.GetState(p21)
	if p21:IsFadingIn() then
		return v1.CameraShakeState.FadingIn;
	end;
	if p21:IsFadingOut() then
		return v1.CameraShakeState.FadingOut;
	end;
	if p21:IsShaking() then
		return v1.CameraShakeState.Sustained;
	end;
	return v1.CameraShakeState.Inactive;
end;
return v1;
