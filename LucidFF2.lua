
local CoreGui = Instance.new("ScreenGui")
local Coreloader = Instance.new("Frame")
local Loader = Instance.new("Frame")
local Thing = Instance.new("Frame")
local TextLabel2 = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
 
CoreGui.Name = "CoreGui"
CoreGui.Parent = game.CoreGui
CoreGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Coreloader.Name = "Coreloader"
Coreloader.Parent = CoreGui
Coreloader.BackgroundColor3 = Color3.fromRGB(30, 31, 33)
Coreloader.BorderColor3 = Color3.new(0, 0, 0)
Coreloader.BorderSizePixel = 0
Coreloader.Position = UDim2.new(0.35, 0, 0.36807102, 0)
Coreloader.Size = UDim2.new(0, 568, 0, 239)

Loader.Name = "Loader"
Loader.Parent = Coreloader
Loader.BackgroundColor3 = Color3.fromRGB(49, 50, 54)
Loader.BorderColor3 = Color3.new(0, 0, 0)
Loader.BorderSizePixel = 0
Loader.Position = UDim2.new(0.0528169014, 0, 0.815899551, 0)
Loader.Size = UDim2.new(0, 507, 0, 8)

Thing.Name = "Thing"
Thing.Parent = Loader
Thing.BackgroundColor3 = Color3.fromRGB(27, 97, 227)
Thing.BorderColor3 = Color3.new(0, 0, 0)
Thing.BorderSizePixel = 0
Thing.Size = UDim2.new(0, 0, 0, 8)

TextLabel2.Name = "TextLabel2"
TextLabel2.Parent = Coreloader
TextLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel2.BackgroundTransparency = 1
TextLabel2.BorderColor3 = Color3.new(0, 0, 0)
TextLabel2.BorderSizePixel = 0
TextLabel2.Position = UDim2.new(0.0827464759, 0, 0.125523016, 0)
TextLabel2.Size = UDim2.new(0, 473, 0, 50)
TextLabel2.Font = Enum.Font.Gotham
TextLabel2.Text = "Lucid Loader"
TextLabel2.TextColor3 = Color3.new(1, 1, 1)
TextLabel2.TextSize = 28

TextLabel.Parent = Coreloader
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.107394367, 0, 0.882845163, 0)
TextLabel.Size = UDim2.new(0, 441, 0, 19)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = ""
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14

TextButton.Parent = Coreloader
TextButton.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.383802831, 0, 0.430962354, 0)
TextButton.Size = UDim2.new(0, 130, 0, 50)
TextButton.Font = Enum.Font.Gotham
TextButton.Text = "Copy Discord Link"
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 14



local frame = game:GetService("CoreGui").CoreGui.Coreloader.Loader.Thing
local guisize = UDim2.new(0, 509,0, 8)
local tween_time = math.random(4,5)
local tween_time2 = 2
local frame2 = game:GetService("CoreGui").CoreGui.Coreloader
local guipos = UDim2.new(0.35, 0,-0.500, 0)
local button = game:GetService("CoreGui").CoreGui.Coreloader.TextButton

button.MouseButton1Click:Connect(function()
setclipboard("https://discord.gg/hwmCFgppQH")
end)

wait(0.1)	

function namechange1()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Lucid Loader"
end

function namechange2()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Lucid Loader"
end

function namechange3()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Lucid Loader"
end

function namechange4()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Checking Whitelist..."
end

function starttween()
	local tweenInfo = TweenInfo.new(tween_time, Enum.EasingStyle.Linear)
	local tween = game:GetService("TweenService"):Create(frame, tweenInfo, {Size = guisize})
	tween:Play()
end	
wait(0.5)
starttween()
wait(1)
namechange1()
wait(1.2)
namechange2()
wait(1.4)
namechange3()
wait(2.4)
namechange4()
wait(6.0)

function endtween2()
	local tweenInfo2 = TweenInfo.new(tween_time2, Enum.EasingStyle.Quad)
	local tween2 = game:GetService("TweenService"):Create(frame2, tweenInfo2, {Position = guipos})
	tween2:Play()
end
endtween2()

wait(5)

	game:GetService("CoreGui").CoreGui:Destroy()



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





local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Lucid",
   LoadingTitle = "Lucid",
   LoadingSubtitle = "",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Example Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key | Youtube Hub",
      Subtitle = "Key System",
      Note = "Key In Discord Server",
      FileName = "YoutubeHubKey1", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/AtgzSPWK"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Catching", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Player")



local Playeer = game.Players.LocalPlayer
_G.CheckingTool = false

local Toggle = MainTab:CreateToggle({
Name = "Long Arms",
CurrentValue = false, 
Flag = "Toggle",
Callback = function(bool)
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
end,
  })

local Toggle = MainTab:CreateToggle({
Name = "Long Legs",
CurrentValue = false, 
Flag = "Toggle",
Callback = function(bool)
_G.CheckingTool = bool
Highlight = Instance.new("Highlight", Playeer.Character['Left Leg'])
Highlight.Enabled = bool
Highlight = Instance.new("Highlight", Playeer.Character['Right Leg'])
Highlight.Enabled = bool
getgenv().jjj = bool
if getgenv().jjj == true then
Playeer.Character['Left Leg'].Size = Vector3.new(1, _G.Legs, 1)
Playeer.Character['Right Leg'].Size = Vector3.new(1, _G.Legs, 1)
Playeer.Character['Left Leg'].Transparency = .999
Playeer.Character['Right Leg'].Transparency = .999
elseif getgenv().jjj == false then
Playeer.Character['Left Leg'].Size = Vector3.new(1, 2, 1)
Playeer.Character['Right Leg'].Size = Vector3.new(1, 2, 1)
Playeer.Character['Left Leg'].Transparency = 0
Playeer.Character['Right Leg'].Transparency = 0
end
end,
  })
local MainSection = MainTab:CreateSection("Adjust")
local Slider = MainTab:CreateSlider({
    Name = "Long Arms Reach",
    Range = {1, 40},
    Increment = 1,
    Suffix = "Reach",
    CurrentValue = 1,
    Flag = "JPSlider",
    Callback = function(g)
      _G.Arms = g
if _G.CheckingTool == true then
Playeer.Character['Left Arm'].Size = Vector3.new(1, _G.Arms, 1)
Playeer.Character['Right Arm'].Size = Vector3.new(1, _G.Arms, 1)
elseif _G.CheckingTool == false then
		end
end,
  })

local Slider = MainTab:CreateSlider({
    Name = "Long Legs Height",
    Range = {1, 15},
    Increment = 1,
    Suffix = "Reach",
    CurrentValue = 1,
    Flag = "JPSlider",
    Callback = function(g)
     _G.Legs = g
if _G.CheckingTool == true then
Playeer.Character['Left Leg'].Size = Vector3.new(1, _G.Legs, 1)
Playeer.Character['Right Leg'].Size = Vector3.new(1, _G.Legs, 1)
elseif _G.CheckingTool == false then
		end
end,
  })

local MainSection = MainTab:CreateSection("Other")

local Toggle = MainTab:CreateToggle({
   Name = "Fake JP (Jump twice)",
   CurrentValue = false,
   Flag = "Toggle",
   Callback = function(Value)
   		
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
    --Ensures this only runs once to save resources
    _G.infinJumpStarted = true
    
    --Notifies readiness
    game.StarterGui:SetCore("SendNotification", {Title="Youtube Hub"; Text="Infinite Jump Activated!"; Duration=5;})

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

local Tab = Window:CreateTab("Teleport") -- Title, Image

     local Section = Tab:CreateSection("Areas")

local Button = Tab:CreateButton({
        Name = "TP to Home Endzone",
        Callback = function()
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
 end,
})


local Button = Tab:CreateButton({
        Name = "TP to Away Endzone",
        Callback = function()
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
 end,
})

local Section = Tab:CreateSection("Misc")

local Button = Tab:CreateButton({
        Name = "Server Hop",
        Callback = function()
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
 end,
	})



    local Tab = Window:CreateTab("Visuals") -- Title, Image

     local Section = Tab:CreateSection("Visuals")

     local Toggle = Tab:CreateToggle({
   Name = "Ball Tracer",
   CurrentValue = false,
   Flag = "Toggle",
   Callback = function(enabled)
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
     end,
})
    
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
        
