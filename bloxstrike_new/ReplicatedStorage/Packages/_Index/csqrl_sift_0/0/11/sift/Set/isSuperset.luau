-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Set.isSuperset

local v_u1 = require(script.Parent.isSubset)
return function(arg1, arg2)
	-- upvalues: (copy) v_u1
	return v_u1(arg2, arg1)
end