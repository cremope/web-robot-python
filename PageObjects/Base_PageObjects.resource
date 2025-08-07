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