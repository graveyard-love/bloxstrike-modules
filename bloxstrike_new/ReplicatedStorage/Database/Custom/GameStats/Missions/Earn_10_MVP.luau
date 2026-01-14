-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Earn 10 MVP

local v1 = {
	["MissionId"] = "Earn 10 MVP",
	["Target"] = 10,
	["Type"] = "daily",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 12
		}
	}
}
return table.freeze(v1)