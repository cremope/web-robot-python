*** Settings ***
Library    SeleniumLibrary    run_on_failure=NOTHING
Library    AllureLibrary
Library    ../Resources/Libs/DotEnv/    ${AMBIENTE}
Library    ../Resources/Libs/Uteis/ChromeWebdriver_Manager.py
Library    OperatingSystem
Library    Screenshot
Library    Process
Library    DateTime

*** Variables ***
#ambiente
#Seta o ambiente de dev como padrão caso não seja informado o ambiente de execução
${AMBIENTE}        dev

#navegador e urls
${Browser}    chrome    
${Url}    %{url=${None}}


#Variáves reutilizáveis
${DRIVER}    ${None}

#Variáveis de espera
${TempoEspera_3}    3
${TempoEspera_30}    30

#Dados Login - Os dados de login ficam nos arquivos .env no caminho Resouces/Ambiente/<dev ou homolog>/.env
${Usuario}      %{usuario=${None}}
${Senha}        %{senha=${None}}

*** Keywords ***
Informacoes Ambiente
    Log To Console    .
    Log To Console    -------------
    Log To Console    Ambiente de execução: %{ambiente=${None}}   
    Log To Console    -------------

Setup ChromeDriver
    ${process} =    Run Process    python    Resources/Libs/Uteis/ChromeWebdriver_Manager.py    stdout=STDOUT
    Log To Console    ${process.stdout}

Configuracao Selenium 
    Set Selenium Page Load Timeout    60
    Set Selenium Implicit Wait    30
    Set Selenium Timeout    30
    Set Selenium Speed    0.2

Finaliza teste
    Coleta Evidencia
    Close Browser
        
Coleta Evidencia
    Capture Page Screenshot    EMBED
