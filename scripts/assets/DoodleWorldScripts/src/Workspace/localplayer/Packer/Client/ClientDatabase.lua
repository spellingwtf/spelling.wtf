-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	function v1.GetDoodleInfo(p2, p3)
		return p1.DoodleInfo[p3];
	end;
	function v1.GetKlydaFront(p4, p5)
		local v2 = nil;
		if not p5 then
			return;
		end;
		v2 = p1.DoodleInfo[p5.RealName or p5.Name];
		if p5.Shiny then
			return v2.ShinyBase, v2.StripeOutline, v2.StripeFront;
		end;
		return v2.BaseFront, v2.StripeOutline, v2.StripeFront;
	end;
	function v1.GetKlydaBack(p6, p7)
		local v3 = nil;
		if not p7 then
			return;
		end;
		v3 = p1.DoodleInfo[p7.RealName or p7.Name];
		if p7.Shiny then
			return v3.BackShiny, v3.BackOutline, v3.BackStripe;
		end;
		return v3.BaseBack, v3.BackOutline, v3.BackStripe;
	end;
	function v1.GetFrontSprite(p8, p9)
		if not p9 then
			return;
		end;
		if typeof(p9) ~= "table" then
			return;
		end;
		local v4 = p1.DoodleInfo[p9.RealName or p9.Name];
		if not p9.Skin or p9.Skin == 0 then
			if p9.Gender == "F" and v4.FemaleFrontSprite then
				if p9.Shiny then
					return v4.FemaleSFSprite;
				else
					return v4.FemaleFrontSprite;
				end;
			elseif p9.Shiny then
				return v4.SFSprite;
			else
				return v4.FrontSprite;
			end;
		end;
		local v5 = p1.Skins.Sprites[p9.RealName or p9.Name][p9.Skin];
		if p9.Gender == "F" and v5 and v5.FemaleFrontSprite then
			if p9.Shiny then
				return v5.FemaleSFSprite;
			else
				return v5.FemaleFrontSprite;
			end;
		end;
		if p9.Shiny then
			return v5.SFSprite;
		end;
		return v5 and v5.FrontSprite or "";
	end;
	function v1.GetBackSprite(p10, p11)
		local v6 = p1.DoodleInfo[p11.RealName or p11.Name];
		if p11.Skin and p11.Skin ~= 0 then
			local v7 = nil;
			v7 = p1.Skins.Sprites[p11.RealName or p11.Name][p11.Skin];
			if p11.Shiny then
				return v7.SBSprite;
			else
				return v7.BackSprite;
			end;
		end;
		if p11.Gender == "F" and v6.FemaleBackSprite then
			if p11.Shiny then
				return v6.FemaleSBSprite;
			else
				return v6.FemaleBackSprite;
			end;
		end;
		if p11.Shiny then
			return v6.SBSprite;
		end;
		return v6.BackSprite;
	end;
	function v1.GetMoveData(p12, p13)
		return p1.Moves[p13];
	end;
	function v1.GetDoodleSize(p14, p15, p16)
		if typeof(p15) ~= "table" then
			return;
		end;
		local v8 = p16 * p1.DoodleInfo[p15.RealName or p15.Name].Size;
		local v9 = v8 * p15.Size;
		return v8;
	end;
	function v1.GetNextLevel(p17, p18, p19)
		local l__ExpRate__10 = p1.DoodleInfo[p18.RealName or p18.Name].ExpRate;
		if p19 == 1 then
			return 0;
		end;
		if l__ExpRate__10 == "Fast" then
			return math.floor(p19 ^ 3 * 4 / 5);
		end;
		if l__ExpRate__10 == "MedFast" then
			return p19 ^ 3;
		end;
		if l__ExpRate__10 ~= "MedSlow" then
			if l__ExpRate__10 == "Slow" then
				return math.floor(p19 ^ 3 * 5 / 4);
			else
				return;
			end;
		end;
		return math.floor(p19 ^ 3 * 6 / 5) - p19 ^ 2 * 15 + p19 * 100 - 140;
	end;
	function v1.PDSFunc(p20, p21, ...)
		return p1.Network:get("PlayerData", p21, ...);
	end;
	function v1.PDSRunEvent(p22, p23, ...)
		return p1.Network:post("PlayerData", "RunEvent", p23, ...);
	end;
	function v1.PDSEvent(p24, p25, ...)
		return p1.Network:post("PlayerData", p25, ...);
	end;
	return v1;
end;
