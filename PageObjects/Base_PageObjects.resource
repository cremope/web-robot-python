*** Settings ***
Resource  ../Resources/Base_Resources.resource
Resource  RCremonez/Login.resource
Resource  RCremonez/Home.resource

*** Keywords ***
Existe objeto 
    [Arguments]    ${Element}
    ${Existe}=    Run Keyword And Return Status    Page Should Contain Element    ${Element}    
    Run Keyword If    ${Existe}    
    ...    Log To Console    O elemento ${Element} está presente.
    
    Run Keyword If    not ${Existe}    
    ...    Log To Console    O elemento ${Element}  não está presente.
    RETURN     ${Existe}

Aguarda carregamento completo da pagina e elemento
    [Arguments]    ${Element}
    Wait For Condition	return document.readyState == "complete"
    Wait Until Element Is Visible    ${Element}
    ...    timeout=${TempoEspera_30}
    ...    error=Não foi encontrado o objeto: ${Element}

Valida se contem o texto no elemento
    [Arguments]    ${Element}    ${Valor}

    Wait Until Element Contains    ${Element}    ${Valor}   
    ...    timeout=${TempoEspera_30} 
    ...    error=Não foi encontrado o valor ${Valor} no objeto: ${Element}

Aguardo Elemento Ou Recarrego Pagina
    [Arguments]    ${Element}
    ${Resultado}    Tente Encontrar Elemento    ${Element}
    Run Keyword If    ${Resultado} == False    Recarrega E Verifica Elemento    ${Element}

Tente Encontrar Elemento
    [Arguments]    ${Element}
    ${Resultado}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${Element}    
    ...    timeout=${TempoEspera_30}
    ...    error=Não foi encontrado o objeto: ${Element}   
    RETURN    ${Resultado}

Recarrega E Verifica Elemento
    [Arguments]    ${Element}
    Log To Console   Elemento não encontrado. Recarregando página...
    Sleep    ${TempoEspera_3}
    Reload Page
    Wait Until Page Contains Element    ${Element}    
    ...    timeout=${TempoEspera_30}    
    ...    error=Elemento ${Element} não encontrado mesmo após recarregar a página.

Recarrega a pagina
    Reload Page
    Wait For Condition	return document.readyState == "complete"
    Sleep    ${TempoEspera_30}

Scroll ate final da pagina
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
