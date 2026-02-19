*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${BROWSER}        chrome
${GOOGLE_URL}     https://www.google.com
${BEKLEME}        10s

*** Test Cases ***
Kapsamli Google Testi
    [Documentation]    Google'ın farklı özelliklerini test eder

    # Chrome'u başlat ve Google'a git
    Open Browser    ${GOOGLE_URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Google

    # Farklı arama terimleriyle test
    @{arama_terimleri}    Create List    Robot Framework    Selenium    Python
    FOR    ${terim}    IN    @{arama_terimleri}
        Arama Yap Ve Kontrol Et    ${terim}
    END

    [Teardown]    Close Browser

*** Keywords ***
Arama Yap Ve Kontrol Et
    [Arguments]    ${terim}

    Log    "${terim}" için arama yapılıyor...

    # Arama kutusunu bul ve temizle
    Wait Until Element Is Visible    name=q    ${BEKLEME}
    Input Text    name=q    ${terim}
    Press Keys    name=q    RETURN

    # Sonuçların geldiğini kontrol et
    Wait Until Page Contains    Sonuçlar    ${BEKLEME}
    Wait Until Page Contains    ${terim}    ${BEKLEME}

    # Sonuç sayısını al
    ${sonuc_sayisi}=    Get Element Count    css=h3
    Log    "${terim}" için ${sonuc_sayisi} sonuç başlığı bulundu

    # 3 saniye bekle ve ana sayfaya dön
    Sleep    2s
    Go To    ${GOOGLE_URL}