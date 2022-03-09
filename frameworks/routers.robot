*** Settings ***
### Import Resource ###
# Frameworks
Resource            config.robot
Resource            app_config.robot

Library             AppiumLibrary                       ${DEFAULT_TIMEOUT}
Library             String

### Data
Resource            ../data/accounts.robot

# Resource
Resource            ../pages/general_keywords.robot
Resource            ../pages/login_page.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_page.robot