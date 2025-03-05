const BOT_TOKEN = "8111648383:AAH0shy5bIro985TLQgGbca8zLouvOJB1T0"; // Thay bằng token bot của bạn
const TELEGRAM_API = `https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`;

function sendMessage() {
    const chatId = document.getElementById("chat_id").value;
    const message = document.getElementById("message").value;
    const status = document.getElementById("status");

    if (!chatId || !message) {
        status.innerHTML = "Vui lòng nhập Chat ID và tin nhắn!";
        return;
    }

    fetch(TELEGRAM_API, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ chat_id: chatId, text: message })
    })
    .then(response => response.json())
    .then(data => {
        if (data.ok) {
            status.innerHTML = "✅ Tin nhắn đã gửi!";
        } else {
            status.innerHTML = "❌ Lỗi khi gửi tin nhắn!";
        }
    })
    .catch(error => {
        status.innerHTML = "❌ Lỗi kết nối!";
        console.error(error);
    });
}
