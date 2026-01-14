-- game.ReplicatedStorage.Packages._Index.howmanysmall_bytenet@0.4.7.bytenet.namespaces.packetIDs

local v_u1 = {}
return {
	["set"] = function(arg1, arg2)
		-- upvalues: (copy) v_u1
		v_u1[arg1] = arg2
	end,
	["ref"] = function()
		-- upvalues: (copy) v_u1
		return v_u1
	end
}