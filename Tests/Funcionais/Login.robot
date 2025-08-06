*** Settings ***
Test Tags    Login
Suite Setup   RUN Keywords    Base_Resources.Informacoes Ambiente  
Resource   ../../Steps/Base_Steps.robot

Test Teardown    Finaliza teste

*** Test Cases ***
TC01 - Realiza login com sucsso
    [Documentation]    Realiza login na pagina RCremonez
    Base_Resources.Setup Chromedriver
    Login_Steps.Acessa Url
    Login_Steps.Informo o usuario    ${Usuario}
    Login_Steps.Informo a senha   ${Senha}
    Login_Steps.Clico no botao entrar
    Home_Steps.Valida mensagem de bem vindo