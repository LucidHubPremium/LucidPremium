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
	game:GetService("CoreGui").CoreGui.Coreloader.TextLabel2.Text = "Loading UI.."
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




local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
local numTeleports = 30 -- Define the number of teleports
local tooggleEnabled = false -- Variable to track the toggle state






local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()
local Window = UILib.new("Lucid", game.Players.LocalPlayer.UserId, "Buyer")
local Category12 = Window:Category("Catching", "http://www.roblox.com/asset/?id=8395621517")
local Category1 = Window:Category("Player", "http://www.roblox.com/asset/?id=8395621517")
local Category2 = Window:Category("Settings", "http://www.roblox.com/asset/?id=8395621517")
local Category3 = Window:Category("Kicking", "http://www.roblox.com/asset/?id=8395621517")
local Category4 = Window:Category("Physics", "http://www.roblox.com/asset/?id=8395621517")
local SubButton12 = Category12:Button(".", "")
local SubButton1 = Category1:Button("-", "")
local SubButton2 = Category2:Button("--", "")
local SubButton3 = Category3:Button("---", "")
local SubButton4 = Category4:Button("----", "")
local Section12 = SubButton12:Section("Customizable Mags", "Left")
local Section1 = SubButton1:Section("Humanoid", "Left")
local Section2 = SubButton2:Section("Settings", "Left")
local Section3 = SubButton3:Section("Kicking", "Left")
local Section4 = SubButton4:Section("Enhancement", "Left")








local wiihub = {
	pv = true,
	unitoggle = true,
	blatoggle = true,
	block = true,
	AutoFollowQb = true,
	tprange = 0,
	autocatchv = 0,
}

local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local remotes = replicatedStorage:FindFirstChild("Remotes")
local characterSoundEvent = remotes:FindFirstChild("CharacterSoundEvent")
local player = players.LocalPlayer
local runService = game:GetService("RunService")

local blatant = 0
local universal = 0
local uis = game:GetService("UserInputService")
local uniDelay = 0
local regDelay = 0

-- Functions

local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
local numTeleports = 30 -- Define the number of teleports
local tooggleEnabled = false -- Variable to track the toggle state

local function universalcatch()
	if tooggleEnabled then
		local catchRight = Players.LocalPlayer.Character:FindFirstChild("CatchRight")

		if not catchRight then
			return
		end

		local closestFootball = nil
		local closestDistance = math.huge

		for i, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "Football" and v:IsA("BasePart") then
				local distance = (v.Position - catchRight.Position).Magnitude
				if distance < closestDistance and distance <= universal then
					v.CanCollide = false
					closestDistance = distance
					closestFootball = v
				end
			end
		end

		if closestFootball then
				wait(uniDelay)
			firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
			firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
			task.wait()
		end
	end
end









Section12:Toggle({
    Title = "Mags",
    Description = "",
    Default = false
    }, function(v)
    print(enabled)
   tooggleEnabled = v
	while tooggleEnabled == true do
		task.wait()
		universalcatch()
	end
end)




Section12:Slider({
    Title = "Mag Delay",
    Description = "",
    Default = 0,
    Min = 0,
    Max = 1,
    }, function(v)
    print(value)
		
    uniDelay = v
end)

Section12:Slider({
    Title = "Mag Range",
    Description = "",
    Default = 0,
    Min = 0,
    Max = 30,
    }, function(v)
    print(value)
		
    universal = v
end)


















	local Spoofed = {};
        local Clone = game.Clone;
        local oldIdx;
        local oldNewIdx;
        local OldNC;
        
        
        local Player = game:GetService("Players").LocalPlayer;
        
        local Methods = {
            "FindFirstChild",
            "FindFirstChildOfClass",
            "FindFirstChildWhichIsA"
        }

        local function SpoofProp(Instance, Property)
            local Cloned = Clone(Instance);
        
            table.insert(Spoofed, {
                Instance = Instance,
                Property = Property;
                ClonedInstance = Cloned;
            })
        end
        
        
        oldIdx = hookmetamethod(game, "__index", function(self, key)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldIdx(v.ClonedInstance, key)
                end
        
                if key == "Parent" and (self == v.ClonedInstance or self == v.Instance) and checkcaller() == false then
                    return oldIdx(v.Instance, key)
                end
            end
        
            return oldIdx(self, key)
        end)
        
        oldNewIdx = hookmetamethod(game, "__newindex", function(self, key, newval, ...)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldNewIdx(v.ClonedInstance, key, newval, ...);
                end
            end
            return oldNewIdx(self, key, newval, ...)
        end)
        
        OldNC = hookmetamethod(game, "__namecall", function(self, ...)
            
            local Method = getnamecallmethod();
        
            if not table.find(Methods, Method) or Player.Character == nil or self ~= Player.Character then
                return OldNC(self, ...)
            end
            
            local Results = OldNC(self, ...);
        
            if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                for i,v in next, Spoofed do
                    if v.Instance == Results then
                        return v.ClonedInstance
                    end
                end
            end
            return OldNC(self, ...)
        end)
        
        for i, Method in next, Methods do
            local Old;
        
            Old = hookfunction(game[Method], function(self, ...)
                if not Player.Character or self ~= Player.Character then
                    return Old(self, ...)
                end
        
                local Results = Old(self, ...);
        
                if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                    for i,v in next, Spoofed do
                        if v.Instance == Results then
                            return v.ClonedInstance
                        end
                    end
                end
                return Old(self, ...)
            end)
        end
        
       

Section1:Slider({
    Title = "Walkspeed",
    Description = "",
    Default = 20,
    Min = 0,
    Max = 75
    }, function(value)
    print(value)
     Player.Character.Humanoid.WalkSpeed = value            -- Change any value you want
end)
		       
        
        SpoofProp(Player.Character.Humanoid, "WalkSpeed")      -- Here you can either change to walkspeed or "JumpPower"
      
      

Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "WalkSpeed")
            character.Humanoid.WalkSpeed = value
        end)




 




Section1:Slider({
    Title = "JumpPower",
    Description = "",
    Default = 50,
    Min = 0,
    Max = 110
    }, function(value)
    print(value)
     game.Players.LocalPlayer.Character.Humanoid.JumpPower = value            -- Change any value you want
end)
		       
        
        SpoofProp(game.Players.LocalPlayer.Character.Humanoid, "JumpPower")      -- Here you can either change to walkspeed or "JumpPower"
      
      

Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "JumpPower")
            character.Humanoid.JumpPower = value
        end)






Section1:Slider({
    Title = "HipHeight",
    Description = "",
    Default = 0,
    Min = 0,
    Max = 25
    }, function(value)
    print(value)
     Player.Character.Humanoid.HipHeight= value            -- Change any value you want
end)
		       
        
        SpoofProp(Player.Character.Humanoid, "HipHeight")      -- Here you can either change to walkspeed or "JumpPower"
      
      

Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "HipHeight")
            character.Humanoid.HipHeight = value
        end)






Section1:Button({
    Title = "",
    ButtonName = "Enable",
    Description = "Set JumpPower to 52",
    }, function(value)
    print(value)

		        local Spoofed = {};
        local Clone = game.Clone;
        local oldIdx;
        local oldNewIdx;
        local OldNC;
        
        
        local Player = game:GetService("Players").LocalPlayer;
        
        local Methods = {
            "FindFirstChild",
            "FindFirstChildOfClass",
            "FindFirstChildWhichIsA"
        }

        local function SpoofProp(Instance, Property)
            local Cloned = Clone(Instance);
        
            table.insert(Spoofed, {
                Instance = Instance,
                Property = Property;
                ClonedInstance = Cloned;
            })
        end
        
        
        oldIdx = hookmetamethod(game, "__index", function(self, key)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldIdx(v.ClonedInstance, key)
                end
        
                if key == "Parent" and (self == v.ClonedInstance or self == v.Instance) and checkcaller() == false then
                    return oldIdx(v.Instance, key)
                end
            end
        
            return oldIdx(self, key)
        end)
        
        oldNewIdx = hookmetamethod(game, "__newindex", function(self, key, newval, ...)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldNewIdx(v.ClonedInstance, key, newval, ...);
                end
            end
            return oldNewIdx(self, key, newval, ...)
        end)
        
        OldNC = hookmetamethod(game, "__namecall", function(self, ...)
            
            local Method = getnamecallmethod();
        
            if not table.find(Methods, Method) or Player.Character == nil or self ~= Player.Character then
                return OldNC(self, ...)
            end
            
            local Results = OldNC(self, ...);
        
            if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                for i,v in next, Spoofed do
                    if v.Instance == Results then
                        return v.ClonedInstance
                    end
                end
            end
            return OldNC(self, ...)
        end)
        
        for i, Method in next, Methods do
            local Old;
        
            Old = hookfunction(game[Method], function(self, ...)
                if not Player.Character or self ~= Player.Character then
                    return Old(self, ...)
                end
        
                local Results = Old(self, ...);
        
                if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                    for i,v in next, Spoofed do
                        if v.Instance == Results then
                            return v.ClonedInstance
                        end
                    end
                end
                return Old(self, ...)
            end)
        end
        
        SpoofProp(Player.Character.Humanoid, "JumpPower")      -- Here you can either change to walkspeed or "JumpPower"
        Player.Character.Humanoid.JumpPower = 52            -- Change any value you want
        
        Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "JumpPower")
            character.Humanoid.JumpPower = 52
        end)
end)










Section1:Button({
    Title = "",
    ButtonName = "Enable",
    Description = "Set Walkspeed to 45",
    }, function(value)
    print(value)

		        local Spoofed = {};
        local Clone = game.Clone;
        local oldIdx;
        local oldNewIdx;
        local OldNC;
        
        
        local Player = game:GetService("Players").LocalPlayer;
        
        local Methods = {
            "FindFirstChild",
            "FindFirstChildOfClass",
            "FindFirstChildWhichIsA"
        }

        local function SpoofProp(Instance, Property)
            local Cloned = Clone(Instance);
        
            table.insert(Spoofed, {
                Instance = Instance,
                Property = Property;
                ClonedInstance = Cloned;
            })
        end
        
        
        oldIdx = hookmetamethod(game, "__index", function(self, key)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldIdx(v.ClonedInstance, key)
                end
        
                if key == "Parent" and (self == v.ClonedInstance or self == v.Instance) and checkcaller() == false then
                    return oldIdx(v.Instance, key)
                end
            end
        
            return oldIdx(self, key)
        end)
        
        oldNewIdx = hookmetamethod(game, "__newindex", function(self, key, newval, ...)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldNewIdx(v.ClonedInstance, key, newval, ...);
                end
            end
            return oldNewIdx(self, key, newval, ...)
        end)
        
        OldNC = hookmetamethod(game, "__namecall", function(self, ...)
            
            local Method = getnamecallmethod();
        
            if not table.find(Methods, Method) or Player.Character == nil or self ~= Player.Character then
                return OldNC(self, ...)
            end
            
            local Results = OldNC(self, ...);
        
            if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                for i,v in next, Spoofed do
                    if v.Instance == Results then
                        return v.ClonedInstance
                    end
                end
            end
            return OldNC(self, ...)
        end)
        
        for i, Method in next, Methods do
            local Old;
        
            Old = hookfunction(game[Method], function(self, ...)
                if not Player.Character or self ~= Player.Character then
                    return Old(self, ...)
                end
        
                local Results = Old(self, ...);
        
                if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                    for i,v in next, Spoofed do
                        if v.Instance == Results then
                            return v.ClonedInstance
                        end
                    end
                end
                return Old(self, ...)
            end)
        end
        
        SpoofProp(Player.Character.Humanoid, "WalkSpeed")      -- Here you can either change to walkspeed or "JumpPower"
        Player.Character.Humanoid.WalkSpeed = 45              -- Change any value you want
        
        Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "WalkSpeed")
            character.Humanoid.WalkSpeed = 45
        end)
end)


Section1:Button({
    Title = "",
    ButtonName = "Enable",
    Description = "Set HipHeight to 16",
    }, function(value)
    print(value)

		        local Spoofed = {};
        local Clone = game.Clone;
        local oldIdx;
        local oldNewIdx;
        local OldNC;
        
        
        local Player = game:GetService("Players").LocalPlayer;
        
        local Methods = {
            "FindFirstChild",
            "FindFirstChildOfClass",
            "FindFirstChildWhichIsA"
        }

        local function SpoofProp(Instance, Property)
            local Cloned = Clone(Instance);
        
            table.insert(Spoofed, {
                Instance = Instance,
                Property = Property;
                ClonedInstance = Cloned;
            })
        end
        
        
        oldIdx = hookmetamethod(game, "__index", function(self, key)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldIdx(v.ClonedInstance, key)
                end
        
                if key == "Parent" and (self == v.ClonedInstance or self == v.Instance) and checkcaller() == false then
                    return oldIdx(v.Instance, key)
                end
            end
        
            return oldIdx(self, key)
        end)
        
        oldNewIdx = hookmetamethod(game, "__newindex", function(self, key, newval, ...)
            for i,v in next, Spoofed do
                if self == v.Instance and key == v.Property and not checkcaller() then
                    return oldNewIdx(v.ClonedInstance, key, newval, ...);
                end
            end
            return oldNewIdx(self, key, newval, ...)
        end)
        
        OldNC = hookmetamethod(game, "__namecall", function(self, ...)
            
            local Method = getnamecallmethod();
        
            if not table.find(Methods, Method) or Player.Character == nil or self ~= Player.Character then
                return OldNC(self, ...)
            end
            
            local Results = OldNC(self, ...);
        
            if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                for i,v in next, Spoofed do
                    if v.Instance == Results then
                        return v.ClonedInstance
                    end
                end
            end
            return OldNC(self, ...)
        end)
        
        for i, Method in next, Methods do
            local Old;
        
            Old = hookfunction(game[Method], function(self, ...)
                if not Player.Character or self ~= Player.Character then
                    return Old(self, ...)
                end
        
                local Results = Old(self, ...);
        
                if Results and Results:IsA("Humanoid") and Player.Character and self == Player.Character then
                    for i,v in next, Spoofed do
                        if v.Instance == Results then
                            return v.ClonedInstance
                        end
                    end
                end
                return Old(self, ...)
            end)
        end
        
        SpoofProp(Player.Character.Humanoid, "HipHeight")      -- Here you can either change to walkspeed or "JumpPower"
        Player.Character.Humanoid.HipHeight = 16           -- Change any value you want
        
        Player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid")
            SpoofProp(character.Humanoid, "HipHeight")
            character.Humanoid.HipHeight = 16
        end)
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
     
                             TextLabel.Text = tostring(math.floor(Distance)) .. "m"
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



Section2:Toggle({
    Title = "Ball Tracer",
    Description = "",
    Default = false
    }, function(enabled)
    print(enabled)
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






Section2:Button({
    Title = "Chat Spy",
    ButtonName = "Enable",
    Description = "See Private Msgs",
    }, function(value)
    print(value)
 --This script reveals ALL hidden messages in the default chat
--chat "/spy" to toggle!
enabled = true
--if true will check your messages too
spyOnMyself = true
--if true will chat the logs publicly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = true
--customize private logs
privateProperties = {
    Color = Color3.fromRGB(62, 148, 240); 
    Font = Enum.Font.SourceSansBold;
    TextSize = 18;
}
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance
 
local function onChatted(p,msg)
    if _G.chatSpyInstance == instance then
        if p==player and msg:lower():sub(1,4)=="/spy" then
            enabled = not enabled
            wait(0.3)
            privateProperties.Text = "[Lucid Premium Spy] "..(enabled and "EN" or "DIS").."ABLED:"
            StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
        elseif enabled and (spyOnMyself==true or p~=player) then
            msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
            local hidden = true
            local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
                if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
                    hidden = false
                end
            end)
            wait(1)
            conn:Disconnect()
            if hidden and enabled then
                if public then
                    saymsg:FireServer((publicItalics and "/me " or '').."[Lucid Premium Spy] [".. p.Name .."]: "..msg,"All")
                else
                    privateProperties.Text = "[Lucid Premium Spy] [".. p.Name .."]: "..msg
                    StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
                end
            end
        end
    end
end
 
for _,p in ipairs(Players:GetPlayers()) do
    p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
    p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
privateProperties.Text = "[Lucid Spy] "..(enabled and "en" or "dis").."abled"
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
                end)




Section2:Button({
    Title = "No Textures",
    ButtonName = "Enable",
    Description = "Increases FPS",
    }, function(value)
    print(value)

loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
	end)
	








local autokick = false 

task.spawn(function()

getgenv().Variables = {}

	Variables.Players = game:GetService("Players")
	Variables.ReplicatedStorage = game:GetService("ReplicatedStorage")
	Variables.UserInputService = game:GetService("UserInputService")
	Variables.Client = Variables.Players.LocalPlayer
	Variables.Character = Variables.Client.Character or Variables.Client.CharacterAdded:Wait()

	Variables.Client.CharacterAdded:Connect(function(Character)
		Variables.Character = Character 
	end)

	local Aimbot = {}

	function Aimbot:GetAccuracyArrow(Arrows)
		local Y = 0
		local Arrow1 = nil

		for _, Arrow in pairs(Arrows) do
			if Arrow.Position.Y.Scale > Y then
				Y = Arrow.Position.Y.Scale
				Arrow1 = Arrow 
			end
		end

		return Arrow1
	end

	Variables.Client.PlayerGui.ChildAdded:Connect(function(child)
		if child.Name == "KickerGui" and autokick == true then
			local KickerGui = child 
			local Meter = KickerGui:FindFirstChild("Meter")
			local Cursor = Meter:FindFirstChild("Cursor")
			local Arrows = {}

			for i,v in pairs(Meter:GetChildren()) do
				if string.find(v.Name:lower(), "arrow") then
					table.insert(Arrows, v)
				end
			end 

			repeat task.wait() until Cursor.Position.Y.Scale < 0.02
			mouse1click()
			repeat task.wait() until Cursor.Position.Y.Scale >= Aimbot:GetAccuracyArrow(Arrows).Position.Y.Scale + (.03 / (100 / 100))
			mouse1click()
		end
	end)
end)



Section3:Toggle({
    Title = "Kicker Aimbot",
    Description = "Automatically Kicks For You",
    Default = false
    }, function(v)
    print(value)
		autokick = v
end)














local isAntiJamEnabled = false

local function updateCollisionState()
	while true do
		if isAntiJamEnabled then
			if game.Players.LocalPlayer.Character.Head.CanCollide then
				for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
					if player ~= game.Players.LocalPlayer then
						pcall(function()
							player.Character.Torso.CanCollide = false
							player.Character.Head.CanCollide = false
						end)
					end
				end
			end
		else
			if not game.Players.LocalPlayer.Character.Head.CanCollide then
				game.Players.LocalPlayer.Character.Torso.CanCollide = true
				game.Players.LocalPlayer.Character.Head.CanCollide = true
			end
		end
		task.wait()
	end
end

Section4:Toggle({
    Title = "Anti-Jam",
    Description = "",
    Default = false
    }, function(enabled)
    print(value)
		isAntiJamEnabled = enabled
end)


spawn(updateCollisionState)

local player = game.Players.LocalPlayer
local toggleEnabled = false -- Variable to track if the toggle is enabled

local function onKeyPress(input)
    if toggleEnabled and input.KeyCode == Enum.KeyCode.F then
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if character and humanoid then
            local forwardVector = character.HumanoidRootPart.CFrame.LookVector
            local newPosition = character.HumanoidRootPart.Position + forwardVector * 3
            local newCFrame = CFrame.new(newPosition, newPosition + forwardVector)
            character.HumanoidRootPart.CFrame = newCFrame
        end
    end
end




Section4:Toggle({
    Title = "Quick TP | F",
    Description = "",
    Default = false
    }, function(value)
    print(value)
		toggleEnabled = value -- Update the toggle state when it's toggled on/off
end)


game:GetService("UserInputService").InputBegan:Connect(onKeyPress)
