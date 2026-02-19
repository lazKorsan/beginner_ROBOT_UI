*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${name}                lazKOrsan
${email}               lazKorsan190220260356@lazKorsan.com
${password}            Query.2026
${loginUrl}            https://qa.loyalfriendcare.com/en/login
${email_BOX_xPATH}     //input[@id='email']
${password_BOX_xPATH}  //input[@id='password']
${login_BUTTON_xPATH}  //button[@type='submit']

*** Test Cases ***
Login to LoyalFriendCare
    [Documentation]    Test the login functionality of LoyalFriendCare
    Open Browser        ${loginUrl}    chrome
    Set Selenium Implicit Wait    10s
    Input Text    xpath=${email_BOX_xPATH}    ${email}
    Input Text    xpath=${password_BOX_xPATH}    ${password}
    Click Element    xpath=${login_BUTTON_xPATH}
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'Welcome')]    timeout=10s
    [Teardown]    Close Browser
