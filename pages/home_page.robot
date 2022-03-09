*** Settings ***
Resource                   ../frameworks/routers.robot

*** Variables ***
${banner_slider}           xpath=//android.widget.HorizontalScrollView
${banner_shrine}           xpath=//android.view.View[contains(@content-desc, 'Shrine')]

*** Keywords ***
user tap shrine banner
    swipe horizontal element until element is visible       ${banner_slider}    ${banner_shrine}    LEFT
    Click Element                                           ${banner_shrine}
