-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Win 2 rounds

local v1 = {
	["MissionId"] = "Win 2 Rounds",
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