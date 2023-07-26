local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Lucid Premium - Football Fusion 2",
   LoadingTitle = "Lucid Premium",
   LoadingSubtitle = "by stonedthoughts",
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

local MainTab = Window:CreateTab("Catching", nil) -- Title, Image
local MainSection = MainTab:CreareSection("Mags")
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Script Made By TactiqR",
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

---
    
    local Toggle = MainTab:CreateToggle({
        Name = "Regular",
        CurrentValue = false,
        Flag = "Togglebalgnt", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            blatoggle = Value
            if blatoggle == true then
                task.wait()
                local UserInputService = game:GetService("UserInputService")
                UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        regular()
                    end
                end)
            end
        end
    })    

local Slider = MainTab:CreateSlider({
       Name = "Regular Range",
       Range = {0, 60},
       Increment = 0.1,
       Suffix = "Range",
       CurrentValue = 0,
       Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
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
---

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

     
