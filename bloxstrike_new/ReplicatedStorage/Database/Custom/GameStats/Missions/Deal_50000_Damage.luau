-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Deal 50000 Damage

local v1 = {
	["MissionId"] = "Deal 50000 Damage",
	["Target"] = 50000,
	["Type"] = "weekly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 30
		}
	}
}
return table.freeze(v1)