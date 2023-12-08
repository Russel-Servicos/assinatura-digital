const express = require("express");
const htmlToImage = require("html-to-image");
const nodeHtmlToImage = require("node-html-to-image");
const Handlebars = require("handlebars");
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

let tmpPath = "";
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

  const template = Handlebars.compile(htmlContent);
  const html = template(data);

  console.log(`Gerando a imagem...`);
  // const image = await htmlToImage.toPng("<h1>testeee</h1>");
  const image = await nodeHtmlToImage({ html });
  console.log(`Imagem gerada.`);

  res.writeHead(200, {
    "Content-type": "image/png",
    "Content-Disposition": `attachment; filename="${imageName}"`,
    "Content-Transfer-Encoding": "binary",
    "Accept-Ranges": "bytes",

    "Cache-Control": "no-store, no-cache",
    "Cache-control": "private",
    Pragma: "private",
  });
  res.end(image);
});

app.listen(port, () => {
  console.log(`Rodando na porta ${port}`);
});
