-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Array.reduceRight

return function(arg1, arg2, arg3)
	local v1 = #arg1
	if arg3 == nil then
		arg3 = arg1[v1]
		v1 = v1 - 1
	end
	for v2 = v1, 1, -1 do
		arg3 = arg2(arg3, arg1[v2], v2, arg1)
	end
	return arg3
end