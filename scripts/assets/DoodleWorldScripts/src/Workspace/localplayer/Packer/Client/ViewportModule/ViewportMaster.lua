-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
v1.__index = v1;
local u1 = Vector3.new(0, 10000, 0);
local l__Workspace__2 = game:GetService("Workspace");
local u3 = nil;
function v1.buildFrame(p1)
	local v2 = {};
	setmetatable(v2, v1);
	v2.Orientation = Vector3.new(0, 0, 0);
	v2.Zoom = 1;
	local function v3(p2)
		local v4 = p2:Clone();
		local v5 = 1;
		for v6, v7 in pairs(v4:GetDescendants()) do
			if v7:IsA("BasePart") then
				local v8 = Instance.new("IntValue");
				v8.Name = "PartTag" .. tostring(v5);
				v8.Value = v5;
				v5 = v5 + 1;
				v8.Parent = v7;
			end;
		end;
		local v9 = (function()
			return v4:FindFirstChildWhichIsA("Humanoid") and v4:FindFirstChildWhichIsA("AnimationController");
		end)();
		if v9 then
			local u4 = v4:Clone();
			(function()
				local v10 = {};
				for v11, v12 in pairs(u4:GetDescendants()) do
					local l__Parent__13 = v12.Parent.Parent;
					if v12:IsA("Attachment") and l__Parent__13:IsA("Accessory") then
						local l__Name__14 = v12.Name;
						local v15 = v10[tostring(l__Name__14)];
						if v15 == nil then
							v15 = {};
						end;
						table.insert(v15, l__Parent__13);
						v10[tostring(l__Name__14)] = v15;
					end;
				end;
				for v16, v17 in pairs(u4:GetDescendants()) do
					if v17:IsA("Attachment") and v17.Parent.Parent:IsA("Model") then
						local v18 = v10[tostring(v17.Name)];
						if v18 then
							for v19, v20 in pairs(v18) do
								local v21 = Instance.new("Motor6D");
								v21.Parent = v17.Parent;
								v21.Part0 = v17.Parent;
								v21.Part1 = v20:FindFirstChildWhichIsA("Part");
								v21.C0 = CFrame.new(v20.AttachmentPos * 0.5);
							end;
						end;
					end;
				end;
			end)();
			if v9:IsA("Humanoid") then
				u4:FindFirstChildWhichIsA("Humanoid"):Destroy();
				v9 = Instance.new("AnimationController", u4);
				if not (not v4:FindFirstChild("Shirt")) or not (not v4:FindFirstChild("Pants")) or v4:FindFirstChild("Body Colors") then
					local v22 = Instance.new("Humanoid");
					v22.RigType = Enum.HumanoidRigType.R15;
					v22.Parent = v4;
				end;
			end;
			u4:SetPrimaryPartCFrame(CFrame.new(u1));
			u4.PrimaryPart.Anchored = true;
			u4.Parent = l__Workspace__2;
			v2.Dummy = u4;
			v2.Animator = v9;
		end;
		local v23 = v4:Clone();
		local v24 = v23:FindFirstChildWhichIsA("Humanoid");
		local v25 = v23:FindFirstChildWhichIsA("AnimationController");
		if v24 then
			v24:Destroy();
		end;
		if v25 then
			v25:Destroy();
		end;
		local v26, v27, v28 = (function()
			local v29 = nil;
			local v30 = nil;
			local v31 = nil;
			local v32 = nil;
			local v33 = nil;
			local v34 = nil;
			for v35, v36 in pairs(v4:GetDescendants()) do
				if v36:IsA("BasePart") and v36 ~= v4.PrimaryPart then
					local v37 = v36.Position;
					local v38 = v36.Size;
					local v39 = v36:FindFirstChildWhichIsA("SpecialMesh");
					if v39 then
						v37 = v37 + v39.Offset;
						v38 = v39.Scale;
					end;
					local l__p__40 = (CFrame.new(v37) * CFrame.Angles(math.rad(v36.Orientation.X), math.rad(v36.Orientation.Y), math.rad(v36.Orientation.Z)) * CFrame.new(v38 / 2)).p;
					local l__p__41 = (CFrame.new(v37) * CFrame.Angles(math.rad(v36.Orientation.X), math.rad(v36.Orientation.Y), math.rad(v36.Orientation.Z)) * CFrame.new(-(v38 / 2))).p;
					local v42 = math.max(l__p__40.X, l__p__41.X);
					local v43 = math.max(l__p__40.Y, l__p__41.Y);
					local v44 = math.max(l__p__40.Z, l__p__41.Z);
					local v45 = math.min(l__p__40.X, l__p__41.X);
					local v46 = math.min(l__p__40.Y, l__p__41.Y);
					local v47 = math.min(l__p__40.Z, l__p__41.Z);
					if v29 == nil or v45 < v29 then
						v29 = v45;
					end;
					if v32 == nil or v32 < v42 then
						v32 = v42;
					end;
					if v30 == nil or v46 < v30 then
						v30 = v46;
					end;
					if v33 == nil or v33 < v43 then
						v33 = v43;
					end;
					if v31 == nil or v47 < v31 then
						v31 = v47;
					end;
					if v34 == nil or v34 < v44 then
						v34 = v44;
					end;
				end;
			end;
			local v48 = Vector3.new(v29, v30, v31);
			local v49 = Vector3.new(v32, v33, v34);
			local v50 = v48:Lerp(v49, 0.5);
			return v50, v49 - v48, v50 - v4:GetPrimaryPartCFrame().p;
		end)(v23);
		local v51 = math.max(v27.X, v27.Y, v27.Z);
		v2.LargestAxis = v51;
		v23:SetPrimaryPartCFrame(CFrame.new(u1) * CFrame.new(-v28));
		local v52 = Instance.new("ViewportFrame");
		v52.Size = UDim2.new(1, 0, 1, 0);
		v52.SizeConstraint = Enum.SizeConstraint.RelativeYY;
		v52.Position = UDim2.new(0.5, 0, 0.5, 0);
		v52.AnchorPoint = Vector2.new(0.5, 0.5);
		v52.BackgroundTransparency = 1;
		local v53 = Instance.new("Camera");
		v53.CameraType = Enum.CameraType.Scriptable;
		v53.Parent = v52;
		v53.FieldOfView = 105;
		v52.CurrentCamera = v53;
		v52.CurrentCamera.CFrame = CFrame.new(u1) * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, 0, v51 * 1.25);
		u3 = v52.CurrentCamera.CFrame.p;
		v23.Parent = v52;
		v2.Camera = v53;
		v2.Frame = v52;
		v2.Model = v23;
	end;
	v3(p1);
	function v2.getFrame()
		return v2.Frame;
	end;
	function v2.getCamera()
		return v2.Camera;
	end;
	function v2.setZoom(p3)
		if tonumber(p3) == nil then
			error(".setZoom() requires a numerical value.");
		end;
		v2.Zoom = p3;
	end;
	function v2.getZoom()
		return v2.Zoom;
	end;
	function v2.setOrientation(p4)
		if typeof(p4) ~= "Vector3" then
			error(".setOrientation([]) requires a Vector3 value.");
		end;
		v2.Orientation = p4;
	end;
	function v2.getOrientation()
		return v2.Orientation;
	end;
	function v2.setModel(p5)
		if v2.Model then
			v2.Model:Destroy();
		end;
		if v2.Dummy then
			v2.Dummy:Destroy();
		end;
		v2.LargestAxis = 0;
		v2.Model = nil;
		v2.Dummy = nil;
		v3(p5);
	end;
	function v2.getModel()
		return v2.Model, v2.Dummy;
	end;
	v2.Parent = nil;
	return v2;
end;
function v1.LoadAnimation(p6, p7)
	local l__Animator__54 = p6.Animator;
	if l__Animator__54 == nil then
		warn(":LoadAnimation() can only be used on models with AnimationControllers or Humanoids.");
		return nil;
	end;
	return l__Animator__54:LoadAnimation(p7);
end;
function v1.GetPlayingAnimationTracks(p8)
	local l__Animator__55 = p8.Animator;
	if l__Animator__55 == nil then
		warn(":GetPlayingAnimationTracks() can only be used on models with AnimationControllers or Humanoids.");
		return nil;
	end;
	return l__Animator__55:GetPlayingAnimationTracks();
end;
function v1.Update(p9)
	local l__Model__56 = p9.Model;
	local l__Dummy__57 = p9.Dummy;
	local l__Frame__58 = p9.Frame;
	local l__Orientation__59 = p9.Orientation;
	l__Frame__58.Parent = p9.Parent;
	p9.Camera.CFrame = (CFrame.new(u1) + Vector3.new(-1, 2, 0)) * CFrame.Angles(math.rad(l__Orientation__59.X), math.rad(l__Orientation__59.Y + 180), math.rad(l__Orientation__59.Z)) * CFrame.new(0, 0, p9.LargestAxis * 1.25 / p9.Zoom);
	if l__Frame__58.Visible and l__Dummy__57 then
		for v60, v61 in pairs(l__Dummy__57:GetDescendants()) do
			if v61:IsA("BasePart") then
				for v62, v63 in pairs(v61:GetChildren()) do
					if v63:IsA("IntValue") and string.sub(v63.Name, 1, 7) == "PartTag" then
						l__Model__56:FindFirstChild(v63.Name, true).Parent.CFrame = l__Model__56:GetPrimaryPartCFrame() * l__Dummy__57:GetPrimaryPartCFrame():toObjectSpace(v61.CFrame);
						break;
					end;
				end;
			end;
		end;
	end;
end;
function v1.Destroy(p10)
	if p10.Frame then
		p10.Frame:Destroy();
	end;
	if p10.Model then
		p10.Model:Destroy();
	end;
	if p10.Dummy then
		p10.Dummy:Destroy();
	end;
	p10.Destroyed = true;
end;
return v1;
