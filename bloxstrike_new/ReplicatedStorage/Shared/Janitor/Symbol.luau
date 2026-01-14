-- game.ReplicatedStorage.Shared.Janitor.Symbol

return function(self)
	local v1 = newproxy(true)
	getmetatable(v1).__tostring = function()
		-- upvalues: (copy) self
		return self
	end
	return v1
end