-- game.ReplicatedStorage.Interface.Screens.Gameplay.Middle.BuyMenu

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_u_replicatedstorage.Controllers.EndScreenController)
local v_u4 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u5 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u6 = require(v_u_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u7 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u8 = require(v_u_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u9 = require(v_u_replicatedstorage.Database.Components.Common.IsInBuyArea)
local v_u10 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u11 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u12 = require(v_u_replicatedstorage.Packages.Observers)
local v13 = require(v_u_replicatedstorage.Shared.Janitor)
local v14 = require(v_u_replicatedstorage.Shared.Spring)
local v_u15 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u16 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u17 = require(v_u_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u_characters = v_u_replicatedstorage.Assets.Characters
local v_u18 = require(v_u_replicatedstorage.Database.Custom.GameStats.NumberSlots)
local v_u19 = require(v_u_replicatedstorage.Database.Custom.GameStats.Character.Attachments)
local v_u20 = require(v_u_replicatedstorage.Database.Custom.GameStats.Character.Viewport)
local v_u21 = require(v_u_replicatedstorage.Shared.ViewportModel)
local v_u_new = v13.new()
local v_u_new = v13.new()
local v_u_new = v14.new(1, 8, 0)
local v_u22 = nil
local v_u23 = nil
local v_u24 = nil
local v_u25 = nil
local v_u26 = nil
local v_u27 = nil
local v_u28 = nil
local v_u29 = {}
local v_u30 = nil
local v_u31 = nil
local function v_u32()
	-- upvalues: (ref) v_u30, (copy) v_u1
	for _, v1 in ipairs(v_u30.Menu.Container:GetDescendants()) do
		if v1:IsA("TextButton") and v1.Parent.Name ~= "Equipment" then
			v_u1.setupTemplate(v1, (("Loadout.%*.Options.%*"):format(v1.Parent.Name, (tonumber(v1.Name)))))
		end
	end
end
local function v_u33(arg1, arg2)
	for _, v1 in ipairs(arg1) do
		for _, v2 in ipairs(v1._items) do
			if v2.Name == arg2 then
				return v2
			end
		end
	end
	return false
end
local function v_u34(arg1, arg2)
	local v1 = 0
	for _, v2 in ipairs(arg1) do
		for _, v3 in ipairs(v2._items) do
			if v3.Name == arg2 then
				v1 = v1 + 1
			end
		end
	end
	return v1
end
local function v_u35(arg1, arg2)
	local v_getattribute = arg1:GetAttribute(arg2)
	while not v_getattribute do
		v_getattribute = arg1:GetAttribute(arg2)
		task.wait()
	end
	return v_getattribute
end
function v_u1.purchase(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u9, (copy) v_u17, (copy) v_u2, (copy) v_u18, (copy) v_u_replicatedstorage, (copy) v_u29, (copy) v_u16, (copy) v_u15
	local v_money = v_u_localplayer:GetAttribute("Money")
	if v_u9(v_u_localplayer) then
		local v1 = not arg4
		if v1 then
			v1 = v_u17[arg1] ~= nil
		end
		local v2 = v1 and v_u2.getCurrentInventory()
		if v2 then
			local v3 = v2[v_u18.Grenade]
			if v3 and #v3._items >= v3._settings._strict_slot_space then
				return
			end
		end
		if not arg4 then
			local v_gamemode = workspace:GetAttribute("Gamemode")
			if v_u_localplayer:GetAttribute("BuyMenu") and (v_gamemode == "Hostage Rescue" or v_gamemode == "Bomb Defusal") then
				local v_getcurrentinventory = v_u2.getCurrentInventory()
				local v4 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(arg1) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(arg1)
				local v5
				if v4 then
					v5 = require(v4)
				else
					v5 = nil
				end
				local v6 = v_u18[v5.Slot]
				if v_getcurrentinventory and v5 then
					local v7 = v_getcurrentinventory[v6]
					if v7 and #v7._items > 0 then
						local v8 = v7._items[1]
						if table.find(v_u29, v8.Identifier) then
							local v_name = v8.Name
							local v9 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_name) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_name)
							local v10
							if v9 then
								v10 = require(v9)
							else
								v10 = nil
							end
							if v10 then
								arg3 = arg3 - v10.Cost
							end
						end
					end
				end
			end
		end
		if v_money and arg3 <= v_money then
			v_u16.broadcastRouter("RunInterfaceSound", "Successful Buy Menu Purchase")
			v_u15.Inventory.BuyMenuPurchase.Send({
				["Equipment"] = arg4,
				["Name"] = arg1,
				["Path"] = arg2 or ""
			})
		end
	end
end
function v_u1.createTemplate(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u8, (copy) v_u2, (copy) v_u34, (copy) v_u17, (copy) v_u11, (copy) v_u_new, (copy) v_u16, (copy) v_u33, (copy) v_u_tween, (ref) v_u24, (copy) v_u1, (copy) v_u9, (copy) v_u15
	local v_name = arg2.Name
	local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_name) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_name)
	local v_u2
	if v1 then
		v_u2 = require(v1)
	else
		v_u2 = nil
	end
	if arg3 or not v_u2 then
		arg1.Visible = false
	else
		local v_gamemode = workspace:GetAttribute("Gamemode")
		arg1.Icon.Image = v_u2.ReverseIcon or v_u2.Icon
		arg1.Cost.Text = "$" .. tostring(v_u2.Cost):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		local v3 = tonumber(arg1.Name)
		arg1.Keybind.Text = tostring(v3)
		arg1.Cost.Visible = v_gamemode ~= "Deathmatch"
		arg1.LayoutOrder = tonumber(arg1.Name)
		arg1.ItemName.Text = arg2.Name
		arg1.Teammates.Visible = false
		arg1.Visible = true
		local v4 = v_u2.Cost > v_u_localplayer:GetAttribute("Money") and Color3.fromRGB(149, 149, 149) or v_u8()
		arg1.ItemName.TextColor3 = v4
		arg1.Keybind.TextColor3 = v4
		arg1.Icon.ImageColor3 = v4
		arg1.Cost.TextColor3 = v4
		arg1:SetAttribute("Weapon", arg2.Name)
		arg1:SetAttribute("IsEquipment", arg3)
		arg1:SetAttribute("InventoryItemId", arg2._id)
		local v_getcurrentinventory = v_u2.getCurrentInventory()
		local v5, v6
		if v_getcurrentinventory then
			v5 = v_u34(v_getcurrentinventory, arg2.Name) > 0
			local v_name = arg2.Name
			local v7 = v_u34(v_getcurrentinventory, v_name)
			local v8 = v_u17[v_name]
			if v8 then
				v6 = v7 < v8
			else
				v6 = v7 == 0
			end
		else
			v5 = false
			v6 = true
		end
		local v_return = arg1.Return
		local v9
		if v5 then
			if v_u11.GetState() == "Warmup" or v_gamemode == "Deathmatch" then
				v9 = false
			else
				local v10
				if arg1.Parent.Name == "Pistols" then
					v10 = arg1.Name == "1"
				else
					v10 = false
				end
				v9 = not v10
			end
		else
			v9 = v5
		end
		v_return.Visible = v9
		arg1.Hover.Visible = v5
		arg1.Hover.UIStroke.Transparency = v5 and not v6 and 0 or 1
		v_u_new:Add(arg1.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u16, (ref) v_u33, (copy) arg2, (copy) arg1, (ref) v_u_tween, (copy) arg3, (ref) v_u24
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			v_u16.broadcastRouter("RunInterfaceSound", "UI Highlight")
			if v_getcurrentinventory then
				if not v_u33(v_getcurrentinventory, arg2.Name) then
					arg1.Hover.UIStroke.Transparency = 1
					arg1.Hover.Visible = true
					v_u_tween:Create(arg1.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Transparency"] = 0.8
					}):Play()
				end
				local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				v_u_tween:Create(arg1.Icon, v_new, {
					["Size"] = UDim2.fromScale(0.7, 0.7)
				}):Play()
				if not arg3 then
					v_u24 = arg2._id
				end
			end
		end))
		v_u_new:Add(arg1.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u33, (copy) arg2, (copy) arg1, (ref) v_u_tween, (copy) arg3, (ref) v_u24
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				if not v_u33(v_getcurrentinventory, arg2.Name) then
					arg1.Hover.UIStroke.Transparency = 1
					arg1.Hover.Visible = false
				end
				local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				v_u_tween:Create(arg1.Icon, v_new, {
					["Size"] = UDim2.fromScale(0.75, 0.75)
				}):Play()
				if not arg3 and v_u24 == arg2._id then
					v_u24 = nil
				end
			end
		end))
		v_u_new:Add(arg1.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) arg1
			local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			v_u_tween:Create(arg1.Icon, v_new, {
				["Size"] = UDim2.fromScale(0.65, 0.65)
			}):Play()
		end))
		v_u_new:Add(arg1.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) arg1
			local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			v_u_tween:Create(arg1.Icon, v_new, {
				["Size"] = UDim2.fromScale(0.7, 0.7)
			}):Play()
		end))
		v_u_new:Add(arg1.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg2, (copy) arg4, (copy) v_u2, (copy) arg3
			v_u1.purchase(arg2.Name, arg4, v_u2.Cost, arg3)
		end))
		v_u_new:Add(arg1.Return.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u33, (copy) arg2, (ref) v_u9, (ref) v_u_localplayer, (ref) v_u15, (copy) arg3
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				local v1 = v_u33(v_getcurrentinventory, arg2.Name)
				if v1 and v_u9(v_u_localplayer) then
					v_u15.Inventory.ReturnBuyMenuPurchase.Send({
						["Identifier"] = v1.Identifier,
						["Equipment"] = arg3
					})
				end
			end
		end))
	end
end
function v_u1.setupTemplate(arg1, arg2)
	-- upvalues: (copy) v_u16, (copy) v_u_localplayer, (copy) v_u1
	local v_broadcastrouter = v_u16.broadcastRouter("GetEquippedInventoryItem", v_u_localplayer, arg2)
	if v_broadcastrouter and v_broadcastrouter.Name then
		v_u1.createTemplate(arg1, v_broadcastrouter, false, arg2)
	else
		arg1:SetAttribute("IsEquipment", nil)
		arg1:SetAttribute("Weapon", nil)
		arg1.Visible = false
	end
end
function v_u1.updateBuyMenuTemplate(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u8, (copy) v_u34, (copy) v_u17, (copy) v_u11, (copy) v_u_tween
	local v_isequipment = arg2:GetAttribute("IsEquipment")
	local v_weapon = arg2:GetAttribute("Weapon")
	if v_isequipment or not v_weapon then
		return
	else
		local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_weapon) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_weapon)
		local v2
		if v1 then
			v2 = require(v1)
		else
			v2 = nil
		end
		local v3 = v2 and v_u_localplayer:GetAttribute("Money")
		if v3 then
			local v4 = v3 < v2.Cost and Color3.fromRGB(149, 149, 149) or v_u8()
			arg2.ItemName.TextColor3 = v4
			arg2.Keybind.TextColor3 = v4
			arg2.Icon.ImageColor3 = v4
			arg2.Cost.TextColor3 = v4
		end
		if arg2.Visible then
			local v5 = v_u34(arg1, v_weapon) > 0
			local v6 = v_u34(arg1, v_weapon)
			local v7 = v_u17[v_weapon]
			local v8
			if v7 then
				v8 = v6 < v7
			else
				v8 = v6 == 0
			end
			local v_gamemode = workspace:GetAttribute("Gamemode")
			local v_return = arg2.Return
			local v9
			if v5 then
				if v_gamemode == "Deathmatch" or v_u11.GetState() == "Warmup" then
					v9 = false
				else
					local v10
					if arg2.Parent.Name == "Pistols" then
						v10 = arg2.Name == "1"
					else
						v10 = false
					end
					v9 = not v10
				end
			else
				v9 = v5
			end
			v_return.Visible = v9
			arg2.Hover.Visible = v5
			if v5 then
				v_u_tween:Create(arg2.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Transparency"] = v8 and 1 or 0
				}):Play()
			else
				arg2.Hover.UIStroke.Transparency = 1
			end
		else
			return
		end
	end
end
local function v_u36(arg1)
	-- upvalues: (ref) v_u26, (ref) v_u23, (ref) v_u22, (copy) v_u7, (copy) v_u20, (ref) v_u25, (copy) v_u19, (copy) v_u_replicatedstorage
	local v1 = v_u26
	if v1 then
		if arg1 and v_u23 == arg1._id then
			local v2 = v_u22
			if not (v2 and v2.IsPlaying) then
				local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
				local v3 = v_humanoid and v_humanoid:FindFirstChildOfClass("Animator")
				if v3 then
					local v4 = nil
					if arg1.Type == "Melee" then
						v4 = "Melee"
					else
						local v5, v6 = pcall(v_u7, arg1.Name)
						if v5 and v6 then
							local v_type = v6.Type
							local v_aimingoptions = v6.AimingOptions
							local v_muzzletype = v6.MuzzleType
							if v_type == nil then
								v4 = nil
							elseif v_aimingoptions == "SniperScope" then
								v4 = "Sniper"
							elseif v_type == "Heavy" then
								v4 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
							else
								v4 = ({
									["Pistol"] = "Pistol",
									["Rifle"] = "Rifle",
									["SMG"] = "SMG"
								})[v_type]
							end
						end
					end
					if v4 then
						local v_name = arg1.Name
						local v7
						if v4 and v_u20.ANIMATION_MAPPING[v4] then
							local v8 = v_u20.ANIMATION_MAPPING[v4]
							if v_name and v8[v_name] then
								v7 = v8[v_name]
							else
								v7 = v8.Default
							end
						else
							v7 = nil
						end
						if v7 then
							local v_loadanimation = v3:LoadAnimation(v7)
							v_loadanimation.Looped = true
							v_loadanimation.Priority = Enum.AnimationPriority.Action
							v_loadanimation:Play()
							v_u22 = v_loadanimation
						end
					end
				end
			end
			return
		else
			if v_u22 then
				v_u22:Stop()
				v_u22 = nil
			end
			if v_u25 then
				v_u25:Destroy()
				v_u25 = nil
			end
			v_u23 = nil
			for _, v9 in pairs({ v_u19.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
				local v10 = v1:FindFirstChild(v9)
				if v10 then
					for _, v11 in ipairs(v10:GetChildren()) do
						if v11:IsA("Motor6D") and (v11.Name == "WeaponAttachment" or (v11.Name == "WeaponAttachmentHandleR" or v11.Name == "WeaponAttachmentHandleL")) then
							v11:Destroy()
						end
					end
				end
			end
			for _, v12 in ipairs(v1:GetChildren()) do
				if v12:IsA("Model") and (v12 ~= v1 and v12.Name ~= "CharacterArmor") and (v12:FindFirstChild("Insert", true) or v12:FindFirstChild("Weapon", true)) then
					v12:Destroy()
				end
			end
			if arg1 then
				local v_getcharactermodel = require(v_u_replicatedstorage.Database.Components.Libraries.Skins).GetCharacterModel(arg1.Name, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag)
				if v_getcharactermodel then
					v_getcharactermodel.Name = arg1.Name
					local v13 = v1:FindFirstChild(v_u19.WEAPON_JOINT_PARTS[arg1.Name] or v_u19.DEFAULT_JOINT_PART)
					if v13 then
						if not v_getcharactermodel.PrimaryPart then
							local v_weapon = v_getcharactermodel:FindFirstChild("Weapon")
							if v_weapon then
								v_weapon = v_weapon:FindFirstChild("Insert")
							end
							if v_weapon then
								v_getcharactermodel.PrimaryPart = v_weapon
							else
								local v_insert = v_getcharactermodel:FindFirstChild("Insert", true)
								if v_insert then
									v_getcharactermodel.PrimaryPart = v_insert
								end
							end
						end
						if v_getcharactermodel.PrimaryPart then
							for _, v14 in ipairs(v_getcharactermodel:GetDescendants()) do
								if v14:IsA("BasePart") then
									v14.CanCollide = false
									v14.CanQuery = false
									v14.CanTouch = false
									v14.Anchored = false
									v14.Massless = true
								end
							end
							v_getcharactermodel.Parent = v1
							local v15, v16 = pcall(v_u7, arg1.Name)
							local v17
							if v15 and v16 then
								v17 = v16.ShootingOptions == "Dual"
							else
								v17 = false
							end
							local v_properties = v_getcharactermodel:FindFirstChild("Properties")
							if not v_properties then
								local v_weapon = v_getcharactermodel:FindFirstChild("Weapon")
								if v_weapon then
									v_properties = v_weapon:FindFirstChild("Properties")
								end
							end
							local v18 = v_properties or v_getcharactermodel:FindFirstChild("Properties", true)
							if v17 then
								local v_righthand = v1:FindFirstChild("RightHand")
								local v_lefthand = v1:FindFirstChild("LeftHand")
								if v_righthand and v_lefthand then
									local v_handler = v_getcharactermodel:FindFirstChild("HandleR", true)
									if v_handler then
										local v_motor6d = Instance.new("Motor6D")
										v_motor6d.Name = "WeaponAttachmentHandleR"
										v_motor6d.Part0 = v_righthand
										v_motor6d.Part1 = v_handler
										v_motor6d.Parent = v_righthand
										if v18 then
											local v_c0right = v18:FindFirstChild("C0RIGHT")
											if v_c0right then
												v_motor6d.C0 = v_c0right.Value
											end
											local v_c1right = v18:FindFirstChild("C1RIGHT")
											if v_c1right then
												v_motor6d.C1 = v_c1right.Value
											end
										end
									end
									local v_handlel = v_getcharactermodel:FindFirstChild("HandleL", true)
									if v_handlel then
										local v_motor6d = Instance.new("Motor6D")
										v_motor6d.Name = "WeaponAttachmentHandleL"
										v_motor6d.Part0 = v_lefthand
										v_motor6d.Part1 = v_handlel
										v_motor6d.Parent = v_lefthand
										if v18 then
											local v_c0left = v18:FindFirstChild("C0LEFT")
											if v_c0left then
												v_motor6d.C0 = v_c0left.Value
											end
											local v_c1left = v18:FindFirstChild("C1LEFT")
											if v_c1left then
												v_motor6d.C1 = v_c1left.Value
											end
										end
									end
								end
							else
								local v_motor6d = Instance.new("Motor6D")
								v_motor6d.Name = "WeaponAttachment"
								v_motor6d.Part0 = v13
								v_motor6d.Part1 = v_getcharactermodel.PrimaryPart
								v_motor6d.Parent = v13
								if v18 then
									local v_c0 = v18:FindFirstChild("C0")
									if v_c0 then
										v_motor6d.C0 = v_c0.Value
									end
									local v_c1 = v18:FindFirstChild("C1")
									if v_c1 then
										v_motor6d.C1 = v_c1.Value
									end
								end
							end
							v_u25 = v_getcharactermodel
							v_u23 = arg1._id
							local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
							if v_humanoid then
								local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
								if v_animator then
									local v19 = nil
									if arg1.Type == "Melee" then
										v19 = "Melee"
									elseif v16 then
										local v_type = v16.Type
										local v_aimingoptions = v16.AimingOptions
										local v_muzzletype = v16.MuzzleType
										if v_type == nil then
											v19 = nil
										elseif v_aimingoptions == "SniperScope" then
											v19 = "Sniper"
										elseif v_type == "Heavy" then
											v19 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
										else
											v19 = ({
												["Pistol"] = "Pistol",
												["Rifle"] = "Rifle",
												["SMG"] = "SMG"
											})[v_type]
										end
									else
										local v20, v21 = pcall(v_u7, arg1.Name)
										if v20 and v21 then
											local v_type = v21.Type
											local v_aimingoptions = v21.AimingOptions
											local v_muzzletype = v21.MuzzleType
											if v_type == nil then
												v19 = nil
											elseif v_aimingoptions == "SniperScope" then
												v19 = "Sniper"
											elseif v_type == "Heavy" then
												v19 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
											else
												v19 = ({
													["Pistol"] = "Pistol",
													["Rifle"] = "Rifle",
													["SMG"] = "SMG"
												})[v_type]
											end
										end
									end
									if v19 then
										local v_name = arg1.Name
										local v22
										if v19 and v_u20.ANIMATION_MAPPING[v19] then
											local v23 = v_u20.ANIMATION_MAPPING[v19]
											if v_name and v23[v_name] then
												v22 = v23[v_name]
											else
												v22 = v23.Default
											end
										else
											v22 = nil
										end
										if v22 then
											local v_loadanimation = v_animator:LoadAnimation(v22)
											v_loadanimation.Looped = true
											v_loadanimation.Priority = Enum.AnimationPriority.Action
											v_loadanimation:Play()
											v_u22 = v_loadanimation
										end
									end
								end
							else
								return
							end
						else
							v_getcharactermodel:Destroy()
							return
						end
					else
						v_getcharactermodel:Destroy()
						return
					end
				else
					return
				end
			else
				return
			end
		end
	else
		return
	end
end
local function v_u37()
	-- upvalues: (ref) v_u26, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u_replicatedstorage
	local v1 = v_u26
	if not v1 then
		return
	end
	local v_team = v_u_localplayer:GetAttribute("Team")
	if not v_team or v_team ~= "Counter-Terrorists" and v_team ~= "Terrorists" then
		return
	end
	local v2 = (v_team == "Counter-Terrorists" and "CT" or "T") == "CT" and "Counter-Terrorists" or "Terrorists"
	local v_get = v_u5.Get(v_u_localplayer, "Loadout")
	if not (v_get and v_get[v2]) then
		return
	end
	local v_equipped = v_get[v2].Equipped
	if v_equipped then
		v_equipped = v_get[v2].Equipped["Equipped Gloves"]
	end
	if not v_equipped then
		return
	end
	local v_get = v_u5.Get(v_u_localplayer, "Inventory")
	local v3 = nil
	if v_get and type(v_get) == "table" then
		for _, v4 in ipairs(v_get) do
			if v4 and v4._id == v_equipped then
				v3 = v4
				break
			end
		end
	end
	if v3 then
		local v_getgloves = require(v_u_replicatedstorage.Database.Components.Libraries.Skins).GetGloves(v3.Name, v3.Skin, v3.Float)
		if v_getgloves then
			local v5 = {
				["Right Arm"] = "RightHand",
				["Left Arm"] = "LeftHand"
			}
			local v6 = {
				["Right Arm"] = "RightGlove",
				["Left Arm"] = "LeftGlove"
			}
			for _, v7 in ipairs(v_getgloves:GetChildren()) do
				if v7:IsA("BasePart") then
					local v8 = v5[v7.Name]
					if v8 then
						local v9 = v1:FindFirstChild(v8)
						if v9 then
							local v_clone = v7:Clone()
							v_clone.Name = v6[v7.Name] or v7.Name
							v_clone.CastShadow = false
							v_clone.CanCollide = false
							v_clone.CanTouch = false
							v_clone.Anchored = false
							v_clone.CanQuery = false
							v_clone.CFrame = v9.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
							v_clone.Size = Vector3.new(v9.Size.X * 1.1, v9.Size.Z, v9.Size.Y) * 1.1
							v_clone.Parent = v1
							local v_motor6d = Instance.new("Motor6D")
							v_motor6d.Name = "GloveAttachment"
							v_motor6d.Part0 = v9
							v_motor6d.Part1 = v_clone
							v_motor6d.C0 = CFrame.new(0, 0, -0.025)
							v_motor6d.C1 = v_clone.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
							v_motor6d.Parent = v_clone
						end
					end
				end
			end
			v_getgloves:Destroy()
		end
	else
		return
	end
end
local function v_u38()
	-- upvalues: (copy) v_u5, (copy) v_u_localplayer, (ref) v_u24, (copy) v_u36, (copy) v_u2
	v_u5.WaitForDataLoaded(v_u_localplayer)
	if v_u24 then
		local v_get = v_u5.Get(v_u_localplayer, "Inventory")
		if v_get and type(v_get) == "table" then
			for _, v1 in ipairs(v_get) do
				if v1 and v1._id == v_u24 then
					v_u36(v1)
					return
				end
			end
		end
		return
	end
	local v_getcurrentinventory = v_u2.getCurrentInventory()
	local v_get = v_u5.Get(v_u_localplayer, "Inventory")
	if not v_getcurrentinventory or (not v_get or type(v_get) ~= "table") then
		return
	end
	local v8 = nil
	local v3 = v_getcurrentinventory[1]
	if v3 and (v3._items and #v3._items > 0) then
		local v4 = v3._items[1]
		if not (v4 and v4._id) then
			goto l16
		end
		local v__id = v4._id
		for _, v8 in ipairs(v_get) do
			if v8._id == v__id then
				goto l16
			end
		end
		v8 = nil
		goto l16
	else
		::l16::
		if v8 then
			::l26::
			if v8 then
				v_u36(v8)
			end
			return
		else
			local v6 = v_getcurrentinventory[2]
			if not v6 or (not v6._items or #v6._items <= 0) then
				goto l26
			end
			local v7 = v6._items[1]
			if not (v7 and v7._id) then
				goto l26
			end
			local v__id = v7._id
			for _, v8 in ipairs(v_get) do
				if v8._id == v__id then
					goto l26
				end
			end
			v8 = nil
			goto l26
		end
	end
end
local function v_u39()
	-- upvalues: (ref) v_u30, (copy) v_u_localplayer, (copy) v_u20, (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) v_u_characters, (copy) v_u_new, (copy) v_u21, (copy) v_u37, (copy) v_u38, (ref) v_u23, (ref) v_u22, (ref) v_u25
	local v_player = v_u30.Player
	if v_player then
		local v_team = v_u_localplayer:GetAttribute("Team")
		if v_team and (v_team == "Counter-Terrorists" or v_team == "Terrorists") then
			local v1 = v_u20.VIEWPORT_CHARACTER_CONFIG[v_team == "Counter-Terrorists" and "CT" or "T"]
			if v1 then
				if v_u26 and v_u26.Parent then
					return
				else
					if v_u27 then
						v_u27:Destroy()
						v_u27 = nil
					end
					if v_u28 then
						v_u28:Destroy()
						v_u28 = nil
					end
					for _, v2 in ipairs(v_player:GetChildren()) do
						if v2:IsA("WorldModel") or v2:IsA("Camera") then
							v2:Destroy()
						end
					end
					local v3 = v_u_characters:FindFirstChild(v1.Character)
					if v3 then
						local v_worldmodel = Instance.new("WorldModel")
						v_worldmodel.Name = "CharacterWorldModel"
						v_worldmodel.Parent = v_player
						v_u27 = v_worldmodel
						local v_clone = v3:Clone()
						v_clone.Name = "BuyMenuCharacter"
						v_clone.Parent = v_worldmodel
						v_u26 = v_clone
						if v_clone.PrimaryPart then
							v_clone:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
						end
						local v4 = -v_clone:GetBoundingBox().Y
						local v_new = CFrame.new(0, v4, 0.4)
						if v_clone.PrimaryPart then
							v_clone:SetPrimaryPartCFrame(v_new)
						end
						local v_camera = Instance.new("Camera")
						v_camera.CameraType = Enum.CameraType.Scriptable
						v_camera.Name = "ViewportCamera"
						v_camera.FieldOfView = 55
						v_camera.Parent = v_player
						v_player.CurrentCamera = v_camera
						v_u28 = v_camera
						local v_humanoid = v_clone:FindFirstChildOfClass("Humanoid")
						if v_humanoid and v1.IdleAnimation then
							local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
							if not v_animator then
								v_animator = Instance.new("Animator")
								v_animator.Parent = v_humanoid
							end
							local v_animation = Instance.new("Animation")
							v_animation.AnimationId = v1.IdleAnimation
							local v_loadanimation = v_animator:LoadAnimation(v_animation)
							v_loadanimation.Looped = true
							v_loadanimation:Play()
							v_u_new:Add(v_loadanimation, "Stop", "BuyMenuIdleAnimTrack")
							v_u_new:Add(v_animation, "Destroy", "BuyMenuIdleAnim")
						end
						local v_new = v_u21.new(v_player, v_camera)
						v_new:SetModel(v_clone)
						local v_getminimumfitcframe = v_new:GetMinimumFitCFrame(CFrame.new(0, v4, 0) * CFrame.Angles(0, -3.141592653589793, 0))
						v_camera.CFrame = CFrame.new(0, v4, v_getminimumfitcframe.Position.Z) * CFrame.Angles(0, -3.141592653589793, 0)
						v_u37()
						v_u38()
						v_u_new:Add(function()
							-- upvalues: (ref) v_u27, (ref) v_u28, (ref) v_u26, (ref) v_u23, (ref) v_u22, (ref) v_u25
							if v_u27 then
								v_u27:Destroy()
								v_u27 = nil
							end
							if v_u28 then
								v_u28:Destroy()
								v_u28 = nil
							end
							if v_u26 then
								v_u26:Destroy()
								v_u26 = nil
							end
							v_u23 = nil
							v_u22 = nil
							v_u25 = nil
						end, true, "BuyMenuCharacter")
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
end
local function v_u40()
	-- upvalues: (ref) v_u30, (ref) v_u26, (copy) v_u39, (ref) v_u28, (copy) v_u38
	local v_player = v_u30.Player
	if v_player then
		if v_player.Visible and (v_player.AbsoluteSize.X > 0 and v_player.AbsoluteSize.Y > 0) then
			if not (v_u26 and v_u26.Parent) then
				v_u39()
			end
			if v_u28 and v_u28.Parent then
				v_player.CurrentCamera = v_u28
			end
			v_u38()
		end
	else
		return
	end
end
function v_u1.openFrame()
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (copy) v_u9, (ref) v_u30, (copy) v_u4, (ref) v_u31, (ref) v_u24, (copy) v_u40
	if v_u3.IsActive() then
		return
	else
		local v_buymenu = v_u_localplayer:GetAttribute("BuyMenu")
		if v_u9(v_u_localplayer) then
			if v_buymenu and not v_u30.Visible then
				v_u4.setForceLockOverride("BuyMenu", true)
				v_u4.setPerspective(true, true)
				v_u31.Gameplay.Bottom.Health.Visible = false
				v_u31.Gameplay.Bottom.Middle.Visible = false
				v_u31.Gameplay.Bottom.Armor.Visible = false
				v_u31.Gameplay.Bottom.Money.Visible = false
				v_u31.Gameplay.Bottom.Ammo.Visible = false
				v_u30.Visible = true
				v_u24 = nil
				v_u40()
			end
		else
			return
		end
	end
end
function v_u1.closeFrame()
	-- upvalues: (ref) v_u30, (copy) v_u4, (ref) v_u31, (ref) v_u24
	if v_u30.Visible then
		v_u4.setForceLockOverride("BuyMenu", false)
		v_u4.setPerspective(true, false)
		v_u31.Gameplay.Bottom.Health.Visible = true
		v_u31.Gameplay.Bottom.Middle.Visible = true
		v_u31.Gameplay.Bottom.Armor.Visible = true
		v_u31.Gameplay.Bottom.Money.Visible = true
		v_u31.Gameplay.Bottom.Ammo.Visible = true
		v_u30.Visible = false
		v_u24 = nil
	end
end
function v_u1.toggleFrame()
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (ref) v_u30, (copy) v_u1
	if v_u3.IsActive() then
		return
	elseif v_u_localplayer:GetAttribute("BuyMenu") and not v_u30.Visible then
		v_u1.openFrame()
		return
	elseif v_u30.Visible then
		v_u1.closeFrame()
	end
end
function v_u1.characterAdded(_)
	-- upvalues: (copy) v_u35, (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u39, (copy) v_u32
	if v_u35(v_u_localplayer, "Money") then
		v_u_new:Cleanup()
		v_u39()
		v_u32()
	end
end
function v_u1.characterRemoving(_)
	-- upvalues: (copy) v_u_new, (ref) v_u25, (ref) v_u22, (ref) v_u23, (ref) v_u24, (ref) v_u26, (ref) v_u27, (ref) v_u28
	v_u_new:Cleanup()
	if v_u25 then
		v_u25:Destroy()
		v_u25 = nil
	end
	if v_u22 then
		v_u22:Stop()
		v_u22 = nil
	end
	v_u23 = nil
	v_u24 = nil
	v_u26 = nil
	v_u27 = nil
	v_u28 = nil
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u31, (ref) v_u30, (copy) v_u12, (copy) v_u_localplayer, (ref) v_u26, (copy) v_u1, (copy) v_u39, (copy) v_u40, (copy) v_u15, (copy) v_u29, (copy) v_u6, (copy) v_u_new, (copy) v_u10, (copy) v_u11, (copy) v_u_run, (copy) v_u8, (copy) v_u9, (copy) v_u2, (copy) v_u38, (copy) v_u5, (copy) v_u_new, (copy) v_u_new, (copy) v_u32
	v_u31 = arg1
	v_u30 = arg2
	v_u12.observeAttribute(v_u_localplayer, "Team", function(_)
		-- upvalues: (ref) v_u26, (ref) v_u_localplayer, (ref) v_u1, (ref) v_u39, (ref) v_u30, (ref) v_u40
		if v_u26 and v_u_localplayer.Character then
			v_u1.characterRemoving(v_u_localplayer.Character)
		end
		if v_u_localplayer.Character then
			v_u39()
			if v_u30.Visible then
				v_u40()
			end
		end
	end)
	v_u15.Inventory.NewInventoryItem.Listen(function(arg1)
		-- upvalues: (ref) v_u29
		table.insert(v_u29, arg1.identifier)
	end)
	v_u15.Inventory.RemoveInventoryItem.Listen(function(self)
		-- upvalues: (ref) v_u6, (ref) v_u29
		v_u6(v_u29, function(_, arg2)
			-- upvalues: (copy) self
			return arg2 == self
		end)
	end)
	v_u12.observeAttribute(v_u_localplayer, "MinimumNextRoundIncome", function(arg1)
		-- upvalues: (ref) v_u30
		v_u30.Menu.TopFrame.NextRoundMoney.Text = "Next Round Minimum:  $" .. tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end)
	v_u12.observeAttribute(v_u_localplayer, "Money", function(arg1)
		-- upvalues: (ref) v_u_new
		v_u_new:setGoal(arg1)
	end)
	v_u12.observeAttribute(v_u_localplayer, "BuyMenu", function(_)
		-- upvalues: (ref) v_u1
		return function()
			-- upvalues: (ref) v_u1
			v_u1.closeFrame()
		end
	end)
	v_u12.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u30, (ref) v_u10
		v_u30.Menu.TopFrame.Timer.Text = v_u10(arg1)
	end)
	v_u11.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u29
		if arg2 == "Buy Period" then
			table.clear(v_u29)
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_new, (ref) v_u30, (ref) v_u8, (ref) v_u9, (ref) v_u_localplayer, (ref) v_u1
		local v_getposition = v_u_new:getPosition()
		local v_round = math.round(v_getposition)
		local v_gsub = tostring(v_round):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		v_u30.Menu.TopFrame.Money.TextColor3 = v_u8()
		v_u30.Menu.TopFrame.Money.Text = "$" .. v_gsub
		v_u_new:update(arg1)
		if v_u30.Visible and not v_u9(v_u_localplayer) then
			local v_gamemode = workspace:GetAttribute("Gamemode")
			if v_gamemode == "Bomb Defusal" or v_gamemode == "Hostage Rescue" then
				v_u1.closeFrame()
				return
			end
		end
	end)
	v_u2.OnInventoryChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u30, (ref) v_u1, (ref) v_u38
		for _, v1 in ipairs(v_u30.Menu.Container:GetDescendants()) do
			if v1:IsA("TextButton") then
				v_u1.updateBuyMenuTemplate(arg1, v1)
			end
		end
		if v_u30.Visible then
			task.defer(v_u38)
		end
	end)
	v_u5.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u2, (ref) v_u30, (ref) v_u1
		local v_getcurrentinventory = v_u2.getCurrentInventory()
		if v_getcurrentinventory then
			for _, v1 in ipairs(v_u30.Menu.Container:GetDescendants()) do
				if v1:IsA("TextButton") then
					v_u1.updateBuyMenuTemplate(v_getcurrentinventory, v1)
				end
			end
		end
	end)
	v_u5.CreateListener(v_u_localplayer, "Loadout", function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u_new, (ref) v_u32, (ref) v_u30, (ref) v_u1
		if v_u_localplayer.Character then
			v_u_new:Cleanup()
			v_u_new:Cleanup()
			v_u32()
			for _, v1 in ipairs(v_u30.Menu.Container:GetDescendants()) do
				if v1:IsA("TextButton") and v1.Parent.Name ~= "Equipment" then
					v_u1.setupTemplate(v1, (("Loadout.%*.Options.%*"):format(v1.Parent.Name, (tonumber(v1.Name)))))
				end
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1
	if v_u_localplayer.Character then
		v_u1.characterAdded(v_u_localplayer.Character)
	end
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.characterAdded(arg1)
	end)
	v_u_localplayer.CharacterRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.characterRemoving(arg1)
	end)
end
return v_u1