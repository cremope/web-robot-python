*** Settings ***
Resource  ../Steps/RCremonez/Login_Steps.robot
Resource  ../Steps/RCremonez/Home_Steps.robot

*** Keywords ***
Abre Chrome
    [Arguments]    ${URLAcesso}=${URL}
    ${GITHUB_CI}    Get Environment Variable    CI    false

    ${CHROME_OPTIONS}=  Evaluate  selenium.webdriver.ChromeOptions()
    Call Method    ${CHROME_OPTIONS}    add_argument    --incognito    
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-notifications   
    Call Method    ${CHROME_OPTIONS}    add_argument    --new-window   
    Call Method    ${CHROME_OPTIONS}    add_argument    --aggressive-cache-discard        
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-application-cache  
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-dev-shm-usage
    Call Method    ${CHROME_OPTIONS}    add_argument    --no-sandbox
    Call Method    ${CHROME_OPTIONS}    add_argument    --disable-gpu
    Call Method    ${CHROME_OPTIONS}    add_argument    --mute-audio
    Call Method    ${CHROME_OPTIONS}    add_argument    --start-maximized

    Run Keyword If  '${GITHUB_CI}'=='true'   Com Headless     ${CHROME_OPTIONS}   ${URLAcesso} 
    Run Keyword If  '${GITHUB_CI}'=='false'  Sem Headless  ${CHROME_OPTIONS}   ${URLAcesso}
    Maximize Browser Window
Com Headless
    [Arguments]  ${CHROME_OPTIONS}    ${URLAcesso}
    Call Method    ${CHROME_OPTIONS}    add_argument    --headless
    Open Browser    ${URLAcesso}    chrome    options=${CHROME_OPTIONS}
    Set Window Size    1440    900

Sem Headless
    [Arguments]  ${CHROME_OPTIONS}    ${URLAcesso}
    Open Browser    ${URLAcesso}    chrome   options=${CHROME_OPTIONS}
    Set Window Size    1440    900