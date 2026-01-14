-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Deal 700 Damage

local v1 = {
	["MissionId"] = "Deal 700 Damage",
	["Target"] = 700,
	["Type"] = "hourly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 1
		}
	}
}
return table.freeze(v1)