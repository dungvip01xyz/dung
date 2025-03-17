return function(Settings)
    print("Bạn đã chọn team: " .. Settings.JoinTeam)
    if Settings.Translator then
        print("Dịch ngôn ngữ: BẬT")
    else
        print("Dịch ngôn ngữ: TẮT")
    end
end
