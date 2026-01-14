-- game.ReplicatedStorage.Database.Custom.GameStats.UI.Inventory.Sort

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Controllers.DataController)
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_replicatedstorage.Database.Components.Libraries.Cases)
local v_u5 = require(v_replicatedstorage.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u6 = {
	["Forbidden"] = 7,
	["Special"] = 6,
	["Red"] = 5,
	["Pink"] = 4,
	["Purple"] = 3,
	["Blue"] = 2,
	["Stock"] = 1
}
local v_u7 = {
	["Sticker Capsule"] = 14,
	["Charm Capsule"] = 13,
	["Music Kit"] = 8,
	["Graffiti"] = 11,
	["Grenade"] = 16,
	["Sticker"] = 10,
	["Zeus x27"] = 3,
	["Charm"] = 9,
	["Melee"] = 1,
	["Glove"] = 2,
	["Badge"] = 7,
	["Case"] = 12,
	["C4"] = 15
}
local v_u8 = {
	["Melee"] = 1,
	["Glove"] = 2,
	["Case"] = 3,
	["Charm Capsule"] = 4,
	["Sticker Capsule"] = 4
}
local v_u9 = {
	["Miscellaneous"] = 18,
	["Equipment"] = 17,
	["Pistol"] = 3,
	["Rifle"] = 6,
	["Heavy"] = 5,
	["SMG"] = 4
}
local v_u10 = {
	["Pistols"] = 1,
	["Mid Tier"] = 2,
	["Rifles"] = 3
}
local v_u11 = {
	["Equipped Melee"] = 1,
	["Equipped Gloves"] = 2,
	["Equipped Badge"] = 3,
	["Equipped Music Kit"] = 4,
	["Equipped Graffiti"] = 5,
	["Equipped Zeus x27"] = 6
}
local function v_u12(arg1, arg2)
	-- upvalues: (copy) v_u5, (copy) v_u4, (copy) v_u3
	if v_u5.IsCapsule(arg1) then
		return "Capsules"
	end
	if arg1.Type ~= "Case" then
		if not (arg1.Name and arg1.Skin) then
			return nil
		end
		local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
		return v_getskininformation and v_getskininformation.collection or nil
	end
	if not arg1.Skin then
		return nil
	end
	local v_getcasebyname = v_u4.GetCaseByName(arg1.Skin)
	if not v_getcasebyname then
		return nil
	end
	if arg2 then
		arg2 = arg2()
	end
	if not arg2 then
		return nil
	end
	for _, v1 in ipairs(arg2) do
		if v1.cases then
			for _, v2 in ipairs(v1.cases) do
				if v2 == v_getcasebyname.name then
					return v1.name
				end
			end
		end
	end
	return nil
end
local function v_u13(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u10, (copy) v_u11
	local v1 = nil
	local v_get = v_u1.Get(arg2, "Loadout")
	if not v_get then
		return nil
	end
	for _, v2 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
		local v3 = v_get[v2]
		if v3 and v3.Loadout then
			for v4, v5 in pairs(v_u10) do
				if v5 and (v3.Loadout[v4] and v3.Loadout[v4].Options) then
					for v6, v7 in ipairs(v3.Loadout[v4].Options) do
						if v7 == arg1 then
							local v8 = v5 * 1000 + v6
							if not v1 or v8 < v1 then
								v1 = v8
							end
						end
					end
				end
			end
			if v3.Equipped then
				for v9, v10 in pairs(v3.Equipped) do
					if v10 == arg1 then
						local v11 = v_u11[v9] or 99
						if not v1 or v11 < v1 then
							v1 = v11
						end
					end
				end
			end
		end
	end
	return v1
end
return {
	["GetSortComparisonFunction"] = function(arg1, arg2, arg3)
		-- upvalues: (copy) v_u12, (copy) v_u5, (copy) v_u8, (copy) v_u3, (copy) v_u6, (copy) v_u13, (copy) v_u7, (copy) v_u2, (copy) v_u9
		return arg1 == "Alphabetical" and function(arg1, arg2)
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2
				if arg1.Type == "Case" then
					v2 = arg1.Skin or ""
				else
					v2 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
				end
				local v3
				if arg2.Type == "Case" then
					v3 = arg2.Skin or ""
				else
					v3 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
				end
				if v2 == v3 then
					local v4 = arg1.MetaData and (arg1.MetaData.CreatedAt or 0) or 0
					local v5 = arg2.MetaData and (arg2.MetaData.CreatedAt or 0) or 0
					if v4 == v5 then
						return (arg1._id or "") < (arg2._id or "")
					else
						return v5 < v4
					end
				else
					return v2 < v3
				end
			else
				return v1
			end
		end or (arg1 == "Collection" and function(arg1, arg2)
			-- upvalues: (ref) v_u12, (copy) arg3, (ref) v_u5, (ref) v_u8, (ref) v_u3, (ref) v_u6
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u12(arg1, arg3) or ""
				local v3 = v_u12(arg2, arg3) or ""
				if v2 == v3 then
					local v_geteffectiveitemtype = v_u5.GetEffectiveItemType(arg1)
					local v_geteffectiveitemtype = v_u5.GetEffectiveItemType(arg2)
					local v4 = v_u8[v_geteffectiveitemtype] or 4
					local v5 = v_u8[v_geteffectiveitemtype] or 4
					if v4 == v5 then
						local v6
						if arg1.Name and arg1.Skin then
							v6 = v_u3.GetSkinInformation(arg1.Name, arg1.Skin) or nil
						else
							v6 = nil
						end
						local v7
						if arg2.Name and arg2.Skin then
							v7 = v_u3.GetSkinInformation(arg2.Name, arg2.Skin) or nil
						else
							v7 = nil
						end
						local v8 = v6 and v_u6[v6.rarity] or 0
						local v9 = v7 and v_u6[v7.rarity] or 0
						if v8 == v9 then
							local v10
							if arg1.Type == "Case" then
								v10 = arg1.Skin or ""
							else
								v10 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
							end
							local v11
							if arg2.Type == "Case" then
								v11 = arg2.Skin or ""
							else
								v11 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
							end
							if v10 == v11 then
								return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
							else
								return v10 < v11
							end
						else
							return v9 < v8
						end
					else
						return v4 < v5
					end
				else
					return v2 < v3
				end
			else
				return v1
			end
		end or (arg1 == "Equipped" and function(arg1, arg2)
			-- upvalues: (ref) v_u13, (copy) arg2
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2
				if arg1._id then
					v2 = v_u13(arg1._id, arg2) or nil
				else
					v2 = nil
				end
				local v3
				if arg2._id then
					v3 = v_u13(arg2._id, arg2) or nil
				else
					v3 = nil
				end
				if v2 ~= nil == (v3 ~= nil) then
					if v2 and v3 then
						if v2 == v3 then
							local v4
							if arg1.Type == "Case" then
								v4 = arg1.Skin or ""
							else
								v4 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
							end
							local v5
							if arg2.Type == "Case" then
								v5 = arg2.Skin or ""
							else
								v5 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
							end
							if v4 == v5 then
								return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
							else
								return v4 < v5
							end
						else
							return v2 < v3
						end
					else
						local v6
						if arg1.Type == "Case" then
							v6 = arg1.Skin or ""
						else
							v6 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
						end
						local v7
						if arg2.Type == "Case" then
							v7 = arg2.Skin or ""
						else
							v7 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
						end
						if v6 == v7 then
							return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
						else
							return v6 < v7
						end
					end
				else
					return v2 ~= nil
				end
			else
				return v1
			end
		end or (arg1 == "Newest" and function(arg1, arg2)
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = arg1.MetaData and (arg1.MetaData.CreatedAt or 0) or 0
				local v3 = arg2.MetaData and (arg2.MetaData.CreatedAt or 0) or 0
				if v2 == v3 then
					local v4
					if arg1.Type == "Case" then
						v4 = arg1.Skin or ""
					else
						v4 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
					end
					local v5
					if arg2.Type == "Case" then
						v5 = arg2.Skin or ""
					else
						v5 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
					end
					if v4 == v5 then
						return (arg1._id or "") < (arg2._id or "")
					else
						return v4 < v5
					end
				else
					return v3 < v2
				end
			else
				return v1
			end
		end or (arg1 == "Quality" and function(arg1, arg2)
			-- upvalues: (ref) v_u3, (ref) v_u6
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2
				if arg1.Name and arg1.Skin then
					v2 = v_u3.GetSkinInformation(arg1.Name, arg1.Skin) or nil
				else
					v2 = nil
				end
				local v3
				if arg2.Name and arg2.Skin then
					v3 = v_u3.GetSkinInformation(arg2.Name, arg2.Skin) or nil
				else
					v3 = nil
				end
				local v4 = v2 and v_u6[v2.rarity] or 0
				local v5 = v3 and v_u6[v3.rarity] or 0
				if v4 == v5 then
					local v6
					if arg1.Type == "Case" then
						v6 = arg1.Skin or ""
					else
						v6 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
					end
					local v7
					if arg2.Type == "Case" then
						v7 = arg2.Skin or ""
					else
						v7 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
					end
					if v6 == v7 then
						return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
					else
						return v6 < v7
					end
				else
					return v5 < v4
				end
			else
				return v1
			end
		end or (arg1 == "Type" and function(arg1, arg2)
			-- upvalues: (ref) v_u5, (ref) v_u7, (ref) v_u2, (ref) v_u9
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v_geteffectiveitemtype = v_u5.GetEffectiveItemType(arg1)
				local v_geteffectiveitemtype = v_u5.GetEffectiveItemType(arg2)
				local v2 = v_u7[v_geteffectiveitemtype]
				local v3
				if v2 or v_geteffectiveitemtype ~= "Weapon" then
					v3 = v2 or 99
				elseif arg1.Name then
					local v4, v5 = pcall(v_u2, arg1.Name)
					v3 = v4 and (v5 and v5.Type) and (v_u9[v5.Type] or 99) or 99
				else
					v3 = 99
				end
				local v6 = v_u7[v_geteffectiveitemtype]
				local v7
				if v6 or v_geteffectiveitemtype ~= "Weapon" then
					v7 = v6 or 99
				elseif arg2.Name then
					local v8, v9 = pcall(v_u2, arg2.Name)
					v7 = v8 and (v9 and v9.Type) and (v_u9[v9.Type] or 99) or 99
				else
					v7 = 99
				end
				if v3 == v7 then
					local v10
					if arg1.Type == "Case" then
						v10 = arg1.Skin or ""
					else
						v10 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
					end
					local v11
					if arg2.Type == "Case" then
						v11 = arg2.Skin or ""
					else
						v11 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
					end
					if v10 == v11 then
						return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
					else
						return v10 < v11
					end
				else
					return v3 < v7
				end
			else
				return v1
			end
		end or nil)))))
	end
}