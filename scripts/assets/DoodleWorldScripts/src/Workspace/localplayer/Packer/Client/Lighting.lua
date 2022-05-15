-- Decompiled with the Synapse X Luau decompiler.

local u1 = { "Bloom", "Blur", "SunRays", "ColorCorrection", "Atmosphere", "Sky" };
local u2 = {
	["The Town"] = {
		Lighting = {
			Ambient = Color3.fromRGB(108, 126, 148), 
			Brightness = 1, 
			ClockTime = 14, 
			ColorShift_Bottom = Color3.fromRGB(255, 255, 255), 
			ColorShift_Top = Color3.fromRGB(176, 165, 153), 
			ExposureCompensation = 0.9, 
			EnvironmentDiffuseScale = 0.5, 
			EnvironmentSpecularScale = 0.9, 
			GlobalShadows = true, 
			OutdoorAmbient = Color3.fromRGB(33, 33, 33), 
			FogColor = Color3.fromRGB(255, 252, 228), 
			FogEnd = 2500, 
			FogStart = 35
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Brightness = -0.04, 
				Contrast = 0.1, 
				Saturation = 0.2, 
				TintColor = Color3.fromRGB(255, 255, 255), 
				Enabled = true
			}, 
			SunRaysEffect = {
				Intensity = 0.06, 
				Spread = 1, 
				Enabled = true
			}, 
			BlurEffect = {
				Size = 1, 
				Enabled = false
			}, 
			BloomEffect = {
				Threshold = 0.9, 
				Size = 56, 
				Intensity = 0.3, 
				Enabled = true
			}
		}
	}, 
	Default = {
		Lighting = {
			Ambient = Color3.fromRGB(0, 0, 0), 
			Brightness = 2, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			ColorShift_Top = Color3.fromRGB(0, 0, 0), 
			ExposureCompensation = 0, 
			EnvironmentDiffuseScale = 0, 
			EnvironmentSpecularScale = 0, 
			GlobalShadows = true, 
			OutdoorAmbient = Color3.fromRGB(128, 128, 128), 
			FogColor = Color3.fromRGB(192, 192, 192), 
			FogEnd = 3000, 
			FogStart = 0
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Enabled = false
			}, 
			SunRaysEffect = {
				Enabled = false
			}, 
			BlurEffect = {
				Enabled = false
			}, 
			BloomEffect = {
				Enabled = false
			}
		}
	}, 
	BuildingDefault = {
		Lighting = {
			Ambient = Color3.fromRGB(101, 111, 130), 
			Brightness = 1.01, 
			GeographicLatitude = 7.378, 
			ClockTime = 8.12, 
			ColorShift_Bottom = Color3.fromRGB(255, 255, 255), 
			ColorShift_Top = Color3.fromRGB(255, 253, 183), 
			ExposureCompensation = 0, 
			EnvironmentDiffuseScale = 1, 
			EnvironmentSpecularScale = 1, 
			GlobalShadows = true, 
			OutdoorAmbient = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(192, 192, 192), 
			FogEnd = 3000, 
			FogStart = 0
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Enabled = true, 
				Brightness = 0.05, 
				Contrast = 0.15, 
				Saturation = 0.9, 
				TintColor = Color3.fromRGB(255, 255, 255)
			}, 
			SunRaysEffect = {
				Enabled = true, 
				Intensity = 0.019, 
				Spread = 0.538
			}, 
			BlurEffect = {
				Enabled = true, 
				Size = 3
			}, 
			BloomEffect = {
				Intensity = 1, 
				Size = 24, 
				Threshold = 2.445, 
				Enabled = true
			}, 
			Atmosphere = {
				Color = Color3.fromRGB(199, 170, 107), 
				Decay = Color3.fromRGB(92, 60, 13), 
				Glare = 0, 
				Haze = 0
			}
		}
	}, 
	["001_Chunk"] = {
		Lighting = {
			Ambient = Color3.fromRGB(159, 103, 103), 
			Brightness = 1.5, 
			ClockTime = 14, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			ColorShift_Top = Color3.fromRGB(255, 251, 196), 
			ExposureCompensation = 0, 
			EnvironmentDiffuseScale = 0.23, 
			EnvironmentSpecularScale = 0.262, 
			GlobalShadows = true, 
			ShadowSoftness = 0.21, 
			OutdoorAmbient = Color3.fromRGB(100, 80, 98), 
			FogColor = Color3.fromRGB(192, 192, 192), 
			FogEnd = 3000, 
			FogStart = 0
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Enabled = true, 
				Brightness = 0.2, 
				Contrast = 0.09, 
				Saturation = 0.2, 
				TintColor = Color3.fromRGB(255, 255, 226)
			}, 
			SunRaysEffect = {
				Spread = 1, 
				Intensity = 0.04, 
				Enabled = true
			}, 
			BloomEffect = {
				Enabled = true, 
				Intensity = 0.8, 
				Size = 57, 
				Threshold = 3
			}, 
			Sky = {
				CelestialBodiesShown = true, 
				MoonAngularSize = 25, 
				MoonTextureId = "rbxassetid://8400363487", 
				SkyboxBk = "rbxassetid://8400236806", 
				SkyboxDn = "rbxassetid://8400236570", 
				SkyboxFt = "rbxassetid://8400236304", 
				SkyboxLf = "rbxassetid://8400236047", 
				SkyboxRt = "rbxassetid://8400235812", 
				SkyboxUp = "rbxassetid://8400235593", 
				StarCount = 500, 
				SunAngularSize = 16
			}
		}, 
		Terrain = {
			WaterColor = Color3.fromRGB(12, 84, 92), 
			WaterReflectance = 0.2, 
			WaterTransparency = 1, 
			WaterWaveSize = 0.15, 
			WaterWaveSpeed = 10
		}
	}, 
	Sewer = {
		Lighting = {
			ClockTime = 9.885000228881836, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(175, 185, 109), 
			FogEnd = 1500, 
			FogStart = 0, 
			EnvironmentDiffuseScale = 0.09099999815225601, 
			EnvironmentSpecularScale = 0.07699999958276749, 
			ExposureCompensation = 0, 
			GeographicLatitude = 22.17434310913086, 
			Ambient = Color3.fromRGB(66, 66, 66), 
			OutdoorAmbient = Color3.fromRGB(100, 80, 98), 
			ShadowSoftness = 0.5099999904632568, 
			Brightness = 0.4000000059604645, 
			ColorShift_Top = Color3.fromRGB(48, 47, 37), 
			GlobalShadows = true
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Brightness = 0.20000000298023224, 
				Contrast = 0.09000000357627869, 
				Enabled = true, 
				Saturation = 0.20000000298023224, 
				TintColor = Color3.fromRGB(255, 255, 226)
			}, 
			SunRaysEffect = {
				Spread = 1, 
				Intensity = 0.04, 
				Enabled = true
			}, 
			BloomEffect = {
				Name = "Bloom", 
				Enabled = true, 
				Intensity = 0.800000011920929, 
				Size = 57, 
				Threshold = 2.757999897003174
			}, 
			Sky = {
				CelestialBodiesShown = true, 
				MoonAngularSize = 25, 
				MoonTextureId = "rbxassetid://8400363487", 
				SkyboxBk = "rbxassetid://8400236806", 
				SkyboxDn = "rbxassetid://8400236570", 
				SkyboxFt = "rbxassetid://8400236304", 
				SkyboxLf = "rbxassetid://8400236047", 
				SkyboxRt = "rbxassetid://8400235812", 
				SkyboxUp = "rbxassetid://8400235593", 
				StarCount = 500, 
				SunAngularSize = 16
			}
		}, 
		Terrain = {
			WaterColor = Color3.fromRGB(52, 104, 0), 
			WaterReflectance = 0.15, 
			WaterTransparency = 0.25, 
			WaterWaveSize = 0.2, 
			WaterWaveSpeed = 5
		}
	}, 
	CrystalCaverns = {
		Lighting = {
			ClockTime = 10.473610877990723, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(9, 53, 81), 
			FogEnd = 800, 
			FogStart = 300, 
			EnvironmentDiffuseScale = 0.335999995470047, 
			EnvironmentSpecularScale = 0.2669999897480011, 
			ExposureCompensation = 0, 
			GeographicLatitude = 12.666051864624023, 
			Ambient = Color3.fromRGB(88, 88, 88), 
			OutdoorAmbient = Color3.fromRGB(70, 70, 70), 
			ShadowSoftness = 0.3199999928474426, 
			Brightness = 3, 
			ColorShift_Top = Color3.fromRGB(0, 0, 0), 
			GlobalShadows = true
		}, 
		Sky = {
			CelestialBodiesShown = true, 
			MoonAngularSize = 11, 
			MoonTextureId = "rbxassetid://6444320592", 
			SkyboxBk = "rbxassetid://6444884337", 
			SkyboxDn = "rbxassetid://6444884785", 
			SkyboxFt = "rbxassetid://6444884337", 
			SkyboxLf = "rbxassetid://6444884337", 
			SkyboxRt = "rbxassetid://6444884337", 
			SkyboxUp = "rbxassetid://6412503613", 
			StarCount = 3000, 
			SunAngularSize = 11, 
			SunTextureId = "rbxassetid://6196665106", 
			Name = "Sky"
		}, 
		Atmosphere = {
			Density = 0.30000001192092896, 
			Offset = 0.25, 
			Name = "Atmosphere", 
			Color = Color3.fromRGB(199, 199, 199), 
			Decay = Color3.fromRGB(106, 112, 125), 
			Glare = 0, 
			Haze = 0
		}, 
		Effects = {
			BloomEffect = {
				Name = "Bloom", 
				Enabled = true, 
				Intensity = 1, 
				Size = 24, 
				Threshold = 2
			}, 
			SunRaysEffect = {
				Name = "SunRays", 
				Enabled = true, 
				Intensity = 0.009999999776482582, 
				Spread = 0.10000000149011612
			}
		}
	}, 
	LouisCult = {
		Lighting = {
			ClockTime = 11.772500038146973, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(47, 5, 5), 
			FogEnd = 5000, 
			FogStart = 0, 
			EnvironmentDiffuseScale = 0.335999995470047, 
			EnvironmentSpecularScale = 0.2669999897480011, 
			ExposureCompensation = 0, 
			GeographicLatitude = 22.329994201660156, 
			Ambient = Color3.fromRGB(88, 88, 88), 
			OutdoorAmbient = Color3.fromRGB(70, 70, 70), 
			ShadowSoftness = 1, 
			Brightness = 3, 
			ColorShift_Top = Color3.fromRGB(0, 0, 0), 
			GlobalShadows = true
		}, 
		Sky = {
			CelestialBodiesShown = true, 
			MoonAngularSize = 11, 
			MoonTextureId = "rbxassetid://6444320592", 
			SkyboxBk = "rbxassetid://6444884337", 
			SkyboxDn = "rbxassetid://6444884785", 
			SkyboxFt = "rbxassetid://6444884337", 
			SkyboxLf = "rbxassetid://6444884337", 
			SkyboxRt = "rbxassetid://6444884337", 
			SkyboxUp = "rbxassetid://6412503613", 
			StarCount = 3000, 
			SunAngularSize = 11, 
			SunTextureId = "rbxassetid://6196665106", 
			Name = "Sky"
		}, 
		Terrain = {
			WaterColor = Color3.fromRGB(12, 84, 92), 
			WaterReflectance = 0.2, 
			WaterTransparency = 1, 
			WaterWaveSize = 0.15, 
			WaterWaveSpeed = 10
		}, 
		Effects = {
			BloomEffect = {
				Name = "Bloom", 
				Enabled = true, 
				Intensity = 1, 
				Size = 24, 
				Threshold = 2
			}, 
			SunRaysEffect = {
				Name = "SunRays", 
				Enabled = false, 
				Intensity = 0.30000001192092896, 
				Spread = 0.41100001335144043
			}
		}
	}, 
	GraphiteForest = {
		Lighting = {
			Ambient = Color3.fromRGB(159, 103, 103), 
			Brightness = 1.5, 
			ClockTime = 14, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			ColorShift_Top = Color3.fromRGB(255, 251, 196), 
			ExposureCompensation = 0, 
			EnvironmentDiffuseScale = 0.23, 
			EnvironmentSpecularScale = 0.262, 
			GlobalShadows = true, 
			ShadowSoftness = 0.21, 
			OutdoorAmbient = Color3.fromRGB(100, 80, 98), 
			FogColor = Color3.fromRGB(192, 192, 192), 
			FogEnd = 3000, 
			FogStart = 0
		}, 
		Effects = {
			ColorCorrectionEffect = {
				Enabled = true, 
				Brightness = 0.2, 
				Contrast = 0.09, 
				Saturation = 0.2, 
				TintColor = Color3.fromRGB(255, 255, 226)
			}, 
			SunRaysEffect = {
				Spread = 1, 
				Intensity = 0.04, 
				Enabled = true
			}, 
			BloomEffect = {
				Enabled = true, 
				Intensity = 0.8, 
				Size = 57, 
				Threshold = 3
			}, 
			Sky = {
				CelestialBodiesShown = true, 
				MoonAngularSize = 25, 
				MoonTextureId = "rbxassetid://8400363487", 
				SkyboxBk = "rbxassetid://8400236806", 
				SkyboxDn = "rbxassetid://8400236570", 
				SkyboxFt = "rbxassetid://8400236304", 
				SkyboxLf = "rbxassetid://8400236047", 
				SkyboxRt = "rbxassetid://8400235812", 
				SkyboxUp = "rbxassetid://8400235593", 
				StarCount = 500, 
				SunAngularSize = 16
			}
		}, 
		Terrain = {
			WaterColor = Color3.fromRGB(15, 99, 255), 
			WaterReflectance = 1, 
			WaterTransparency = 0.5, 
			WaterWaveSize = 0.05, 
			WaterWaveSpeed = 10
		}
	}, 
	GraphiteMaze = {
		Lighting = {
			ClockTime = 11.123332977294922, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(192, 187, 166), 
			FogEnd = 30000, 
			FogStart = 0, 
			EnvironmentDiffuseScale = 0.23000000417232513, 
			EnvironmentSpecularScale = 0.2619999945163727, 
			ExposureCompensation = 0, 
			GeographicLatitude = 25.836158752441406, 
			Ambient = Color3.fromRGB(159, 103, 103), 
			OutdoorAmbient = Color3.fromRGB(100, 80, 98), 
			ShadowSoftness = 0.20000000298023224, 
			Brightness = 0.8600000143051147, 
			ColorShift_Top = Color3.fromRGB(255, 251, 196), 
			GlobalShadows = true
		}, 
		Effects = {
			Atmosphere = {
				Density = 0.5889999866485596, 
				Offset = 0.5559999942779541, 
				Name = "Atmosphere", 
				Color = Color3.fromRGB(200, 170, 108), 
				Decay = Color3.fromRGB(92, 60, 14), 
				Glare = 0, 
				Haze = 0
			}, 
			BloomEffect = {
				Name = "Bloom", 
				Enabled = true, 
				Intensity = 0.800000011920929, 
				Size = 57, 
				Threshold = 3
			}, 
			ColorCorrectionEffect = {
				Name = "ColorCorrection", 
				Brightness = 0.20000000298023224, 
				Contrast = 0.09000000357627869, 
				Enabled = true, 
				Saturation = 0.20000000298023224, 
				TintColor = Color3.fromRGB(255, 255, 226)
			}, 
			SunRaysEffect = {
				Name = "SunRays", 
				Enabled = true, 
				Intensity = 0.03999999910593033, 
				Spread = 1
			}, 
			Sky = {
				CelestialBodiesShown = true, 
				MoonAngularSize = 11, 
				MoonTextureId = "rbxasset://sky/moon.jpg", 
				SkyboxBk = "rbxassetid://9285798058", 
				SkyboxDn = "rbxassetid://9284785541", 
				SkyboxFt = "rbxassetid://9284785438", 
				SkyboxLf = "rbxassetid://9284785338", 
				SkyboxRt = "rbxassetid://9284784847", 
				SkyboxUp = "rbxassetid://9284784760", 
				StarCount = 3000, 
				SunAngularSize = 21, 
				SunTextureId = "rbxasset://sky/sun.jpg", 
				Name = "Rain_Sky"
			}
		}
	}, 
	FirstKey = {
		Lighting = {
			ClockTime = 12.8774995803833, 
			ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
			FogColor = Color3.fromRGB(157, 185, 184), 
			FogEnd = 1000, 
			FogStart = 300, 
			EnvironmentDiffuseScale = 0.23000000417232513, 
			EnvironmentSpecularScale = 0.2619999945163727, 
			ExposureCompensation = 0, 
			GeographicLatitude = 26.913700103759766, 
			Ambient = Color3.fromRGB(159, 103, 103), 
			OutdoorAmbient = Color3.fromRGB(138, 138, 138), 
			ShadowSoftness = 0.20999999344348907, 
			Brightness = 1.9800000190734863, 
			ColorShift_Top = Color3.fromRGB(255, 251, 196), 
			GlobalShadows = true
		}, 
		Effects = {
			Lighting = {
				SunRaysEffect = {
					Name = "SunRays", 
					Enabled = true, 
					Intensity = 0.03999999910593033, 
					Spread = 1
				}, 
				ColorCorrectionEffect = {
					Name = "ColorCorrection", 
					Brightness = 0.20000000298023224, 
					Contrast = 0.09000000357627869, 
					Enabled = true, 
					Saturation = 0.20000000298023224, 
					TintColor = Color3.fromRGB(255, 255, 226)
				}, 
				BloomEffect = {
					Name = "Bloom", 
					Enabled = true, 
					Intensity = 0.800000011920929, 
					Size = 57, 
					Threshold = 3
				}, 
				Sky = {
					CelestialBodiesShown = true, 
					MoonAngularSize = 25, 
					MoonTextureId = "rbxassetid://8400363487", 
					SkyboxBk = "rbxassetid://8400236806", 
					SkyboxDn = "rbxassetid://8400236570", 
					SkyboxFt = "rbxassetid://8400236304", 
					SkyboxLf = "rbxassetid://8400236047", 
					SkyboxRt = "rbxassetid://8400235812", 
					SkyboxUp = "rbxassetid://8400235593", 
					StarCount = 500, 
					SunAngularSize = 16, 
					SunTextureId = "", 
					Name = "Old"
				}, 
				Atmosphere = {
					Density = 0.34200000762939453, 
					Offset = 0.41999998688697815, 
					Name = "Atmosphere", 
					Color = Color3.fromRGB(200, 170, 108), 
					Decay = Color3.fromRGB(92, 60, 14), 
					Glare = 0, 
					Haze = 0
				}
			}
		}
	}
};
return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Class({
		ClassName = "Lighting"
	}, function(p2)
		p2.Lighting = p1.Services.Lighting;
		p2.Current = "001_Chunk";
		p2:Apply(p2.Current);
		return p2;
	end);
	function v2.LightingSetting(p3)
		if p1.Settings:Get("DisableLighting") == true then
			p3:Apply("Default");
			return;
		end;
		p3:Apply(p3.CurrentLocation);
	end;
	local l__Tween__3 = p1.Tween;
	function v2.Darken(p4, p5)
		l__Tween__3:PlayTween(p4.Lighting, {
			Ambient = Color3.fromRGB(66, 72, 86), 
			Brightness = 0.3
		}, true, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		if p5 then
			l__Utilities__1.Halt(1);
		end;
	end;
	local function u4(p6, p7)
		if p6:FindFirstChild(p7) then
			p6[p7]:Destroy();
		end;
	end;
	function v2.DeleteEffects(p8)
		for v3, v4 in pairs(u1) do
			u4(p8.Lighting, v4);
		end;
	end;
	function v2.Apply(p9, p10)
		if p10 ~= "Default" then
			p9.CurrentLocation = p10;
		end;
		local v5 = u2[p10];
		if not v5 then
			warn(p10 .. " not a valid lighting location");
			return;
		end;
		for v6, v7 in pairs(v5.Lighting) do
			p9.Lighting[v6] = v7;
		end;
		p9:DeleteEffects();
		for v8, v9 in pairs(v5.Effects) do
			if v9.Enabled == true or v8 == "Atmosphere" or v8 == "Sky" then
				local v10 = Instance.new(v8);
				for v11, v12 in pairs(v9) do
					v10[v11] = v12;
				end;
				v10.Parent = p9.Lighting;
			end;
		end;
		if v5.Terrain then
			for v13, v14 in pairs(v5.Terrain) do
				workspace.Terrain[v13] = v14;
			end;
		end;
	end;
	return v2.new();
end;
