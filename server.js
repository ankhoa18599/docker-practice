const express = require("express");
const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Hello Docker! Chào mừng bạn đến với container đầu tiên.");
});

app.get("/api/users", (req, res) => {
  res.json([
    { id: 1, name: "Siucode User 1" },
    { id: 2, name: "Docker Fan" },
  ]);
});

app.listen(PORT, () => {
  console.log(`Server đang chạy tại http://localhost:${PORT}`);
  console.log(`Node.js version: ${process.version}`);
});
