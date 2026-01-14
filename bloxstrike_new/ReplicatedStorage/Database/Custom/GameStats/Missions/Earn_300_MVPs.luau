-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Earn 300 MVPs

local v1 = {
	["MissionId"] = "Earn 300 MVPs",
	["Target"] = 300,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 175
		}
	}
}
return table.freeze(v1)