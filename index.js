const express = require("express");
const nodeHtmlToImage = require("node-html-to-image");
const path = require("path");
const fs = require("node:fs");

const app = express();
const port = 3000;

const pathIndex = path.join(__dirname, "public", "index.html");

const pathAssinaturaDigital = path.join(
  __dirname,
  "public",
  "assinatura-digital.html"
);

app.use(express.json());
app.use(express.urlencoded());
app.use(express.static("public"));

app.get("/", async (req, res) => {
  res.set("Content-Type", "text/html");
  res.sendFile(pathIndex);
});

app.post("/download", async (req, res) => {
  console.log(req.body);
  const { name, career, phone, email } = req.body;

  const data = {
    name,
    career,
    phone,
    email,
  };

  const htmlContent = fs.readFileSync(pathAssinaturaDigital, "utf8");
  const image = await nodeHtmlToImage({
    html: htmlContent,
    content: data,
  });

  res.status(200).format({
    "image/png": () => res.send(image),
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
