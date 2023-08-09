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

local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
local numTeleports = 30 -- Define the number of teleports
local tooggleEnabled = false -- Variable to track the toggle state




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
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
        task.wait()
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
            wait()
            end
        end
    end

----


local tab = win:Tab("Catching")


tab:Toggle("Adjustable Mags", false, function(v)
                                        tooggleEnabled = v
                                        while tooggleEnabled == true do
                                            task.wait()
                                            universalcatch()
                                        end
                                    end)

tab:Slider("Mag Distance", .1, 30, 0, function(v)
                                        universal = v
                                    end)






local tab = win:Tab("Physics")

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


tab:Button("Auto Captain", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Models.LockerRoomA.FinishLine.CFrame + Vector3.new(0, 2, 0)
        end)


local tab = win:Tab("Trolling")

tab:Toggle("Underground", false, function(Value)
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

