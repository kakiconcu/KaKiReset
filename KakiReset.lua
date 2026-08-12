print("KAKI RESET LOADED")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function() playerGui:FindFirstChild("KakiResetGUI"):Destroy() end)

-- MÀU XANH BIỂN
local KAKI = Color3.fromRGB(0, 170, 255)
local WHITE = Color3.fromRGB(255, 255, 255)

_G.KakiResetRemote = nil
_G.KakiResetGuid = "f888ee6e-c86d-46e1-93d7-0639d6635d42"

-- HOOK bắt remote
pcall(function()
if not _G.KakiHooked and hookfunction and newcclosure then
_G.KakiHooked = true
local oldFire
oldFire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self,...)
if not _G.KakiResetRemote and typeof(self) == "Instance" and self:IsA("RemoteEvent") and self.Name:sub(1, 3) == "RE/" then
_G.KakiResetRemote = self
end
return oldFire(self,...)
end))
end
end)

local function findRemote()
if _G.KakiResetRemote then return _G.KakiResetRemote end
for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
if v:IsA("RemoteEvent") and v.Name:sub(1,3) == "RE/" then
_G.KakiResetRemote = v
break
end
end
return _G.KakiResetRemote
end

local function reset()
local remote = findRemote()
if remote then
for i = 1, 5 do
pcall(function() remote:FireServer(_G.KakiResetGuid, player, "balloon") end)
task.wait(0.05)
end
end
end

-- GUI NHỎ GỌN
local gui = Instance.new("ScreenGui")
gui.Name = "KakiResetGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.5, -40)
frame.BackgroundColor3 = KAKI
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", frame)
stroke.Color = WHITE
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "KAKI RESET"
title.TextColor3 = WHITE
title.FontFace = Font.fromEnum(Enum.Font.GothamBlack, Enum.FontWeight.Bold, Enum.FontStyle.Italic)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 160, 0, 30)
btn.Position = UDim2.new(0.5, -80, 0, 40)
btn.Text = "RESET [Q]"
btn.TextColor3 = WHITE
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
btn.FontFace = Font.fromEnum(Enum.Font.GothamBold, Enum.FontWeight.Bold, Enum.FontStyle.Italic)
btn.TextSize = 14
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

btn.MouseButton1Click:Connect(reset)
UIS.InputBegan:Connect(function(input, gpe)
if not gpe and input.KeyCode == Enum.KeyCode.Q then reset() end
end)
