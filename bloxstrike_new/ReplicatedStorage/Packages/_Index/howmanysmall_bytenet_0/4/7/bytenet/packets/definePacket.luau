-- game.ReplicatedStorage.Packages._Index.howmanysmall_bytenet@0.4.7.bytenet.packets.definePacket

local v_u1 = require(script.Parent.packet)
require(script.Parent.Parent.types)
return function(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		return v_u1(self, arg1)
	end
end