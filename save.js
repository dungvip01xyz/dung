const fs = require("fs");
const readline = require("readline");

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question("Nhập tin nhắn: ", function(message) {
    fs.appendFile("data.txt", message + "\n", function(err) {
        if (err) throw err;
        console.log("Tin nhắn đã được lưu vào data.txt!");
        rl.close();
    });
});
