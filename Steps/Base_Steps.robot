*** Settings ***
Resource  ../Steps/RCremonez/Login_Steps.robot
Resource  ../Steps/RCremonez/Home_Steps.robot

*** Keywords ***
Open Chrome
    [Arguments]    ${URLAcesso}=${URL}
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

    Open Browser    ${URLAcesso}    chrome    options=${CHROME_OPTIONS}
    Maximize Browser Window