-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 2 assists

local v1 = {
	["MissionId"] = "Get 2 Assists",
	["Target"] = 2,
	["Type"] = "hourly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 1
		}
	}
}
return table.freeze(v1)