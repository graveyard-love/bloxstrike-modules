-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Set.isSubset

return function(arg1, arg2)
	for v1, v2 in pairs(arg1) do
		if arg2[v1] ~= v2 then
			return false
		end
	end
	return true
end