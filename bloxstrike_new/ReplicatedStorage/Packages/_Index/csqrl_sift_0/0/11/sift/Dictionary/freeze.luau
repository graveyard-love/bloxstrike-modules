-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Dictionary.freeze

require(script.Parent.Parent.Types)
local v_u1 = require(script.Parent.copy)
return function(arg1)
	-- upvalues: (copy) v_u1
	local v1 = v_u1(arg1)
	table.freeze(v1)
	return v1
end