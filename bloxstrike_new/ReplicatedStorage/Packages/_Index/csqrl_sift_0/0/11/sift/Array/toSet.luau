-- game.ReplicatedStorage.Packages._Index.csqrl_sift@0.0.11.sift.Array.toSet

require(script.Parent.Parent.Types)
return function(arg1)
	local v1 = {}
	for _, v2 in ipairs(arg1) do
		v1[v2] = true
	end
	return v1
end