*** Settings ***    
Resource  ../../Resources/Base_Resources.resource
Resource  ../../PageObjects/Base_PageObjects.resource
Resource  ../../Steps/Base_Steps.robot


*** Keywords ***
Acessa Url
    [Documentation]    Acessa a url informada - Abre navegador(driver) anonimo, acessa url e maxima a tela
    Abre Chrome    ${Url}
    Coleta Evidencia
    
Informo o usuario
    [Documentation]    Informa o usuario
    [Arguments]      ${Usuario}

    Aguarda carregamento completo da pagina e elemento    ${Login.Input_Usuario}
    Input Text    ${Login.Input_Usuario}    ${Usuario}

Informo a senha
    [Documentation]    Informa a senha
    [Arguments]      ${Senha}

    Aguarda carregamento completo da pagina e elemento    ${Login.Input_Senha}
    Input Text    ${Login.Input_Senha}    ${Senha}

Clico no botao entrar
    [Documentation]    Clico no botão Entrar
    Aguarda carregamento completo da pagina e elemento    ${Login.Btn_Entrar}
    Click Element    ${Login.Btn_Entrar}
    Coleta Evidencia

Valida mensagem
    [Documentation]    Valida mensagem '${Mensagem_Esperada}'
    [Arguments]    ${Mensagem_Esperada}

    Aguarda carregamento completo da pagina e elemento    ${Login.Msg_erro}

    ${Xpath_Mensagem}    Set Variable                                 //div[@id='mensagem' and contains(text(),'${Mensagem_Esperada}')]

    Aguarda carregamento completo da pagina e elemento               ${Xpath_Mensagem}
    ${Existe}    Existe objeto                                       ${Xpath_Mensagem}
    IF    ${Existe}    
        Log To Console   Encontrada a mensagem de erro: ${Mensagem_Esperada}
        Coleta Evidencia
    ELSE
        Coleta Evidencia
        Fail    Não foi encontrada a mensagem de erro: ${Mensagem_Esperada} - xpath usado ${Xpath_Mensagem}
    END