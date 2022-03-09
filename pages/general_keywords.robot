*** Settings ***
Resource                ../frameworks/routers.robot

*** Variables ***

*** Keywords ***
user open flutter gallery app
    Open Application	${HOST}
    ...                 platformName=${PLATFORM_NAME}
    ...                 deviceName=${DEVICE_NAME}
    ...                 appPackage=${APP_PACKAGE}
    ...                 appActivity=${APP_ACTIVITY}
    ...                 udid=${UDID}
    ...                 app=${APP}

swipe horizontal from element
    [Arguments]     ${element}     ${direction}

    ${element_size} =       Get Element Size            ${element}
    ${element_location} =   Get Element Location        ${element}

    IF  "${direction}" == "RIGHT"
        ${START_X} =    Evaluate      ${element_location['x']} + (${element_size['width']} * 0.2)
        ${START_Y} =    Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
        ${END_X} =      Evaluate      ${element_location['x']} + (${element_size['width']} * 0.8)
        ${END_Y} =      Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
    ELSE IF  "${direction}" == "LEFT"
        ${START_X} =    Evaluate      ${element_location['x']} + (${element_size['width']} * 0.8)
        ${START_Y} =    Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
        ${END_X} =      Evaluate      ${element_location['x']} + (${element_size['width']} * 0.2)
        ${END_Y} =      Evaluate      ${element_location['y']} + (${element_size['height']} * 0.5)
    END
    Swipe               ${START_X}    ${START_Y}  ${END_X}  ${END_Y}  1500

swipe horizontal element until element is visible
    [Arguments]     ${element1}     ${element2}     ${direction}
    Wait Until ELement Is Visible   ${element1}

    FOR    ${robot}    IN    10
        ${is_visible}=  Run Keyword And Return Status   Wait Until Element Is Visible       ${element2}     1
        IF  "${is_visible}" == "False"
            swipe horizontal from element           ${element1}     ${direction}
        ELSE
            Exit For Loop
        END
    END


swipe horizontal
    [Arguments]    ${direction}

    ${width}	Get Window Width
    ${height}	Get Window Height
    IF  "${direction}" == "RIGHT"
        ${START_X} =    Evaluate      (${width} * 0.1)
        ${START_Y} =    Evaluate      (${height} * 0.5)
        ${END_X} =      Evaluate      (${width} * 0.9)
        ${END_Y} =      Evaluate      (${height} * 0.5)
    ELSE IF  "${direction}" == "LEFT"
        ${START_X} =    Evaluate      (${width} * 0.9)
        ${START_Y} =    Evaluate      (${height} * 0.5)
        ${END_X} =      Evaluate      (${width} * 0.1)
        ${END_Y} =      Evaluate      (${height} * 0.5)
    END
    Swipe               ${START_X}    ${START_Y}  ${END_X}  ${END_Y}  1500

swipe horizontal until element is visible
    [Arguments]     ${element}      ${direction}

    FOR    ${i}    IN RANGE    30
        ${is_visible}=  Run Keyword And Return Status   Wait Until Element Is Visible    ${element}      1
        IF  "${is_visible}" == "False"
            swipe horizontal        ${direction}
        ELSE
            Exit For Loop
        END
    END