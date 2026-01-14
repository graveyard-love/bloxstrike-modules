-- game.ReplicatedStorage.Database.Custom.GameStats.Missions.Plant or defuse the bomb 1 time

local v1 = {
	["MissionId"] = "Plant Or Defuse The Bomb 1 Time",
	["Target"] = 1,
	["Type"] = "hourly",
	["Rewards"] = {
		{
			["type"] = "Credits",
			["amount"] = 2
		}
	}
}
return table.freeze(v1)