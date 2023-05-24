Feature: Testing Get All Accounts API

  Background: Setup API
    Given url "https://tek-insurance-api.azurewebsites.net"
    And def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token

  Scenario: Verify Get All Accounts API
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
