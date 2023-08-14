
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
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Almost There..."
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

wait(3)

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

Rayfield:Notify({
   Title = "Authentication Success!",
   Content = "",
   Duration = 5,
   Image = 13047715178,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})

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
    Increment = 20,
    Suffix = "Reach",
    CurrentValue = 20,
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
	
    local Tab = Window:CreateTab("Automatics") -- Title, Image

     local Section = Tab:CreateSection("Captain")

     local Button = Tab:CreateButton({
        Name = "Finish Captain Race",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Models.LockerRoomA.FinishLine.CFrame + Vector3.new(0, 2, 0)
        end
     })
