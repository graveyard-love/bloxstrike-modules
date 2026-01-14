-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Array.unshift

return function(arg1, ...)
	local v1 = { ... }
	for _, v2 in ipairs(arg1) do
		table.insert(v1, v2)
	end
	return v1
end