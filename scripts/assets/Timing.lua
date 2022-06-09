
-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	linear = function(p1)
		return function(p2)
			return p2 / p1;
		end;
	end, 
	easeInQuad = function(p3)
		return function(p4)
			return (p4 / p3) ^ 2;
		end;
	end, 
	easeOutQuad = function(p5)
		return function(p6)
			p6 = p6 / p5;
			return -p6 * (p6 - 2);
		end;
	end, 
	easeInOutQuad = function(p7)
		return function(p8)
			p8 = p8 * 2 / p7;
			if p8 < 1 then
				return 0.5 * p8 ^ 2;
			end;
			p8 = p8 - 1;
			return -0.5 * (p8 * (p8 - 2) - 1);
		end;
	end, 
	easeInCubic = function(p9)
		return function(p10)
			return (p10 / p9) ^ 3;
		end;
	end, 
	easeOutCubic = function(p11)
		return function(p12)
			p12 = p12 / p11 - 1;
			return p12 * p12 * p12 + 1;
		end;
	end, 
	easeInOutCubic = function(p13)
		return function(p14)
			p14 = p14 * 2 / p13;
			if p14 < 1 then
				return 0.5 * p14 ^ 3;
			end;
			p14 = p14 - 2;
			return 0.5 * (p14 ^ 3 + 2);
		end;
	end, 
	easeInQuart = function(p15)
		return function(p16)
			return (p16 / p15) ^ 4;
		end;
	end, 
	easeOutQuart = function(p17)
		return function(p18)
			p18 = p18 / p17 - 1;
			return -(p18 ^ 4 - 1);
		end;
	end, 
	easeInOutQuart = function(p19)
		return function(p20)
			p20 = p20 * 2 / p19;
			if p20 < 1 then
				return 0.5 * p20 ^ 4;
			end;
			p20 = p20 - 2;
			return -0.5 * (p20 ^ 4 - 2);
		end;
	end, 
	easeInQuint = function(p21)
		return function(p22)
			return (p22 / p21) ^ 5;
		end;
	end, 
	easeOutQuint = function(p23)
		return function(p24)
			p24 = p24 / p23 - 1;
			return p24 ^ 5 + 1;
		end;
	end, 
	easeInOutQuint = function(p25)
		return function(p26)
			p26 = p26 * 2 / p25;
			if p26 < 1 then
				return 0.5 * p26 ^ 5;
			end;
			p26 = p26 - 2;
			return 0.5 * (p26 ^ 5 + 2);
		end;
	end
};
local l__math_pi__1 = math.pi;
local l__math_cos__2 = math.cos;
function v1.easeInSine(p27)
	return function(p28)
		return -l__math_cos__2(p28 / p27 * l__math_pi__1 / 2) + 1;
	end;
end;
local l__math_sin__3 = math.sin;
function v1.easeOutSine(p29)
	return function(p30)
		return l__math_sin__3(p30 / p29 * l__math_pi__1 / 2);
	end;
end;
function v1.easeInOutSine(p31)
	return function(p32)
		return -0.5 * (l__math_cos__2(l__math_pi__1 * p32 / p31) - 1);
	end;
end;
function v1.easeInExpo(p33)
	return function(p34)
		return 2 ^ (10 * (p34 / p33 - 1));
	end;
end;
function v1.easeOutExpo(p35)
	return function(p36)
		return -2 ^ (-10 * p36 / p35) + 1;
	end;
end;
function v1.easeInOutExpo(p37)
	return function(p38)
		p38 = p38 * 2 / p37;
		if p38 < 1 then
			return 0.5 * 2 ^ (10 * (p38 - 1));
		end;
		p38 = p38 - 1;
		return 0.5 * (-2 ^ (-10 * p38) + 2);
	end;
end;
local l__math_sqrt__4 = math.sqrt;
function v1.easeInCirc(p39)
	return function(p40)
		return -(l__math_sqrt__4(1 - (p40 / p39) ^ 2) - 1);
	end;
end;
function v1.easeOutCirc(p41)
	return function(p42)
		p42 = p42 / p41 - 1;
		return l__math_sqrt__4(1 - p42 ^ 2);
	end;
end;
function v1.easeInOutCirc(p43)
	return function(p44)
		p44 = p44 * 2 / p43;
		if p44 < 1 then
			return -0.5 * (l__math_sqrt__4(1 - p44 ^ 2) - 1);
		end;
		p44 = p44 - 2;
		return 0.5 * (l__math_sqrt__4(1 - p44 ^ 2) + 1);
	end;
end;
function v1.easeInBack(p45, p46)
	p46 = p46 and 1.70158;
	return function(p47)
		p47 = p47 / p45;
		return p47 * p47 * ((p46 + 1) * p47 - p46);
	end;
end;
function v1.easeOutBack(p48, p49)
	p49 = p49 and 1.70158;
	return function(p50)
		p50 = p50 / p48 - 1;
		return p50 * p50 * ((p49 + 1) * p50 + p49) + 1;
	end;
end;
function v1.easeOutBounce(p51)
	return function(p52)
		p52 = p52 / p51;
		if p52 < 0.36363636363636365 then
			return 7.5625 * p52 * p52;
		end;
		if p52 < 0.7272727272727273 then
			p52 = p52 - 0.5454545454545454;
			return 7.5625 * p52 * p52 + 0.75;
		end;
		if p52 < 0.9090909090909091 then
			p52 = p52 - 0.8181818181818182;
			return 7.5625 * p52 * p52 + 0.9375;
		end;
		p52 = p52 - 0.9545454545454546;
		return 7.5625 * p52 * p52 + 0.984375;
	end;
end;
local l__math_asin__5 = math.asin;
local l__math_pow__6 = math.pow;
function v1.easeOutElastic(p53, p54, p55)
	p54 = p54 and 1;
	p55 = p55 and 0.3;
	local u7 = p55 / (2 * l__math_pi__1) * l__math_asin__5(1 / p54);
	return function(p56)
		if p56 <= 0 then
			return 0;
		end;
		if p53 <= p56 then
			return 1;
		end;
		p56 = p56 / p53;
		return p54 * l__math_pow__6(2, -10 * p56) * l__math_sin__3((p56 * p53 - u7) * (2 * l__math_pi__1) / p55) + 1;
	end;
end;
function v1.cubicBezier(p57, p58, p59, p60, p61)
	p58 = p58 and 0;
	p59 = p59 and 0;
	p60 = p60 and 1;
	p61 = p61 and 1;
	local v2 = 3 * p58;
	local v3 = 3 * (p60 - p58) - v2;
	local v4 = 3 * p59;
	local v5 = 3 * (p61 - p59) - v4;
	local u8 = 1 - v2 - v3;
	local u9 = 1 - v4 - v5;
	local function u10(p62)
		return ((u8 * p62 + v3) * p62 + v2) * p62;
	end;
	local u11 = 1 / (200 * p57);
	local function u12(p63)
		return (3 * u8 * p63 + 2 * v3) * p63 + v2;
	end;
	local function u13(p64)
		return ((u9 * p64 + v5) * p64 + v4) * p64;
	end;
	local function u14(p65)
		local function v6(p66)
			return p66 >= 0 and p66 or 0 - p66;
		end;
		local v7 = p65;
		for v8 = 0, 7 do
			local v9 = u10(v7) - p65;
			if v6(v9) < u11 then
				return v7;
			end;
			local v10 = u12(v7);
			if v6(v10) < 1E-06 then
				break;
			end;
			v7 = v7 - v9 / v10;
		end;
		local v11 = 0;
		local v12 = 1;
		local v13 = p65;
		if v13 < v11 then
			return v11;
		end;
		if v12 < v13 then
			return v12;
		end;
		while v11 < v12 do
			local v14 = u10(v13);
			if v6(v14 - p65) < u11 then
				return v13;
			end;
			if v14 < p65 then
				v11 = v13;
			else
				v12 = v13;
			end;
			v13 = (v12 - v11) * 0.5 + v11;		
		end;
		return v13;
	end;
	return function(p67)
		return u13(u14(p67 / p57));
	end;
end;
return v1;

