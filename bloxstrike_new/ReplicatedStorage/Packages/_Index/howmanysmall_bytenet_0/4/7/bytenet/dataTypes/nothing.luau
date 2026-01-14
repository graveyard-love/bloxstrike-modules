-- game.ReplicatedStorage.Packages._Index.howmanysmall_bytenet@0.4.7.bytenet.dataTypes.nothing

require(script.Parent.Parent.types)
local v_u1 = {
	["Write"] = function() end,
	["Read"] = function()
		return nil, 0
	end
}
return function()
	-- upvalues: (copy) v_u1
	return v_u1
end