-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Deal 200000 Damage

local v1 = {
	["MissionId"] = "Deal 200000 Damage",
	["Target"] = 200000,
	["Type"] = "monthly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 135
		}
	}
}
return table.freeze(v1)