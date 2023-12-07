const express = require("express");
const htmlToImage = require("node-html-to-image");
const crypto = require("node:crypto");
const path = require("node:path");
const fs = require("node:fs");

const app = express();
const port = 24066;

const env = process.env.NODE_ENV;
const isProduction = env === "production";

const publicPath = path.join(__dirname, "public");

const assinaturaDigitalPath = path.join(
  __dirname,
  "public",
  "assinatura-digital.html"
);

let tmpPath = path.join(__dirname, "tmp");
if (isProduction) {
  tmpPath = path.join("/tmp");
} else {
  tmpPath = path.join(__dirname, "tmp");
  if (!fs.existsSync(tmpPath)) {
    fs.mkdirSync(tmpPath);
    console.log("Criado a pasta: " + tmpPath);
  }
}

app.use(express.json());
app.use(express.urlencoded());
app.use(express.static("public"));

app.get("/", async (req, res) => {
  console.log("Buscando página: " + publicPath + "/index.html");

  res.set("Content-Type", "text/html");
  res.sendFile(publicPath + "/index.html");
});

app.post("/download", async (req, res) => {
  const { name, career, phone, email } = req.body;

  const data = {
    name,
    career,
    phone,
    email,
  };

  console.log(`Buscando path da assinatura: ` + assinaturaDigitalPath);
  const htmlContent = fs.readFileSync(assinaturaDigitalPath, "utf8");

  const imageName = crypto.randomBytes(10).toString("hex") + ".png";
  console.log(`Nome da imagem gerada: ${imageName}`);

  const imagePath = path.join(tmpPath, imageName);
  console.log(`Path da imagem: ${imagePath}`);

  console.log(`Gerando a imagem...`);
  const image = await htmlToImage({
    html: htmlContent,
    output: path.join(tmpPath, imageName),
    content: data,
  });
  console.log(`Imagem gerada.`);

  res.download(path.join(tmpPath, imageName), imageName, function (error) {
    if (!error && !isProduction) {
      fs.rmSync(imagePath);
      console.log("Imagem removida (após o download): " + imagePath);
    }
  });
});

app.listen(port, () => {
  console.log(`Rodando na porta ${port}`);
});
