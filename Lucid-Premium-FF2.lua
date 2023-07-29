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
                blockslider = 1.5
            end
        end
    })

local Section = Tab:CreateSection("Mag")



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
    Name = "QB Aim Trajectory Predictions",
    CurrentValue = toggleState,
    Flag = "Toggle1",
    Callback = function(data)
        toggleState = data -- Update the toggle state
        
        if toggleState then
            -- Toggle turned on
            local beam = Instance.new("Beam")
            local a0 = Instance.new("Attachment")
            local a1 = Instance.new("Attachment")
            beam.Color = ColorSequence.new(beamColor)
            beam.Transparency = NumberSequence.new(0, 0)
            beam.Segments = 10 * 300
            beam.Name = "Hitbox"
            beam.Parent = workspace.Terrain
            a0.Parent = workspace.Terrain
            a1.Parent = workspace.Terrain
            beam.Attachment0 = a0
            beam.Attachment1 = a1
            beam.Width0 = 0.5
            beam.Width1 = 0.5
            while toggleState do
                task.wait()
                if player.Character:FindFirstChild("Football") and player.PlayerGui:FindFirstChild("BallGui") and player.Character:FindFirstChild("Head") then
                    local power = tonumber(player.PlayerGui.BallGui.Frame.Disp.Text)
                    local direction = (mouse.Hit.Position - workspace.CurrentCamera.CFrame.Position).Unit
                    local vel = power * direction
                    local origin = player.Character.Head.Position + direction * 5
                    local c0, c1, cf1, cf2 = beamProjectile(Vector3.new(0, -28, 0), vel, origin, 15)
                    a0.CFrame = a0.Parent.CFrame:Inverse() * cf1
                    a1.CFrame = a1.Parent.CFrame:Inverse() * cf2
                    beam.CurveSize0 = c0
                    beam.CurveSize1 = c1
                end
            end
            beam:Destroy() -- Clean up the beam when toggled off
        else
            -- Toggle turned off
            -- Add any additional code here to handle the toggle turning off
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

     
