


do --//
    local coreGui = game:GetService("CoreGui")
    local contentProvider = game:GetService('ContentProvider')
    local tbl = {}
    
    for index, descendant in pairs(coreGui:GetDescendants()) do
        if descendant:IsA("ImageLabel") and string.find(descendant.Image, "rbxasset://") then
            table.insert(tbl, descendant.Image)
        end
    end
    
    local preloadAsync; preloadAsync = hookfunction(contentProvider.PreloadAsync, function(self, ...)
        local args = {...}
        if not checkcaller() and type(args[1]) == "table" and table.find(args[1], coreGui) then
            args[1] = tbl
            return preloadAsync(self, unpack(args))
        end
        return preloadAsync(self, ...)
    end)
    
    local function compareMethod(m1, m2)
        return string.lower(m1) == string.lower(m2)
    end
    
    local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if not checkcaller() and type(args[1]) == "table" and table.find(args[1], coreGui) and self == contentProvider and compareMethod("PreloadAsync", method) then
            args[1] = tbl
            return __namecall(self, unpack(args))
        end
        return __namecall(self, ...)
    end)
end



local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Lucid",Color3.fromRGB(66, 135, 245), Enum.KeyCode.RightControl)

-----

local wiihub = {
	pv = true,
	unitoggle = true,
	blatoggle = true,
	block = true,
	blockslider = 1.5,
	AutoFollowQb = true,
	tprange = 0,
	autocatchv = 0,	
   }

   local blatant = 0
   local universal = 0


----- actual stuff




local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local pullVectorEnabled = false  
local pullVectorMagnitude = 10 

function magBall(ball)
    if ball and player.Character then
        local direction = (ball.Position - player.Character.HumanoidRootPart.Position).Unit
        player.Character.HumanoidRootPart.Velocity = direction * pullVectorMagnitude  
    end
end

runService.Stepped:Connect(function()
    if pullVectorEnabled then
        for _, ball in ipairs(workspace:GetChildren()) do
            if ball.Name == "Football" and ball:IsA("BasePart") then
                local magnitude = (player.Character.HumanoidRootPart.Position - ball.Position).Magnitude
                if magnitude < 10 then
                    magBall(ball)
                end
            end
        end
    end
end)
tab:Toggle("Silent Pull Vector", false, function(Value)
    pullVectorEnabled = Value  
end)

tab:Slider("Pull Vector Distance", 16, 30, 1, function(Value)
    pullVectorMagnitude = Value  
end)






local tab = win:Tab("Defense")

local swatreachmain = false
local player = game.Players.LocalPlayer
local swatDistance = math.huge
local swatted = false
local userInputService = game:GetService("UserInputService")

local function isFootball(fb)
    return fb and fb:FindFirstChildWhichIsA("RemoteEvent")
end

local function getNearestBall(checkFunc)
    local lowestDistance = math.huge
    local lowestFB = nil
    for index, part in pairs(workspace:GetChildren()) do
        if isFootball(part) and not part.Anchored then
            if checkFunc then
                if not checkFunc(part) then
                    continue
                end
            end
            local distance = (player.Character.HumanoidRootPart.Position - part.Position).Magnitude
            if distance < lowestDistance then
                lowestFB = part
                lowestDistance = distance
            end
        end
    end
    return lowestFB, lowestDistance
end

local function getNearestPartToPartFromParts(parts, part)
    local lowestMagnitude = math.huge
    local lowestPart = nil
    for index, p in pairs(parts) do
        local dis = (part.Position - p.Position).Magnitude
        if dis < lowestMagnitude then
            lowestMagnitude = dis
            lowestPart = p
        end
    end
    return lowestPart
end

local function initCharacter(char)
    while swatreachmain do
        task.wait()
        local ball = getNearestBall()
        if ball and swatted then
            local distance = (player.Character.HumanoidRootPart.Position - ball.Position).Magnitude
            if distance < swatDistance then
                local catch = getNearestPartToPartFromParts({player.Character["CatchLeft"], player.Character["CatchRight"]}, ball)
                firetouchinterest(ball, catch, 0)
                firetouchinterest(ball, catch, 1)
            end
        end
    end
end

userInputService.InputBegan:Connect(function(input, gp)
    if not gp then
        if input.KeyCode == Enum.KeyCode.R and not swatted then
            swatted = true
            task.wait(1.5)
            swatted = false
        end
    end
end)

local function updateCharacter(character)
    if swatreachmain then
        initCharacter(character)
    end
end

player.CharacterAdded:Connect(updateCharacter)

tab:Toggle("Swat Reach", swatreachmain, function(value)
    swatreachmain = value
    if value then
        updateCharacter(player.Character) 
    end
end)

if swatreachmain then
    initCharacter(player.Character)
end





-- Auto Swat

local autoswatv = 0

 local enabledd = false

 local function autoswatfunction()
    if enabledd then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local RunService = game:GetService("RunService")

        local function checkDistance(part)
            local distance = (part.Position - humanoidRootPart.Position).Magnitude
            if distance <= autoswatv then
                keypress(0x52)
                keyrelease(0x52)
                task.wait()
            end
        end
        local function updateDistances()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Football" and v:IsA("BasePart") then
                    checkDistance(v)
                end
            end
        end
        connection = RunService.Heartbeat:Connect(updateDistances)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

tab:Toggle("Auto Swat", false, function(v)
    enabledd = v
    autoswatfunction()
end)

tab:Slider("Auto Swat Range", 1, 45, 0, function(v)
    autoswatv = v
end)





local tab = win:Tab("Teleport")

tab:Button("TP to Home Endzone", function()
local Teleport1 = function(XP, YP, ZP)
		local XTpEvery = 8
		local YTpEvery = 1
		local ZTpEvery = 8
		local Timer = 0.2
		local pos = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
		if pos.Position.X < XP then
			for x = pos.Position.X, XP, XTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x, pos.Position.Y, pos.Position.Z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		else
			for x = pos.Position.X, XP, -XTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x, pos.Position.Y, pos.Position.Z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		end
		if pos.Position.Z < ZP then
			for z = pos.Position.Z, ZP, ZTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, pos.Position.Y, z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		else
			for z = pos.Position.Z, ZP, -ZTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, pos.Position.Y, z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		end
		if pos.Position.Y < YP then
			for High = pos.Position.Y, YP, YTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, High, pos.Position.Z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		else
			for High = pos.Position.Y, YP, -YTpEvery do
				game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, High, pos.Position.Z))
				local part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(10, 0.1, 10)
				part.Material = "Glass"
				part.BrickColor = BrickColor.Random()
				part.Transparency = 1
				part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
				wait(Timer)
				part:Destroy()
			end
		end
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(XP, YP, ZP))
	end
Teleport1(2, 6, -169)
 end)


tab:Button("TP To Away Endzone", function()
    local Teleport1 = function(XP, YP, ZP)
        local XTpEvery = 8
        local YTpEvery = 1
        local ZTpEvery = 8
        local Timer = 0.2
        local pos = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
        if pos.Position.X < XP then
            for x = pos.Position.X, XP, XTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x, pos.Position.Y, pos.Position.Z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        else
            for x = pos.Position.X, XP, -XTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x, pos.Position.Y, pos.Position.Z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        end
        if pos.Position.Z < ZP then
            for z = pos.Position.Z, ZP, ZTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, pos.Position.Y, z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        else
            for z = pos.Position.Z, ZP, -ZTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, pos.Position.Y, z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        end
        if pos.Position.Y < YP then
            for High = pos.Position.Y, YP, YTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, High, pos.Position.Z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        else
            for High = pos.Position.Y, YP, -YTpEvery do
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X, High, pos.Position.Z))
                local part = Instance.new("Part", workspace)
                part.Anchored = true
                part.Size = Vector3.new(10, 0.1, 10)
                part.Material = "Glass"
                part.BrickColor = BrickColor.Random()
                part.Transparency = 1
                part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -3.05, 0)
                wait(Timer)
                part:Destroy()
            end
        end
        game.Players.LocalPlayer.Character:MoveTo(Vector3.new(XP, YP, ZP))
    end

    Teleport1(-0, 6, 164)
 end)

tab:Button("Auto Captain", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Models.LockerRoomA.FinishLine.CFrame + Vector3.new(0, 2, 0)
        end)

local tab = win:Tab("Player")

local Playeer = game.Players.LocalPlayer
_G.CheckingTool = false

tab:Toggle("Long Arms", {Toggled=false , Description = false}, function(bool)
   _G.CheckingTool = bool
Highlight = Instance.new("Highlight", Playeer.Character['Left Arm'])
Highlight.Enabled = bool
Highlight = Instance.new("Highlight", Playeer.Character['Right Arm'])
Highlight.Enabled = bool
getgenv().jjj = bool
if getgenv().jjj == true then
Playeer.Character['Left Arm'].Size = Vector3.new(1, _G.Arms, 1)
Playeer.Character['Right Arm'].Size = Vector3.new(1, _G.Arms, 1)
Playeer.Character['Left Arm'].Transparency = .999
Playeer.Character['Right Arm'].Transparency = .999
elseif getgenv().jjj == false then
Playeer.Character['Left Arm'].Size = Vector3.new(1, 2, 1)
Playeer.Character['Right Arm'].Size = Vector3.new(1, 2, 1)
Playeer.Character['Left Arm'].Transparency = 0
Playeer.Character['Right Arm'].Transparency = 0
end
end)

tab:Slider("Long Arms Strength", 1, 40, 20, function(g)
   _G.Arms = g
if _G.CheckingTool == true then
Playeer.Character['Left Arm'].Size = Vector3.new(1, _G.Arms, 1)
Playeer.Character['Right Arm'].Size = Vector3.new(1, _G.Arms, 1)
elseif _G.CheckingTool == false then

end
end)


tab:Toggle("Infinite Jump", false, function(Value)
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
   end)
local tab = win:Tab("Visuals")

tab:Button("Chat Spy", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/LucidHubPremium/LucidPremium/main/Lucid-Premium-ChatSpy.lua'))()
	end)

tab:Button("Remove Uniform", function()
            for i, v in pairs(game.workspace:GetDescendants()) do
                if v:IsA("Model") and v.Parent.Name == game.Players.LocalPlayer.Name and v.Name == "Uniform" then
                v:Destroy()
                end
            end
        end)


tab:Button("Disable Textures", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
  end)


local Tracers = {}
     local DistanceLabels = {}
     local tracerEnabled = false
     
     function AttachBall(Ball)
         local RootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart
         if RootPart then
             if Ball then
                 local Tracer = Drawing.new("Line")
                 Tracer.Visible = false
                 Tracer.Color = Color3.fromRGB(255, 0, 0)
                 Tracer.Thickness = 1
                 Tracer.Transparency = 1
     
                 local TextLabel = Drawing.new("Text")
                 TextLabel.Text = ""
                 TextLabel.Transparency = 1
                 TextLabel.Visible = false
                 TextLabel.Color = Color3.fromRGB(255, 0, 0)
                 TextLabel.Size = 25
     
                 local con
                 con = game:GetService("RunService").RenderStepped:Connect(function()
                     if RootPart.Parent ~= nil and Ball.Parent ~= nil and tracerEnabled then
                         local Vector, OnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(Ball.Position)
                         local Vector2_, OnScreen2 = game.Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
                         local Distance = (RootPart.Position - Ball.Position).Magnitude
     
                         if OnScreen and OnScreen2 then
                             Tracer.From = Vector2.new(Vector2_.X, Vector2_.Y)
                             Tracer.To = Vector2.new(Vector.X, Vector.Y)
                             Tracer.Visible = true
                             TextLabel.Visible = true
     
                             TextLabel.Text = tostring(math.floor(Distance)) .. " Studs Away"
                             TextLabel.Position = Vector2.new(Vector.X, Vector.Y)
     
                             if Distance <= 50 then
                                 TextLabel.Color = Color3.fromRGB(0, 255, 0)
                                 Tracer.Color = Color3.fromRGB(0, 255, 0)
                             else
                                 TextLabel.Color = Color3.fromRGB(255, 0, 0)
                                 Tracer.Color = Color3.fromRGB(255, 0, 0)
                             end
                         else
                             Tracer.Visible = false
                             TextLabel.Visible = false
                         end
                     else
                         con:Disconnect()
                         Tracer.Visible = false
                         TextLabel.Visible = false
                     end
                 end)
     
                 table.insert(Tracers, Tracer)
                 table.insert(DistanceLabels, TextLabel)
             end
         end
     end
     
     workspace.ChildAdded:Connect(function(child)
         if child.Name == "Football" then
             if tracerEnabled then
                 AttachBall(child)
             end
         end
     end)
tab:Toggle("Ball Tracer", {Toggled=false , Description = false}, function(enabled)
        tracerEnabled = enabled
    
        if not enabled then
            
            for _, tracer in ipairs(Tracers) do
                tracer:Remove()
            end
    
            for _, label in ipairs(DistanceLabels) do
                label:Remove()
            end
    
            Tracers = {}
            DistanceLabels = {}
        else
    
            for _, child in ipairs(workspace:GetChildren()) do
                if child.Name == "Football" then
                    AttachBall(child)
                end
            end
        end
     end)

    
        local func = workspace.ChildAdded:Connect(function(f)
            if f.Name == "Football" and f:IsA("BasePart") then
                task.wait()
                local g = Vector3.new(0, -28.1, 0)
                local t = 8
                local v0 = f.Velocity
                local x0 = f.Position
                local curve0, curve1, cf1, cf2 = beamProjectile(g, v0, x0, t)
                   local line = Instance.new("Beam")
                local att0 = Instance.new("Attachment")
                local att1 = Instance.new("Attachment")
                line.Color = ColorSequence.new(Color3.fromRGB(38, 255, 0))
                   line.Transparency = NumberSequence.new(0, 0)
                line.CurveSize0 = curve0
                line.CurveSize1 = curve1
                   line.Name = "Catch"
                line.Parent = workspace.Terrain
          
                    
                line.Segments = 10000
                att0.Parent = workspace.Terrain
                att1.Parent = workspace.Terrain
                att0.CFrame = att0.Parent.CFrame:Inverse() * cf1
                att1.CFrame = att1.Parent.CFrame:Inverse() * cf2
                   line.Attachment0 = att0
                line.Attachment1 = att1
                line.Width0 = 1
                line.Width1 = 1
    
               wait(7)
                    att0:Destroy()
                    att1:Destroy()
                    line:Destroy()
                end
        end)


local tab = win:Tab("Misc")

tab:Button("Server Hop", function()
local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
     
    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
     
    Teleport()
 end)



tab:Button("Rejoin Server", function ()
    repeat
        wait()  
        until game:IsLoaded() 
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId) 
        end)
         
        spawn(function()
            local plr = game.Players.LocalPlayer
        local uis = game:GetService("UserInputService")
                  
 end)
