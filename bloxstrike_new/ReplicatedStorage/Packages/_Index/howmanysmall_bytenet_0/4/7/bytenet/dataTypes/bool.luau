-- game.ReplicatedStorage.Packages._Index.howmanysmall_bytenet@0.4.7.bytenet.dataTypes.bool

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u2 = {
	["Read"] = function(arg1, arg2)
		return buffer.readu8(arg1, arg2) == 1, 1
	end,
	["Length"] = 1,
	["Write"] = v1.writebool
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end