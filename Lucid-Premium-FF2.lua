local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Lucid Premium - Football Fusion 2",
   LoadingTitle = "Lucid Premium",
   LoadingSubtitle = "",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Example Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "discord.gg/tQcZcfSK", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Lucid Premium",
      Subtitle = "Key System",
      Note = "Only Whitelisters Get Key",
      FileName = "YoutubeHubKey1", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/AtgzSPWK"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

 local Lucid Premium = {
     pv = true,
     universal = 0,
     blatant = 0,
     unitoggle = true,
     blatoggle = true,
     block = true,
     blockslider = 1.5,
     AutoFollowQb = true,
     tprange = 0,
     autocatchv = 0,
    }

local MainTab = Window:CreateTab("Catching", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Catching Features")

Rayfield:Notify({
   Title = "Authentication Success",
   Content = "",
   Duration = 5,
   Image = 13047715178,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Close",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})

---
    
   

local Toggle = MainTab:CreateToggle({
   Name = "Fake Boost (Jump twice)",
   CurrentValue = false,
   Flag = "Toggle",
   Callback = function(Value)
   		
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
    --Ensures this only runs once to save resources
    _G.infinJumpStarted = true
    
    --Notifies readiness
    game.StarterGui:SetCore("SendNotification", {Title="Lucid Premium"; Text="Infinite Jump Activated!"; Duration=5;})

    --The actual infinite jump
    local plr = game:GetService('Players').LocalPlayer
    local m = plr:GetMouse()
    m.KeyDown:connect(function(k)
        if _G.infinjump then
            if k:byte() == 32  then
            humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
            humanoid:ChangeState('Jumping')
            wait()
            humanoid:ChangeState('Seated')
            end
        end
    end)
end
   end,
})

local Button = MainTab:CreateButton({
	Name = "High Angle",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
	end,
})
    local Tab = Window:CreateTab("Quarterback") -- Title, Image
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local remotes = replicatedStorage:FindFirstChild("Remotes")
local characterSoundEvent = remotes:FindFirstChild("CharacterSoundEvent")
local player = players.LocalPlayer
local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()

local enabled = false
local autoAngle = false -- Auto Angle
local highlights1 = false
local autoChooseThrowType = false -- Auto Choose Throw Type
local showBeam = false -- Determines if to show the beam projectile
local showCards = false -- Determines if to show cards or not
local throwHeightOffset = 0
local straightenThrowDirection = false -- Determines if to straighten the move direction
local leadDistance = 0 -- Lead Distance (self-explanatory)
local beamColor = Color3.fromRGB(135, 82, 215)
local throwData = {
	power = 0,
	direction = Vector3.new(0, 0, 0),
	angle = 40
}
task.spawn(function()
	--// variables
	local gui = game:GetObjects("rbxassetid://13795523903")[1]
	local mouse = loadstring(game:HttpGet("https://raw.githubusercontent.com/madmodss/something../main/sdas"))()
	local mouseRaycastParams = RaycastParams.new()	
	local usePart = Instance.new("Part")
	usePart.Anchored = true
	usePart.CanCollide = false
	usePart.Size = Vector3.new(2048, 1, 2048)
	usePart.Transparency = 1
	usePart.Parent = workspace
	usePart.Position = player.Character.HumanoidRootPart.Position - Vector3.new(0, 2, 0)
	mouseRaycastParams.FilterType = Enum.RaycastFilterType.Include
	mouseRaycastParams.FilterDescendantsInstances = {usePart}
	mouse:SetRaycastParams(mouseRaycastParams)
	local throwTypes = {"Dime", "Mag", "Jump", "Bullet", "Slant"}
	local throwType = "Dime"
	local beam, a0, a1 = Instance.new("Beam"), Instance.new("Attachment"), Instance.new("Attachment")
	local hooked = {}
	local locked = false
	local target = nil
	local throwTypeLead = {
		["Dime"] = 11.5,
		["Mag"] = 9,
		["Bullet"] = 6,
		["Slant"] = 3.5
	}
	local throwTypeSwitch = {
		["Dime"] = "Mag",
		["Mag"] = "Bullet",
		["Bullet"] = "Slant",
		["Slant"] = "Dime"
	}
	--// hooking (T to throw was crazy)
	local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
		local args = {...}
		if not checkcaller() and hooked[self] and enabled and args[1] == "Clicked" then
			local nwArgs = {"Clicked", player.Character.Head.Position, player.Character.Head.Position + throwData.direction * 10000, (game.PlaceId == 8206123457 and throwData.power) or 60, throwData.power}
			return __namecall(self, unpack(nwArgs))
		end
		return __namecall(self, ...)
	end)
	--// initalization
	gui.Parent = game.CoreGui:FindFirstChild("RobloxGui")
	beam.Parent = workspace.Terrain
	a0.Parent = workspace.Terrain
	a1.Parent = workspace.Terrain
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.Segments = 1750
	beam.Width0 = 1
	beam.Width1 = 1
	--// main

	local function getMoveDirection(target)
		if players:GetPlayerFromCharacter(target) then
			return target.Humanoid.MoveDirection
		else
			return (target.Humanoid.WalkToPoint - target.Head.Position).Unit
		end
	end
	
	local function checkIsDiagonal()
		local md = getMoveDirection(target)
		local absMD = Vector3.new(math.abs(md.X), 0, math.abs(md.Z))
		local diff = (absMD - Vector3.new(0.7, 0, 0.7)).Magnitude
		return diff < 0.25
	end
	
	local function checkIsSideways()
		local md = getMoveDirection(target)
		return math.abs(md.Z) < math.abs(md.X)
	end
	
	local function checkMovingTowardsQB()
		local md = getMoveDirection(target)
		local lastDis = (target.Head.Position - player.Character.Head.Position).Magnitude
		local nwPos = target.Head.Position + md
		local nwDis = (nwPos - player.Character.Head.Position).Magnitude
		local diff = lastDis - nwDis
		return diff > 0.5
	end
	local function findClosestDistanceToDB()
		local closestDis = math.huge
		local closestDB = nil
		for index, player in pairs(players:GetPlayers()) do
			if player.Team and player.Team == players:GetPlayerFromCharacter(target).Team then continue end
			if player.Character == target then continue end
			if player.Character and player.Character:FindFirstChild("Head") then
				local distance = (player.Character.Head.Position - target.Head.Position).Magnitude
				if distance < closestDis then
					closestDis = distance
					closestDB = player.Character
				end	
			end
		end
		return closestDis, closestDB
	end
	
	local function findPower(pos)
		local powerTable = {
			[10] = 55,
			[20] = 60,
			[30] = 65,
			[35] = 70,
			[40] = 75,
			[50] = 80,
			[60] = 85,
			[70] = 90,
			[80] = 95,
		}
		local distance = (player.Character.Head.Position - pos).Magnitude
		local lDiff = math.huge
		local power = 0
		local pdistance = nil
		local reachedDis = 0
		local nextDis = 0
		local naturalPower = 0
		for dis, pwr in pairs(powerTable) do
			dis *= 3
			if distance > dis and dis > reachedDis then
				power = pwr
				naturalPower = pwr
				pdistance = dis
				reachedDis = dis
				if dis == 90 then nextDis = dis + 15 else nextDis = dis + 30 end
			end
		end
		local diff = math.clamp(nextDis - distance, 0, math.huge)
		local required = (nextDis - reachedDis)
		local nextPower = powerTable[nextDis / 3] or 75
		local percentage = diff / required
		--print(diff, required, nextPower, power, percentage, (nextPower - power) - ((nextPower - power) * percentage))
		power += math.clamp((nextPower - power) - ((nextPower - power) * percentage), 0, 100)
		if power ~= power then
			power = 50
		end
		return power - 5, naturalPower - 5
	end

	local function calculateVelocity(x0, d0, t)
		local g = Vector3.new(0, -28, 0)
		local v0 = (d0 - x0 - 0.5*g*t*t)/t;
		local dir = ((x0 + v0) - x0).Unit
		local power = v0.Y / dir.Y
		return v0, dir, math.clamp(math.round(power), 0, 95)
	end

	local function findZDirection(at)
		local zDiff = player.Character.HumanoidRootPart.Position.Z - at.Z
		local a = 0
		if zDiff < 0 then
			a = 1
		else
			a = -1
		end
		return a	
	end

	local function straightenMoveDirection(moveDirection, pos)
		-- wrs tend to turn and can mess up the dime, so let's straighten the movedirection.
		moveDirection = Vector3.new(moveDirection.X, 0, moveDirection.Z)
		local x = moveDirection.X
		local z = moveDirection.Z
		if math.abs(x) > 0.95 then
			if x ~= math.abs(x) then
				x = -1
			else
				x = 1
			end
		else
			x = 0
		end
		if math.abs(z) > 0.95 then
			if z ~= math.abs(z) then
				z = -1
			else
				z = 1
			end
		else
			z = 0
		end
		local md = Vector3.new(x, 0, z)
		if md.Magnitude <= 0 then
			md = Vector3.new(0, 0, findZDirection(pos))
		end
		return md
	end
	

	local function findtarget()
		local np = nil
		local nm = math.huge
		local s = {workspace}
		if workspace:FindFirstChild("npcwr") then
			table.insert(s, workspace.npcwr.a)
			table.insert(s, workspace.npcwr.b)
		end
		for i, p in pairs(s) do
			for i, c in pairs(p:GetChildren()) do
				if c:FindFirstChildWhichIsA("Humanoid") and c:FindFirstChild("HumanoidRootPart") then
					local plr = players:GetPlayerFromCharacter(c)
					if plr == player then continue end
					if not plr and game.PlaceId ~= 8206123457 then continue end
					if not player.Neutral then
						if plr.Team ~= player.Team then
							continue
						end
					end
					local d = (c.HumanoidRootPart.Position - mouse.Hit.Position).Magnitude
					if d < nm then
						nm = d
						np = c
					end	
				end
			end
		end

		
		
		if np and enabled == true and highlights1 == true then
        wait(0.1)
        for _, part in pairs(workspace:GetDescendants()) do
			if part:IsA("Highlight") then
				part:Destroy()
			end
		end
			local highlight = Instance.new("Highlight")
			highlight.Name = "Highlight"
			highlight.FillColor = Color3.fromRGB(135, 82, 215)
			highlight.Parent = np
		end
		
        local printing = "bro this shit is detected -mr.jeepers"

		local playerCharacter = player.Character
		if playerCharacter then
			local rootPart = playerCharacter.HumanoidRootPart
			for _, otherPlayer in ipairs(players:GetPlayers()) do
				if otherPlayer ~= player then
					local otherRootPart = otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart")
					if otherRootPart then
						local magnitude = (otherRootPart.Position - rootPart.Position).Magnitude
						if magnitude < 1 then
							print(printing)
						end
					end
				end
			end
		end
		
		return np
	end
	


	local function beamProjectile(g, v0, x0, t1) -- easy egomoose copy!
		-- calculate the bezier points
		local c = 0.5*0.5*0.5;
		local p3 = 0.5*g*t1*t1 + v0*t1 + x0;
		local p2 = p3 - (g*t1*t1 + v0*t1)/3;
		local p1 = (c*g*t1*t1 + 0.5*v0*t1 + x0 - c*(x0+p3))/(3*c) - p2;

		-- the curve sizes
		local curve0 = (p1 - x0).magnitude;
		local curve1 = (p2 - p3).magnitude;

		-- build the world CFrames for the attachments
		local b = (x0 - p3).unit;
		local r1 = (p1 - x0).unit;
		local u1 = r1:Cross(b).unit;
		local r2 = (p2 - p3).unit;
		local u2 = r2:Cross(b).unit;
		b = u1:Cross(r1).unit;

		local cf1 = CFrame.new(
			x0.x, x0.y, x0.z,
			r1.x, u1.x, b.x,
			r1.y, u1.y, b.y,
			r1.z, u1.z, b.z
		)

		local cf2 = CFrame.new(
			p3.x, p3.y, p3.z,
			r2.x, u2.x, b.x,
			r2.y, u2.y, b.y,
			r2.z, u2.z, b.z
		)

		return curve0, -curve1, cf1, cf2;
	end

	local solveForT = function(target, power, angle)
		local distance = (target.Head.Position - player.Character.Head.Position).Magnitude
		local special = {
			["Bullet"] = function()
				return distance / 95
			end,
			["Fold"] = function()
				return distance / 105
			end,
		}
		local default = function()
			local assumedDirection = (target.Head.Position - player.Character.Head.Position).Unit
			local speed = (assumedDirection * power).Magnitude
			local t = (distance / speed) * (angle / 22)
			return t
		end
		return (special[throwType] or default)()
	end

	local solveForAngle = function(distance)
		local special = {
			["Bullet"] = function()
				return 15
			end,
					["Fold"] = function()
				return 25
			end,
			["Slant"] = function()
				return math.clamp(distance / 4, 20, 45)
			end,
		}
		local default = function()
			return math.clamp(distance / 2.5, 20, 40)
		end
		return (special[throwType] or default)()
	end

	local function hookFootball(f)
		local remoteEvent = f:WaitForChild("Handle"):WaitForChild("RemoteEvent")
		hooked[remoteEvent] = true
	end

	local function initChar(char)
		char.ChildAdded:Connect(function(c)
			task.wait()
			if c:IsA("Tool") then
				hookFootball(c)
			end
		end)
	end
	
	local function findRoute(md)
		local routeFunctions = {
			["Dime"] = function()
				return not checkMovingTowardsQB() and not checkIsSideways() and not checkIsDiagonal()
			end,
			["Slant"] = function()
				return not checkMovingTowardsQB() and checkIsSideways()
			end,
			["Fold"] = function()
				return checkMovingTowardsQB() and checkIsDiagonal()
			end,
			["Comeback"] = function()
				return checkMovingTowardsQB() and not checkIsSideways()
			end,
			["Post"] = function()
				return not checkMovingTowardsQB() and checkIsDiagonal()
			end,
			["Still"] = function(md)
				return md.Magnitude <= 0
			end,
		}
		local route = nil
		for r, func in pairs(routeFunctions) do
			route = func(md) and r
			if route then break end
		end
		return route or "Unknown"
	end

	initChar(player.Character)
	player.CharacterAdded:Connect(initChar)

	userInputService.InputBegan:Connect(function(input, gp)
		if player.PlayerGui:FindFirstChild("BallGui") and not gp then
			if input.KeyCode == Enum.KeyCode.Q then
				locked = not locked
			elseif input.KeyCode == Enum.KeyCode.Z then
				throwType = throwTypeSwitch[throwType]
			elseif input.KeyCode == Enum.KeyCode.R then
				while userInputService:IsKeyDown(Enum.KeyCode.R) do
					throwData.angle += 5
					throwData.angle = math.clamp(throwData.angle, 5, 90)
					task.wait(5/30)
				end
			elseif input.KeyCode == Enum.KeyCode.F then
				while userInputService:IsKeyDown(Enum.KeyCode.F) do
					throwData.angle -= 5
					throwData.angle = math.clamp(throwData.angle, 5, 90)
					task.wait(5/30)
				end
			end
		end
	end)
	while true do
		task.wait()
		local s, e = pcall(function()
			if not locked then
				target = findtarget()
			end
			gui.Enabled = enabled and showCards and player.PlayerGui:FindFirstChild("BallGui")
			beam.Enabled = showBeam and enabled and player.PlayerGui:FindFirstChild("BallGui")
			if player.PlayerGui:FindFirstChild("BallGui") and target and player.Character:FindFirstChild("Head") then
				local distance = (player.Character.Head.Position - target.Head.Position).Magnitude
				if autoAngle then
					throwData.angle = solveForAngle(distance)
				end
				if autoChooseThrowType then
					if checkMovingTowardsQB() and checkIsDiagonal() then
						throwType = "Fold"
					elseif not checkIsSideways() and not checkMovingTowardsQB() then
						local dis = findClosestDistanceToDB()
						if dis > 5 then
							throwType = "Dime"
						else
							throwType = "Mag"
						end
					elseif checkIsSideways() then
						if distance < 135 then
							throwType = "Bullet"
						else
							throwType = "Slant"
						end
					elseif checkMovingTowardsQB() then
						throwType = "Bullet"
					else
						throwType = "Dime"
					end
				end

if throwType == "Dime" then
    throwHeightOffset = -8 else
    throwHeightOffset = 0
end

				local moveDirection = (straightenThrowDirection and straightenMoveDirection(getMoveDirection(target), target.Head.Position)) or getMoveDirection(target)
				local power = findPower(target.Head.Position)
				local t = solveForT(target, power, throwData.angle)
				local leadDistance = throwTypeLead[throwType] + leadDistance
				local predictedPosition = target.Head.Position + Vector3.new(0, throwHeightOffset, 0) + (moveDirection * 20 * t) + moveDirection * leadDistance
				local _, dir, power = calculateVelocity(player.Character.Head.Position, predictedPosition, t)
				local c0, c1, cf1, cf2 = beamProjectile(Vector3.new(0, -28, 0), dir * power, player.Character.Head.Position + dir * 5, t * 1.75)
				beam.CurveSize0 = c0
				beam.CurveSize1 = c1
				beam.Color = ColorSequence.new(Color3.fromRGB(37, 115, 58))
				a0.CFrame = a0.Parent.CFrame:Inverse() * cf1
				a1.CFrame = a1.Parent.CFrame:Inverse() * cf2
				gui.Main.AngleCard.Val.Text = math.round(throwData.angle * 100) / 100
				gui.Main.PowerCard.Val.Text = throwData.power
				gui.Main.PassDurationCard.Val.Text = tostring(math.round(t * 100) / 100).."s"
				gui.Main.ModeCard.Val.Text = throwType
				gui.Main.RouteCard.Val.Text = findRoute(moveDirection)
				throwData.direction = dir; throwData.power = power
			end
		end)
		if not s then
			warn(e)
		end
	end
end)

local Toggle = Tab:CreateToggle({
	Name = "Qb Aimbot",
	CurrentValue = false,
	Callback = function(v)
		enabled = v
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Choose Throw Type",
	CurrentValue = false,
	Callback = function(v)
		autoChooseThrowType = v
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Anti Move Direction",
	CurrentValue = false,
	Callback = function(v)
		print("Hey this toggle 2 got changed to "..tostring(v))
	end,
})

local Slider = Tab:CreateSlider({
	Name = "Lead Distance",
	Range = {-30, 30},
	CurrentValue = 0,
	Callback = function(v)
		leadDistance = v
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Show Beam",
	CurrentValue = false,
	Callback = function(v)
		showBeam = v
	end,
})


local Toggle = Tab:CreateToggle({
	Name = "Show Cards",
	CurrentValue = false,
	Callback = function(v)
		showCards = v
	end,
})

    local Tab = Window:CreateTab("Defense") -- Title, Image
	
local Toggle = Tab:CreateToggle({
        Name = "Block Reach",
        CurrentValue = false,
        Flag = "Toggleraeachvlox1",
        Callback = function(Value)
            block = Value
            if block == true then
                setBlockSize()
            else
                game.Players.LocalPlayer.Character.BlockPart.Size = defaultSize
                blockslider = 10.5
            end
        end
    })

local MainSection = MainTab:CreateSection("Mag")




local Slider = Tab:CreateSlider({
        Name = "Block Reach Visibility",
        Range = {0, 1},
        Increment = 0.1,
        Suffix = "Transparency",
        CurrentValue = 1,
        Flag = "Slidersliderblock1",
        Callback = function(Value)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("BlockPart") then
            game.Players.LocalPlayer.Character.BlockPart.Transparency = Value
            end
        end
    })



local Toggle = Tab:CreateToggle({
    Name = "Football Landing Predictions",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        if Value and not toggleActive then
            toggleActive = true
   
            local function beamProjectile(g, v0, x0, t1)
                -- calculate the bezier points
                local c = 0.5 * 0.5 * 0.5;
                local p3 = 0.5 * g * t1 * t1 + v0 * t1 + x0;
                local p2 = p3 - (g * t1 * t1 + v0 * t1) / 3;
                local p1 = (c * g * t1 * t1 + 0.5 * v0 * t1 + x0 - c * (x0 + p3)) / (3 * c) - p2;
   
                -- the curve sizes
                local curve0 = (p1 - x0).magnitude;
                local curve1 = (p2 - p3).magnitude;
   
                -- build the world CFrames for the attachments
                local b = (x0 - p3).unit;
                local r1 = (p1 - x0).unit;
                local u1 = r1:Cross(b).unit;
                local r2 = (p2 - p3).unit;
                local u2 = r2:Cross(b).unit;
                b = u1:Cross(r1).unit;
   
                local cf1 = CFrame.new(
                    x0.x, x0.y, x0.z,
                    r1.x, u1.x, b.x,
                    r1.y, u1.y, b.y,
                    r1.z, u1.z, b.z
                )
   
                local cf2 = CFrame.new(
                    p3.x, p3.y, p3.z,
                    r2.x, u2.x, b.x,
                    r2.y, u2.y, b.y,
                    r2.z, u2.z, b.z
                )
   
                return curve0, -curve1, cf1, cf2;
            end
   
            eventConnection = workspace.ChildAdded:Connect(function(b)
                if b.Name == "Football" and b:IsA("BasePart") then
                    task.wait()
                    local vel = b.Velocity
                    local pos = b.Position
                    local c0, c1, cf1, cf2 = beamProjectile(Vector3.new(0, -28, 0), vel, pos, 10)
                    local beam = Instance.new("Beam")
                    local a0 = Instance.new("Attachment")
                    local a1 = Instance.new("Attachment")
                    beam.Color = ColorSequence.new(beamColor) -- Use beamColor variable
                    beam.Transparency = NumberSequence.new(0, 0)
                    beam.Segments = 10 * 300
                    beam.CurveSize0 = c0
                    beam.CurveSize1 = c1
                    beam.Name = "Hitbox"
                    beam.Parent = workspace.Terrain
                    a0.Parent = workspace.Terrain
                    a1.Parent = workspace.Terrain
                    a0.CFrame = a0.Parent.CFrame:Inverse() * cf1
                    a1.CFrame = a1.Parent.CFrame:Inverse() * cf2
                    beam.Attachment0 = a0
                    beam.Attachment1 = a1
                    beam.Width0 = 0.5
                    beam.Width1 = 0.5
                    repeat task.wait() until b.Parent ~= workspace
                    a0:Destroy()
                    a1:Destroy()
                end
            end)
        elseif not Value and toggleActive then
            toggleActive = false
            if eventConnection then
                eventConnection:Disconnect()
            end
        end
    end
   })

local ColorPicker = Tab:CreateColorPicker({
    Name = "Beam Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "ColorPicker1",
    Callback = function(Value)
        beamColor = Value -- Update beamColor variable
    end
})
	
    local Tab = Window:CreateTab("Other") -- Title, Image

     local Section = Tab:CreateSection("Features")

     local Button = Tab:CreateButton({
        Name = "Finish Captain Race",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Models.LockerRoomA.FinishLine.CFrame + Vector3.new(0, 2, 0)
        end
     })
     
     local Button = Tab:CreateButton({
        Name = "Remove Uniform",
        Callback = function()
            for i, v in pairs(game.workspace:GetDescendants()) do
                if v:IsA("Model") and v.Parent.Name == game.Players.LocalPlayer.Name and v.Name == "Uniform" then
                v:Destroy()
                end
            end
        end
     })


     
     local track = nil
    
     local Toggle = Tab:CreateToggle({
        Name = "Underground",
        CurrentValue = false,
        Flag = "Toggasfsle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            if Value then
                local Anim = Instance.new("Animation")
                Anim.AnimationId = "rbxassetid://182724289"
                track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
                track:Play(.1, 1, 1)
            local part = Instance.new("Part")
            part.Size = Vector3.new(500, 0.001, 500)
            part.CFrame = CFrame.new(Vector3.new(10.3562937, -1.51527438, 30.4708614))
            part.Anchored = true
            part.Parent = game.Workspace
            
            local model = game:GetService("Workspace").Models.Field.Grass
            for _, part in pairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
            part.CanCollide = false
            part.Transparency = .5
            end
            end
            else 
                track:Stop()
                local model = game:GetService("Workspace").Models.Field.Grass
                for _, part in pairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.CanCollide = true
            end
                end
            end
    end
     })

local Button = Tab:CreateButton({
	Name = "Chat Spy",
	Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/LucidHubPremium/LucidPremium/main/Lucid-Premium-ChatSpy.lua'))()
	end,
})

     
