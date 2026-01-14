-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 200 Multi-Kills

local v1 = {
	["MissionId"] = "Get 200 Multi-Kills",
	["Target"] = 200,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 165
		}
	}
}
return table.freeze(v1)