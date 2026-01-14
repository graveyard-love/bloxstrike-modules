-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Deal 6700 Damage

local v1 = {
	["MissionId"] = "Deal 6700 Damage",
	["Target"] = 6700,
	["Type"] = "daily",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 10
		}
	}
}
return table.freeze(v1)