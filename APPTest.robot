*** Settings ***
Library     AppiumLibrary


*** Variables ***
${LocalHost}        http://localhost:4723/wd/hub
${PLATFORM_NAME}    Android
${DEVICE_NAME}      emulator-554
${APP}              ${CURDIR}\\sunflower.apk
${APP_PACKAGE}      com.google.samples.apps.sunflower
${APP_ACTIVITY}     com.google.samples.apps.sunflower.GardenActivity
${UI_AUTOMATOR}     Uiautomator2

*** Test Cases ***

Abrindo APP
    Abrir APP
    Adicionar Planta  

*** Keywords ***

Abrir App
    Open Application    ${LocalHost}
    ...     platformName=${PLATFORM_NAME}
    ...     appium:deviceName=${DEVICE_NAME}
    ...     app=${APP}
    ...     Package=${APP_PACKAGE}
    ...     appActivity=${APP_ACTIVITY}
    ...     automationName=${UI_AUTOMATOR}

Adicionar Planta
    Wait Until Page Contains Element    
    ...     id=com.google.samples.apps.sunflower:id/add_plant
    Click Element       
    ...     id=com.google.samples.apps.sunflower:id/add_plant
    Wait Until Page Contains Element
    ...     xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/androidx.viewpager.widget.ViewPager/androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout/android.widget.FrameLayout/androidx.recyclerview.widget.RecyclerView/androidx.cardview.widget.CardView[6]/android.view.ViewGroup/android.widget.TextView
    ${Planta}    Get Text
    ...     xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/androidx.viewpager.widget.ViewPager/androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout/android.widget.FrameLayout/androidx.recyclerview.widget.RecyclerView/androidx.cardview.widget.CardView[6]/android.view.ViewGroup/android.widget.TextView
    Log     ${Planta}
    Click Element
    ...     xpath=(//android.widget.ImageView[@content-desc="Picture of plant"])[6]
    Wait Until Page Contains Element
    ...     id=com.google.samples.apps.sunflower:id/fab
    Click Element
    ...     id=com.google.samples.apps.sunflower:id/fab
    Go back
    Click Element
    ...     xpath=//android.widget.LinearLayout[@content-desc="My garden"]      
    Wait Until Page Contains Element
    ...     xpath=//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/androidx.viewpager.widget.ViewPager/androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout/android.widget.FrameLayout/androidx.recyclerview.widget.RecyclerView/androidx.cardview.widget.CardView/android.view.ViewGroup 
    Element Should Contain Text    
    ...     id=com.google.samples.apps.sunflower:id/plant_name
    ...     expected=${Planta}
    ...     message=Nao achei o nome correto    
