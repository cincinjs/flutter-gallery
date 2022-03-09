*** Settings ***
Resource                    ../frameworks/routers.robot

*** Variables ***
${field_username}           xpath=//android.widget.EditText[@text='Username']
${field_password}           xpath=//android.widget.EditText[@text='Password']
${button_next}              accessibility_id=NEXT

*** Keywords ***
user login using credentials
    [Arguments]     ${username}     ${password}
    Wait Until Element Is Visible           ${field_username}
    Input Text                              ${field_username}           ${username}
    Input Text                              ${field_password}           ${password}
    Click Element                           ${button_next}