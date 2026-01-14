-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Get 600 Rifle Kills

local v1 = {
	["MissionId"] = "Get 600 Rifle Kills",
	["Target"] = 600,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 135
		}
	}
}
return table.freeze(v1)