-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 2 headshots

local v1 = {
	["MissionId"] = "Get 2 Headshots",
	["Target"] = 2,
	["Type"] = "hourly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 2
		}
	}
}
return table.freeze(v1)