*** Settings ***    
Resource  ../../Resources/Base_Resources.resource
Resource  ../../PageObjects/Base_PageObjects.resource
Resource  ../../Steps/Base_Steps.robot


*** Keywords ***
Acessa Url
    [Documentation]    Acessa a url informada - Abre navegador(driver) anonimo, acessa url e maxima a tela
    Abre Chrome    ${URL}
    Coleta Evidencia
    
Informo o usuario
    [Documentation]    Informa o usuario
    [Arguments]      ${usuario}

    Aguarda carregamento completo da pagina e elemento    ${Login.Input_Usuario}
    Input Text    ${Login.Input_Usuario}    ${usuario}

Informo a senha
    [Documentation]    Informa a senha
    [Arguments]      ${senha}

    Aguarda carregamento completo da pagina e elemento    ${Login.Input_Senha}
    Input Text    ${Login.Input_Senha}    ${senha}

Clico no botao entrar
    [Documentation]    Clico no botão Entrar
    Aguarda carregamento completo da pagina e elemento    ${Login.Btn_Entrar}
    Click Element    ${Login.Btn_Entrar}
    Coleta Evidencia

Valida mensagem Preencha todos os campos
    [Documentation]    Valida mensagem de erro 'Preencha todos os campos.'
    Aguarda carregamento completo da pagina e elemento    ${Login.Msg_PreenchaCampos}
    Element Should Contain    ${Login.Msg_PreenchaCampos}    Preencha todos os campos.
    Coleta Evidencia