local relinquish = {}
local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local debris = game:GetService("Debris")

local window = {}; do
	local tab = {}; do
		tab.__index = tab
		function tab:Show()
			for index, child in pairs(self.Children) do
				child.Parent = self.Parent.UI.Main.Core.Tab
			end
		end
		function tab:Hide()
			for index, child in pairs(self.Children) do
				child.Parent = nil
			end
		end
		function tab:CreateToggle(data)
			local toggleClone = self.Parent.Props.Toggle:Clone()
			toggleClone.Title.Text = data.Name
			local tInfo = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
			local function onTween()
				local textTween = tweenService:Create(toggleClone.Title, tInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
				local barTween = tweenService:Create(toggleClone.Bar, tInfo, {BackgroundColor3 = Color3.fromRGB(85, 116, 166)})
				local ballTween = tweenService:Create(toggleClone.Toggle.Ball, tInfo, {Position = UDim2.new(0.5, 0, 0.5, 0)})
				local backgroundTween = tweenService:Create(toggleClone.Toggle, tInfo, {BackgroundColor3 = Color3.fromRGB(57, 78, 109)})
				textTween:Play()
				barTween:Play()
				backgroundTween:Play()
				ballTween:Play()
			end
			local function offTween()
				local textTween = tweenService:Create(toggleClone.Title, tInfo, {TextColor3 = Color3.fromRGB(118, 118, 118)})
				local barTween = tweenService:Create(toggleClone.Bar, tInfo, {BackgroundColor3 = Color3.fromRGB(39, 53, 75)})
				local ballTween = tweenService:Create(toggleClone.Toggle.Ball, tInfo, {Position = UDim2.new(0, 0, 0.5, 0)})
				local backgroundTween = tweenService:Create(toggleClone.Toggle, tInfo, {BackgroundColor3 = Color3.fromRGB(39, 53, 75)})
				textTween:Play()
				barTween:Play()
				backgroundTween:Play()
				ballTween:Play()
			end
			local stateFunc = {
				[true] = onTween;
				[false] = offTween;
			}
			local function onClick(f)
				if not f then
					data.CurrentValue = not data.CurrentValue
				end
				data.Callback(data.CurrentValue)
				stateFunc[data.CurrentValue]()
			end
			stateFunc[data.CurrentValue]()
			toggleClone.Toggle.MouseButton1Click:Connect(onClick)
			toggleClone.Toggle.Ball.MouseButton1Click:Connect(onClick)
			self.Children[#self.Children + 1] = toggleClone
			return {
				Set = function(value)
					data.CurrentValue = value
					onClick(true)
				end,
			}
		end
		function tab:CreateDropdown(data)
			local shown = false
			local dropdownClone = self.Parent.Props.Dropdown:Clone()
			dropdownClone.Title.Text = data.Name
			
			local function refresh()
				dropdownClone.Dropdown.Selected.Text = data.CurrentOption
				data.Callback(data.CurrentOption)
			end
			
			local function showDropdown()
				dropdownClone.Dropdown.List.Visible = true
				dropdownClone.Dropdown.Arrow.Image = "rbxassetid://13582361562"
			end

			local function hideDropdown()
				dropdownClone.Dropdown.List.Visible = false
				dropdownClone.Dropdown.Arrow.Image = "rbxassetid://13582137949"
			end
			
			local function createSelection(option)
				local dropdownText = self.Parent.Props.DropdownText:Clone()
				dropdownClone.Dropdown.List.Size += UDim2.new(0, 0, 0, 22)
				dropdownText.Text = option
				dropdownText.Parent = dropdownClone.Dropdown.List
				dropdownText.MouseButton1Click:Connect(function()
					shown = false
					hideDropdown()
					data.CurrentOption = option
					refresh()
				end)
			end
			
			local stateFunc = {
				[false] = hideDropdown,
				[true] = showDropdown,
			}
			
			for index, option in pairs(data.Options) do
				createSelection(option)
			end
			
			dropdownClone.Dropdown.Arrow.MouseButton1Click:Connect(function()
				shown = not shown
				stateFunc[shown]()
			end)
			
			refresh()
			
			self.Children[#self.Children + 1] = dropdownClone
			
			return {
				Set = function(v)
					data.CurrentOption = v
					refresh()
				end,
			}
		end
		function tab:CreateSlider(data)
			local rangeMin = data.Range[1]
			local rangeMax = data.Range[2]
			local dragging = false
			local dragInput
			local sliderClone = self.Parent.Props.Slider:Clone()
			sliderClone.Title.Text = data.Name
			sliderClone.Number.Text = data.CurrentValue
			local function refresh()
				local percentage = (data.CurrentValue - rangeMin) / (rangeMax - rangeMin)
				sliderClone.Number.Text = math.round(data.CurrentValue * 10) / 10
				sliderClone.Slider.Coverage.Size = UDim2.new(math.clamp(percentage, 0.025, 1), 0, 1, 0)
				sliderClone.Slider.Ball.Position = UDim2.new(percentage, 0, 0.5, 0)
				data.Callback(data.CurrentValue)	
			end
			
			sliderClone.Slider.Ball.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					local e; e = input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
							e:Disconnect()
						end
					end)
				end
			end)
			
			sliderClone.Slider.Ball.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			
			userInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					local mousePos = userInputService:GetMouseLocation()
					local mouseX, mouseY = mousePos.X, mousePos.Y
					local boundaries0 = sliderClone.Slider.AbsolutePosition.X 
					local boundaries1 = sliderClone.Slider.AbsolutePosition.X + sliderClone.Slider.AbsoluteSize.X
					local at = mouseX - boundaries0
					local goal = boundaries1 - boundaries0
					local percentage = math.clamp(at / goal, 0, 1)
					data.CurrentValue = rangeMin + ((rangeMax - rangeMin) * percentage)
					refresh()	
				end
			end)
			
			sliderClone.Number.FocusLost:Connect(function()
				data.CurrentValue = math.clamp(tonumber(sliderClone.Number.Text) or rangeMin, rangeMin, rangeMax)
				refresh()
			end)
			
			self.Children[#self.Children + 1] = sliderClone
			
			refresh()
			
			return {
				Set = function(value)
					data.CurrentValue = value
					refresh()
				end,
			}
		end
	end
	window.__index = window
	function window:Init()
		local minimized = false
		self.UI.Main.Core.Topbar.MinimizeButton.MouseButton1Click:Connect(function()
			minimized = not minimized
			if minimized then
				self.UI.Main.BackgroundTransparency = 1
				self.UI.Main.DropShadowHolder.Visible = false
				for index, element in pairs(self.UI.Main.Core:GetChildren()) do
					if element.Name ~= "Topbar" then
						element.Visible = false
					end
				end
			else
				self.UI.Main.BackgroundTransparency = 0
				self.UI.Main.DropShadowHolder.Visible = true
				for index, element in pairs(self.UI.Main.Core:GetChildren()) do
					if element.Name ~= "Topbar" then
						element.Visible = true
					end
				end
			end
		end)
		self.UI.Main.Core.Topbar.CloseButton.MouseButton1Click:Connect(function()
			self:Notify({
				Title = "Lucid Premium",
				Content = "Press TAB to re-open ui.",
				Duration = 4
			})
			self.UI.Main.Visible = false
		end)
		userInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Tab then
				self.UI.Main.Visible = true
			end
		end)
		self.UI.Main.Introduction.Title.Text = self.Data.LoadingTitle
		self.UI.Main.Introduction.Description.Text = self.Data.LoadingDescription
		self.UI.Main.Core.Topbar.Title.Text = self.Data.Title
		self.UI.Main.BackgroundTransparency = 1
		for index, element in pairs(self.UI.Main.Core:GetChildren()) do
			element.Visible = false
		end
		self.UI.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
		local loadingInfo = TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
		local sizeTween = tweenService:Create(self.UI.Main.Introduction, loadingInfo, {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0})
		local titleTween = tweenService:Create(self.UI.Main.Introduction.Title, loadingInfo, {TextTransparency = 0})
		local descriptionTween = tweenService:Create(self.UI.Main.Introduction.Description, loadingInfo, {TextTransparency = 0, Position = UDim2.new(0.078, 0, 0.512, 0)})
		local creditsTween = tweenService:Create(self.UI.Main.Introduction.Credits, loadingInfo, {TextTransparency = 0})
		local shadowTween = tweenService:Create(self.UI.Main.DropShadowHolder.DropShadow, loadingInfo, {ImageTransparency = 0.5})
		sizeTween:Play()
		sizeTween.Completed:Wait()
		self.UI.Main.BackgroundTransparency = 0
		for index, element in pairs(self.UI.Main.Core:GetChildren()) do
			element.Visible = true
		end
		task.wait(0.5)
		titleTween:Play()
		descriptionTween:Play()
		task.wait(0.5)
		shadowTween:Play()
		creditsTween:Play()
		task.wait(2.5)
		for index, element in pairs(self.UI.Main.Introduction:GetChildren()) do
			if element:IsA("TextLabel") then
				local t = tweenService:Create(element, loadingInfo, {TextTransparency = 1})
				t:Play()
			end
		end
		local introductionFrameTween = tweenService:Create(self.UI.Main.Introduction, loadingInfo, {BackgroundTransparency = 1})
		introductionFrameTween:Play()	
	end
	function window:CreateTab(name, icon)
		local tab = setmetatable({}, tab)
		local tabButton = self.Props.TabButton:Clone()
		tabButton.Image.Image = "rbxassetid://"..tostring(icon)
		tabButton.Title.Text = name
		tabButton.Parent = self.UI.Main.Core.TabsColor.TabsList
		tabButton.MouseButton1Click:Connect(function()
			if self.LastTab and self.LastTab ~= tab then
				self.LastTab.Button.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				self.LastTab.Button.Image.ImageColor3 = Color3.fromRGB(255, 255, 255)
				self.LastTab:Hide()	
			end
			local tInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
			local tInfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
			local imageTween = tweenService:Create(tabButton.Image, tInfo2, {ImageColor3 = Color3.fromRGB(85, 116, 166)})
			local textTween = tweenService:Create(tabButton.Title, tInfo2, {TextColor3 = Color3.fromRGB(85, 116, 166)})
			local circle = Instance.new("Frame")
			local uiCorner = Instance.new("UICorner")
			local pos = userInputService:GetMouseLocation() - tabButton.AbsolutePosition
			uiCorner.Parent = circle
			uiCorner.CornerRadius = UDim.new(1, 0)
			circle.AnchorPoint = Vector2.new(0.5, 0.5)
			circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			circle.Size = UDim2.new(0, 0, 0, 0)
			circle.Parent = tabButton
			circle.BackgroundTransparency = 0.5
			circle.Position = UDim2.new(0, pos.X, 0, pos.Y - 37.5)
			local circleTween = tweenService:Create(circle, tInfo, {BackgroundTransparency = 1, Size = UDim2.new(2, 0, 2, 0)})
			imageTween:Play()
			textTween:Play()
			circleTween:Play()
			debris:AddItem(circle, 0.5)
			tab:Show()
			self.LastTab = tab
		end)
		tab.Button = tabButton
		tab.Children = {}
		tab.Parent = self
		return tab
	end
	function window:Notify(data)
		task.spawn(function()
			local function addTweenToQueue(tween)
				table.insert(self.NotifyTweens, tween)
				task.spawn(function()
					tween.Completed:Wait()
					table.remove(self.NotifyTweens, table.find(self.NotifyTweens, tween))
				end)
			end
			local notificationClone = self.Props.Notification:Clone()
			notificationClone.Frame.NotificationTitle.Text = data.Title
			notificationClone.NotificationText.Text = data.Content
			local tInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
			local notifShowTween = tweenService:Create(notificationClone, tInfo, {Position = UDim2.new(0, 0, 1, 0)})
			local notifHideTween = tweenService:Create(notificationClone, tInfo, {Position = UDim2.new(1.2, 0, notificationClone.Position.Y.Scale, 0)})
			local function upNotifs()
				repeat task.wait() until #self.NotifyTweens <= 0
				for index, notification in pairs(self.UI.Notifications:GetChildren()) do
					if notification:GetAttribute("Ended") then continue end
					local t = tweenService:Create(notification, tInfo, {Position = notification.Position - UDim2.new(0, 0, 0.17, 0)})
					t:Play()
					addTweenToQueue(t)
				end
			end
			local function downNotifs()
				repeat task.wait() until #self.NotifyTweens <= 0
				for index, notification in pairs(self.UI.Notifications:GetChildren()) do
					if notification:GetAttribute("Ended") then continue end
					if notificationClone.Position.Y.Scale > notification.Position.Y.Scale then continue end
					local t = tweenService:Create(notification, tInfo, {Position = notification.Position + UDim2.new(0, 0, 0.17, 0)})
					t:Play()
					addTweenToQueue(t)
				end
			end
			upNotifs()
			notificationClone.Parent = self.UI.Notifications
			notifShowTween:Play()
			task.wait(data.Duration)
			notificationClone:SetAttribute("Ended", true)
			notifHideTween:Play()
			downNotifs()
			notifHideTween.Completed:Wait()
			notificationClone:Destroy()
		end)
	end
end

function relinquish:CreateWindow(data)
	local items = game:GetObjects("rbxassetid://13584545046")[1]
	local nwWindow = setmetatable({}, window)
	nwWindow.Props = items.Props
	nwWindow.UI = items.RelinquishUI
	nwWindow.Data = data
	nwWindow.NotifyTweens = {}
	nwWindow.LastTab = nil
	do
		local gui = nwWindow.UI.Main

		local dragging
		local dragInput
		local dragStart
		local startPos
		local nwPosition = gui.Position

		local function update(input)
			local delta = input.Position - dragStart
			nwPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end

		gui.Core.Topbar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				local e; e = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						e:Disconnect()
					end
				end)
			end
		end)

		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		userInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
		
		task.spawn(function()
			local tInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
			while true do
				task.wait()
				local t = tweenService:Create(gui, tInfo, {Position = nwPosition})
				t:Play()
			end
		end)
	end
	task.spawn(nwWindow.Init, nwWindow)
	return nwWindow
end


local function beamProjectile(g, v0, x0, t1)
    local c = 0.5*0.5*0.5;
    local p3 = 0.5*g*t1*t1 + v0*t1 + x0;
    local p2 = p3 - (g*t1*t1 + v0*t1)/3;
    local p1 = (c*g*t1*t1 + 0.5*v0*t1 + x0 - c*(x0+p3))/(3*c) - p2;

    local curve0 = (p1 - x0).Magnitude;
    local curve1 = (p2 - p3).Magnitude;

    local b = (x0 - p3).Unit;
    local r1 = (p1 - x0).Unit;
    local u1 = r1:Cross(b).Unit;
    local r2 = (p2 - p3).Unit;
    local u2 = r2:Cross(b).Unit;
    b = u1:Cross(r1).Unit;

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




local window = relinquish:CreateWindow({
	LoadingTitle = "Lucid Premium";
	LoadingDescription = "";
	Title = "Lucid Premium"
})

local delay = 0
local catchdelay = 0

local tab1 = window:CreateTab("Catching", 80373024)
local tab2  = window:CreateTab("Player", 80373024)
local tab3 = window:CreateTab("Tween", 80373024)
local tab4 = window:CreateTab("Visuals", 80373024)


local Velocity hub = {
block = true,
blockslider = 1.5,
blatoggle = true,
blatant = 0,
}


tab1:CreateToggle({
	Name = "Mag Script",
  CurrentValue = false,
	Callback = function()
		-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.231448919, 0, 0.220385626, 0)
Frame.Size = UDim2.new(0, 0, 0, 0)
Frame.Active = true
Frame.Draggable = true
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Size = UDim2.new(0, 251, 0, 50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Football duels ball mag"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextSize = 30.000


TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Position = UDim2.new(0.10000000, 0, 0.00010000, 0)
TextButton.Size = UDim2.new(0, 250, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Silent Mag"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 50.000
--PASTE THE SCRIPT BELOW UNDER THE BUTTON.


TextButton.MouseButton1Down:connect(function()
    local plr = game.Players.LocalPlayer
    local rs = game:GetService("RunService")

    function magBall(ball)
        if ball and plr.Character then
            local leftArm = plr.Character:FindFirstChild("Left Arm")
            if leftArm then
                firetouchinterest(leftArm, ball, 0)
                task.wait()
                firetouchinterest(leftArm, ball, 1)
            end
        end
    end

    rs.Heartbeat:Connect(function()
        local footballs = workspace:FindPartsInRegion3(Region3.new(plr.Character.HumanoidRootPart.Position - Vector3.new(50, 50, 50), plr.Character.HumanoidRootPart.Position + Vector3.new(50, 50, 50)), nil, math.huge)
        for _, football in ipairs(footballs) do
            if football.Name == "Football" and football:IsA("BasePart") and (football.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 50 then
                magBall(football)
            end
        end
    end)
end)
		end,
})

tab1:CreateSlider({
Name = "Mag Range",
       Range = {0, 60},
       Increment = 0.1,
       Suffix = "Range",
       CurrentValue = 0,
       Callback = function(Value)
if blatoggle == true then
           blatant = Value
           else
               if blatoggle == false then
                   blatant = 0
            end
        end
    end
	})	

tab1:CreateToggle({
   Name = "Legit Pull Vector",
   CurrentValue = false,
   Callback = function(Value)
	local plr = game.Players.LocalPlayer

local function teleportToFootball()
    wait()
    local character = plr.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local football = game:GetService("Workspace")["Balls_Kickz"].Football
        if football then
            local distance = (football.Position - character.HumanoidRootPart.Position).Magnitude
            if distance <= 40 then
                character.HumanoidRootPart.CFrame = CFrame.new(football.Position)
            end
        end
    end
end

while wait(1) do
    teleportToFootball()
end
end

	})




tab1:CreateToggle({
   Name = "Blatant Pull Vector",
   CurrentValue = false,
   Callback = function(Value)
	local plr = game.Players.LocalPlayer		
local function teleportToFootball()
    wait()
    local character = plr.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local football = game:GetService("Workspace")["Balls_Kickz"].Football
        if football then
            local distance = (football.Position - character.HumanoidRootPart.Position).Magnitude
            if distance <= 40 then
                character.HumanoidRootPart.CFrame = CFrame.new(football.Position)
            end
        end
    end
end

while wait() do
    teleportToFootball()
end
end
	
})



tab1:CreateToggle({
   Name = "Auto Catch (V to Disable/Enable)",
   CurrentValue = false,
   Callback = function(Value)
   		
       getgenv().Settings = {
    ["Auto Click Keybind"] = "V", -- Use an UpperCase letter or KeyCode Enum. Ex: Enum.KeyCode.Semicolon
    ["Lock Mouse Position Keybind"] = "B",
    ["Right Click"] = false,
    ["GUI"] = true, -- A drawing gui that tells you what is going on with the autoclicker.
    ["Delay"] = 0 -- 0 for RenderStepped, other numbers go to regular wait timings.
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/BimbusCoder/Script/main/Auto%20Clicker.lua"))()
   end,
})




-----






       tab2:CreateToggle({
   Name = "Double Jump",
   CurrentValue = false,
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

tab2:CreateToggle({
   Name = "Jump Power",
   CurrentValue = false,
   Callback = function(Value)
    local p = game.Players.LocalPlayer.Character.HumanoidRootPart
local yeah_this_is_yeah = Instance.new("BodyForce")
yeah_this_is_yeah.Parent = p
yeah_this_is_yeah.Force = Vector3.new(0, 2015, 0)
		end,
	})


tab2:CreateToggle({
   Name = "Walkspeed",
   CurrentValue = false,
   Callback = function(Value)
    lp = game.Players.LocalPlayer
UIS = game:GetService("UserInputService")


repeat
wait(0.1)
until lp.Character:FindFirstChild('HumanoidRootPart')

local speed = CFrame.new(0,0,0)
local lastpos = lp.Character.HumanoidRootPart.Position


while true do
if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
speed = lp.Character.HumanoidRootPart.Position - lastpos
if speed.Y < 0 then
speed = speed - Vector3.new(0, speed.Y, 0)
end
lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + (speed/2)
lastpos = lp.Character.HumanoidRootPart.Position
end
wait(0.1)
end
		end,
	})

     

	tab2:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
    local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

noclip() -- to toggle noclip() and clip()
	end,
})



tab2:CreateToggle({
   Name = "F to TP",
   CurrentValue = false,
   Callback = function(Value)
	local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local distance = 10
    local duration = 0.5
    
    local isTweening = false
    
    local function onInputBegan(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F and not isTweening then
            isTweening = true
            local endPos = humanoidRootPart.CFrame * CFrame.new(0, 0, -distance)
            local tween = game:GetService("TweenService"):Create(humanoidRootPart, TweenInfo.new(duration), {CFrame = endPos})
            tween:Play()
            tween.Completed:Wait()
            isTweening = false
        end
    end
    
    game:GetService("UserInputService").InputBegan:Connect(onInputBegan) 
    end

	
})


tab3:CreateToggle({
   Name = "Elimination",
   CurrentValue = false,
   Callback = function(Value)
   local plr = game.Players.LocalPlayer
    
    local tweenDuration = 1
    local endCFrame = game:GetService("Workspace").ElimTP.CFrame
    
    local function tweenToElimPosition()
        local character = plr.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local tween = game:GetService("TweenService"):Create(character.HumanoidRootPart, TweenInfo.new(tweenDuration), {CFrame = endCFrame})
            tween:Play()
        end
    end
    
    tweenToElimPosition()
    end
})


tab4:CreateToggle({
          Name = "FPS Booster",
         CurrentValue = false,
         Callback = function(v)
                    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
                end,
            })
		



tab4:CreateToggle({
          Name = "Chat Spy",
         CurrentValue = false,
         Callback = function(v)
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
    Color = Color3.fromRGB(99,14,246); 
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
privateProperties.Text = "[Lucid Premium Spy] "..(enabled and "EN" or "DIS").."ABLED:"
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
                end,
            })	
