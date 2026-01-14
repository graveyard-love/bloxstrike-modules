-- game.ReplicatedStorage.Database.Custom.GameStats.Missions

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v_u2 = {}
function v1.GetMissionDefinition(arg1)
	-- upvalues: (copy) v_u2
	return v_u2[arg1]
end
for _, v3 in ipairs(script:GetChildren()) do
	if v3:IsA("ModuleScript") then
		local v4 = require(v3)
		v_u2[v4.MissionId] = v4
	end
end
return v1