*** Settings ***
Library    SeleniumLibrary    run_on_failure=NOTHING
Library    ../Resources/Libs/DotEnv/    ${Ambiente}
Library    ../Resources/Libs/Uteis/ChromeWebdriver_Manager.py
Library    OperatingSystem
Library    Screenshot
Library    Process
Library    DateTime

*** Variables ***
#ambiente
#Seta o ambiente de dev como padrão caso não seja informado o ambiente de execução
${Ambiente}        dev

#navegador e urls
${Url}    %{url=${None}}

#Variáveis de espera
${TempoEspera_3}    3
${TempoEspera_30}    30

#Dados Login - Os dados de login ficam nos arquivos .env no caminho Resouces/Ambiente/<dev ou homolog>/.env
${Usuario}      %{usuario=${None}}
${Senha}        %{senha=${None}}
${UsuarioInvalido}    admin
${SenhaInvalida}    test

*** Keywords ***
Informacoes Ambiente
    Log To Console    .
    Log To Console    -------------
    Log To Console    Ambiente de execução: %{ambiente=${None}}   
    Log To Console    -------------

Gerencia_ChromeDriver
    ${process} =    Run Process    python    Resources/Libs/Uteis/ChromeWebdriver_Manager.py    stdout=STDOUT
    Log To Console    ${process.stdout}

Finaliza teste
    Coleta Evidencia
    Close Browser
        
Coleta Evidencia
    Capture Page Screenshot    EMBED
