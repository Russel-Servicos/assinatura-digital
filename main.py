from flask import Flask, render_template, request, send_file
from jinja2 import Template
from pathlib import Path
import uuid
import os
import shutil
import subprocess
import platform

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
    
    content = Path('./templates/assinatura-digital.html').read_text(encoding='utf-8')
    print(content)
    tm = Template(content)
    html = tm.render(name=name, career=career, phone=phone, email=email)

    fileWithoutExtension = uuid.uuid4()
    imageName = f'{fileWithoutExtension}.png'
    htmlName = f'{fileWithoutExtension}.html'

    htmlPath = os.path.join("images", htmlName)
    imagePath = os.path.join("images", imageName)
    
    # Criar diretório images
    if os.path.exists("images"):
        shutil.rmtree("images")
    os.makedirs("images")

    # Salvar o HTML
    with open(htmlPath, 'w', encoding='utf-8') as file:
        file.write(html)
    
    # Converter HTML para imagem
    width = int(width) + 3
    
    # Usar caminhos absolutos
    abs_html_path = os.path.abspath(htmlPath)
    abs_image_path = os.path.abspath(imagePath)
    
    # Detectar sistema operacional
    is_windows = platform.system() == 'Windows'
    
    if is_windows:
        # No Windows, procurar wkhtmltoimage
        wkhtmltoimage_paths = [
            shutil.which('wkhtmltoimage'),  # Procura no PATH primeiro
            r'C:\Program Files\wkhtmltopdf\bin\wkhtmltoimage.exe',
            r'C:\Program Files (x86)\wkhtmltopdf\bin\wkhtmltoimage.exe',
        ]
        
        wkhtmltoimage_exe = None
        checked_paths = []
        
        for path in wkhtmltoimage_paths:
            if path is None:
                continue
            checked_paths.append(f"{path} - Existe: {os.path.exists(path)}")
            if os.path.exists(path):
                wkhtmltoimage_exe = path
                print(f"✓ wkhtmltoimage encontrado em: {path}")
                break
        
        if not wkhtmltoimage_exe:
            error_msg = f"""
Erro: wkhtmltoimage não encontrado!

Caminhos verificados:
{chr(10).join(checked_paths)}

Verifique se está instalado e no PATH.
            """
            print(error_msg)
            return error_msg, 500
        
        command = [
            wkhtmltoimage_exe,
            '--width', str(width),
            abs_html_path,
            abs_image_path
        ]
        
        print(f"Executando comando (Windows): {' '.join(command)}")
        
        try:
            result = subprocess.run(
                command,
                capture_output=True,
                text=True,
                timeout=30,
                creationflags=subprocess.CREATE_NO_WINDOW
            )
        except FileNotFoundError as e:
            return f"Erro ao executar wkhtmltoimage: {e}", 500
    else:
        # No Linux
        command = f'wkhtmltoimage --width {width} "{abs_html_path}" "{abs_image_path}"'
        print(f"Executando comando (Linux): {command}")
        
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            timeout=30
        )
    
    print(f"Return code: {result.returncode}")
    print(f"STDOUT: {result.stdout}")
    print(f"STDERR: {result.stderr}")
    
    if result.returncode != 0:
        error_msg = f"Erro ao gerar imagem: {result.stderr}"
        print(error_msg)
        return error_msg, 500
    
    # Verificar se o arquivo foi criado
    if not os.path.exists(abs_image_path):
        print(f"ERRO: Arquivo não foi criado: {abs_image_path}")
        return "Erro: imagem não foi gerada", 500
    
    print(f"✓ Enviando arquivo: {abs_image_path}")
    return send_file(abs_image_path, mimetype='image/png', as_attachment=True, download_name=f'assinatura-{name}.png', max_age=0)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=24066, debug=True)