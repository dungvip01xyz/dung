-- Hàm nhận dữ liệu và in ra console
local function ProcessSettings(Settings)
    print("Bạn đã chọn team: " .. Settings.JoinTeam)
    if Settings.Translator then
        print("Dịch ngôn ngữ: BẬT")
    else
        print("Dịch ngôn ngữ: TẮT")
    end
end

-- Hàm xử lý dữ liệu và hiển thị GUI
local function DisplaySettings(Settings)
    -- Tạo ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Tạo Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.Parent = screenGui

    -- Tạo TextLabel hiển thị team
    local teamLabel = Instance.new("TextLabel")
    teamLabel.Size = UDim2.new(1, 0, 0.5, 0)
    teamLabel.Text = "Bạn đã chọn team: " .. Settings.JoinTeam
    teamLabel.TextColor3 = Color3.new(1, 1, 1)
    teamLabel.BackgroundTransparency = 1
    teamLabel.Parent = frame

    -- Tạo TextLabel hiển thị Translator trạng thái
    local translatorLabel = Instance.new("TextLabel")
    translatorLabel.Size = UDim2.new(1, 0, 0.5, 0)
    translatorLabel.Position = UDim2.new(0, 0, 0.5, 0)
    translatorLabel.Text = "Dịch ngôn ngữ: " .. (Settings.Translator and "BẬT" or "TẮT")
    translatorLabel.TextColor3 = Color3.new(1, 1, 1)
    translatorLabel.BackgroundTransparency = 1
    translatorLabel.Parent = frame
end

-- Dữ liệu settings
local Settings = {
    JoinTeam = "Pirates"; -- Pirates/Marines
    Translator = true; -- true/false
}

-- Gọi hàm xử lý và hiển thị dữ liệu
ProcessSettings(Settings)
DisplaySettings(Settings)
