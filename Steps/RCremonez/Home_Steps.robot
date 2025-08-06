*** Settings ***    
Resource  ../../Resources/Base_Resources.resource
Resource  ../../PageObjects/Base_PageObjects.resource
Resource  ../../Steps/Base_Steps.robot


*** Keywords ***
Valida mensagem de bem vindo
    [Documentation]    Valida mensagem de boas vindas após login
    Aguarda carregamento completo da pagina e elemento    ${Home.Title_Bem_Vindo}
    Element Should Contain    ${Home.Title_Bem_Vindo}    Bem-vindo à RCremonez Digital!
    Coleta Evidencia