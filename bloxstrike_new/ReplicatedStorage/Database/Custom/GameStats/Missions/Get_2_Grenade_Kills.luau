-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 2 Grenade Kills

local v1 = {
	["MissionId"] = "Get 2 Grenade Kills",
	["Target"] = 2,
	["Type"] = "daily",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 12
		}
	}
}
return table.freeze(v1)