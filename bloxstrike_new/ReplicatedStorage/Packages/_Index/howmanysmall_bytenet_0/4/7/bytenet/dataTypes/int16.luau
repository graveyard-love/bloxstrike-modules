-- game.ReplicatedStorage.Packages._Index.howmanysmall_bytenet@0.4.7.bytenet.dataTypes.int16

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u2 = {
	["Write"] = v1.writei16,
	["Read"] = function(arg1, arg2)
		return buffer.readi16(arg1, arg2), 2
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end