import os
import sys
import requests
import subprocess
import re
import zipfile
import shutil

def find_existing_chromedriver_path():
    """
    Verifica qual caminho do ChromeDriver existe entre os caminhos pré-definidos,
    baseado na versão do Python instalada.
    Se o caminho correspondente à versão do Python (ex.: "Python312") existir,
    retorna esse caminho. Caso contrário, informa que não existe o caminho para essa versão.
    """
    python_folder = f"Python{sys.version_info.major}{sys.version_info.minor}"
    possible_paths = [
        r"C:\Users\RL90\AppData\Local\Programs\Python\Python313\Scripts"
    ]
    for path in possible_paths:
        if python_folder in path and os.path.exists(path) and os.path.isdir(path):
            print(f"Diretorio valido encontrado para {python_folder}: {path}")
            return path
    print(f"Nenhum caminho encontrado para a versao do Python: {python_folder}")
    return None

def remove_existing_chromedriver(path):
    """
    Remove todos os arquivos e pastas relacionados ao ChromeDriver no diretório informado.
    Isso inclui:
      - Arquivo "chromedriver.exe"
      - Arquivo "chromedriver-win32.zip"
      - Pasta "chromedriver-win32"
    """
    for item in os.listdir(path):
        item_path = os.path.join(path, item)
        lower_item = item.lower()
        if lower_item == "chromedriver.exe":
            try:
                os.remove(item_path)
                print("Arquivo chromedriver.exe removido com sucesso:", item_path)
            except Exception as e:
                print("Erro ao remover", item_path, ":", e)
        elif lower_item == "chromedriver-win32.zip":
            try:
                os.remove(item_path)
                print("Arquivo chromedriver-win32.zip removido com sucesso:", item_path)
            except Exception as e:
                print("Erro ao remover", item_path, ":", e)
        elif lower_item == "chromedriver-win32" and os.path.isdir(item_path):
            try:
                shutil.rmtree(item_path)
                print("Pasta chromedriver-win32 removida com sucesso:", item_path)
            except Exception as e:
                print("Erro ao remover a pasta", item_path, ":", e)
        elif lower_item == "chrome-win32" and os.path.isdir(item_path):
            try:
                shutil.rmtree(item_path)
                print("Pasta chrome-win32 removida com sucesso:", item_path)
            except Exception as e:
                print("Erro ao remover a pasta", item_path, ":", e)

    # Remove o arquivo chromedriver.exe se existir no diretório informado.
    chromedriver_path = os.path.join(path, "chromedriver.exe")
    if os.path.exists(chromedriver_path):
        try:
            os.remove(chromedriver_path)
            print("Arquivo chromedriver.exe removido com sucesso em", path)
        except Exception as e:
            print("Erro ao remover chromedriver.exe em", path, ":", e)
    else:
        print("Nenhum chromedriver.exe encontrado em", path)

    chromedriver_path = os.path.join(path, "chromedriver-win32.zip")
    if os.path.exists(chromedriver_path):
        try:
            os.remove(chromedriver_path)
            print("Arquivo chromedriver-win32.zip removido com sucesso em", path)
        except Exception as e:
            print("Erro ao remover chromedriver-win32.zip em", path, ":", e)
    else:
        print("Nenhum chromedriver-win32.zip encontrado em", path)    

def get_chrome_version():
    # Detecta a versão do Chrome via registro do Windows.
    try:
        output = subprocess.check_output(
            r'reg query "HKEY_CURRENT_USER\Software\Google\Chrome\BLBeacon" /v version',
            shell=True,
            text=True
        )
        match = re.search(r'(\d+\.\d+\.\d+\.\d+)', output)
        if match:
            version = match.group(1)
            print("Versao do Chrome detectada:", version)
            return version
        else:
            print("Nao foi possivel extrair a versao do Chrome.")
    except Exception as e:
        print("Erro ao detectar a versao do Chrome:", e)
    return None

def get_driver_version(chrome_version):
    """
    Constrói a versão do ChromeDriver com base na versão do Chrome instalada.
    A logica aqui e: pega todos os componentes da versao do Chrome, 
    exceto o ultimo, e adiciona '.88'. 
    Exemplo: "134.0.6998.37" vira "134.0.6998.88"
    """
    parts = chrome_version.split('.')
    if len(parts) >= 4:
        driver_version = '.'.join(parts[:-1]) + '.88'
        print("Driver version obtida:", driver_version)
        return driver_version
    else:
        print("Formato da versao do Chrome inesperado.")
        return chrome_version

def download_and_extract_chromedriver(driver_version, dest_folder):
    # Constrói a URL de download com base na versão do driver.
    download_url = f"https://storage.googleapis.com/chrome-for-testing-public/{driver_version}/win32/chromedriver-win32.zip"
    print("URL de download do ChromeDriver:", download_url)
    
    response = requests.get(download_url)
    if response.status_code == 200:
        zip_path = os.path.join(dest_folder, "chromedriver-win32.zip")
        with open(zip_path, "wb") as f:
            f.write(response.content)
        print("Arquivo zip baixado:", zip_path)
        try:
            with zipfile.ZipFile(zip_path, "r") as zip_ref:
                zip_ref.extractall(dest_folder)
            print("ChromeDriver extraido para", dest_folder)
        except Exception as e:
            print("Erro ao extrair o arquivo zip:", e)
        finally:
            os.remove(zip_path)
    else:
        print("Falha no download do ChromeDriver. Codigo de status:", response.status_code, "URL:", download_url)

def copy_chromedriver(dest_folder):
    # Procura pelo arquivo chromedriver.exe (mesmo em subpastas) e o copia para a raiz do diretório.
    source = None
    for root, dirs, files in os.walk(dest_folder):
        for file in files:
            if file.lower() == "chromedriver.exe":
                source = os.path.join(root, file)
                break
        if source:
            break
    if source:
        target = os.path.join(dest_folder, "chromedriver.exe")
        try:
            shutil.copy(source, target)
            print("chromedriver.exe copiado para", target)
        except Exception as e:
            print("Erro ao copiar chromedriver.exe:", e)
    else:
        print("chromedriver.exe nao encontrado apos a extracao.")

def setup_chromedriver():
    valid_path = find_existing_chromedriver_path()
    if not valid_path:
        return

    remove_existing_chromedriver(valid_path)
    
    chrome_version = get_chrome_version()
    if not chrome_version:
        print("Nao foi possivel detectar a versao do Chrome.")
        return
    
    driver_version = get_driver_version(chrome_version)
    download_and_extract_chromedriver(driver_version, valid_path)
    copy_chromedriver(valid_path)

if __name__ == "__main__":
    setup_chromedriver()