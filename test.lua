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








local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()
local Window = UILib.new("Lucid", game.Players.LocalPlayer.UserId, "Buyer")
local Category1 = Window:Category("Player", "http://www.roblox.com/asset/?id=8395621517")
local Category2 = Window:Category("Settings", "http://www.roblox.com/asset/?id=8395621517")
local SubButton1 = Category1:Button("Settings", "http://www.roblox.com/asset/?id=8395747586")
local Section1 = SubButton1:Section("Humanoid", "Left")


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
     Player.Character.Humanoid.JumpPower = value            -- Change any value you want
end)
		       
        
        SpoofProp(Player.Character.Humanoid, "JumpPower")      -- Here you can either change to walkspeed or "JumpPower"
      
      

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





	
