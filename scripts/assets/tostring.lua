local module = {
    currentTableDepth = 0,
    maxTableDepth = 100,
}

local function toUnicode(string)
    local codepoints = "utf8.char("
    
    for _i, v in utf8.codes(string) do
        codepoints = codepoints .. v .. ', '
    end
    
    return codepoints:sub(1, -3) .. ')'
end

function module.get_path(instance)
    local name = instance.Name
    local head = (#name > 0 and '.' .. name) or "['']"
    if not instance.Parent and instance ~= game then
        return head .. " --[[ Parented to nil ]]"
    end
    if instance == game then
        return "game"
    elseif instance == workspace then
        return "workspace"
    else
        local _success, result = pcall(game.GetService, game, instance.ClassName)
        
        if _success and result then
            head = ':GetService("' .. instance.ClassName .. '")'
        elseif instance == game.Players.LocalPlayer then
            head = '.LocalPlayer' 
        else    
            local nonAlphaNum = name:gsub('[%w_]', '')
            local noPunct = nonAlphaNum:gsub('[%s%p]', '')
            
            if tonumber(name:sub(1, 1)) or (#nonAlphaNum ~= 0 and #noPunct == 0) then
                head = '["' .. name:gsub('"', '\\"'):gsub('\\', '\\\\') .. '"]'
            elseif #nonAlphaNum ~= 0 and #noPunct > 0 then
                head = '[' .. toUnicode(name) .. ']'
            end
        end
    end
    return module.get_path(instance.Parent) .. head
end

function module.table_to_string(t) 
    module.currentTableDepth = module.currentTableDepth + 1
    if module.currentTableDepth > module.maxTableDepth+1 then
        module.currentTableDepth = module.currentTableDepth - 1
        return "table_over_maxTableDepth (.."..tostring(t)..")"
    end
    local returnStr = "{"
    for i,v in next, t do
        returnStr = returnStr.."\n"..(("    "):rep(module.currentTableDepth)).."["..module.get_real_value(i).."] = "..module.get_real_value(v)..","
    end
    if returnStr:sub(-2) == ", " then returnStr = returnStr:sub(1, -3) end
    module.currentTableDepth = module.currentTableDepth - 1
    return returnStr.."\n"..(("    "):rep(module.currentTableDepth)).."}"
end

function module.get_real_value(value)
    local _t = typeof(value)
    if _t == 'Instance' then
        return module.get_path(value)
    elseif _t == 'string' then
        return value
    elseif _t == 'table' then 
        return module.table_to_string(value)
    elseif _t == 'function' then
        local functiontable = {
            Name = debug.getinfo(value).name,
            Source = decompile(value),
            Upvalues = module.get_real_value(debug.getupvalues(value)),
            Constants = module.get_real_value(debug.getconstants(value)),
            Protos = module.get_real_value(debug.getprotos(value)),
        }
        return module.get_real_value(functiontable)
    elseif _t == 'UDim2' or _t == 'UDim' or _t == 'Vector3' or _t == 'Vector2' or _t == 'CFrame' or _t == 'Vector2int16' or _t == 'Vector3int16' or _t == 'BrickColor' or _t == 'Color3' then
        local value = _t == 'BrickColor' and "'"..tostring(value).."'" or value
        return _t..".new("..tostring(value)..")"
    elseif _t == 'TweenInfo' then
        return "TweenInfo.new("..module.get_real_value(value.Time)..", "..module.get_real_value(value.EasingStyle)..", "..module.get_real_value(value.EasingDirection)..", "..module.get_real_value(value.RepeatCount)..", "..module.get_real_value(value.Reverses)..", "..module.get_real_value(value.DelayTime)..")"
    elseif _t == 'Enums' then
        return "Enum"
    elseif _t == 'Enum' then
        return "Enum."..tostring(value)
    elseif _t == 'Axes' or _t == 'Faces' then
        local returnStr = _t..".new("
        local normals = Enum.NormalId:GetEnumItems()
        for i,v in next, normals do
            if value[v.Name] then
                returnStr = returnStr..module.get_real_value(v)..", "
            end
        end
        return returnStr:sub(1, -3)..")"
    elseif _t == 'ColorSequence' then
        local returnStr = "ColorSequence.new{"
        local keypoints = value.Keypoints
        for i,v in next, keypoints do 
            returnStr = returnStr..module.get_real_value(v)..", "
        end
        return returnStr:sub(1, -3).."}"
    elseif _t == 'ColorSequenceKeypoint' then
        return "ColorSequenceKeypoint.new("..tostring(value.Time)..", "..module.get_real_value(value.Value)..")"
    elseif _t == 'DockWidgetPluginGuiInfo' then -- // this was a pain to make \\
        local str = ""
        local split1 = tostring(value):split(":")
        for i,v in next, split1 do 
            str = str..v.." "
        end
        local split2 = str:split(" ") 
        local str = ""
        local reali = 0
        for i,v in next, split2 do
            if math.floor(i/2) == i/2 and v~=" " then
                reali = reali + 1
                local _v = v
                if reali == 1 then 
                    _v = "Enum.InitialDockState."..v
                end
                str = str.._v..", "
            end
        end
        return "DockWidgetPluginGuiInfo.new("..(str:sub(1, -3))..")"
    elseif _t == 'DateTime' then
		if value.UnixTimestampMillis == DateTime.now().UnixTimestampMillis then
            return "DateTime.now()"
        end
        return "DateTime.fromUnixTimestampMillis("..value.UnixTimestampMillis..")"
    elseif _t == 'FloatCurveKey' then
        return "FloatCurveKey.new("..module.get_real_value(value.Time)..", "..module.get_real_value(value.Value)..", "..module.get_real_value(value.Interpolation)..")"
    elseif _t == 'NumberRange' then
        return "NumberRange.new("..module.get_real_value(value.Min)..", "..module.get_real_value(value.Max)..")"
    elseif _t == 'NumberSequence' then
        local returnStr = "NumberSequence.new{"
        local keypoints = value.Keypoints
        for i,v in next, keypoints do 
            returnStr = returnStr..module.get_real_value(v)..", "
        end
        return returnStr:sub(1, -3).."}"
    elseif _t == 'NumberSequenceKeypoint' then
        return "NumberSequenceKeypoint.new("..tostring(value.Time)..", "..module.get_real_value(value.Value)..(value.Envelope and ", "..value.Envelope or "")..")"
    elseif _t == 'PathWaypoint' then
        return "PathWaypoint.new("..module.get_real_value(value.Position)..", "..module.get_real_value(value.Action)..")"
    elseif _t == 'PhysicalProperties' then
        return "PhysicalProperties.new("..module.get_real_value(value.Density)..", "..module.get_real_value(value.Friction)..", "..module.get_real_value(value.Elasticity)..", "..module.get_real_value(value.FrictionWeight)..", "..module.get_real_value(value.ElasticityWeight)..")"
    elseif _t == 'Random' then
        return "Random.new()"
    elseif _t == 'Ray' then
        return "Ray.new("..module.get_real_value(value.Origin)..", "..module.get_real_value(value.Direction)..")"
    elseif _t == 'RaycastParams' then
        return "--[[typeof: RaycastParams ->]] {FilterDescendantsInstances = "..module.get_real_value(value.FilterDescendantsInstances)..", FilterType = "..module.get_real_value(value.FilterType)..", IgnoreWater = "..module.get_real_value(value.IgnoreWater)..", CollisionGroup = '"..module.get_real_value(value.CollisionGroup).."'}"
    elseif _t == 'RaycastResult' then
        return "--[[typeof: RaycastResult ->]] {Distance = " ..module.get_real_value(value.Distance)..", Instance = "..module.get_real_value(value.Instance)..", Material = "..module.get_real_value(value.Material)..", Position = "..module.get_real_value(value.Position)..", Normal = "..module.get_real_value(value.Normal).."}"
    elseif _t == 'RBXScriptConnection' then
        return "--[[typeof: RBXScriptConnection ->]] {Connected = "..module.get_real_value(value.Connected).."}"
    elseif _t == 'RBXScriptSignal' then
        return "RBXScriptSignal"
    elseif _t == 'Rect' then
        return "Rect.new("..module.get_real_value(value.Min)..", "..module.get_real_value(value.Max)..")"
    elseif _t == 'Region3' then
        local cframe = value.CFrame
        local size = value.Size
        local min = module.get_real_value((cframe * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)).p)
        local max = module.get_real_value((cframe * CFrame.new(size.X/2, size.Y/2, size.Z/2)).p)
        return "Region3.new("..min..", "..max..")"
    elseif _t == 'Region3int16' then
        return "Region3int16.new("..module.get_real_value(value.Min)..", "..module.get_real_value(value.Max)..")"
    elseif _t == 'CatalogSearchParams' then
        return "--[[typeof: CatalogSearchParams ->]] {SearchKeyword = "..module.get_real_value(value.SearchKeyword)..", MinPrice = "..module.get_real_value(value.MinPrice)..", MaxPrice = "..module.get_real_value(value.MaxPrice)..", SortType = "..module.get_real_value(value.SortType)..", CategoryFilter = "..module.get_real_value(value.CategoryFilter)..", AssetTypes = "..module.get_real_value(value.AssetTypes).."}"
    elseif _t == 'OverlapParams' then
        return "--[[typeof: OverlapParams ->]] {FilterDescendantsInstances = "..module.get_real_value(value.FilterDescendantsInstances)..", FilterType = "..module.get_real_value(value.FilterType)..", MaxParts ="..module.get_real_value(value.MaxParts)..", CollisionGroup = "..module.get_real_value(value.CollisionGroup).."}"
    elseif _t == 'userdata' then
        return "newproxy(true)"
    elseif value == nil then
        return "nil"
    end
    return tostring(value)
end
module.tabletostring = module.get_real_value


--// test:
--print((module.tabletostring({"what an", {"amazing"}, "test", "here", {["Hello"] = "World"}})))

return module