*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BROWSER}    chrome
${URL}        https://github.com/LambdaTest/Robot-Selenium-Sample
${ARAMA_KELIMESI}    Robot Framework
${BEKLEME_SURESI}    5s

*** Test Cases ***
Google Arama Testi
    [Documentation]    Basit bir Google arama testi
    [Tags]    smoke    google

    # Tarayıcıyı aç
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${BEKLEME_SURESI}

    # Google logosunu kontrol et
    Page Should Contain Element    css=img[alt="Google"]
    Log    Google ana sayfası başarıyla açıldı

    # Arama yap
    Input Text    name=q    ${ARAMA_KELIMESI}
    Press Keys    name=q    RETURN

    # Sonuçları kontrol et
    Wait Until Page Contains    ${ARAMA_KELIMESI}
    ${sonuc_sayisi}=    Get Element Count    css=div.g
    Log    Toplam ${sonuc_sayisi} sonuç bulundu
    Should Be True    ${sonuc_sayisi} > 0    Arama sonucu bulunamadı!

    # Ekran görüntüsü al
    Capture Page Screenshot    google_sonuc.png

    [Teardown]    Close Browser

*** Keywords ***
Hata Mesaji Goster
    [Arguments]    ${mesaj}
    Log    HATA: ${mesaj}    level=ERROR
    Capture Page Screenshot    hata_durumu.png