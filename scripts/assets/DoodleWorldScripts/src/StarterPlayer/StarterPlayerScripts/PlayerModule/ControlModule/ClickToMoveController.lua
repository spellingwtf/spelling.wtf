-- Decompiled with the Synapse X Luau decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__PathfindingService__2 = game:GetService("PathfindingService");
local l__Players__3 = game:GetService("Players");
local l__Debris__4 = game:GetService("Debris");
local l__StarterGui__5 = game:GetService("StarterGui");
local l__Workspace__6 = game:GetService("Workspace");
local l__CollectionService__7 = game:GetService("CollectionService");
local l__GuiService__8 = game:GetService("GuiService");
local v9, v10 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserNavigationClickToMoveSkipPassedWaypoints");
end);
local v11 = {};
local u1 = function(p1)
	if not p1 then
		return;
	end;
	local v12 = p1:FindFirstChildOfClass("Humanoid");
	if v12 then
		return p1, v12;
	end;
	return u1(p1.Parent);
end;
v11.FindCharacterAncestor = u1;
local u2 = function(p2, p3, p4)
	p4 = p4 or {};
	local v13, v14, v15, v16 = l__Workspace__6:FindPartOnRayWithIgnoreList(p2, p4);
	if not v13 then
		return nil, nil;
	end;
	if p3 and v13.CanCollide == false then
		local v17, v18 = u1(v13);
		if v18 ~= nil then
			return v13, v14, v15, v16;
		end;
	else
		return v13, v14, v15, v16;
	end;
	table.insert(p4, v13);
	return u2(p2, p3, p4);
end;
v11.Raycast = u2;
u1 = {};
u2 = function(p5)
	local v19 = p5 and p5.Character;
	if not v19 then
		return;
	end;
	local v20 = u1[p5];
	if v20 and v20.Parent == v19 then
		return v20;
	end;
	u1[p5] = nil;
	local v21 = v19:FindFirstChildOfClass("Humanoid");
	if v21 then
		u1[p5] = v21;
	end;
	return v21;
end;
local l__LocalPlayer__3 = l__Players__3.LocalPlayer;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local function u8()
	return l__LocalPlayer__3 and l__LocalPlayer__3.Character;
end;
local u9 = false;
local u10 = Vector3.new(0, 0, 0);
local u11 = 1;
local u12 = true;
local u13 = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local u14 = 8;
local u15 = v9 or v10;
local function u16()
	if u7 then
		return u7;
	end;
	u7 = {};
	table.insert(u7, u8());
	return u7;
end;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local function u20()
	if u17 then
		u17:Cancel();
		u17 = nil;
	end;
	if u18 then
		u18:Disconnect();
		u18 = nil;
	end;
	if u19 then
		u19:Disconnect();
		u19 = nil;
	end;
end;
local function u21(p6)
	if p6 ~= nil then
		for v22, v23 in pairs(p6:GetChildren()) do
			if v23:IsA("Tool") then
				return v23;
			end;
		end;
	end;
end;
local u22 = true;
local function u23()
	local v24 = u2(l__LocalPlayer__3);
	local v25 = false;
	if v24 ~= nil then
		v25 = v24.Health > 0;
	end;
	return v25;
end;
local function u24(p7, p8, p9)
	local v26 = {};
	if p9 ~= nil then
		local v27 = p9;
		local v28 = p9;
	else
		v27 = u9;
		v28 = true;
	end;
	v26.Cancelled = false;
	v26.Started = false;
	v26.Finished = Instance.new("BindableEvent");
	v26.PathFailed = Instance.new("BindableEvent");
	v26.PathComputing = false;
	v26.PathComputed = false;
	v26.OriginalTargetPoint = p7;
	v26.TargetPoint = p7;
	v26.TargetSurfaceNormal = p8;
	v26.DiedConn = nil;
	v26.SeatedConn = nil;
	v26.BlockedConn = nil;
	v26.TeleportedConn = nil;
	v26.CurrentPoint = 0;
	v26.HumanoidOffsetFromPath = u10;
	v26.CurrentWaypointPosition = nil;
	v26.CurrentWaypointPlaneNormal = u10;
	v26.CurrentWaypointPlaneDistance = 0;
	v26.CurrentWaypointNeedsJump = false;
	v26.CurrentHumanoidPosition = u10;
	v26.CurrentHumanoidVelocity = 0;
	v26.NextActionMoveDirection = u10;
	v26.NextActionJump = false;
	v26.Timeout = 0;
	v26.Humanoid = u2(l__LocalPlayer__3);
	v26.OriginPoint = nil;
	v26.AgentCanFollowPath = false;
	v26.DirectPath = false;
	v26.DirectPathRiseFirst = false;
	local v29 = v26.Humanoid and v26.Humanoid.RootPart;
	if v29 then
		v26.OriginPoint = v29.CFrame.p;
		local v30 = 2;
		local v31 = 5;
		local v32 = true;
		local l__SeatPart__33 = v26.Humanoid.SeatPart;
		if l__SeatPart__33 and l__SeatPart__33:IsA("VehicleSeat") then
			local v34 = l__SeatPart__33:FindFirstAncestorOfClass("Model");
			if v34 then
				v34.PrimaryPart = l__SeatPart__33;
				if v28 then
					local v35 = v34:GetExtentsSize();
					v30 = u11 * 0.5 * math.sqrt(v35.X * v35.X + v35.Z * v35.Z);
					v31 = u11 * v35.Y;
					v32 = false;
					v26.AgentCanFollowPath = true;
					v26.DirectPath = v28;
				end;
				v34.PrimaryPart = v34.PrimaryPart;
			end;
		else
			local v36 = u8():GetExtentsSize();
			v30 = u11 * 0.5 * math.sqrt(v36.X * v36.X + v36.Z * v36.Z);
			v31 = u11 * v36.Y;
			v32 = v26.Humanoid.JumpPower > 0;
			v26.AgentCanFollowPath = true;
			v26.DirectPath = v27;
			v26.DirectPathRiseFirst = v26.Humanoid.Sit;
		end;
		v26.pathResult = l__PathfindingService__2:CreatePath({
			AgentRadius = v30, 
			AgentHeight = v31, 
			AgentCanJump = v32
		});
	end;
	function v26.Cleanup(p10)
		if v26.stopTraverseFunc then
			v26.stopTraverseFunc();
			v26.stopTraverseFunc = nil;
		end;
		if v26.MoveToConn then
			v26.MoveToConn:Disconnect();
			v26.MoveToConn = nil;
		end;
		if v26.BlockedConn then
			v26.BlockedConn:Disconnect();
			v26.BlockedConn = nil;
		end;
		if v26.DiedConn then
			v26.DiedConn:Disconnect();
			v26.DiedConn = nil;
		end;
		if v26.SeatedConn then
			v26.SeatedConn:Disconnect();
			v26.SeatedConn = nil;
		end;
		if v26.TeleportedConn then
			v26.TeleportedConn:Disconnect();
			v26.TeleportedConn = nil;
		end;
		v26.Started = false;
	end;
	function v26.Cancel(p11)
		v26.Cancelled = true;
		v26:Cleanup();
	end;
	function v26.IsActive(p12)
		return v26.AgentCanFollowPath and (v26.Started and not v26.Cancelled);
	end;
	function v26.OnPathInterrupted(p13)
		v26.Cancelled = true;
		v26:OnPointReached(false);
	end;
	function v26.ComputePath(p14)
		if v26.OriginPoint then
			if v26.PathComputed or v26.PathComputing then
				return;
			end;
			v26.PathComputing = true;
			if v26.AgentCanFollowPath then
				if v26.DirectPath then
					v26.pointList = { PathWaypoint.new(v26.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(v26.TargetPoint, v26.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) };
					v26.PathComputed = true;
				else
					v26.pathResult:ComputeAsync(v26.OriginPoint, v26.TargetPoint);
					v26.pointList = v26.pathResult:GetWaypoints();
					v26.BlockedConn = v26.pathResult.Blocked:Connect(function(p15)
						v26:OnPathBlocked(p15);
					end);
					v26.PathComputed = v26.pathResult.Status == Enum.PathStatus.Success;
				end;
			end;
			v26.PathComputing = false;
		end;
	end;
	function v26.IsValidPath(p16)
		v26:ComputePath();
		return v26.PathComputed and v26.AgentCanFollowPath;
	end;
	v26.Recomputing = false;
	function v26.OnPathBlocked(p17, p18)
		if not (v26.CurrentPoint <= p18) or v26.Recomputing then
			return;
		end;
		v26.Recomputing = true;
		if v26.stopTraverseFunc then
			v26.stopTraverseFunc();
			v26.stopTraverseFunc = nil;
		end;
		v26.OriginPoint = v26.Humanoid.RootPart.CFrame.p;
		v26.pathResult:ComputeAsync(v26.OriginPoint, v26.TargetPoint);
		v26.pointList = v26.pathResult:GetWaypoints();
		if #v26.pointList > 0 then
			v26.HumanoidOffsetFromPath = v26.pointList[1].Position - v26.OriginPoint;
		end;
		v26.PathComputed = v26.pathResult.Status == Enum.PathStatus.Success;
		if u12 then
			local v37, v38 = u13.CreatePathDisplay(v26.pointList);
			v26.stopTraverseFunc = v37;
			v26.setPointFunc = v38;
		end;
		if v26.PathComputed then
			v26.CurrentPoint = 1;
			v26:OnPointReached(true);
		else
			v26.PathFailed:Fire();
			v26:Cleanup();
		end;
		v26.Recomputing = false;
	end;
	function v26.OnRenderStepped(p19, p20)
		if v26.Started and not v26.Cancelled then
			v26.Timeout = v26.Timeout + p20;
			if u14 < v26.Timeout then
				v26:OnPointReached(false);
				return;
			end;
			v26.CurrentHumanoidPosition = v26.Humanoid.RootPart.Position + v26.HumanoidOffsetFromPath;
			v26.CurrentHumanoidVelocity = v26.Humanoid.RootPart.Velocity;
			while v26.Started and v26:IsCurrentWaypointReached() do
				v26:OnPointReached(true);			
			end;
			if v26.Started then
				v26.NextActionMoveDirection = v26.CurrentWaypointPosition - v26.CurrentHumanoidPosition;
				if v26.NextActionMoveDirection.Magnitude > 1E-06 then
					v26.NextActionMoveDirection = v26.NextActionMoveDirection.Unit;
				else
					v26.NextActionMoveDirection = u10;
				end;
				if v26.CurrentWaypointNeedsJump then
					v26.NextActionJump = true;
					v26.CurrentWaypointNeedsJump = false;
					return;
				end;
				v26.NextActionJump = false;
			end;
		end;
	end;
	function v26.IsCurrentWaypointReached(p21)
		if v26.CurrentWaypointPlaneNormal ~= u10 then
			local v39 = v26.CurrentWaypointPlaneNormal:Dot(v26.CurrentHumanoidPosition) - v26.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -v26.CurrentWaypointPlaneNormal:Dot(v26.CurrentHumanoidVelocity));
		else
			v39 = true;
		end;
		if v39 then
			v26.CurrentWaypointPosition = nil;
			v26.CurrentWaypointPlaneNormal = u10;
			v26.CurrentWaypointPlaneDistance = 0;
		end;
		return v39;
	end;
	function v26.OnPointReached(p22, p23)
		if not p23 or not (not v26.Cancelled) then
			v26.PathFailed:Fire();
			v26:Cleanup();
			return;
		end;
		if v26.setPointFunc then
			v26.setPointFunc(v26.CurrentPoint);
		end;
		local v40 = v26.CurrentPoint + 1;
		if #v26.pointList < v40 then
			if v26.stopTraverseFunc then
				v26.stopTraverseFunc();
			end;
			v26.Finished:Fire();
			v26:Cleanup();
			return;
		end;
		local v41 = v26.pointList[v26.CurrentPoint];
		local v42 = v26.pointList[v40];
		local v43 = v26.Humanoid:GetState();
		local v44 = true;
		if v43 ~= Enum.HumanoidStateType.FallingDown then
			v44 = true;
			if v43 ~= Enum.HumanoidStateType.Freefall then
				v44 = v43 == Enum.HumanoidStateType.Jumping;
			end;
		end;
		if v44 then
			local v45 = v42.Action == Enum.PathWaypointAction.Jump;
			if not v45 and v26.CurrentPoint > 1 then
				local v46 = v41.Position - v26.pointList[v26.CurrentPoint - 1].Position;
				local v47 = v42.Position - v41.Position;
				v45 = Vector2.new(v46.x, v46.z).Unit:Dot(Vector2.new(v47.x, v47.z).Unit) < 0.996;
			end;
			if v45 then
				v26.Humanoid.FreeFalling:Wait();
				wait(0.1);
			end;
		end;
		if u15 then
			v26:MoveToNextWayPoint(v41, v42, v40);
			return;
		end;
		if v26.setPointFunc then
			v26.setPointFunc(v40);
		end;
		if v42.Action == Enum.PathWaypointAction.Jump then
			v26.Humanoid.Jump = true;
		end;
		v26.Humanoid:MoveTo(v42.Position);
		v26.CurrentPoint = v40;
	end;
	function v26.MoveToNextWayPoint(p24, p25, p26, p27)
		v26.CurrentWaypointPlaneNormal = p25.Position - p26.Position;
		v26.CurrentWaypointPlaneNormal = Vector3.new(v26.CurrentWaypointPlaneNormal.X, 0, v26.CurrentWaypointPlaneNormal.Z);
		if v26.CurrentWaypointPlaneNormal.Magnitude > 1E-06 then
			v26.CurrentWaypointPlaneNormal = v26.CurrentWaypointPlaneNormal.Unit;
			v26.CurrentWaypointPlaneDistance = v26.CurrentWaypointPlaneNormal:Dot(p26.Position);
		else
			v26.CurrentWaypointPlaneNormal = u10;
			v26.CurrentWaypointPlaneDistance = 0;
		end;
		v26.CurrentWaypointNeedsJump = p26.Action == Enum.PathWaypointAction.Jump;
		v26.CurrentWaypointPosition = p26.Position;
		v26.CurrentPoint = p27;
		v26.Timeout = 0;
	end;
	function v26.Start(p28, p29)
		if not v26.AgentCanFollowPath then
			v26.PathFailed:Fire();
			return;
		end;
		if v26.Started then
			return;
		end;
		v26.Started = true;
		u13.CancelFailureAnimation();
		if u12 and (p29 == nil or p29) then
			local v48, v49 = u13.CreatePathDisplay(v26.pointList, v26.OriginalTargetPoint);
			v26.stopTraverseFunc = v48;
			v26.setPointFunc = v49;
		end;
		if not (#v26.pointList > 0) then
			v26.PathFailed:Fire();
			if v26.stopTraverseFunc then
				v26.stopTraverseFunc();
			end;
			return;
		end;
		v26.HumanoidOffsetFromPath = Vector3.new(0, v26.pointList[1].Position.Y - v26.OriginPoint.Y, 0);
		v26.CurrentHumanoidPosition = v26.Humanoid.RootPart.Position + v26.HumanoidOffsetFromPath;
		v26.CurrentHumanoidVelocity = v26.Humanoid.RootPart.Velocity;
		v26.SeatedConn = v26.Humanoid.Seated:Connect(function(p30, p31)
			v26:OnPathInterrupted();
		end);
		v26.DiedConn = v26.Humanoid.Died:Connect(function()
			v26:OnPathInterrupted();
		end);
		v26.TeleportedConn = v26.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
			v26:OnPathInterrupted();
		end);
		v26.CurrentPoint = 1;
		v26:OnPointReached(true);
	end;
	local v50, v51 = l__Workspace__6:FindPartOnRayWithIgnoreList(Ray.new(v26.TargetPoint + v26.TargetSurfaceNormal * 1.5, Vector3.new(0, -1, 0) * 50), u16());
	if v50 then
		v26.TargetPoint = v51;
	end;
	v26:ComputePath();
	return v26;
end;
local function u25(p32, p33, p34, p35, p36)
	if u17 then
		u20();
	end;
	u17 = p32;
	p32:Start(p36);
	u18 = p32.Finished.Event:Connect(function()
		u20();
		if p34 then
			local v52 = u21(p35);
			if v52 then
				v52:Activate();
			end;
		end;
	end);
	u19 = p32.PathFailed.Event:Connect(function()
		u20();
		if p36 == nil or p36 then
			if u22 and (not u17 or not u17:IsActive()) then
				u13.PlayFailureAnimation();
			end;
			u13.DisplayFailureWaypoint(p33);
		end;
	end);
end;
local function u26(p37)
	if u17 and u17:IsActive() then
		u17:Cancel();
	end;
	if u22 then
		u13.PlayFailureAnimation();
	end;
	u13.DisplayFailureWaypoint(p37);
end;
function OnTap(p38, p39, p40)
	local l__CurrentCamera__53 = l__Workspace__6.CurrentCamera;
	local l__Character__54 = l__LocalPlayer__3.Character;
	if not u23() then
		return;
	end;
	if #p38 ~= 1 then
		if p39 then
			if l__CurrentCamera__53 then
				local v55 = l__CurrentCamera__53:ScreenPointToRay(p38[1].x, p38[1].y);
				local v56 = u2(l__LocalPlayer__3);
				local v57, v58, v59 = v11.Raycast(Ray.new(v55.Origin, v55.Direction * 1000), true, u16());
				local v60, v61 = v11.FindCharacterAncestor(v57);
				if p40 then
					if v61 then
						if l__StarterGui__5:GetCore("AvatarContextMenuEnabled") then
							if l__Players__3:GetPlayerFromCharacter(v61.Parent) then
								u20();
								return;
							end;
						end;
					end;
				end;
				if p39 then
					v58 = p39;
					v60 = nil;
				end;
				if v58 then
					if l__Character__54 then
						u20();
						local v62 = u24(v58, v59);
						if v62:IsValidPath() then
							u25(v62, v58, v60, l__Character__54);
							return;
						else
							v62:Cleanup();
							u26(v58);
							return;
						end;
					end;
				end;
			end;
		elseif 2 <= #p38 then
			if l__CurrentCamera__53 then
				local v63 = u21(l__Character__54);
				if v63 then
					v63:Activate();
				end;
			end;
		end;
	elseif l__CurrentCamera__53 then
		v55 = l__CurrentCamera__53:ScreenPointToRay(p38[1].x, p38[1].y);
		v56 = u2(l__LocalPlayer__3);
		v57, v58, v59 = v11.Raycast(Ray.new(v55.Origin, v55.Direction * 1000), true, u16());
		v60, v61 = v11.FindCharacterAncestor(v57);
		if p40 then
			if v61 then
				if l__StarterGui__5:GetCore("AvatarContextMenuEnabled") then
					if l__Players__3:GetPlayerFromCharacter(v61.Parent) then
						u20();
						return;
					end;
				end;
			end;
		end;
		if p39 then
			v58 = p39;
			v60 = nil;
		end;
		if v58 then
			if l__Character__54 then
				u20();
				v62 = u24(v58, v59);
				if v62:IsValidPath() then
					u25(v62, v58, v60, l__Character__54);
					return;
				else
					v62:Cleanup();
					u26(v58);
					return;
				end;
			end;
		end;
	end;
end;
local v64 = require(script.Parent:WaitForChild("Keyboard"));
local v65 = setmetatable({}, v64);
v65.__index = v65;
function v65.new(p41)
	local v66 = setmetatable(v64.new(p41), v65);
	v66.fingerTouches = {};
	v66.numUnsunkTouches = 0;
	v66.mouse1Down = tick();
	v66.mouse1DownPos = Vector2.new();
	v66.mouse2DownTime = tick();
	v66.mouse2DownPos = Vector2.new();
	v66.mouse2UpTime = tick();
	v66.keyboardMoveVector = u10;
	v66.tapConn = nil;
	v66.inputBeganConn = nil;
	v66.inputChangedConn = nil;
	v66.inputEndedConn = nil;
	v66.humanoidDiedConn = nil;
	v66.characterChildAddedConn = nil;
	v66.onCharacterAddedConn = nil;
	v66.characterChildRemovedConn = nil;
	v66.renderSteppedConn = nil;
	v66.menuOpenedConnection = nil;
	v66.running = false;
	v66.wasdEnabled = false;
	return v66;
end;
local function u27(p42)
	if p42 then
		p42:Disconnect();
	end;
end;
function v65.DisconnectEvents(p43)
	u27(p43.tapConn);
	u27(p43.inputBeganConn);
	u27(p43.inputChangedConn);
	u27(p43.inputEndedConn);
	u27(p43.humanoidDiedConn);
	u27(p43.characterChildAddedConn);
	u27(p43.onCharacterAddedConn);
	u27(p43.renderSteppedConn);
	u27(p43.characterChildRemovedConn);
	u27(p43.menuOpenedConnection);
end;
function v65.OnTouchBegan(p44, p45, p46)
	if p44.fingerTouches[p45] == nil and not p46 then
		p44.numUnsunkTouches = p44.numUnsunkTouches + 1;
	end;
	p44.fingerTouches[p45] = p46;
end;
function v65.OnTouchChanged(p47, p48, p49)
	if p47.fingerTouches[p48] == nil then
		p47.fingerTouches[p48] = p49;
		if not p49 then
			p47.numUnsunkTouches = p47.numUnsunkTouches + 1;
		end;
	end;
end;
function v65.OnTouchEnded(p50, p51, p52)
	if p50.fingerTouches[p51] ~= nil and p50.fingerTouches[p51] == false then
		p50.numUnsunkTouches = p50.numUnsunkTouches - 1;
	end;
	p50.fingerTouches[p51] = nil;
end;
local u28 = {
	[Enum.KeyCode.W] = true, 
	[Enum.KeyCode.A] = true, 
	[Enum.KeyCode.S] = true, 
	[Enum.KeyCode.D] = true, 
	[Enum.KeyCode.Up] = true, 
	[Enum.KeyCode.Down] = true
};
function v65.OnCharacterAdded(p53, p54)
	p53:DisconnectEvents();
	p53.inputBeganConn = l__UserInputService__1.InputBegan:Connect(function(p55, p56)
		if p55.UserInputType == Enum.UserInputType.Touch then
			p53:OnTouchBegan(p55, p56);
		end;
		if p53.wasdEnabled and p56 == false and p55.UserInputType == Enum.UserInputType.Keyboard and u28[p55.KeyCode] then
			u20();
			u13.CancelFailureAnimation();
		end;
		if p55.UserInputType == Enum.UserInputType.MouseButton1 then
			p53.mouse1DownTime = tick();
			p53.mouse1DownPos = p55.Position;
		end;
		if p55.UserInputType == Enum.UserInputType.MouseButton2 then
			p53.mouse2DownTime = tick();
			p53.mouse2DownPos = p55.Position;
		end;
	end);
	p53.inputChangedConn = l__UserInputService__1.InputChanged:Connect(function(p57, p58)
		if p57.UserInputType == Enum.UserInputType.Touch then
			p53:OnTouchChanged(p57, p58);
		end;
	end);
	p53.inputEndedConn = l__UserInputService__1.InputEnded:Connect(function(p59, p60)
		if p59.UserInputType == Enum.UserInputType.Touch then
			p53:OnTouchEnded(p59, p60);
		end;
		if p59.UserInputType == Enum.UserInputType.MouseButton2 then
			p53.mouse2UpTime = tick();
			local l__Position__67 = p59.Position;
			if p53.mouse2UpTime - p53.mouse2DownTime < 0.25 and (l__Position__67 - p53.mouse2DownPos).magnitude < 5 and (u17 or p53.keyboardMoveVector.Magnitude <= 0) then
				OnTap({ l__Position__67 });
			end;
		end;
	end);
	p53.tapConn = l__UserInputService__1.TouchTap:Connect(function(p61, p62)
		if not p62 then
			OnTap(p61, nil, true);
		end;
	end);
	p53.menuOpenedConnection = l__GuiService__8.MenuOpened:Connect(function()
		u20();
	end);
	local function u29(p63)
		if l__UserInputService__1.TouchEnabled and p63:IsA("Tool") then
			p63.ManualActivationOnly = true;
		end;
		if p63:IsA("Humanoid") then
			u27(p53.humanoidDiedConn);
			p53.humanoidDiedConn = p63.Died:Connect(function()

			end);
		end;
	end;
	p53.characterChildAddedConn = p54.ChildAdded:Connect(function(p64)
		u29(p64);
	end);
	p53.characterChildRemovedConn = p54.ChildRemoved:Connect(function(p65)
		if l__UserInputService__1.TouchEnabled and p65:IsA("Tool") then
			p65.ManualActivationOnly = false;
		end;
	end);
	for v68, v69 in pairs(p54:GetChildren()) do
		u29(v69);
	end;
end;
function v65.Start(p66)
	p66:Enable(true);
end;
function v65.Stop(p67)
	p67:Enable(false);
end;
function v65.CleanupPath(p68)
	u20();
end;
function v65.Enable(p69, p70, p71, p72)
	if p70 then
		if not p69.running then
			if l__LocalPlayer__3.Character then
				p69:OnCharacterAdded(l__LocalPlayer__3.Character);
			end;
			p69.onCharacterAddedConn = l__LocalPlayer__3.CharacterAdded:Connect(function(p73)
				p69:OnCharacterAdded(p73);
			end);
			p69.running = true;
		end;
		p69.touchJumpController = p72;
		if p69.touchJumpController then
			p69.touchJumpController:Enable(p69.jumpEnabled);
		end;
	else
		if p69.running then
			p69:DisconnectEvents();
			u20();
			if l__UserInputService__1.TouchEnabled then
				local l__Character__70 = l__LocalPlayer__3.Character;
				if l__Character__70 then
					for v71, v72 in pairs(l__Character__70:GetChildren()) do
						if v72:IsA("Tool") then
							v72.ManualActivationOnly = false;
						end;
					end;
				end;
			end;
			p69.running = false;
		end;
		if p69.touchJumpController and not p69.jumpEnabled then
			p69.touchJumpController:Enable(true);
		end;
		p69.touchJumpController = nil;
	end;
	if l__UserInputService__1.KeyboardEnabled and p70 ~= p69.enabled then
		p69.forwardValue = 0;
		p69.backwardValue = 0;
		p69.leftValue = 0;
		p69.rightValue = 0;
		p69.moveVector = u10;
		if p70 then
			p69:BindContextActions();
			p69:ConnectFocusEventListeners();
		else
			p69:UnbindContextActions();
			p69:DisconnectFocusEventListeners();
		end;
	end;
	p69.wasdEnabled = p70 and p71 or false;
	p69.enabled = p70;
end;
function v65.OnRenderStepped(p74, p75)
	p74.isJumping = false;
	if u17 then
		u17:OnRenderStepped(p75);
		if u17 then
			p74.moveVector = u17.NextActionMoveDirection;
			p74.moveVectorIsCameraRelative = false;
			if u17.NextActionJump then
				p74.isJumping = true;
			end;
		else
			p74.moveVector = p74.keyboardMoveVector;
			p74.moveVectorIsCameraRelative = true;
		end;
	else
		p74.moveVector = p74.keyboardMoveVector;
		p74.moveVectorIsCameraRelative = true;
	end;
	if p74.jumpRequested then
		p74.isJumping = true;
	end;
end;
function v65.UpdateMovement(p76, p77)
	if p77 == Enum.UserInputState.Cancel then
		p76.keyboardMoveVector = u10;
		return;
	end;
	if p76.wasdEnabled then
		p76.keyboardMoveVector = Vector3.new(p76.leftValue + p76.rightValue, 0, p76.forwardValue + p76.backwardValue);
	end;
end;
function v65.UpdateJump(p78)

end;
function v65.SetShowPath(p79, p80)
	u12 = p80;
end;
function v65.GetShowPath(p81)
	return u12;
end;
function v65.SetWaypointTexture(p82, p83)
	u13.SetWaypointTexture(p83);
end;
function v65.GetWaypointTexture(p84)
	return u13.GetWaypointTexture();
end;
function v65.SetWaypointRadius(p85, p86)
	u13.SetWaypointRadius(p86);
end;
function v65.GetWaypointRadius(p87)
	return u13.GetWaypointRadius();
end;
function v65.SetEndWaypointTexture(p88, p89)
	u13.SetEndWaypointTexture(p89);
end;
function v65.GetEndWaypointTexture(p90)
	return u13.GetEndWaypointTexture();
end;
function v65.SetWaypointsAlwaysOnTop(p91, p92)
	u13.SetWaypointsAlwaysOnTop(p92);
end;
function v65.GetWaypointsAlwaysOnTop(p93)
	return u13.GetWaypointsAlwaysOnTop();
end;
function v65.SetFailureAnimationEnabled(p94, p95)
	u22 = p95;
end;
function v65.GetFailureAnimationEnabled(p96)
	return u22;
end;
local function u30(p97)
	if p97 == u4 then
		return;
	end;
	if u5 then
		u5:Disconnect();
		u5 = nil;
	end;
	if u6 then
		u6:Disconnect();
		u6 = nil;
	end;
	u4 = p97;
	u7 = { u8() };
	if u4 ~= nil then
		for v73, v74 in ipairs((l__CollectionService__7:GetTagged(u4))) do
			table.insert(u7, v74);
		end;
		u5 = l__CollectionService__7:GetInstanceAddedSignal(u4):Connect(function(p98)
			table.insert(u7, p98);
		end);
		u6 = l__CollectionService__7:GetInstanceRemovedSignal(u4):Connect(function(p99)
			for v75 = 1, #u7 do
				if u7[v75] == p99 then
					u7[v75] = u7[#u7];
					table.remove(u7);
					return;
				end;
			end;
		end);
	end;
end;
function v65.SetIgnoredPartsTag(p100, p101)
	u30(p101);
end;
function v65.GetIgnoredPartsTag(p102)
	return u4;
end;
function v65.SetUseDirectPath(p103, p104)
	u9 = p104;
end;
function v65.GetUseDirectPath(p105)
	return u9;
end;
function v65.SetAgentSizeIncreaseFactor(p106, p107)
	u11 = 1 + p107 / 100;
end;
function v65.GetAgentSizeIncreaseFactor(p108)
	return (u11 - 1) * 100;
end;
function v65.SetUnreachableWaypointTimeout(p109, p110)
	u14 = p110;
end;
function v65.GetUnreachableWaypointTimeout(p111)
	return u14;
end;
function v65.SetUserJumpEnabled(p112, p113)
	p112.jumpEnabled = p113;
	if p112.touchJumpController then
		p112.touchJumpController:Enable(p113);
	end;
end;
function v65.GetUserJumpEnabled(p114)
	return p114.jumpEnabled;
end;
function v65.MoveTo(p115, p116, p117, p118)
	local l__Character__76 = l__LocalPlayer__3.Character;
	if l__Character__76 == nil then
		return false;
	end;
	local v77 = u24(p116, Vector3.new(0, 1, 0), p118);
	if not v77 or not v77:IsValidPath() then
		return false;
	end;
	u25(v77, p116, nil, l__Character__76, p117);
	return true;
end;
return v65;
