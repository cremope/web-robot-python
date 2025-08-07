*** Settings ***
Resource  ../Steps/RCremonez/Login_Steps.robot
Resource  ../Steps/RCremonez/Home_Steps.robot

*** Keywords ***
Abre Chrome
    [Arguments]    ${UrlAcesso}=${Url}
    ${GitHub_CI}    Get Environment Variable    CI    false

    ${Chrome_Options}=  Evaluate  selenium.webdriver.ChromeOptions()
    Call Method    ${Chrome_Options}    add_argument    --incognito    
    Call Method    ${Chrome_Options}    add_argument    --disable-notifications   
    Call Method    ${Chrome_Options}    add_argument    --new-window   
    Call Method    ${Chrome_Options}    add_argument    --aggressive-cache-discard        
    Call Method    ${Chrome_Options}    add_argument    --disable-application-cache  
    Call Method    ${Chrome_Options}    add_argument    --disable-dev-shm-usage
    Call Method    ${Chrome_Options}    add_argument    --no-sandbox
    Call Method    ${Chrome_Options}    add_argument    --disable-gpu
    Call Method    ${Chrome_Options}    add_argument    --mute-audio
    Call Method    ${Chrome_Options}    add_argument    --start-maximized

    Run Keyword If  '${GitHub_CI}'=='true'   Com Headless     ${Chrome_Options}   ${UrlAcesso} 
    Run Keyword If  '${GitHub_CI}'=='false'  Sem Headless  ${Chrome_Options}   ${UrlAcesso}
    Maximize Browser Window
Com Headless
    [Arguments]  ${Chrome_Options}    ${UrlAcesso}
    Call Method    ${Chrome_Options}    add_argument    --headless
    Open Browser    ${UrlAcesso}    chrome    options=${Chrome_Options}
    Set Window Size    1440    900

Sem Headless
    [Arguments]  ${Chrome_Options}    ${UrlAcesso}
    Open Browser    ${UrlAcesso}    chrome   options=${Chrome_Options}
    Set Window Size    1440    900