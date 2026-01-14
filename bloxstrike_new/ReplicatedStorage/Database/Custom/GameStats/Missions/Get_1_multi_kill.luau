-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 1 multi-kill

local v1 = {
	["MissionId"] = "Get 1 Multi-Kill",
	["Target"] = 1,
	["Type"] = "hourly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 2
		}
	}
}
return table.freeze(v1)