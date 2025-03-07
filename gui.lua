local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- 🟢 Tạo GUI chính
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- 🟢 Tạo Frame chứa danh sách đảo
local listFrame = Instance.new("Frame")
listFrame.Size = UDim2.new(0, 250, 0, 250)
listFrame.Position = UDim2.new(0, 50, 0, 50)
listFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
listFrame.Active = true
listFrame.Draggable = true
listFrame.Parent = gui

-- 🟢 Tiêu đề danh sách đảo
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Dungvip.xyz Danh sách quái"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = listFrame

-- 🟢 ScrollingFrame chứa danh sách đảo
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -10, 1, -50)
scrollingFrame.Position = UDim2.new(0, 5, 0, 45)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 5
scrollingFrame.Parent = listFrame

-- 🟢 Bố cục danh sách
local layout = Instance.new("UIListLayout")
layout.Parent = scrollingFrame
layout.Padding = UDim.new(0, 5)

-- 🟢 Danh sách đảo
--local IslandList = { "Ironbara", "Turbobara", "Ultrabara" }

local IslandList = {
    "Cog", "Screw", "Ironbara", "TorTor", "Sea Urchin", "Pinkaroo", "Raptor", "Oyster", 
    "Treasure", "Turbobara", "Giant Mushroom", "Pear", "Axolotus", "Vault", "Ultrabara", 
    "Rocky", "Dinovine", "Apple", "Cowzilla", "Golden Apple", "Orange", "Aquarion", 
    "Peepkin", "Acorn", "Pignite", "Dragon Nest", "Three-Eyed Capybara", "BOSSBOT", 
    "Cupbara", "Capybara Long-Legs", "Trashybara", "Wyrmbara", "Hydrotops", "Cowbara"
}


-- 🟢 Nút bật/tắt dịch chuyển
local ToggleMoveButton = Instance.new("TextButton")
ToggleMoveButton.Size = UDim2.new(1, -10, 0, -50)
ToggleMoveButton.Position = UDim2.new(0, 5, 0, 260)
ToggleMoveButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ToggleMoveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMoveButton.Text = "Dịch chuyển: BẬT"
ToggleMoveButton.Parent = listFrame

-- 🟢 Nút ẩn/hiện GUI
local ToggleGuiButton = Instance.new("TextButton")
ToggleGuiButton.Size = UDim2.new(0, 100, 0, 30)
ToggleGuiButton.Position = UDim2.new(0, 10, 0, 10)
ToggleGuiButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiButton.Text = "Ẩn GUI"
ToggleGuiButton.Parent = gui
ToggleGuiButton.Draggable = true 

-- 🟢 Trạng thái GUI
local guiVisible = true 

ToggleGuiButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    listFrame.Visible = guiVisible
    ToggleGuiButton.Text = guiVisible and "DUNG" or "DUNG"
end)

-- 🟢 Trạng thái dịch chuyển
local moveEnabled = true

ToggleMoveButton.MouseButton1Click:Connect(function()
    moveEnabled = not moveEnabled
    ToggleMoveButton.Text = "Dịch chuyển: " .. (moveEnabled and "BẬT" or "TẮT")
end)

-- 🟢 Hàm tìm quái theo tên
local function getMonstersByName(name)
    local monsters = {}

    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj.Name == name then
            table.insert(monsters, obj)
        end
    end

    return monsters
end

-- 🟢 Hàm tìm vị trí phía sau quái
local function getBehindPosition(monster)
    local monsterCFrame = monster:GetPivot()
    local backwardVector = -monsterCFrame.LookVector
    local behindPosition = monsterCFrame.Position + (backwardVector * 5) + Vector3.new(0, 20, 0)

    return CFrame.new(behindPosition)
end

-- 🟢 Tắt trọng lực để không rơi
local function disableGravity()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    game:GetService("RunService").Stepped:Connect(function()
        hrp.Velocity = Vector3.new(0, 0, 0)
    end)
end

disableGravity()

-- 🟢 Trạng thái săn quái
local stopHunting = false

-- 🟢 Hàm tấn công quái liên tục
local function attackAndFollowMonster(monster)
    while monster.Parent and not stopHunting do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if moveEnabled then
                player.Character.HumanoidRootPart.CFrame = getBehindPosition(monster)
            end

            -- Gửi yêu cầu tấn công
            local args = { [1] = CFrame.new(monster:GetPivot().Position) }
            ReplicatedStorage.Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(unpack(args))
        end
        wait(0.3)
    end
end

-- 🟢 Xử lý tìm & tấn công quái
local function handleMonsters(monsterName)
    stopHunting = false
    print("🔍 Bắt đầu săn:", monsterName)

    while not stopHunting do
        local monsters = getMonstersByName(monsterName)

        if #monsters == 0 then
            print("❌ Không tìm thấy", monsterName, "! Chờ 3 giây...")
            wait(3)
        else
            for _, monster in pairs(monsters) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    attackAndFollowMonster(monster)
                end
            end
        end

        wait(1)
    end
    print("⏹ Dừng săn quái:", monsterName)
end

-- 🟢 Hàm tạo nút chọn đảo
local function createIslandButton(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Parent = scrollingFrame

    button.MouseButton1Click:Connect(function()
        print("🔵 Chọn đảo:", name)
        stopHunting = true
        task.wait(0.5)
        task.spawn(function()
            handleMonsters(name)
        end)
    end)
end

-- 🟢 Tạo danh sách nút đảo
for _, island in ipairs(IslandList) do
    createIslandButton(island)
end

scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #IslandList * 35)
