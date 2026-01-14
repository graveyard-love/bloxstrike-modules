-- game.ReplicatedStorage.Database.Custom.GameStats.Character.Viewport

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local function v1(arg1)
	local v1 = {}
	for _, v2 in arg1:GetChildren() do
		if v2:IsA("Animation") then
			v1[v2.Name] = v2
		end
	end
	return v1
end
local v2 = {
	["VIEWPORT_CHARACTER_OFFSET"] = CFrame.new(0, 0.025, 0.4)
}
local v3 = {
	["CT"] = {
		["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
		["IdleAnimation"] = "rbxassetid://137360078752983",
		["CharacterOffset"] = CFrame.new(0, 0.025, 0.4),
		["Character"] = "IDF"
	},
	["T"] = {
		["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
		["IdleAnimation"] = "rbxassetid://99540873384647",
		["CharacterOffset"] = CFrame.new(0, 0.025, 0.4),
		["Character"] = "Anarchist"
	}
}
v2.VIEWPORT_CHARACTER_CONFIG = v3
v2.ANIMATION_MAPPING = {
	["Sniper"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.Sniper),
	["Pistol"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.Pistol),
	["Heavy"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.Heavy),
	["Rifle"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.Rifle),
	["Melee"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.Melee),
	["LMG"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.LMG),
	["SMG"] = v1(v_replicatedstorage.Assets.UI.Loadout.Animations.SMG)
}
return table.freeze(v2)