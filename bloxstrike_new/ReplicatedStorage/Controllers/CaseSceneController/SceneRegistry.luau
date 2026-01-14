-- game.ReplicatedStorage.Controllers.CaseSceneController.SceneRegistry

local v1 = {}
local v_u2 = {}
local v3 = {
	["AssetFolder"] = "CaseScene",
	["InteractionType"] = "Click",
	["Animations"] = {
		["CaseFall"] = "rbxassetid://91366765923171",
		["CloseIdle"] = "rbxassetid://96896409518629",
		["CaseOpening"] = "rbxassetid://100000665946048",
		["OpenIdle"] = "rbxassetid://127592440292292"
	},
	["Sounds"] = {
		["Drop"] = "Case Fall",
		["Opening"] = "Case Opening"
	}
}
v_u2.Default = v3
local v4 = {
	["AssetFolder"] = "CharmScene",
	["InteractionType"] = "Drag",
	["Animations"] = {
		["PackOpening"] = "rbxassetid://97837283629886"
	},
	["DragSettings"] = {
		["Threshold"] = 0.5,
		["EndKeyframe"] = "DragEndPoint"
	},
	["Sounds"] = {
		["DragStart"] = "Charm Drag Start",
		["DragLoop"] = "Charm Drag Loop"
	}
}
v_u2.CharmCapsule = v4
local v5 = {
	["AssetFolder"] = "PackageScene",
	["InteractionType"] = "Click",
	["Animations"] = {
		["CaseFall"] = "rbxassetid://134599478765866",
		["CloseIdle"] = "rbxassetid://119593507010060",
		["CaseOpening"] = "rbxassetid://97681949800792"
	}
}
local v6 = {
	["CaseFall"] = {
		["Drop"] = "Package Drop"
	},
	["CaseOpening"] = {
		["RightTape"] = "Package Right Tape",
		["LeftTape"] = "Package Left Tape",
		["FrontLid"] = "Package Front Lid",
		["FinalOpen"] = "Package Final Open"
	}
}
v5.AnimationKeyframeSounds = v6
v_u2.Package = v5
local v_u7 = {
	["Case"] = "Default",
	["Sticker Capsule"] = "Default",
	["Charm Capsule"] = "CharmCapsule",
	["Package"] = "Package"
}
function v1.GetSceneForCaseType(arg1)
	-- upvalues: (copy) v_u7
	return v_u7[arg1] or "Default"
end
function v1.GetConfig(arg1)
	-- upvalues: (copy) v_u2
	return v_u2[arg1]
end
function v1.GetAllSceneNames()
	-- upvalues: (copy) v_u2
	local v1 = {}
	for v2 in v_u2 do
		table.insert(v1, v2)
	end
	return v1
end
function v1.RegisterScene(arg1, arg2)
	-- upvalues: (copy) v_u2
	v_u2[arg1] = arg2
end
function v1.RegisterCaseTypeMapping(arg1, arg2)
	-- upvalues: (copy) v_u7
	v_u7[arg1] = arg2
end
return v1