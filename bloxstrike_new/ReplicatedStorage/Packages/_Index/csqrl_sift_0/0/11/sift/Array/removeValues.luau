-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Array.removeValues

local v_u1 = require(script.Parent.toSet)
return function(arg1, ...)
	-- upvalues: (copy) v_u1
	local v1 = v_u1({ ... })
	local v2 = {}
	for _, v3 in ipairs(arg1) do
		if not v1[v3] then
			table.insert(v2, v3)
		end
	end
	return v2
end