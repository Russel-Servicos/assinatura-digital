from flask import Flask, render_template, request, send_file
from jinja2 import Template
from pathlib import Path
import uuid
import os
import shutil 

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('index.html')

@app.route("/download", methods=["POST"])
def download():
    name = request.form.get("name")
    career = request.form.get("career")
    phone = request.form.get("phone")
    email = request.form.get("email")
    width = request.form.get("width")
    
    content = Path('./templates/assinatura-digital.html').read_text()
    
    tm = Template(content)
    html = tm.render(name=name,career=career,phone=phone,email=email)

    fileWithoutExtension=uuid.uuid4()
    imageName=f'{fileWithoutExtension}.png'
    htmlName=f'{fileWithoutExtension}.html'

    htmlPath=f"images/{htmlName}"
    imagePath=f"images/{imageName}"


    if(os.path.exists("images")):
        shutil.rmtree("images")
    os.makedirs("images") 

    with open(htmlPath, 'w') as file:
        file.write(html)
    
    width = int(width) + 3
    print(f"wkhtmltoimage --width {width} {htmlPath} {imagePath}")
    os.system(f"wkhtmltoimage --width {width} {htmlPath} {imagePath}")

    return send_file(f"./{imagePath}", mimetype='image/png', as_attachment=True, max_age=0)

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=24066, debug=True)