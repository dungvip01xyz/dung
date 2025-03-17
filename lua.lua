-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FruitLabel = Instance.new("TextLabel")
local CheckLabel = Instance.new("TextLabel")

-- Cấu hình GUI
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)

FruitLabel.Parent = Frame
FruitLabel.Text = "Fruit List: " .. table.concat(getgenv().fruitList, ", ")
FruitLabel.Size = UDim2.new(1, 0, 0, 50)
FruitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FruitLabel.BackgroundTransparency = 1
FruitLabel.TextWrapped = true

CheckLabel.Parent = Frame
CheckLabel.Text = "Check Fruit: " .. table.concat(getgenv().checkFruitList, ", ")
CheckLabel.Size = UDim2.new(1, 0, 0, 50)
CheckLabel.Position = UDim2.new(0, 0, 0, 50)
CheckLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckLabel.BackgroundTransparency = 1
CheckLabel.TextWrapped = true

-- Load script từ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/dungvip01xyz/dung/refs/heads/main/lua.lua"))()
