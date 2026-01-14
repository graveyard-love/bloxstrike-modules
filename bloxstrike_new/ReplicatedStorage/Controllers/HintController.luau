-- game.ReplicatedStorage.Controllers.HintController

local v_u1 = {}
local v_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u2 = require(v_replicatedstorage.Database.Components.GameState)
local v_u3 = require(script.Parent.InputController)
local v_u4 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u6 = nil
local v_u7 = nil
local v_hints = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Hints")
local v_u_static = v_hints:WaitForChild("Static")
local v_u_ranged = v_hints:WaitForChild("Ranged")
local v_u8 = {
	["Inspect"] = {
		["Type"] = "Static",
		["Action"] = "Inspect",
		["Blurb"] = "Inspect"
	},
	["Reload"] = {
		["Type"] = "Static",
		["Action"] = "Reload",
		["Blurb"] = "Reload your Weapon!"
	},
	["Use"] = {
		["Type"] = "Static",
		["Action"] = "Use"
	},
	["Plant"] = {
		["Type"] = "Ranged",
		["Action"] = "Plant",
		["Blurb"] = "Plant the Bomb!",
		["HideDistance"] = 5
	},
	["Defuse"] = {
		["Type"] = "Ranged",
		["Action"] = "Defuse",
		["Blurb"] = "Defuse the Bomb!",
		["HideDistance"] = 5
	},
	["Rescue"] = {
		["Type"] = "Ranged",
		["Action"] = "Rescue",
		["Blurb"] = "Rescue the Hostage!",
		["HideDistance"] = 5
	},
	["Return"] = {
		["Type"] = "Ranged",
		["Action"] = "Return",
		["Blurb"] = "Return the Hostage",
		["HideDistance"] = 5
	}
}
local function v_u9(arg1, arg2)
	local v1 = {}
	for _, v2 in ipairs(arg1:GetDescendants()) do
		if v2:IsA("BasePart") and v2:GetAttribute("Site") == arg2 then
			table.insert(v1, v2)
		end
	end
	return v1
end
function isOnScreen(arg1)
	-- upvalues: (copy) v_u_current_camera
	local v_worldtoviewportpoint, v1 = v_u_current_camera:WorldToViewportPoint(arg1)
	local v_viewportsize = v_u_current_camera.ViewportSize
	if v1 then
		if v_worldtoviewportpoint.X < 100 or (v_worldtoviewportpoint.X > v_viewportsize.X - 100 or (v_worldtoviewportpoint.Y < 100 or v_worldtoviewportpoint.Y > v_viewportsize.Y - 100)) then
			return false, v_worldtoviewportpoint
		else
			return true, v_worldtoviewportpoint
		end
	else
		return false, v_worldtoviewportpoint
	end
end
local function v_u10()
	-- upvalues: (ref) v_u6, (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u1
	if v_u6 and (v_u6.ui and v_u6.target) then
		local v_icon = v_u6.ui:FindFirstChild("Icon")
		local v_arrow = v_u6.ui:FindFirstChild("Arrow")
		local v_attention = v_u6.ui:FindFirstChild("Attention")
		if v_icon and (v_arrow and v_attention) then
			local v_cframe = v_u_current_camera.CFrame
			local v_viewportsize = v_u_current_camera.ViewportSize
			if v_u6.target and v_u6.target.Parent then
				local v_position = v_u6.target.Position
				local v_character = v_u_localplayer.Character
				if v_character then
					local v_humanoidrootpart = v_character:FindFirstChild("HumanoidRootPart")
					if v_humanoidrootpart and (v_humanoidrootpart.Position - v_position).Magnitude <= (v_u6.hideDistance or 5) then
						local v1 = v_u6 and v_u6.ui
						if v1 then
							v1 = v_u6.ui:GetAttribute("Type")
						end
						v_u1:clearHint()
						if v1 then
							if v1 == "Defuse" then
								v_u1:createHint("Use", nil, "Defuse the Bomb!")
								task.delay(3, function()
									-- upvalues: (ref) v_u1
									v_u1:clearHint("Use")
								end)
							elseif v1 == "Rescue" then
								v_u1:createHint("Use", nil, "Rescue the Hostage!")
								task.delay(3, function()
									-- upvalues: (ref) v_u1
									v_u1:clearHint("Use")
								end)
							end
						else
							return
						end
					end
				end
				local v2, v3 = isOnScreen(v_position)
				if v2 then
					v_u6.ui.BackgroundTransparency = 0.5
					v_u6.ui.Position = UDim2.new(0, v3.X, 0, v3.Y - 60)
					v_u6.ui.AnchorPoint = Vector2.new(0.5, 0.5)
					v_attention.Size = UDim2.new(0.75, 0, 0.75, 0)
					v_attention.Visible = true
					v_arrow.Visible = false
					v_icon.Visible = false
					v_u6.ui.Visible = true
				else
					v_u6.ui.BackgroundTransparency = 1
					local v_new = Vector2.new(v_viewportsize.X / 2, v_viewportsize.Y / 2)
					local v_dot = (v_position - v_cframe.Position).Unit:Dot(v_cframe.RightVector)
					local v_atan2 = math.atan2(-UNNAMED_2189145574648:Dot(v_cframe.UpVector), v_dot)
					local v4 = math.min(v_viewportsize.X, v_viewportsize.Y) / 2 - 60
					v_u6.ui.Position = UDim2.new(0, v_new.X + math.cos(v_atan2) * v4, 0, v_new.Y + math.sin(v_atan2) * v4)
					v_u6.ui.AnchorPoint = Vector2.new(0.5, 0.5)
					v_arrow.Visible = true
					v_arrow.Position = UDim2.new(0.5, 0, 0.5, 0)
					v_arrow.AnchorPoint = Vector2.new(0.5, 0.5)
					v_arrow.Rotation = math.deg(v_atan2) - 90
					local v5 = v_atan2 + 3.141592653589793
					v_icon.Position = UDim2.new(0.5, math.cos(v5) * 55, 0.5, math.sin(v5) * 55)
					v_icon.Visible = true
					v_attention.Visible = false
					v_u6.ui.Visible = true
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u11(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u4, (ref) v_u7, (copy) v_u_run, (copy) v_u10
	if arg1 and arg2 then
		if arg1:FindFirstChild("Left") and arg1:FindFirstChild("Right") then
			arg1.Left.BackgroundColor3 = v_u4()
			arg1.Right.BackgroundColor3 = v_u4()
			if arg2.Type == "Static" then
				local v_controlicon = arg1:FindFirstChild("ControlIcon")
				local v_instructions = arg1:FindFirstChild("Instructions")
				if v_controlicon and v_instructions then
					local v_keycapicon = v_controlicon:FindFirstChild("KeycapIcon")
					if v_keycapicon then
						local v_control = v_keycapicon:FindFirstChild("Control")
						if v_control then
							arg1:SetAttribute("Type", arg2.Action)
							v_instructions.Text = arg5 or arg2.Blurb
							v_control.Text = arg3 or "???"
						end
					else
						return
					end
				else
					return
				end
			else
				if arg2.Type == "Ranged" then
					local v_icon = arg1:FindFirstChild("Icon")
					local v_arrow = arg1:FindFirstChild("Arrow")
					local v_attention = arg1:FindFirstChild("Attention")
					local v_instructions = v_attention:FindFirstChild("Instructions")
					if not (v_icon and (v_arrow and (v_attention and (arg4 and v_instructions)))) then
						return
					end
					v_instructions.Text = arg2.Blurb
					if v_u7 then
						v_u7:Disconnect()
						v_u7 = nil
					end
					v_u7 = v_u_run.RenderStepped:Connect(v_u10)
				end
				return
			end
		else
			arg1:Destroy()
			return
		end
	else
		return
	end
end
function v_u1.getKeyOfAction(_, arg2)
	-- upvalues: (copy) v_u3
	if arg2 then
		return v_u3.GetActionKeybind(arg2)
	end
end
function v_u1.createHint(_, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2, (copy) v_u8, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u_static, (copy) v_u11, (ref) v_u6, (copy) v_u_ranged
	if v_u2.GetState() == "Round In Progress" then
		if arg2 and v_u8[arg2] then
			v_u1:clearHint()
			local v1 = v_u8[arg2]
			local v_playergui = v_u_localplayer:FindFirstChild("PlayerGui")
			if v_playergui then
				local v_maingui = v_playergui:FindFirstChild("MainGui")
				if v_maingui then
					local v_gameplay = v_maingui:WaitForChild("Gameplay")
					if v_gameplay then
						local v_middle = v_gameplay:WaitForChild("Middle")
						if v_middle then
							if v1.Type == "Static" then
								local v_clone = v_u_static:Clone()
								v_u11(v_clone, v1, v_u1:getKeyOfAction(arg2), nil, arg4)
								v_u6 = {
									["ui"] = v_clone,
									["target"] = nil,
									["hintType"] = arg2,
									["hideDistance"] = nil
								}
								v_clone:SetAttribute("Type", arg2)
								v_clone.Parent = v_middle
								v_clone.Visible = true
							elseif v1.Type == "Ranged" and arg3 then
								local v_clone = v_u_ranged:Clone()
								v_u6 = {
									["ui"] = v_clone,
									["target"] = arg3,
									["hintType"] = arg2,
									["hideDistance"] = v1.HideDistance or 5
								}
								v_u11(v_clone, v1, nil, arg3)
								v_clone:SetAttribute("Type", arg2)
								v_clone.Parent = v_middle
								v_clone.Visible = true
							end
						else
							return
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.clearHint(_, arg2)
	-- upvalues: (ref) v_u6, (ref) v_u7
	if arg2 then
		if v_u6 and v_u6.hintType == arg2 then
			if v_u6.ui then
				v_u6.ui:Destroy()
			end
			if v_u7 then
				v_u7:Disconnect()
				v_u7 = nil
			end
			v_u6 = nil
		end
	elseif v_u6 then
		if v_u6.ui then
			v_u6.ui:Destroy()
		end
		if v_u7 then
			v_u7:Disconnect()
			v_u7 = nil
		end
		v_u6 = nil
	end
end
v5.Hints.BombSiteEntered.Listen(function(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u_collection, (copy) v_u1
	if arg1 and (arg1.action and arg1.site) then
		local v_map = workspace:FindFirstChild("Map")
		if v_map then
			local v_zones = v_map:FindFirstChild("Zones")
			if v_zones then
				local v_sites = v_zones:FindFirstChild("Sites")
				if v_sites then
					local v1 = v_u9(v_sites, arg1.site)
					if arg1.action == "Defuse" then
						local v_bomb = v_u_collection:GetTagged("Bomb")
						if #v_bomb == 1 and (v1 and #v1 > 0) then
							local v2 = v1[math.random(1, #v1)]
							local v3 = v_bomb[1].PrimaryPart or v2
							if v2 then
								v_u1:createHint(arg1.action, v3)
							end
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end)
v5.Hints.ClearHint.Listen(function()
	-- upvalues: (copy) v_u1
	v_u1:clearHint("Rescue")
	v_u1:clearHint("UseRescue")
end)
v5.Character.CharacterDied.Listen(function()
	-- upvalues: (copy) v_u1
	v_u1:clearHint()
end)
v_u2.ListenToState(function(_, arg2)
	-- upvalues: (copy) v_u1
	if arg2 ~= "Round In Progress" then
		v_u1:clearHint()
	end
end)
local function v_u12()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_collection
	if not (v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character.PrimaryPart)) then
		return nil, (1 / 0)
	end
	local v_hostage = v_u_collection:GetTagged("Hostage")
	if not v_hostage or #v_hostage <= 0 then
		return nil, (1 / 0)
	end
	local v_position = v_u_localplayer.Character.PrimaryPart.Position
	local v1 = (1 / 0)
	local v2 = nil
	for _, v3 in ipairs(v_hostage) do
		if v3.PrimaryPart and v3:GetAttribute("CanRescue") then
			local v_magnitude = (v3.PrimaryPart.Position - v_position).Magnitude
			if v_magnitude < v1 then
				v2 = v3
				v1 = v_magnitude
			end
		end
	end
	return v2, v1
end
local function v_u13()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u6, (copy) v_u1, (copy) v_u_collection, (copy) v_u12
	if v_u2.GetState() == "Round In Progress" then
		local v_team = v_u_localplayer:GetAttribute("Team")
		if v_team then
			v_team = v_u_localplayer:GetAttribute("Team") == "Counter-Terrorists"
		end
		if v_team then
			if v_u_localplayer:GetAttribute("IsCarryingHostage") == true then
				if v_u6 and (v_u6.hintType == "Rescue" or v_u6.hintType == "UseRescue") then
					v_u1:clearHint()
				end
				local v_map = workspace:FindFirstChild("Map")
				if v_map then
					local v_zones = v_map:FindFirstChild("Zones")
					local v1 = v_zones and v_zones:FindFirstChild("Hints")
					if v1 then
						local v2 = {}
						for _, v3 in ipairs(v1:GetChildren()) do
							if v3:IsA("BasePart") then
								table.insert(v2, v3)
							end
						end
						if #v2 > 0 and (v_u_localplayer.Character and v_u_localplayer.Character.PrimaryPart) then
							local v_position = v_u_localplayer.Character.PrimaryPart.Position
							local v4 = (1 / 0)
							local v5 = nil
							for _, v6 in ipairs(v2) do
								local v_magnitude = (v6.Position - v_position).Magnitude
								if v_magnitude < v4 then
									v5 = v6
									v4 = v_magnitude
								end
							end
							if v5 and (not v_u6 or (v_u6.hintType ~= "Return" or v_u6.target ~= v5)) then
								v_u1:clearHint()
								v_u1:createHint("Return", v5)
							end
						end
					end
				end
				return
			else
				local v_hostage = v_u_collection:GetTagged("Hostage")
				if v_hostage and #v_hostage > 0 then
					local v7, v8 = v_u12()
					if v_u6 and (v_u6.hintType == "Rescue" or v_u6.hintType == "UseRescue") then
						if v_u6.target and v7 then
							if v8 >= 50 then
								v_u1:clearHint()
								return
							end
							if v_u6.target ~= v7.PrimaryPart and (v8 < (v_u_localplayer.Character.PrimaryPart.Position - v_u6.target.Position).Magnitude - 10 and v8 < 50) then
								v_u1:clearHint()
								v_u1:createHint("Rescue", v7.PrimaryPart)
								return
							end
						elseif not v7 or v8 >= 50 then
							v_u1:clearHint()
						end
					elseif v7 and v8 < 50 then
						v_u1:createHint("Rescue", v7.PrimaryPart)
					end
				else
					if v_u6 and (v_u6.hintType == "Rescue" or v_u6.hintType == "UseRescue") then
						v_u1:clearHint()
					end
					return
				end
			end
		else
			return
		end
	else
		return
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u13
	while true do
		v_u13()
		task.wait(2)
	end
end)
return v_u1