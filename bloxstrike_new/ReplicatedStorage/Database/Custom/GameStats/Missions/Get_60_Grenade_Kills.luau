-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 60 Grenade Kills

local v1 = {
	["MissionId"] = "Get 60 Grenade Kills",
	["Target"] = 60,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 160
		}
	}
}
return table.freeze(v1)