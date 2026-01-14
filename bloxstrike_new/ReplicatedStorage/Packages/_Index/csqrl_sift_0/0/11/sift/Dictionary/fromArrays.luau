-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Dictionary.fromArrays

return function(arg1, arg2)
	local v1 = {}
	for v2 = 1, #arg1 do
		v1[arg1[v2]] = arg2[v2]
	end
	return v1
end