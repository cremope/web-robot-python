## Template Projeto Robot - UI

Este repositório contém um template de projeto para a criação de testes automatizados de interface (UI) utilizando Robot Framework.

📋 **Pré-requisitos**
Certifique-se de que seu ambiente de desenvolvimento possui os seguintes pré-requisitos instalados:
-  **Python** (versão 3.13.0 ou superior)
-  **Visual Studio Code**
- Instalar as extensões, no menu Extensions (Ctrl + Shift + X):
-  [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
-  [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
-  [Python Debugger](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy)
-  [Robot Framework Language Server](https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp)
-  **Biblioteca Pillow** (pip install Pillow)
-  **Biblioteca Faker** (pip install Faker)
  
➕ **Opcionais**
Para melhor visualização das pastas e arquivos no visual studio, recomendamos instalar a seguinte extensõe no Visual Studio Code, no menu Extensions (Ctrl + Shift + X):
-  [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
🛠️ **Tecnologias Utilizadas**
-  [Robot Framework](https://robotframework.org/)
-  [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
-  [Pillow](https://pillow.readthedocs.io/en/stable/) (para manipulação de imagens - Take ScreenShot)
-  [Faker](https://faker.readthedocs.io/en/master/) (para geração de dados fictícios)
  
💻 **Como usar o Projeto**
- Clone o Repositório
- Executa o comando no diretório que deseja:
> git clone https://gitlab.ici.curitiba.org.br/ICI/GEPMO/ici-template-modelos/tradicional/documentacao.git
- Abra o Visual Studio Code:
- Clique em File
- Clique em Open Folder
- Navegue até a pasta robot, ela está nesse caminho:
documentacao\robot
- Dê um duplo clique na pasta robot
- Clique em Selecionar pasta 
- Instale as dependências
 - Execute o comando para instalar todas as dependências do projeto:
> pip install -r requirements.txt

📂 **Estrutura de Pastas**
A estrutura do projeto está organizada da seguinte forma:
```plaintext
📦 Robot
├── 📂 PageObjects
│ ├── 📂 ExemploPageObject - NomeDoProjeto
│ ├── 🔹 Base_PageObjects.Resource 
├── 📂 Resources 
│ ├── 📂 Ambiente
│ | ├── 🛠️ dev.env -> Dados do ambiente de desenvolvimento
│ | ├── 🛠️ teste.env -> Dados do ambiente de teste
│ ├── 📂 DataBases
│ | ├── 🤖 NomeDoProjeto_DataBase.robot -> Exemplo de como usar dataBase
│ ├── 📂 Helpers 
│ | ├── 🤖 GeradorDeDados.robot -> Gera massa de dados usando a data_generator.py (pasta Resources/Uteis)
│ ├── 📂 Libs 
│ │ ├── 📂 DotEnv 
│ │ | ├── 🛠️ __init__.py -> Contém o código para identificar qual ambiente será executado e usa os dados referente ao ambiente escolhido.
│ │ ├── 📂 Uteis 
│ │ | ├── 🛠️ __init__.py
│ │ | ├── 🛠️ ChromeWebdriver_Manager.py -> Gerencia o download do chromedriver.exe
│ │ | ├── 🛠️ Cpf_Uteis.py -> Manipula dados de CPF
│ │ | ├── 🛠️ data_generator.py -> gerador de dados
│ ├── 🔹 Base_Resources.resource 
├── 📂 Steps
│ ├── 📂 ExemploSteps - NomeDoProjeto
│ ├── 🔹 Base_Steps.robot 
├── 📂 Tests 
│ ├── 📂 Funcionais 
││ ├── 📂 Atendimento
│││ ├── 🤖 AtendimentoExemplo.robot 
├── README.md 
├── requirements.txt -> Dependências do projeto
```
❗❗❗ **Observações arquivos do projeto**
📜 ***Arquivo - Base_PageObjects.Resource deve conter:***
- Somente as instâncias dos arquivos de pageObjects(que contém os elementos de tela (Xpath/Css e etc)).
- Keywords genéricas de telas, para serem utilizadas no projeto.
- Instância do arquivo Base_Resources.resource - **Nunca remover essa instância**.
  
📜 ***Arquivo - Base_Resources.resource deve conter:***
- Variáveis genéricas (Urls, navegadores, dados de login), na maioria das vezes variáveis constantes.
- Libraries, para serem utilizadas no projeto (❗ No futuro trataremos o .env para escolha de ambiente de execução)
📜 ***Arquivo - Base_Steps.robot deve conter:***
- Instâncias de todos os arquivos .robot dentro da pasta Steps
📜 ***Arquivos .robot da pasta - Test:***
- Todos devem instânciar o arquivo **Base_Steps.robot**, assim, todo o mecanismo de funcionamento do projeto fica mais simples, e com reuso.
🧪**Execução dos Testes - Localmente**
- Comandos de execução de testes:
- Executa todos os testes da pasta Tests e armazena o log/report na pasta Results:
> robot -d Resultado Tests
- Executa informando em qual ambiente (`dev` ou `teste`) deseja rodar o teste:
> robot -v AMBIENTE:teste -v JENKINS:False -d ./results ./Tests/Funcionais/
- Executa todos os testes de um arquivo específico, no caso o arquivo AtendimentoParticularizado.robot:
> robot -d Resultado Tests/Funcionais/AtendimentoParticularizado.robot
- Executa com o trace habilitado:
> robot -L trace -d Results Tests/Funcionais/AtendimentoParticularizado.robot
<img src="https://www.jenkins.io/images/logos/jenkins/jenkins.svg" alt="Jenkins Pipeline" width="15"> **Execução dos Testes - Jenkins**
Hoje estamos com a pipeline configurada para rodar o seguinte comando:
>  robot --variable JENKINS:True -d ./results ./Tests/Funcionais/
***Explicando o comando:***
-   **`robot`**: Chama o executável do Robot Framework, iniciando a execução dos testes.
-   **`--variable JENKINS:True`**: Define uma variável de execução chamada `JENKINS` com o valor `True`. Aqui identificamos no nosso código se estamos rodando local ou no jenkins para tomar decisões internas no código, como rodar em modo headless, trabalhar com data no formato americano (DD/MM/YYY).
-   **`-d ./results`**: Especifica o diretório de saída (`./results`) onde serão salvos os resultados da execução, como logs, relatórios e arquivos de saída.
-   **`./Tests/Funcionais/`**: Indica o caminho para a pasta que contém os testes que serão executados.
***Quando desejar rodar a pipeline***
- Acessar a url:
> https://dev-jenkins.ici.curitiba.org.br/job/GEPMO/job/FAS-GESTOR/job/automation-robot-framework/
- Clicar em "Construir agora"
- Aguardar o termino da execução
- Verificar o resultado
  
🤝 **Contribuição**
Contribuições são bem-vindas! Caso queira contribuir, realize o clone do projeto, faça modificações, após as modificações realize o commit e faça um push para o gitlab.