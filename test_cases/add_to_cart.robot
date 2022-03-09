*** Settings ***
Resource                ../frameworks/routers.robot

Test Timeout            ${DEFAULT_TEST_TIMEOUT}
Test Setup              user open flutter gallery app
Test Teardown           Close Application

*** Test Cases ***
Add to cart
    And user tap shrine banner
    And user login using credentials                ${username}     ${password}
    And user add product walter henley white
    And user add product shrug bag
    When user open shopping cart
    user verify total of shopping cart
    And user clear shopping cart
    When user open shopping cart
    Then user verify cart is empty