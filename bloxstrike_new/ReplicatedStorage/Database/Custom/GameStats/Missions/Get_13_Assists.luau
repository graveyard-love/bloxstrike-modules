-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 13 Assists

local v1 = {
	["MissionId"] = "Get 13 Assists",
	["Target"] = 13,
	["Type"] = "daily",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 8
		}
	}
}
return table.freeze(v1)