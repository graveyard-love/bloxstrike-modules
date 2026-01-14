-- game.ReplicatedStorage.Interface.Screens.Gameplay.Middle.MobileButtons

local v_u1 = {}
local v_u_collection = game:GetService("CollectionService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u3 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u4 = require(v_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u6 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u7 = require(v_replicatedstorage.Database.Components.GameState)
local v_u8 = require(v_replicatedstorage.Database.Components.Common.IsInBuyArea)
local v9 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u10 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u11 = require(v_replicatedstorage.Database.Security.Router)
local v_u12 = require(v_replicatedstorage.Shared.Promise)
local v_u13 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u14 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u15 = require(v_replicatedstorage.Interface.Screens.Menu.Top)
local v_u16 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u17 = require(v_u_localplayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u_find = table.find(v9(), "Mobile")
if v_u_find then
	v_u_find = #v9() <= 1
end
local v_u18 = nil
local v_u19 = nil
local v_u20 = nil
local v_u21 = nil
local v_u22 = nil
local v_u23 = nil
local v_u24 = nil
local v_u25 = false
local v_u26 = nil
local v_u_new = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local v_u27 = { "SwapTeam", "Menu" }
local v_u28 = {
	"Shoot",
	"Shop",
	"Reload",
	"Jump",
	"Crouch",
	"Aim",
	"Drop",
	"Interact",
	"SwapTeam",
	"Menu",
	"Configure"
}
local function v_u29()
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u_new
	if not (v_u_current_camera and v_u_localplayer.Character) then
		return nil
	end
	if v_u_localplayer:GetAttribute("Team") ~= "Counter-Terrorists" then
		return nil
	end
	v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
	local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 5, v_u_new)
	if v_raycast then
		local v_instance = v_raycast.Instance
		if v_instance and (v_instance.Parent and v_instance.Parent:HasTag("Hostage")) or false then
			local v_parent = v_raycast.Instance.Parent
			if v_parent and v_parent:GetAttribute("CanRescue") == true then
				local v_rescuingplayer = v_parent:GetAttribute("RescuingPlayer")
				if v_rescuingplayer and v_rescuingplayer ~= v_u_localplayer.Name then
					return nil
				elseif v_parent:GetAttribute("CarryingPlayer") then
					return nil
				else
					return v_parent
				end
			end
		end
	end
	return nil
end
local function v_u30()
	-- upvalues: (ref) v_u18, (copy) v_u_collection
	if v_u18 then
		local v1 = v_u_collection:GetTagged("Bomb")[1]
		if v1 then
			v1 = v1:GetAttribute("CanDefuse")
		end
		local v2 = #v_u_collection:GetTagged("IsHoveringInteractable") > 0
		if v1 then
			v_u18.Interact.Defuse.Visible = true
			v_u18.Interact.Use.Visible = false
			return
		elseif v2 then
			v_u18.Interact.Defuse.Visible = false
			v_u18.Interact.Use.Visible = true
		else
			v_u18.Interact.Defuse.Visible = false
			v_u18.Interact.Use.Visible = false
		end
	else
		return
	end
end
local function v_u31()
	-- upvalues: (ref) v_u18, (copy) v_u10
	local v1 = {}
	if v_u18 then
		for _, v2 in ipairs(v_u18:GetChildren()) do
			if v2:IsA("TextButton") and v2.Name ~= "Configure" then
				local v3 = {
					["Position"] = {
						["X"] = v2.Position.X.Scale,
						["Y"] = v2.Position.Y.Scale
					},
					["Size"] = {
						["X"] = v2.Size.X.Scale,
						["Y"] = v2.Size.Y.Scale
					}
				}
				v1[v2.Name] = v3
			end
		end
		v_u10.Player.UpdateMobileButtons.Send({
			["Value"] = v1
		})
	end
end
local function v_u32()
	-- upvalues: (ref) v_u25, (ref) v_u18
	if not v_u25 then
		v_u25 = true
		for _, v1 in ipairs(v_u18:GetChildren()) do
			if v1:IsA("TextButton") and v1.Name ~= "Configure" then
				v1.Active = false
			end
		end
	end
end
local function v_u33()
	-- upvalues: (ref) v_u25, (ref) v_u22, (ref) v_u23, (ref) v_u24, (ref) v_u26, (ref) v_u19, (ref) v_u18, (copy) v_u31
	if v_u25 then
		v_u25 = false
		v_u22 = nil
		v_u23 = nil
		v_u24 = nil
		v_u26 = nil
		v_u19 = nil
		for _, v1 in ipairs(v_u18:GetChildren()) do
			if v1:IsA("TextButton") then
				v1.Active = true
			end
		end
		v_u31()
	end
end
local function v_u34(arg1)
	-- upvalues: (ref) v_u22, (ref) v_u24, (ref) v_u18
	if v_u22 and v_u24 then
		local v_absolutesize = v_u18.AbsoluteSize
		local v1 = arg1 - v_u24
		local v_absolutesize = v_u22.AbsoluteSize
		local v_clamp = math.clamp(v1.X, 0, v_absolutesize.X - v_absolutesize.X)
		local v_new = Vector2.new(v_clamp, (math.clamp(v1.Y, 0, v_absolutesize.Y - v_absolutesize.Y)))
		v_u22.Position = UDim2.fromScale(v_new.X / v_absolutesize.X, v_new.Y / v_absolutesize.Y)
	end
end
local function v_u35(arg1)
	-- upvalues: (ref) v_u23, (ref) v_u26, (ref) v_u19, (ref) v_u18
	if v_u23 and (v_u26 and v_u19) then
		local v1 = v_u26 + (arg1 - v_u19)
		local v_max = math.max(v1.X, 50)
		local v_new = Vector2.new(v_max, (math.max(v1.Y, 50)))
		local v2 = v_u18.AbsoluteSize * 0.8
		local v_min = math.min(v_new.X, v2.X)
		local v_new = Vector2.new(v_min, (math.min(v_new.Y, v2.Y)))
		v_u23.Size = UDim2.fromScale(v_new.X / UNNAMED_2189145868056.X, v_new.Y / UNNAMED_2189145868056.Y)
	end
end
local function v_u36(arg1, arg2)
	-- upvalues: (ref) v_u25, (ref) v_u24, (ref) v_u22
	if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u25 then
		local v_position = arg1.Position
		local v_new = Vector2.new(v_position.X, v_position.Y)
		if v_u25 then
			v_u24 = v_new - arg2.AbsolutePosition
			v_u22 = arg2
		end
	end
end
local function v_u37(arg1)
	-- upvalues: (ref) v_u25, (ref) v_u22, (copy) v_u34, (ref) v_u23, (copy) v_u35
	if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseMovement) and v_u25 then
		local v_position = arg1.Position
		local v_new = Vector2.new(v_position.X, v_position.Y)
		if v_u22 then
			v_u34(v_new)
			return
		elseif v_u23 then
			v_u35(v_new)
		end
	else
		return
	end
end
function v_u1.setupButton(self)
	-- upvalues: (ref) v_u25, (copy) v_u_tween, (copy) v_u_new
	local v_u_size = self.Size
	self.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u25, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		if not v_u25 then
			local v1 = {}
			local v2 = v_u_size
			v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
			v_u_tween:Create(self, v_u_new, v1):Play()
		end
	end)
	self.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u25, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		if not v_u25 then
			local v1 = {}
			local v2 = v_u_size
			v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
			v_u_tween:Create(self, v_u_new, v1):Play()
		end
	end)
end
function v_u1.setupDraggableButton(self)
	-- upvalues: (ref) v_u25, (ref) v_u23, (ref) v_u22, (ref) v_u26, (ref) v_u19, (copy) v_u36, (ref) v_u24
	local v_u1 = nil
	local v_u2 = nil
	self.InputBegan:Connect(function(arg1)
		-- upvalues: (ref) v_u25, (ref) v_u1, (ref) v_u2
		if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u25 then
			local v_position = arg1.Position
			v_u1 = Vector2.new(v_position.X, v_position.Y)
			v_u2 = tick()
		end
	end)
	self.InputChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u25, (ref) v_u2, (ref) v_u1, (ref) v_u23, (ref) v_u22, (copy) self, (ref) v_u26, (ref) v_u19, (ref) v_u36
		if v_u25 then
			local v_position = arg1.Position
			local v_new = Vector2.new(v_position.X, v_position.Y)
			if v_u2 and v_u1 then
				local v_magnitude = (v_new - v_u1).Magnitude
				if tick() - v_u2 >= 0.5 and v_magnitude < 10 then
					if not (v_u23 or v_u22) then
						local v1 = self
						if v_u25 then
							v_u26 = v1.AbsoluteSize
							v_u19 = v_new
							v_u23 = v1
						end
						return
					end
				elseif v_magnitude >= 10 and not (v_u22 or v_u23) then
					v_u36(arg1, self)
					return
				end
			end
		end
	end)
	self.InputEnded:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u2, (ref) v_u25, (ref) v_u22, (copy) self, (ref) v_u24, (ref) v_u23, (ref) v_u19, (ref) v_u26
		if arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			v_u1 = nil
			v_u2 = nil
			if v_u25 and v_u22 == self and ((arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u25) then
				if v_u22 then
					v_u24 = nil
					v_u22 = nil
				elseif v_u23 then
					v_u19 = nil
					v_u26 = nil
					v_u23 = nil
				end
			end
			if v_u23 == self then
				v_u19 = nil
				v_u26 = nil
				v_u23 = nil
			end
		end
	end)
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u18, (copy) v_u_find, (ref) v_u25, (copy) v_u2, (copy) v_u12, (copy) v_u3, (copy) v_u6, (copy) v_u16, (copy) v_u11, (ref) v_u21, (copy) v_u_tween, (copy) v_u_new, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u7, (copy) v_u17, (ref) v_u20, (copy) v_u_collection, (copy) v_u29, (copy) v_u10, (copy) v_u14, (copy) v_u15, (copy) v_u13, (copy) v_u33, (copy) v_u32, (copy) v_u1, (copy) v_u_run, (copy) v_u8, (copy) v_u30, (copy) v_u_userinput, (copy) v_u37, (ref) v_u22, (ref) v_u24, (ref) v_u23, (ref) v_u19, (ref) v_u26
	v_u18 = arg2
	if v_u_find then
		local v_top = v_u18.Parent.Parent:FindFirstChild("Top")
		local v1 = v_top and v_top:FindFirstChild("Bomb Defusal")
		if v1 then
			v1.Size = UDim2.new(0.6, 0, 0.75, 0)
		end
		v_u18.Jump.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u2
			if not v_u25 then
				v_u2.jump()
			end
		end)
		v_u18.Crouch.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u2
			if not v_u25 then
				v_u2.crouch(not v_u2.GetCrouchState())
			end
		end)
		v_u18.Drop.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u12, (ref) v_u3, (ref) v_u6, (ref) v_u16, (ref) v_u11
			if not v_u25 then
				v_u12.new(function(arg1, arg2)
					-- upvalues: (ref) v_u3
					local v_getcurrentequipped = v_u3.getCurrentEquipped()
					if v_getcurrentequipped then
						arg1(v_getcurrentequipped)
					else
						arg2("Failed to fetch current equipped")
					end
				end):catch(warn):andThen(function(arg1)
					-- upvalues: (ref) v_u6, (ref) v_u16, (ref) v_u11
					if arg1 then
						local v_getskininformation = v_u6.GetSkinInformation(arg1.Name, arg1.Skin)
						assert(v_getskininformation, "Skin data not found for weapon: " .. arg1.Name .. " and skin: " .. arg1.Skin)
						local v1 = v_u16[v_getskininformation.rarity]
						local v_floor = math.floor(v1.Color.R * 255)
						local v_floor = math.floor(v1.Color.G * 255)
						local v_floor = math.floor(v1.Color.B * 255)
						if arg1:drop() then
							v_u11.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, arg1.Name, arg1.Skin), 2)
						end
					end
				end)
			end
		end)
		v_u18.Reload.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u12, (ref) v_u3
			if not v_u25 then
				v_u12.new(function(arg1, arg2)
					-- upvalues: (ref) v_u3
					local v_getcurrentequipped = v_u3.getCurrentEquipped()
					if v_getcurrentequipped then
						arg1(v_getcurrentequipped)
					else
						arg2("Failed to fetch current equipped")
					end
				end):catch(warn):andThen(function(arg1)
					if arg1 then
						arg1:reload()
					end
				end)
			end
		end)
		local v_u_size = v_u18.Shoot.Size
		v_u18.Shoot.Active = true
		local v_u2 = false
		local function v_u3(arg1, arg2)
			-- upvalues: (ref) v_u21, (ref) v_u2, (ref) v_u_tween, (ref) v_u18, (ref) v_u_new, (copy) v_u_size, (ref) v_u25, (ref) v_u12, (ref) v_u3
			if arg1 == v_u21 then
				if arg2 or arg1.UserInputState == Enum.UserInputState.End then
					v_u21 = nil
					if v_u2 then
						v_u2 = false
						local v1 = {}
						local v2 = v_u_size
						v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
						v_u_tween:Create(v_u18.Shoot, v_u_new, v1):Play()
						if not v_u25 then
							v_u12.new(function(arg1, arg2)
								-- upvalues: (ref) v_u3
								local v_getcurrentequipped = v_u3.getCurrentEquipped()
								if v_getcurrentequipped then
									arg1(v_getcurrentequipped)
								else
									arg2("Failed to fetch current equipped")
								end
							end):catch(warn):andThen(function(arg1)
								if arg1 then
									if arg1.Properties.Class == "C4" then
										arg1:cancel()
										return
									elseif arg1.Properties.Slot == "Grenade" then
										arg1:Throw("Far")
									end
								else
									return
								end
							end)
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
		v_u18.Shoot.InputBegan:Connect(function(arg1)
			-- upvalues: (ref) v_u25, (ref) v_u21, (ref) v_u_localplayer, (ref) v_u5, (ref) v_u7, (ref) v_u11, (ref) v_u2, (ref) v_u_tween, (ref) v_u18, (ref) v_u_new, (copy) v_u_size, (ref) v_u12, (ref) v_u3
			if arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				if v_u25 or v_u21 then
					return
				else
					v_u21 = arg1
					if v_u_localplayer:GetAttribute("IsPlayerChatting") then
						return
					elseif v_u5.IsLocalPlayerDead() then
						return
					elseif v_u_localplayer.Character then
						if v_u7.GetState() ~= "Buy Period" then
							v_u11.broadcastRouter("Cancel Defuse Bomb")
							v_u2 = true
							local v1 = {}
							local v2 = v_u_size
							v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
							v_u_tween:Create(v_u18.Shoot, v_u_new, v1):Play()
							v_u12.new(function(arg1, arg2)
								-- upvalues: (ref) v_u3
								local v_getcurrentequipped = v_u3.getCurrentEquipped()
								if v_getcurrentequipped then
									arg1(v_getcurrentequipped)
								else
									arg2("Failed to fetch current equipped")
								end
							end):catch(warn):andThen(function(arg1)
								if arg1 then
									if arg1.Properties.Class == "C4" then
										arg1:shoot()
										return
									elseif arg1.Properties.Slot == "Grenade" then
										arg1:StartThrow()
									else
										arg1:shoot()
									end
								else
									return
								end
							end)
						end
					else
						return
					end
				end
			else
				return
			end
		end)
		v_u18.Shoot.InputEnded:Connect(v_u3)
		v_u18.Shoot.InputChanged:Connect(function(arg1)
			-- upvalues: (ref) v_u21, (ref) v_u25, (ref) v_u17
			if arg1 == v_u21 and (arg1.UserInputType == Enum.UserInputType.Touch and not v_u25) then
				v_u17.addTouchMove(Vector2.new(arg1.Delta.X, arg1.Delta.Y))
			end
		end)
		local v_u_size = v_u18.Aim.Size
		v_u18.Aim.Active = true
		local function v_u4(arg1, arg2)
			-- upvalues: (ref) v_u20, (ref) v_u_tween, (ref) v_u18, (ref) v_u_new, (copy) v_u_size, (ref) v_u25, (ref) v_u12, (ref) v_u3
			if arg1 == v_u20 then
				if arg2 or arg1.UserInputState == Enum.UserInputState.End then
					v_u20 = nil
					local v1 = {}
					local v2 = v_u_size
					v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
					v_u_tween:Create(v_u18.Aim, v_u_new, v1):Play()
					if not v_u25 then
						v_u12.new(function(arg1, arg2)
							-- upvalues: (ref) v_u3
							local v_getcurrentequipped = v_u3.getCurrentEquipped()
							if v_getcurrentequipped then
								arg1(v_getcurrentequipped)
							else
								arg2("Failed to fetch current equipped")
							end
						end):catch(warn):andThen(function(arg1)
							if arg1 then
								if arg1.Properties.HasScope then
									arg1:unscope()
								end
							else
								return
							end
						end)
					end
				else
					return
				end
			else
				return
			end
		end
		v_u18.Aim.InputBegan:Connect(function(arg1)
			-- upvalues: (ref) v_u25, (ref) v_u20, (ref) v_u_tween, (ref) v_u18, (ref) v_u_new, (copy) v_u_size, (ref) v_u12, (ref) v_u3
			if arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				if not (v_u25 or v_u20) then
					v_u20 = arg1
					local v1 = {}
					local v2 = v_u_size
					v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
					v_u_tween:Create(v_u18.Aim, v_u_new, v1):Play()
					v_u12.new(function(arg1, arg2)
						-- upvalues: (ref) v_u3
						local v_getcurrentequipped = v_u3.getCurrentEquipped()
						if v_getcurrentequipped then
							arg1(v_getcurrentequipped)
						else
							arg2("Failed to fetch current equipped")
						end
					end):catch(warn):andThen(function(arg1)
						if arg1 then
							if arg1.Properties.HasScope then
								arg1:scope(true)
								return
							elseif arg1.Properties.HasSuppressor then
								if arg1.IsSuppressed then
									arg1:removeSuppressor()
								else
									arg1:addSuppressor()
								end
							elseif arg1.Properties.ShootingOptions == "Burst" then
								arg1:updateFireMode()
							end
						else
							return
						end
					end)
				end
			else
				return
			end
		end)
		v_u18.Aim.InputEnded:Connect(v_u4)
		v_u18.Aim.InputChanged:Connect(function(arg1)
			-- upvalues: (ref) v_u20, (ref) v_u25, (ref) v_u17
			if arg1 == v_u20 and (arg1.UserInputType == Enum.UserInputType.Touch and not v_u25) then
				v_u17.addTouchMove(Vector2.new(arg1.Delta.X, arg1.Delta.Y))
			end
		end)
		v_u18.Interact.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_collection, (ref) v_u25, (ref) v_u11, (ref) v_u29, (ref) v_u_localplayer, (ref) v_u6, (ref) v_u16, (ref) v_u10
			local v1 = v_u_collection:GetTagged("Bomb")[1]
			if v_u25 then
				return
			elseif v1 and (v1:GetAttribute("CanDefuse") and not v1:GetAttribute("Defused")) then
				v_u11.broadcastRouter("Start Defuse Bomb")
				return
			else
				local v2 = v_u29()
				if v2 then
					local v_team = v_u_localplayer:GetAttribute("Team")
					if not v_u_localplayer:GetAttribute("IsCarryingHostage") and (not v_u_localplayer:GetAttribute("IsRescuingHostage") and v_team == "Counter-Terrorists") then
						local v_rescuingplayer = v2:GetAttribute("RescuingPlayer")
						local v_carryingplayer = v2:GetAttribute("CarryingPlayer")
						if (not v_rescuingplayer or v_rescuingplayer == v_u_localplayer.Name) and not v_carryingplayer then
							v_u11.broadcastRouter("Start Rescue Hostage")
							return
						end
					end
				end
				local v_gettagged = v_u_collection:GetTagged("IsHoveringInteractable")
				if #v_gettagged == 0 then
					return
				else
					local v3 = v_gettagged[1]
					local v_weapon = v3:GetAttribute("Weapon")
					local v_skin = v3:GetAttribute("Skin")
					if v_weapon ~= "C4" or v_u_localplayer:GetAttribute("Team") == "Terrorists" then
						if v3:GetAttribute("CanPickup") then
							local v_getskininformation = v_u6.GetSkinInformation(v_weapon, v_skin)
							if v_getskininformation then
								local v4 = v_u16[v_getskininformation.rarity]
								local v_floor = math.floor(v4.Color.R * 255)
								local v_floor = math.floor(v4.Color.G * 255)
								local v_floor = math.floor(v4.Color.B * 255)
								v_u11.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, v_weapon, v_skin), 2)
							end
							v_u10.Inventory.PickupWeapon.Send({
								["Identity"] = v3.Name
							})
						end
					end
				end
			end
		end)
		v_u18.Interact.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_collection, (ref) v_u25, (ref) v_u_localplayer, (ref) v_u11
			local v1 = v_u_collection:GetTagged("Bomb")[1]
			if v_u25 then
				return
			elseif v1 and v_u_localplayer:GetAttribute("IsDefusingBomb") then
				v_u11.broadcastRouter("Cancel Defuse Bomb")
				return
			elseif v_u_localplayer:GetAttribute("IsRescuingHostage") then
				v_u11.broadcastRouter("Cancel Rescue Hostage")
			end
		end)
		v_u18.Shop.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u14
			if not v_u25 then
				v_u14.toggleFrame()
			end
		end)
		v_u18.Menu.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u15
			if not v_u25 then
				v_u15.ToggleMenu()
			end
		end)
		v_u18.SwapTeam.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u_localplayer, (ref) v_u13
			if v_u25 then
				return
			elseif v_u_localplayer:GetAttribute("IsSpectating") then
				v_u13.openFrame()
				return
			elseif v_u_localplayer.Character then
				v_u13.ToggleTeamSelection()
			end
		end)
		v_u18.Configure.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u33, (ref) v_u32
			if v_u25 then
				v_u33()
			else
				v_u32()
			end
		end)
		for _, v5 in ipairs(v_u18:GetChildren()) do
			if v5:IsA("TextButton") then
				if v5.Name ~= "Shoot" and v5.Name ~= "Aim" then
					v_u1.setupButton(v5)
				end
				if v5.Name ~= "Configure" then
					v_u1.setupDraggableButton(v5)
				end
			end
		end
		v_u_run.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_localplayer, (ref) v_u18, (ref) v_u8, (ref) v_u30
			local _ = v_u_localplayer:GetAttribute("IsSpectating") == true
			local v_shop = v_u18.Shop
			local v_buymenu = v_u_localplayer:GetAttribute("BuyMenu")
			if v_buymenu then
				v_buymenu = v_u8(v_u_localplayer)
			end
			v_shop.Visible = v_buymenu
			v_u30()
		end)
		v_u_userinput.InputChanged:Connect(function(arg1)
			-- upvalues: (ref) v_u21, (ref) v_u20, (ref) v_u25, (ref) v_u17, (ref) v_u37
			if (arg1 == v_u21 or arg1 == v_u20) and not v_u25 then
				v_u17.addTouchMove(Vector2.new(arg1.Delta.X, arg1.Delta.Y))
			end
			v_u37(arg1)
		end)
		v_u_userinput.InputEnded:Connect(function(arg1)
			-- upvalues: (copy) v_u3, (copy) v_u4, (ref) v_u25, (ref) v_u22, (ref) v_u24, (ref) v_u23, (ref) v_u19, (ref) v_u26
			if arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				v_u3(arg1, true)
				v_u4(arg1, true)
			end
			if arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				if not v_u25 then
					return
				end
				if v_u22 then
					v_u24 = nil
					v_u22 = nil
					return
				end
				if v_u23 then
					v_u19 = nil
					v_u26 = nil
					v_u23 = nil
					return
				end
			end
		end)
	else
		v_u18.Visible = false
	end
end
function v_u1.Start()
	-- upvalues: (ref) v_u18, (copy) v_u_localplayer, (copy) v_u_find, (copy) v_u28, (ref) v_u20, (copy) v_u27, (copy) v_u4, (ref) v_u25
	v_u18.Visible = false
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u18, (ref) v_u_find, (ref) v_u28
		v_u18.Visible = v_u_find
		if v_u_localplayer:GetAttribute("IsSpectating") == true then
			return
		elseif v_u18 then
			for _, v1 in ipairs(v_u28) do
				local v2 = v_u18:FindFirstChild(v1)
				if v2 then
					v2.Visible = v1 ~= "Configure"
				end
			end
		end
	end)
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u20, (ref) v_u_find, (ref) v_u18, (ref) v_u28, (ref) v_u27
		v_u20 = nil
		if v_u_localplayer:GetAttribute("IsSpectating") == true and v_u_find then
			if v_u18 then
				for _, v1 in ipairs(v_u28) do
					local v2 = v_u18:FindFirstChild(v1)
					if v2 then
						v2.Visible = table.find(v_u27, v1) ~= nil
					end
				end
			end
			v_u18.Visible = true
		else
			v_u18.Visible = false
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_find, (ref) v_u18, (ref) v_u28, (ref) v_u27
		local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true
		if v_u_find then
			if v1 then
				if v_u18 then
					for _, v2 in ipairs(v_u28) do
						local v3 = v_u18:FindFirstChild(v2)
						if v3 then
							v3.Visible = table.find(v_u27, v2) ~= nil
						end
					end
				end
				v_u18.Visible = true
				return
			elseif v_u_localplayer.Character then
				if v_u18 then
					for _, v4 in ipairs(v_u28) do
						local v5 = v_u18:FindFirstChild(v4)
						if v5 then
							v5.Visible = v4 ~= "Configure"
						end
					end
				end
				v_u18.Visible = true
			else
				v_u18.Visible = false
			end
		else
			if not v1 then
				v_u18.Visible = false
			end
			return
		end
	end)
	if v_u_find then
		if v_u_localplayer:GetAttribute("IsSpectating") == true then
			if v_u18 then
				for _, v1 in ipairs(v_u28) do
					local v2 = v_u18:FindFirstChild(v1)
					if v2 then
						v2.Visible = table.find(v_u27, v1) ~= nil
					end
				end
			end
			v_u18.Visible = true
			return
		end
		if v_u_localplayer.Character then
			if v_u18 then
				for _, v3 in ipairs(v_u28) do
					local v4 = v_u18:FindFirstChild(v3)
					if v4 then
						v4.Visible = v3 ~= "Configure"
					end
				end
			end
			v_u18.Visible = true
			return
		end
	end
	v_u4.CreateListener(v_u_localplayer, "MobileButtons", function(arg1)
		-- upvalues: (ref) v_u25, (ref) v_u18
		if not v_u25 then
			for v1, v2 in pairs(arg1) do
				local v3 = v_u18:FindFirstChild(v1)
				if v3 then
					v3.Position = UDim2.fromScale(v2.Position.X, v2.Position.Y)
					v3.Size = UDim2.fromScale(v2.Size.X, v2.Size.Y)
				end
			end
		end
	end)
end
return v_u1