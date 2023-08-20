local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()
local Window = UILib.new("Lucid", game.Players.LocalPlayer.UserId, "Buyer")
local Category1 = Window:Category("Player", "http://www.roblox.com/asset/?id=8395621517")
local Category2 = Window:Category("Settings", "http://www.roblox.com/asset/?id=8395621517")
local SubButton1 = Category1:Button("ㅤ|", "")
local SubButton2 = Category2:Button("ㅤ", "")
local Section1 = SubButton1:Section("Humanoid", "Left")
local Section2 = SubButton2:Section("Settings", "Left")


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
    Default = 0,
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




