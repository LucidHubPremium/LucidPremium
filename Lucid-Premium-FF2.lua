
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
Coreloader.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
Coreloader.BorderColor3 = Color3.new(0, 0, 0)
Coreloader.BorderSizePixel = 0
Coreloader.Position = UDim2.new(0.35, 0, 0.36807102, 0)
Coreloader.Size = UDim2.new(0, 568, 0, 239)

Loader.Name = "Loader"
Loader.Parent = Coreloader
Loader.BackgroundColor3 = Color3.new(0.372549, 0.117647, 0.458824)
Loader.BorderColor3 = Color3.new(0, 0, 0)
Loader.BorderSizePixel = 0
Loader.Position = UDim2.new(0.0528169014, 0, 0.815899551, 0)
Loader.Size = UDim2.new(0, 507, 0, 8)

Thing.Name = "Thing"
Thing.Parent = Loader
Thing.BackgroundColor3 = Color3.new(1, 0.172549, 1)
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
TextLabel2.Text = "Lucid"
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
TextLabel.Text = "Please wait loading wont take long..."
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
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Checking Whitelist..."
end

function namechange2()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Authenticating..."
end

function namechange3()
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Bypassing..."
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

function endtween2()
	local tweenInfo2 = TweenInfo.new(tween_time2, Enum.EasingStyle.Quad)
	local tween2 = game:GetService("TweenService"):Create(frame2, tweenInfo2, {Position = guipos})
	tween2:Play()
end
endtween2()

wait(10)

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
local tab = win:Tab("Catching")

tab:Toggle("Silent Pull Vector", false, function(Value)
    pullVectorEnabled = Value  
end)

tab:Slider("Pull Vector Distance", 16, 30, 1, function(Value)
    pullVectorMagnitude = Value  
end)









local tab = win:Tab("Teleport")
tab:Button("Auto Captain", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Models.LockerRoomA.FinishLine.CFrame + Vector3.new(0, 2, 0)
        end)

local tab = win:Tab("Player")

local Playeer = game.Players.LocalPlayer
_G.CheckingTool = false

tab:Toggle("Long Arms", false, function(bool)
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


tab:Toggle("Long Arms", false, function(bool)
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
end)

tab:Slider("Long Arms Strength", 1, 40, 20, function(g)
   _G.Legs = g
if _G.CheckingTool == true then
Playeer.Character['Left Leg'].Size = Vector3.new(1, _G.Legs, 1)
Playeer.Character['Right Leg'].Size = Vector3.new(1, _G.Legs, 1)
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
