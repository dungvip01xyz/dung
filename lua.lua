-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

-- Tạo TextLabel hiển thị danh sách trái cây
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.8, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Text = "Đang tải dữ liệu..."
textLabel.Parent = frame

-- Tạo Nút Nhận Fruit
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 0.2, 0)
button.Position = UDim2.new(0, 0, 0.8, 0)
button.Text = "Nhận Fruit"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Parent = frame


local function fetchFruits()
    local success, fruitList = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success and type(fruitList) == "table" then
        textLabel.Text = "Fruit: \n" .. table.concat(fruitList, "\n")
    else
        textLabel.Text = "Lỗi tải dữ liệu!"
    end
end

-- Khi bấm nút, tải danh sách fruit
button.MouseButton1Click:Connect(fetchFruits)
