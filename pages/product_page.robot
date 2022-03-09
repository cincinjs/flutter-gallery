*** Settings ***
Resource                        ../frameworks/routers.robot

*** Variables ***
${button_walter_henley_white}   xpath=//android.widget.Button[contains(@content-desc, "Walter henley (white)")]
${button_shrug_bag}             xpath=//android.widget.Button[contains(@content-desc, "Shrug bag")]
${button_shopping_cart}         xpath=//android.widget.Button[contains(@content-desc, "Shopping cart")]

# Shopping Cart
${list_product}                 //android.widget.Button[contains(@content-desc, "Close cart")]/following-sibling::android.view.View[2]/android.view.View
${text_total}                   xpath=//android.view.View[contains(@content-desc,"TOTAL")]
${text_subtotal}                xpath=//android.view.View[contains(@content-desc, "Subtotal")]
${text_shipping}                xpath=//android.view.View[contains(@content-desc, "Shipping")]
${text_tax}                     xpath=//android.view.View[contains(@content-desc, "Tax")]
${button_clear_cart}            accessibility_id=CLEAR CART

*** Keywords ***
user add product walter henley white
    swipe horizontal until element is visible   ${button_walter_henley_white}       LEFT
    Wait Until Element Is Visible               ${button_walter_henley_white}
    Click Element                               ${button_walter_henley_white}

user add product shrug bag
    swipe horizontal until element is visible   ${button_shrug_bag}                 RIGHT
    Wait Until Element Is Visible               ${button_shrug_bag}
    Click Element                               ${button_shrug_bag}

user open shopping cart
    Wait Until Element Is Visible               ${button_shopping_cart}
    Click Element                               ${button_shopping_cart}

user clear shopping cart
    Wait Until Element Is Visible               ${button_clear_cart}
    Click Element                               ${button_clear_cart}

user verify cart is empty
    ${expected_value}                           Convert To Number       0.0
    Wait Until Element Is Visible               ${text_total}
    ${total}      Get Element Attribute         ${text_total}           content-desc
    ${total}      get product price             ${total}
    Should Be Equal                             ${total}                ${expected_value}

user verify total of shopping cart
    Wait Until Element Is Visible                                   ${list_product}
    ${count}	                    Get Matching Xpath Count        ${list_product}
    Set Test Variable               ${total_product_price}      0
    FOR  ${index}  IN RANGE  1  ${count}+1
        ${price}                    Get Element Attribute   //android.widget.Button[contains(@content-desc, "Close cart")]/following-sibling::android.view.View[2]/android.view.View[${INDEX}]      content-desc
        Log     ${price}
        ${product_price}            get product price      ${price}
        Log     ${product_price}
        ${total_product_price}      Evaluate    ${total_product_price}+${product_price}
    END

    ${shipping_fee}                 Get Element Attribute   ${text_shipping}        content-desc
    ${shipping_fee}                 get product price       ${shipping_fee}
    ${tax_fee}                      Get Element Attribute   ${text_tax}             content-desc
    ${tax_fee}                      get product price       ${tax_fee}

    ${text_total_product_price}                 Get Element Attribute       ${text_subtotal}                    content-desc
    ${text_total_product_price}                 get product price           ${text_total_product_price}

    Should Be Equal         ${text_total_product_price}     ${total_product_price}
    ${total_price}          Evaluate                        ${total_product_price}+${shipping_fee}+${tax_fee}
    ${text_total_price}     Get Element Attribute           ${text_total}           content-desc
    ${text_total_price}     get product price               ${text_total_price}
    Should Be Equal         ${text_total_price}             ${total_price}

get product price
    [Arguments]             ${string_price}
    ${product_price}        Remove String Using Regexp      ${string_price}         ^[^$]*
    ${product_price}        Remove String                   ${product_price}        $
    ${product_price}        Convert To Number               ${product_price}
    [Return]                ${product_price}