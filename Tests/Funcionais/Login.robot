*** Settings ***
Test Tags    Login
Suite Setup   RUN Keywords    Base_Resources.Informacoes Ambiente  
Resource   ../../Steps/Base_Steps.robot

Test Teardown    Finaliza teste

*** Test Cases ***
TC01 - Realiza login com sucesso
    [Documentation]    Realiza login na pagina RCremonez
    Base_Resources.Gerencia_ChromeDriver
    Login_Steps.Acessa Url
    Login_Steps.Informo o usuario    Usuario=${Usuario}
    Login_Steps.Informo a senha   Senha=${Senha}
    Login_Steps.Clico no botao entrar
    Home_Steps.Valida mensagem de bem vindo

TC02 - Realiza login sem preencher dados
    [Documentation]    Realiza login sem preencher dados na pagina RCremonez
    Base_Resources.Gerencia_ChromeDriver
    Login_Steps.Acessa Url
    Login_Steps.Informo o usuario    Usuario=${Empty}
    Login_Steps.Informo a senha   Senha=${Empty}
    Login_Steps.Clico no botao entrar
    Login_Steps.Valida mensagem    Mensagem_Esperada=Preencha todos os campos

TC03 - Realiza login com usuario invalido
    [Documentation]    Realiza login com usuario invalido na pagina RCremonez
    Base_Resources.Gerencia_ChromeDriver
    Login_Steps.Acessa Url
    Login_Steps.Informo o usuario    Usuario=${UsuarioInvalido}
    Login_Steps.Informo a senha   Senha=${Senha}
    Login_Steps.Clico no botao entrar
    Login_Steps.Valida mensagem    Mensagem_Esperada=Usuário inválido

TC04 - Realiza login com senha invalida
    [Documentation]    Realiza login com senha invalida na pagina RCremonez
    Base_Resources.Gerencia_ChromeDriver
    Login_Steps.Acessa Url
    Login_Steps.Informo o usuario    Usuario=${Usuario}
    Login_Steps.Informo a senha   Senha=${SenhaInvalida}
    Login_Steps.Clico no botao entrar
    Login_Steps.Valida mensagem    Mensagem_Esperada=Usuário ou senha inválido.