*** Settings ***
Resource    import.resource
Variables   D:\homeworktest01\dataHome.yaml

*** Variables ***
${TAX_RATE}     0.08    # 8% tax rate

*** Test Cases ***
Open web site testingv
   
    Open browser    ${url}    ${browser}
    Verify page login        
    Input username    ${name.standard.user}
    Input password    ${name.standard.password}
    Click login
    Verify page products
    Verify list Product
    Click add cart
    Click cart
    Verify page cart
    Verify product in cart
    Click checkout
    Verify page Information
    Input Information
    Click Continue
    Verify page checkout
    Verify Checkout Overview
    Click Finish
    Verify Finish




*** Keywords ***
Open browser chrome
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
Verify page login
    Wait Until Element Is Visible    //*[@id="login-button"]    timeout=5s

Input username
    [Arguments]    ${username}
    Input Text    //*[@id="user-name"]    ${username}

Input password
    [Arguments]    ${password}
    Input Text    //*[@id="password"]    ${password}

Click login
    Click Button    //*[@id="login-button"]

Verify page products
    Wait Until Element Is Visible    //div[contains(text(),"Products")]    timeout=5s

Click add cart
    Click Button    //*[@id="inventory_container"]/div/div[1]/div[3]/button

Click cart
    Click Element    //*[@id="shopping_cart_container"]/a
Verify page cart
    Wait Until Element Is Visible    //*[@id="contents_wrapper"]/div[2]    timeout=5s

Click checkout
    Click Element    //*[@id="cart_contents_container"]/div/div[2]/a[2]
Verify page Information
    Wait Until Element Is Visible    //*[@id="contents_wrapper"]/div[2]    timeout=5s

Input Information
    Input Text    //*[@id="first-name"]    ftest
    Input Text    //*[@id="last-name"]    ltest
    Input Text    //*[@id="postal-code"]    52000

Click Continue
    Click Button    //*[@id="checkout_info_container"]/div/form/div[2]/input

Verify page checkout
    Wait Until Element Is Visible    //*[@id="contents_wrapper"]/div[2]    timeout=5s
Click Finish
    Click Element    //*[@id="checkout_summary_container"]/div/div[2]/div[8]/a[2]

Verify Finish
    Wait Until Element Is Visible    //*[@id="checkout_complete_container"]/img    timeout=5s
  
Verify list Product
    ${product1name}=    Get Text    //*[@id="item_4_title_link"]/div
    ${product1detail}=    Get Text    //*[@id="inventory_container"]/div/div[1]/div[2]/div
    ${product1price}=    Get Text    (//*[@id="inventory_container"]/div/div[1]/div[3]/div)[2]
    ${product2name}=    Get Text    //*[@id="item_0_title_link"]/div
    ${product2detail}=    Get Text    //*[@id="inventory_container"]/div/div[2]/div[2]/div
    ${product2price}=    Get Text    //*[@id="inventory_container"]/div/div[2]/div[3]/div
    ${product3name}=    Get Text    //*[@id="item_1_title_link"]/div
    ${product3detail}=    Get Text    //*[@id="inventory_container"]/div/div[3]/div[2]/div
    ${product3price}=    Get Text    //*[@id="inventory_container"]/div/div[3]/div[3]/div
    ${product4name}=    Get Text    //*[@id="item_5_title_link"]/div
    ${product4detail}=    Get Text    //*[@id="inventory_container"]/div/div[4]/div[2]/div
    ${product4price}=    Get Text    //*[@id="inventory_container"]/div/div[4]/div[3]/div
    ${product5name}=    Get Text    //*[@id="item_2_title_link"]/div
    ${product5detail}=    Get Text    //*[@id="inventory_container"]/div/div[5]/div[2]/div
    ${product5price}=    Get Text    //*[@id="inventory_container"]/div/div[5]/div[3]/div
    ${product6name}=    Get Text    //*[@id="item_3_title_link"]/div
    ${product6detail}=    Get Text    //*[@id="inventory_container"]/div/div[6]/div[2]/div
    ${product6price}=    Get Text    //*[@id="inventory_container"]/div/div[6]/div[3]/div
    Should Be Equal As Strings    ${product1name}    ${product.p1.name}
    Should Be Equal As Strings    ${product1detail}    ${product.p1.description}
    Should Be Equal As Strings   ${product1price}    $${product.p1.price}
    Should Be Equal As Strings    ${product2name}    ${product.p2.name}
    Should Be Equal As Strings    ${product2detail}    ${product.p2.description}
    Should Be Equal As Strings   ${product2price}    $${product.p2.price}
    Should Be Equal As Strings    ${product3name}    ${product.p3.name}
    Should Be Equal As Strings    ${product3detail}    ${product.p3.description}
    Should Be Equal As Strings   ${product3price}    $${product.p3.price}
    Should Be Equal As Strings    ${product4name}    ${product.p4.name}
    Should Be Equal As Strings    ${product4detail}    ${product.p4.description}
    Should Be Equal As Strings   ${product4price}    $${product.p4.price}
    Should Be Equal As Strings    ${product5name}    ${product.p5.name}
    Should Be Equal As Strings    ${product5detail}    ${product.p5.description}
    Should Be Equal As Strings   ${product5price}    $${product.p5.price}
    Should Be Equal As Strings    ${product6name}    ${product.p6.name}
    Should Be Equal As Strings    ${product6detail}    ${product.p6.description}
    Should Be Equal As Strings   ${product6price}    $${product.p6.price}

Verify product in cart
    ${productname}=    Get Text    //*[@id="item_4_title_link"]/div
    ${productdetail}=    Get Text    //*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[1]
    ${price}=    Get Text    //*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[2]/div

    Should Be Equal As Strings    ${productname}    ${product.p1.name}
    Should Be Equal As Strings    ${productdetail}    ${product.p1.description}
    Should Be Equal As Strings    ${price}    ${product.p1.price}

Calculate Tax
    [Arguments]    ${amount}    ${tax_rate}
    ${amount_float}=    Convert To Number    ${amount}
    ${tax_float}=    Convert To Number    ${tax_rate}
    ${tax}=    Evaluate    "{:.2f}".format(round(${amount_float} * ${tax_rate},2))     
    RETURN    ${tax}

Verify Checkout Overview
    ${productNameOverview}=    Get Text    //*[@id="item_4_title_link"]/div
    ${productDetailOverview}=    Get Text    //*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[1]
    ${productPriceOverview}=    Get Text    //*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]
    ${productPriceOverview_$}=    Set Variable    $${productPriceOverview}


    ${itemTotal}=    Get Text    //*[@id="checkout_summary_container"]/div/div[2]/div[5]
    ${itemTotal_price}    Set Variable    ${itemTotal.split()[-1]}
    ${itemPrice_without_dollar}=    Replace String    ${itemTotal_price}    $    ${EMPTY}
    ${itemTotal_chack}=    Set Variable    Item total: $${product.p1.price}
    ${calculated_tax}=    Calculate Tax    ${itemPrice_without_dollar}    ${TAX_RATE}
    ${TaxPage}=    Get Text    //*[@id="checkout_summary_container"]/div/div[2]/div[6]
    ${TaxPagePrice}=    Set Variable    ${TaxPage.split()[-1]}
    ${totle}=    Get Text    //*[@id="checkout_summary_container"]/div/div[2]/div[7]
    ${totleOnlyPrice}=     Set Variable    ${totle.split()[-1]}
    ${sum}=    Evaluate    ${itemPrice_without_dollar} + ${calculated_tax}
    Should Be Equal As Strings    ${itemTotal}    ${itemTotal_chack}
    Should Be Equal As Strings    ${TaxPagePrice}    $${calculated_tax}
    Should Be Equal As Strings    ${totleOnlyPrice}    $${sum}




    
    