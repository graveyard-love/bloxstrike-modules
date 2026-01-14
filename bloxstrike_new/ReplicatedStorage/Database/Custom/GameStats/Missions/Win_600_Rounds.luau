-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Win 600 Rounds

local v1 = {
	["MissionId"] = "Win 600 Rounds",
	["Target"] = 600,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 150
		}
	}
}
return table.freeze(v1)