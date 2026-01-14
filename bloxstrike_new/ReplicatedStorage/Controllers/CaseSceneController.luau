-- game.ReplicatedStorage.Controllers.CaseSceneController

local v_u1 = {}
local v_u_contextaction = game:GetService("ContextActionService")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_u_run = game:GetService("RunService")
local v_u_maingui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
require(script:WaitForChild("Types"))
local v_u2 = require(script:WaitForChild("SceneRegistry"))
local v3 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u4 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
local v_u5 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u6 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u7 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u8 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u_current_camera = workspace.CurrentCamera
local v_u9 = false
local v_u10 = nil
local v_u11 = nil
local v_u12 = nil
local v_u13 = nil
local v_u_new = v3.new()
local v_u14 = false
local v_u15 = nil
local v_u16 = {}
local v_u17 = false
local v_u18 = nil
local v_u19 = nil
local v_u20 = 0
local v_u21 = nil
local v_u22 = nil
local v_u23 = {}
local v_u24 = nil
local v_u25 = false
local v_u26 = nil
local v_u27 = nil
local v_u28 = nil
local v_u29 = 0
local v_u30 = 1
local v_u31 = 0
local v_u32 = nil
local v_u33 = false
local v_u34 = false
local function v_u35()
	-- upvalues: (copy) v_u7, (ref) v_u9, (copy) v_u4
	v_u7.EnterCaseScene()
	local v_getmenuframe = v_u7.GetMenuFrame()
	if v_getmenuframe then
		v_u9 = v_u4.IsActive()
		if v_u9 then
			v_u4.HideMenuScene(true, true)
			v_u4.SetMusicVolumeMultiplier(0.5, 0.5)
		end
		v_u7.SetBlurEnabled(false)
		v_getmenuframe.BackgroundTransparency = 1
		local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
		if v_pattern then
			v_pattern.Visible = false
		end
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = false
		end
		local v_store = v_getmenuframe:FindFirstChild("Store")
		if v_store then
			v_store.Visible = true
		end
		for _, v1 in v_getmenuframe:GetChildren() do
			if v1:IsA("Frame") and (v1.Name ~= "Top" and (v1.Name ~= "Store" and v1.Name ~= "OpenCase")) then
				v1.Visible = false
			end
		end
	end
end
local function v_u36(arg1)
	-- upvalues: (ref) v_u16
	for _, v1 in arg1:GetDescendants() do
		if v1:IsA("BasePart") then
			if v1.Transparency < 1 then
				v1:SetAttribute("_CaseScenePrevTransparency", v1.Transparency)
				v1.Transparency = 1
			end
		elseif v1:IsA("SurfaceGui") and v1.Enabled then
			v1:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", true)
			v1.Enabled = false
		end
	end
	table.insert(v_u16, arg1)
end
local function v_u37()
	-- upvalues: (ref) v_u16, (ref) v_u12, (copy) v_u_current_camera, (copy) v_u36
	v_u16 = {}
	local v1 = v_u12 and v_u12.AssetFolder or nil
	for _, v2 in v_u_current_camera:GetChildren() do
		if v2:IsA("Model") and v2.Name ~= v1 then
			v_u36(v2)
		end
	end
end
local function v_u38()
	-- upvalues: (ref) v_u16
	for _, v1 in v_u16 do
		if v1 and v1.Parent then
			for _, v2 in v1:GetDescendants() do
				if v2:IsA("BasePart") then
					local v_getattribute = v2:GetAttribute("_CaseScenePrevTransparency")
					if v_getattribute ~= nil then
						v2.Transparency = v_getattribute
						v2:SetAttribute("_CaseScenePrevTransparency", nil)
					end
				elseif v2:IsA("SurfaceGui") and v2:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") ~= nil then
					v2.Enabled = true
					v2:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
				end
			end
		end
	end
	v_u16 = {}
end
local function v_u39()
	-- upvalues: (copy) v_u7, (ref) v_u9, (copy) v_u4
	local v_getmenuframe = v_u7.GetMenuFrame()
	if v_getmenuframe and v_getmenuframe.Visible then
		local v_getscreenbeforecasescene = v_u7.GetScreenBeforeCaseScene()
		v_u9 = false
		v_u7.ExitCaseScene()
		if v_u9 then
			v_u4.ShowMenuScene()
			v_u4.SetMusicVolumeMultiplier(1, 0.5)
		else
			v_u4.ApplyMapLighting()
		end
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = true
		end
		if v_getscreenbeforecasescene then
			local v1 = v_getmenuframe:FindFirstChild(v_getscreenbeforecasescene)
			if v1 then
				v1.Visible = true
				local v2
				if v_getscreenbeforecasescene == "Dashboard" then
					v2 = false
				else
					v2 = v_getscreenbeforecasescene ~= "Play"
				end
				v_u7.SetBlurEnabled(v2)
				v_getmenuframe.BackgroundTransparency = v2 and 0.15 or 1
				local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
				if v_pattern then
					v_pattern.Visible = not v2
					return
				end
			end
		else
			local v_dashboard = v_getmenuframe:FindFirstChild("Dashboard")
			if v_dashboard then
				v_dashboard.Visible = true
			end
			v_u7.SetBlurEnabled(false)
			v_getmenuframe.BackgroundTransparency = 1
			local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
			if v_pattern then
				v_pattern.Visible = true
			end
		end
	else
		v_u9 = false
		v_u7.ExitCaseScene()
		v_u4.ApplyMapLighting()
	end
end
local function v_u40(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage
	local v_casemod = arg1:FindFirstChild("CaseMod")
	if v_casemod and v_casemod:GetAttribute("IsDynamicModel") then
		v_casemod:Destroy()
	end
	local v_casemodels = v_u_replicatedstorage.Assets:FindFirstChild("CaseModels")
	if v_casemodels then
		local v1 = v_casemodels:FindFirstChild(arg2)
		if v1 then
			local v_clone = v1:Clone()
			v_clone.Name = "CaseMod"
			v_clone:SetAttribute("IsDynamicModel", true)
			local v_casepivot = arg1:FindFirstChild("CasePivot")
			if v_casepivot then
				v_clone:PivotTo(v_casepivot.CFrame)
				v_clone.Parent = arg1
				return v_clone
			else
				warn("[CaseSceneController]: CasePivot not found in CaseScene")
				v_clone.Parent = arg1
				return v_clone
			end
		else
			warn("[CaseSceneController]: Case model not found for case: " .. arg2)
			return nil
		end
	else
		warn("[CaseSceneController]: CaseModels folder not found in ReplicatedStorage.Assets")
		return nil
	end
end
local function v_u41(arg1, arg2)
	local v1
	if arg2.InteractionType == "Drag" then
		v1 = arg1:FindFirstChild("Pack")
	else
		v1 = arg1:FindFirstChild("CaseMod")
	end
	if not v1 then
		return nil
	end
	local v_animationcontroller = v1:FindFirstChildOfClass("AnimationController")
	if not v_animationcontroller then
		return nil
	end
	local v_animator = v_animationcontroller:FindFirstChildOfClass("Animator")
	if not v_animator then
		v_animator = Instance.new("Animator")
		v_animator.Parent = v_animationcontroller
	end
	return v_animator
end
local function v_u42(arg1, arg2, arg3)
	-- upvalues: (copy) v_u41, (ref) v_u22, (ref) v_u23
	local v1
	if arg2.InteractionType == "Click" and arg3 then
		local v_animationcontroller = arg3:FindFirstChildOfClass("AnimationController")
		v1 = not v_animationcontroller or v_animationcontroller:FindFirstChildOfClass("Animator")
		if not v1 then
			v1 = Instance.new("Animator")
			v1.Parent = v_animationcontroller
		end
	else
		v1 = nil
	end
	local v2 = v1 or v_u41(arg1, arg2)
	if v2 then
		v_u22 = v2
		for v3, v4 in arg2.Animations do
			if v4 then
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v4
				v_u23[v3] = v2:LoadAnimation(v_animation)
				v_animation:Destroy()
			end
		end
	else
		warn("[CaseSceneController]: No animator found for scene")
	end
end
local function v_u43(arg1, arg2)
	if arg1 then
		for _, v1 in arg1:GetDescendants() do
			if v1:IsA("Beam") or v1:IsA("ParticleEmitter") then
				v1.Enabled = arg2
			end
		end
	end
end
local function v_u44()
	-- upvalues: (ref) v_u10, (copy) v_u43
	local v1 = v_u10
	if v1 then
		v1 = v_u10:FindFirstChild("CaseMod")
	end
	if v1 then
		v_u43(v1:FindFirstChild("IdleEffect"), true)
		v_u43(v1:FindFirstChild("OpeningEffect"), false)
		v_u43(v1:FindFirstChild("EffectsPart"), true)
	end
end
local function v_u45()
	-- upvalues: (ref) v_u10, (copy) v_u43
	local v1 = v_u10
	if v1 then
		v1 = v_u10:FindFirstChild("CaseMod")
	end
	if v1 then
		v_u43(v1:FindFirstChild("IdleEffect"), false)
		v_u43(v1:FindFirstChild("OpeningEffect"), false)
		v_u43(v1:FindFirstChild("EffectsPart"), false)
	end
end
local function v_u46(arg1, arg2)
	-- upvalues: (copy) v_u6, (copy) v_u_new
	for v1, v_u2 in arg2 do
		v_u_new:Add((arg1:GetMarkerReachedSignal(v1):Connect(function()
			-- upvalues: (ref) v_u6, (copy) v_u2
			v_u6.broadcastRouter("RunStoreSound", v_u2)
		end)))
	end
end
local function v_u47()
	-- upvalues: (ref) v_u23, (copy) v_u44, (ref) v_u12, (copy) v_u46, (copy) v_u6, (copy) v_u_new, (ref) v_u10
	if v_u23.CaseFall and v_u23.CloseIdle then
		v_u44()
		local v_casefall = v_u23.CaseFall
		local v1 = v_u12 and v_u12.AnimationKeyframeSounds
		if v1 then
			v1 = v_u12.AnimationKeyframeSounds.CaseFall
		end
		if v1 then
			v_u46(v_casefall, v1)
		else
			local v_u2 = v_u12 and (v_u12.Sounds and v_u12.Sounds.Drop) or "Case Fall"
			v_u_new:Add((v_casefall:GetMarkerReachedSignal("Dropped"):Connect(function()
				-- upvalues: (ref) v_u6, (copy) v_u2
				v_u6.broadcastRouter("RunStoreSound", v_u2)
			end)))
		end
		v_u_new:Add((v_casefall:GetMarkerReachedSignal(v1 and v1.Drop and "Drop" or "Dropped"):Connect(function()
			-- upvalues: (ref) v_u10
			local v1 = v_u10 and v_u10:FindFirstChild("DropParticle")
			if v1 then
				for _, v2 in v1:GetChildren() do
					if v2:IsA("ParticleEmitter") then
						local v_emitcount = v2:GetAttribute("EmitCount")
						if typeof(v_emitcount) == "number" and v_emitcount > 0 then
							v2:Emit(v_emitcount)
						end
					end
				end
			end
		end)))
		v_casefall:Play()
		v_u23.CloseIdle.Looped = true
		v_u23.CloseIdle:Play()
	end
end
local function v_u48()
	-- upvalues: (ref) v_u23, (ref) v_u12, (copy) v_u46, (copy) v_u6, (ref) v_u10, (copy) v_u43
	if v_u23.CaseOpening then
		if v_u23.CloseIdle then
			v_u23.CloseIdle:Stop()
		end
		local v_caseopening = v_u23.CaseOpening
		local v1 = v_u12 and v_u12.AnimationKeyframeSounds
		if v1 then
			v1 = v_u12.AnimationKeyframeSounds.CaseOpening
		end
		if v1 then
			v_u46(v_caseopening, v1)
		else
			v_u6.broadcastRouter("RunStoreSound", v_u12 and (v_u12.Sounds and v_u12.Sounds.Opening) or "Case Opening")
		end
		local v2 = v_u10
		if v2 then
			v2 = v_u10:FindFirstChild("CaseMod")
		end
		if v2 then
			v_u43(v2:FindFirstChild("OpeningEffect"), true)
			v_u43(v2:FindFirstChild("IdleEffect"), false)
		end
		v_caseopening:Play()
		if v_u23.OpenIdle then
			v_u23.OpenIdle.Looped = true
			v_u23.OpenIdle:Play()
		end
	end
end
local function v_u49()
	-- upvalues: (ref) v_u23, (ref) v_u24
	for _, v1 in v_u23 do
		if v1.IsPlaying then
			v1:Stop()
		end
	end
	if v_u24 then
		v_u24:Stop()
		v_u24:Destroy()
		v_u24 = nil
	end
end
local function v_u50()
	-- upvalues: (ref) v_u24, (ref) v_u28, (ref) v_u32, (copy) v_u_maingui, (ref) v_u23, (ref) v_u26, (ref) v_u12, (copy) v_u6
	if v_u24 then
		v_u24:Stop()
	end
	v_u28 = nil
	if v_u32 then
		v_u32.Enabled = false
	end
	local v_cameraperspective = v_u_maingui:FindFirstChild("CameraPerspective")
	if v_cameraperspective then
		v_cameraperspective.Interactable = true
	end
	local v_u_packopening = v_u23.PackOpening
	if v_u_packopening then
		v_u6.broadcastRouter("RunStoreSound", not (v_u12 and (v_u12.Sounds and v_u12.Sounds.DragLoop)) and "Charm Drag Loop" or v_u12.Sounds.DragLoop)
		if not v_u_packopening.IsPlaying then
			v_u_packopening:Play()
		end
		v_u_packopening:AdjustSpeed(1)
		v_u_packopening.Looped = false
		local v_max = math.max(0, v_u_packopening.Length - v_u_packopening.TimePosition - 0.1)
		task.delay(v_max, function()
			-- upvalues: (copy) v_u_packopening, (ref) v_u26
			if v_u_packopening.IsPlaying then
				v_u_packopening:AdjustSpeed(0)
				v_u_packopening.TimePosition = v_u_packopening.Length * 0.99
				if v_u26 then
					v_u26 = nil
					v_u26()
				end
			end
		end)
	elseif v_u26 then
		v_u26 = nil
		v_u26()
	end
end
local function v_u51(arg1, arg2)
	-- upvalues: (ref) v_u23, (ref) v_u31, (ref) v_u25, (copy) v_u50, (ref) v_u24, (ref) v_u28, (ref) v_u29
	local v_packopening = v_u23.PackOpening
	if v_packopening then
		local v_clamp = math.clamp(arg1, 0, 1)
		local v1
		if v_u31 > 0 then
			v1 = v_u31
		else
			v1 = v_packopening.Length
		end
		local v2 = v1 * v_clamp
		if not v_packopening.IsPlaying then
			v_packopening:Play()
			v_packopening:AdjustSpeed(0)
		end
		v_packopening.TimePosition = v2
		if v_clamp >= 1 then
			v_u25 = false
			v_u50()
		end
		if v_u24 and arg2 then
			local v3 = not v_u28 and 0 or (arg2 - v_u28).Magnitude
			v_u28 = arg2
			if v3 > 0.001 then
				v_u29 = tick()
				if not v_u24.IsPlaying then
					v_u24:Play()
				end
				v_u24.PlaybackSpeed = math.clamp(v3 * 20, 0, 0.7) + 0.8
			end
		end
	end
end
local function v_u52(arg1)
	-- upvalues: (ref) v_u10, (copy) v_u_contextaction, (ref) v_u33, (ref) v_u26, (ref) v_u25, (ref) v_u27, (ref) v_u30, (ref) v_u23, (ref) v_u12, (ref) v_u31, (copy) v_u_maingui, (ref) v_u32, (copy) v_u_new, (ref) v_u34, (copy) v_u_run, (ref) v_u28, (ref) v_u29, (ref) v_u24, (copy) v_u_replicatedstorage, (copy) v_u50, (copy) v_u51, (copy) v_u_userinput, (ref) v_u14, (ref) v_u15, (copy) v_u6
	if v_u10 then
		local v_u_pack = v_u10:FindFirstChild("Pack")
		if v_u_pack then
			local v_u_drag = v_u_pack:FindFirstChild("Drag")
			if v_u_drag then
				local v_u_dragdetector = v_u_drag:FindFirstChildOfClass("DragDetector")
				if v_u_dragdetector then
					v_u_contextaction:UnbindAction("Fire")
					v_u_contextaction:UnbindAction("Secondary Fire")
					v_u33 = true
					v_u26 = arg1
					v_u25 = false
					v_u27 = v_u_drag.Position
					if v_u_dragdetector.MaxDragTranslation.Magnitude <= 0 then
						v_u30 = 1
					end
					local v_u_packopening = v_u23.PackOpening
					if v_u_packopening then
						local v_u1 = not (v_u12 and (v_u12.DragSettings and v_u12.DragSettings.EndKeyframe)) and "DragEndPoint" or v_u12.DragSettings.EndKeyframe
						local v2, v3 = pcall(function()
							-- upvalues: (copy) v_u_packopening, (ref) v_u1
							return v_u_packopening:GetTimeOfKeyframe(v_u1)
						end)
						if v2 and v3 then
							v_u31 = v3
						else
							v_u31 = v_u_packopening.Length
							warn("[CaseSceneController]: " .. v_u1 .. " keyframe not found, using full animation length")
						end
					end
					v_u_dragdetector.Enabled = true
					local v_cameraperspective = v_u_maingui:FindFirstChild("CameraPerspective")
					if v_cameraperspective then
						v_cameraperspective.Interactable = false
					end
					local v_surfacegui = v_u_drag:FindFirstChildOfClass("SurfaceGui")
					if v_surfacegui then
						v_surfacegui.Enabled = true
						v_u32 = v_surfacegui
						local v_frame = v_surfacegui:FindFirstChildOfClass("Frame")
						local v_u4 = v_frame and v_frame:FindFirstChildOfClass("ImageLabel")
						if v_u4 then
							v_u_new:Add(v_frame.MouseEnter:Connect(function()
								-- upvalues: (ref) v_u34, (copy) v_u4
								v_u34 = true
								v_u4.ImageTransparency = 1
							end), "Disconnect", "CharmImageHoverEnter")
							v_u_new:Add(v_frame.MouseLeave:Connect(function()
								-- upvalues: (ref) v_u34, (copy) v_u4
								v_u34 = false
								v_u4.ImageTransparency = 0
							end), "Disconnect", "CharmImageHoverLeave")
							local v_u5 = 0
							v_u_new:Add(v_u_run.RenderStepped:Connect(function(arg1)
								-- upvalues: (ref) v_u34, (ref) v_u5, (copy) v_u4
								if not v_u34 then
									v_u4.ImageTransparency = (math.sin(v_u5 + arg1 * 2) + 1) / 2 * 0.2
								end
							end), "Disconnect", "CharmImageBreathing")
						end
					end
					v_u_new:Add(v_u_dragdetector.DragStart:Connect(function()
						-- upvalues: (ref) v_u25, (ref) v_u28, (copy) v_u_drag, (ref) v_u29, (ref) v_u24, (ref) v_u12, (ref) v_u_replicatedstorage, (copy) v_u_pack, (ref) v_u_new
						v_u25 = true
						v_u28 = v_u_drag.Position
						v_u29 = tick()
						if not v_u24 then
							local v1 = require(v_u_replicatedstorage.Database.Audio.Store)[not (v_u12 and (v_u12.Sounds and v_u12.Sounds.DragStart)) and "Charm Drag Start" or v_u12.Sounds.DragStart]
							if v1 and (v1.Identifiers and v1.Identifiers[1]) then
								local v_sound = Instance.new("Sound")
								v_sound.Name = "DragProgress"
								v_sound.SoundId = "rbxassetid://" .. v1.Identifiers[1]
								v_sound.Volume = v1.Properties.Volume or 1
								v_sound.Looped = true
								v_sound.PlaybackSpeed = 0.8
								v_sound.Parent = v_u_pack
								v_u24 = v_sound
								v_u_new:Add(v_sound, "Destroy")
							end
						end
					end), "Disconnect", "CharmDragStart")
					v_u_new:Add(v_u_run.Heartbeat:Connect(function()
						-- upvalues: (ref) v_u25, (ref) v_u24, (ref) v_u29
						if v_u25 and (v_u24 and (v_u24.IsPlaying and tick() - v_u29 > 0.05)) then
							v_u24:Stop()
						end
					end), "Disconnect", "CharmDragSoundCheck")
					v_u_new:Add(v_u_dragdetector.DragContinue:Connect(function()
						-- upvalues: (ref) v_u25, (ref) v_u27, (copy) v_u_drag, (ref) v_u30, (ref) v_u12, (copy) v_u_dragdetector, (ref) v_u50, (ref) v_u51
						if v_u25 and v_u27 then
							local v_clamp = math.clamp((v_u_drag.Position - v_u27).Magnitude / v_u30, 0, 1)
							if (not (v_u12 and (v_u12.DragSettings and v_u12.DragSettings.Threshold)) and 0.5 or v_u12.DragSettings.Threshold) <= v_clamp then
								v_u25 = false
								v_u_dragdetector.Enabled = false
								if v_u27 then
									v_u_drag.Position = v_u27
								end
								v_u50()
							else
								v_u51(v_clamp, v_u_drag.Position)
							end
						else
							return
						end
					end), "Disconnect", "CharmDragContinue")
					v_u_new:Add(v_u_dragdetector.DragEnd:Connect(function()
						-- upvalues: (ref) v_u25, (ref) v_u27, (ref) v_u24, (copy) v_u_drag, (ref) v_u30, (ref) v_u12, (copy) v_u_dragdetector, (ref) v_u50, (ref) v_u23, (ref) v_u28
						if v_u25 and v_u27 then
							v_u25 = false
							if v_u24 then
								v_u24:Stop()
							end
							local v_clamp = math.clamp((v_u_drag.Position - v_u27).Magnitude / v_u30, 0, 1)
							v_u_drag.Position = v_u27
							if (not (v_u12 and (v_u12.DragSettings and v_u12.DragSettings.Threshold)) and 0.8 or math.max(v_u12.DragSettings.Threshold, 0.8)) <= v_clamp then
								v_u_dragdetector.Enabled = false
								v_u50()
							else
								local v_packopening = v_u23.PackOpening
								if v_packopening then
									v_packopening.TimePosition = 0
								end
								v_u28 = nil
							end
						else
							return
						end
					end), "Disconnect", "CharmDragEnd")
					v_u_new:Add(v_u_userinput.InputBegan:Connect(function(arg1, arg2)
						-- upvalues: (ref) v_u14, (ref) v_u15, (copy) v_u_dragdetector, (ref) v_u25, (ref) v_u27, (copy) v_u_drag, (ref) v_u24, (ref) v_u12, (ref) v_u6, (ref) v_u50
						if arg2 then
							if (arg1.KeyCode == Enum.KeyCode.ButtonX or arg1.KeyCode == Enum.KeyCode.ButtonA) and (v_u14 and v_u15 == "Unboxing") then
								v_u_dragdetector.Enabled = false
								if v_u25 then
									v_u25 = false
									if v_u27 then
										v_u_drag.Position = v_u27
									end
								end
								if v_u24 then
									v_u24:Stop()
								end
								v_u6.broadcastRouter("RunStoreSound", not (v_u12 and (v_u12.Sounds and v_u12.Sounds.DragStart)) and "Charm Drag Start" or v_u12.Sounds.DragStart)
								v_u50()
							end
						end
					end), "Disconnect", "CharmControllerSkip")
				else
					warn("[CaseSceneController]: DragDetector not found on Drag part")
				end
			else
				warn("[CaseSceneController]: Drag part not found in Pack")
				return
			end
		else
			warn("[CaseSceneController]: Pack not found in CharmScene")
			return
		end
	else
		return
	end
end
function v_u1.ShowCaseScene(arg1, arg2)
	-- upvalues: (ref) v_u14, (copy) v_u2, (ref) v_u11, (ref) v_u12, (ref) v_u13, (ref) v_u10, (ref) v_u15, (copy) v_u_current_camera, (copy) v_u35, (ref) v_u9, (copy) v_u4, (copy) v_u_lighting, (copy) v_u37, (copy) v_u_new, (copy) v_u36, (copy) v_u40, (copy) v_u42, (copy) v_u47, (copy) v_u5, (copy) v_u_run, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20, (copy) v_u_tween, (ref) v_u21, (copy) v_u45, (ref) v_u33, (copy) v_u6, (ref) v_u25, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u34, (copy) v_u49, (ref) v_u23, (ref) v_u22
	if v_u14 then
		return
	else
		local v_getsceneforcasetype = v_u2.GetSceneForCaseType(arg1 or "Case")
		local v_u_getconfig = v_u2.GetConfig(v_getsceneforcasetype)
		if v_u_getconfig then
			v_u11 = v_getsceneforcasetype
			v_u12 = v_u_getconfig
			v_u13 = arg2
			local v1 = workspace:FindFirstChild(v_u_getconfig.AssetFolder)
			if v1 then
				v_u10 = v1
				local v2 = v_u_getconfig.InteractionType == "Drag" and v1:FindFirstChild("Pack")
				if v2 then
					local v_drag = v2:FindFirstChild("Drag")
					local v3 = v_drag and v_drag:FindFirstChildOfClass("SurfaceGui")
					if v3 then
						v3.Enabled = false
					end
				end
				v_u15 = "Inspecting"
				local v4
				if v_u10 then
					local v_camera = v_u10:FindFirstChild("Camera")
					if v_camera then
						v4 = v_camera:FindFirstChild("Inspecting")
					else
						v4 = nil
					end
				else
					v4 = nil
				end
				if v4 then
					v_u_current_camera.CameraType = Enum.CameraType.Scriptable
					v_u_current_camera.CFrame = v4.CFrame
					v_u_current_camera.Focus = v4.CFrame
					v_u35()
					if not v_u9 then
						v_u4.ApplyMenuSceneLighting()
					end
					local v_casefog = v1:FindFirstChild("CaseFog", true)
					if v_casefog and v_casefog:IsA("Atmosphere") then
						for _, v5 in v_u_lighting:GetChildren() do
							if v5:IsA("Atmosphere") then
								v5:Destroy()
							end
						end
						v_casefog:Clone().Parent = v_u_lighting
					end
					v_u37()
					v_u_new:Add(v_u_current_camera.ChildAdded:Connect(function(arg1)
						-- upvalues: (copy) v_u_getconfig, (ref) v_u36
						if arg1:IsA("Model") and arg1.Name ~= v_u_getconfig.AssetFolder then
							v_u36(arg1)
						end
					end), "Disconnect", "ViewmodelListener")
					local v6
					if arg2 and v_u_getconfig.InteractionType == "Click" then
						v6 = v_u40(v1, arg2)
					else
						v6 = nil
					end
					v_u42(v1, v_u_getconfig, v6)
					if v_u_getconfig.InteractionType == "Click" then
						v_u47()
					end
					v_u5.updateCameraFOV(50)
					v_u5.setForceLockOverride("CaseScene", true)
					v_u_run:BindToRenderStep("CaseSceneCameraUpdate", Enum.RenderPriority.Camera.Value + 10, function()
						-- upvalues: (ref) v_u10, (ref) v_u_current_camera, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20, (ref) v_u_tween, (ref) v_u21, (ref) v_u15
						if v_u10 then
							v_u_current_camera.CameraType = Enum.CameraType.Scriptable
							if v_u17 and (v_u18 and v_u19) then
								local v_min = math.min((tick() - v_u20) / 0.8, 1)
								v_u_current_camera.CFrame = v_u18:Lerp(v_u19, (v_u_tween:GetValue(v_min, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)))
								v_u_current_camera.Focus = v_u_current_camera.CFrame
								if v_min >= 1 then
									v_u17 = false
									v_u_current_camera.CFrame = v_u19
									if v_u21 then
										v_u21 = nil
										v_u21()
									end
									v_u18 = nil
									v_u19 = nil
									return
								end
							else
								local v1 = v_u15
								local v2
								if v_u10 then
									local v_camera = v_u10:FindFirstChild("Camera")
									if v_camera then
										if v1 == "Inspecting" then
											v2 = v_camera:FindFirstChild("Inspecting")
										elseif v1 == "Unboxing" then
											v2 = v_camera:FindFirstChild("Unboxing")
										else
											v2 = nil
										end
									else
										v2 = nil
									end
								else
									v2 = nil
								end
								if v2 then
									v_u_current_camera.CFrame = v2.CFrame
									v_u_current_camera.Focus = v2.CFrame
								end
							end
						end
					end)
					v_u_new:Add(function()
						-- upvalues: (ref) v_u_run
						v_u_run:UnbindFromRenderStep("CaseSceneCameraUpdate")
					end, true, "CameraUpdate")
					v_u_new:Add(function()
						-- upvalues: (ref) v_u15, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u21, (ref) v_u45, (ref) v_u33, (ref) v_u6, (ref) v_u25, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u34, (ref) v_u10, (ref) v_u49, (ref) v_u23, (ref) v_u22
						v_u15 = nil
						v_u17 = false
						v_u18 = nil
						v_u19 = nil
						v_u21 = nil
						v_u45()
						if v_u33 then
							v_u6.broadcastRouter("RebindKeybinds")
							v_u33 = false
						end
						v_u25 = false
						v_u26 = nil
						v_u27 = nil
						v_u28 = nil
						v_u29 = 0
						v_u30 = 1
						v_u31 = 0
						v_u32 = nil
						v_u34 = false
						if v_u10 then
							local v_casemod = v_u10:FindFirstChild("CaseMod")
							if v_casemod and v_casemod:GetAttribute("IsDynamicModel") then
								v_casemod:Destroy()
							end
						end
						v_u49()
						v_u23 = {}
						v_u22 = nil
					end, true, "CaseSceneCleanup")
					v_u14 = true
				else
					warn("[CaseSceneController]: Scene missing Camera.Inspecting")
					v_u10 = nil
					v_u11 = nil
					v_u12 = nil
					v_u15 = nil
				end
			else
				warn("[CaseSceneController]: Scene not found in workspace: " .. v_u_getconfig.AssetFolder)
				v_u11 = nil
				v_u12 = nil
				v_u13 = nil
				return
			end
		else
			warn("[CaseSceneController]: No config found for scene: " .. v_getsceneforcasetype)
			return
		end
	end
end
function v_u1.TransitionToUnboxing(self)
	-- upvalues: (ref) v_u14, (ref) v_u10, (ref) v_u12, (ref) v_u15, (copy) v_u48, (copy) v_u_current_camera, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20, (ref) v_u21, (copy) v_u52
	if v_u14 and (v_u10 and v_u12) then
		if v_u15 == "Unboxing" then
			return
		else
			local v1
			if v_u10 then
				local v_camera = v_u10:FindFirstChild("Camera")
				if v_camera then
					v1 = v_camera:FindFirstChild("Unboxing")
				else
					v1 = nil
				end
			else
				v1 = nil
			end
			if v1 then
				if v_u12.InteractionType == "Click" then
					v_u48()
					local v2 = v_u15
					local v3
					if v_u10 then
						local v_camera = v_u10:FindFirstChild("Camera")
						if v_camera then
							if v2 == "Inspecting" then
								v3 = v_camera:FindFirstChild("Inspecting")
							elseif v2 == "Unboxing" then
								v3 = v_camera:FindFirstChild("Unboxing")
							else
								v3 = nil
							end
						else
							v3 = nil
						end
					else
						v3 = nil
					end
					local v4
					if v3 then
						v4 = v3.CFrame
					else
						v4 = v_u_current_camera.CFrame
					end
					v_u17 = true
					v_u18 = v4
					v_u19 = v1.CFrame
					v_u20 = tick()
					v_u21 = self
				else
					local function v5()
						-- upvalues: (ref) v_u52, (copy) self
						v_u52(self)
					end
					local v6 = v_u15
					local v7
					if v_u10 then
						local v_camera = v_u10:FindFirstChild("Camera")
						if v_camera then
							if v6 == "Inspecting" then
								v7 = v_camera:FindFirstChild("Inspecting")
							elseif v6 == "Unboxing" then
								v7 = v_camera:FindFirstChild("Unboxing")
							else
								v7 = nil
							end
						else
							v7 = nil
						end
					else
						v7 = nil
					end
					local v8
					if v7 then
						v8 = v7.CFrame
					else
						v8 = v_u_current_camera.CFrame
					end
					v_u17 = true
					v_u18 = v8
					v_u19 = v1.CFrame
					v_u20 = tick()
					v_u21 = v5
				end
				v_u15 = "Unboxing"
			else
				warn("[CaseSceneController]: Scene missing Camera.Unboxing")
			end
		end
	else
		return
	end
end
function v_u1.TransitionToInspecting(arg1)
	-- upvalues: (ref) v_u14, (ref) v_u10, (ref) v_u15, (copy) v_u_current_camera, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20, (ref) v_u21
	if v_u14 and v_u10 then
		if v_u15 == "Inspecting" then
			return
		else
			local v1
			if v_u10 then
				local v_camera = v_u10:FindFirstChild("Camera")
				if v_camera then
					v1 = v_camera:FindFirstChild("Inspecting")
				else
					v1 = nil
				end
			else
				v1 = nil
			end
			if v1 then
				local v2 = v_u15
				local v3
				if v_u10 then
					local v_camera = v_u10:FindFirstChild("Camera")
					if v_camera then
						if v2 == "Inspecting" then
							v3 = v_camera:FindFirstChild("Inspecting")
						elseif v2 == "Unboxing" then
							v3 = v_camera:FindFirstChild("Unboxing")
						else
							v3 = nil
						end
					else
						v3 = nil
					end
				else
					v3 = nil
				end
				local v4
				if v3 then
					v4 = v3.CFrame
				else
					v4 = v_u_current_camera.CFrame
				end
				v_u17 = true
				v_u18 = v4
				v_u19 = v1.CFrame
				v_u20 = tick()
				v_u21 = arg1
				v_u15 = "Inspecting"
			else
				warn("[CaseSceneController]: Scene missing Camera.Inspecting")
			end
		end
	else
		return
	end
end
function v_u1.HideCaseScene(arg1)
	-- upvalues: (ref) v_u14, (copy) v_u_new, (copy) v_u_current_camera, (copy) v_u5, (copy) v_u8, (copy) v_u39, (copy) v_u7, (ref) v_u9, (copy) v_u38, (ref) v_u10, (ref) v_u11, (ref) v_u12, (ref) v_u13, (ref) v_u15
	if v_u14 then
		v_u_new:Cleanup()
		v_u_current_camera.CameraType = Enum.CameraType.Custom
		v_u5.updateCameraFOV(v_u8.DEFAULT_CAMERA_FOV)
		v_u5.setForceLockOverride("CaseScene", false)
		if arg1 then
			v_u7.ExitCaseScene()
			v_u9 = false
		else
			v_u39()
		end
		v_u38()
		v_u10 = nil
		v_u11 = nil
		v_u12 = nil
		v_u13 = nil
		v_u14 = false
		v_u15 = nil
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u14
	return v_u14
end
function v_u1.GetCurrentState()
	-- upvalues: (ref) v_u15
	return v_u15
end
function v_u1.GetSceneName()
	-- upvalues: (ref) v_u11
	return v_u11
end
function v_u1.GetSceneConfig()
	-- upvalues: (ref) v_u12
	return v_u12
end
function v_u1.WaitForOpeningAnimation()
	-- upvalues: (ref) v_u23
	local v_caseopening = v_u23.CaseOpening
	if v_caseopening then
		if v_caseopening.IsPlaying then
			v_caseopening.Stopped:Wait()
		end
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u2, (copy) v_u_userinput, (ref) v_u14, (copy) v_u1, (copy) v_u6
	local v_u_assets = v_u_replicatedstorage:FindFirstChild("Assets")
	if v_u_assets then
		local function v1(arg1)
			-- upvalues: (copy) v_u_assets
			local v1 = v_u_assets:FindFirstChild(arg1)
			if not v1 then
				return
			end
			local v2 = nil
			for _, v3 in v1:GetChildren() do
				if v3:IsA("Model") then
					v2 = v3
					break
				end
			end
			if v2 then
				local v_clone = v2:Clone()
				v_clone.Name = arg1
				v_clone.Parent = workspace
			else
				warn("[CaseSceneController]: No model found in Assets." .. arg1)
			end
		end
		for _, v2 in v_u2.GetAllSceneNames() do
			local v_getconfig = v_u2.GetConfig(v2)
			if v_getconfig then
				v1(v_getconfig.AssetFolder)
			end
		end
		v_u_userinput.InputBegan:Connect(function(arg1, arg2)
			-- upvalues: (ref) v_u14, (ref) v_u1
			if not arg2 then
				if arg1.KeyCode == Enum.KeyCode.Escape and v_u14 then
					v_u1.HideCaseScene()
				end
			end
		end)
		v_u6.observerRouter("CaseSceneShow", function(arg1, arg2)
			-- upvalues: (ref) v_u1
			v_u1.ShowCaseScene(arg1, arg2)
		end)
		v_u6.observerRouter("CaseSceneUnboxing", function(arg1)
			-- upvalues: (ref) v_u1
			v_u1.TransitionToUnboxing(arg1)
		end)
		v_u6.observerRouter("CaseSceneClose", function()
			-- upvalues: (ref) v_u1
			v_u1.HideCaseScene()
		end)
		v_u6.observerRouter("CaseSceneCloseForGameEnd", function()
			-- upvalues: (ref) v_u1
			v_u1.HideCaseScene(true)
		end)
	else
		warn("[CaseSceneController]: Assets folder not found in ReplicatedStorage")
	end
end
function v_u1.Start() end
return v_u1