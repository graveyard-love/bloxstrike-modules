-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Dictionary.withKeys

return function(arg1, ...)
	local v1 = {}
	for _, v2 in ipairs({ ... }) do
		v1[v2] = arg1[v2]
	end
	return v1
end