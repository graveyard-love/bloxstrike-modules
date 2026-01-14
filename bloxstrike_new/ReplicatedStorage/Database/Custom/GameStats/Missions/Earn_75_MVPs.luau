-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Earn 75 MVPs

local v1 = {
	["MissionId"] = "Earn 75 MVPs",
	["Target"] = 75,
	["Type"] = "weekly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 40
		}
	}
}
return table.freeze(v1)