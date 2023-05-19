Feature: Get Account API

  Background: Test Setup API
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Validate existed account and a valid email
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def createdToken = response.token
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer "+ createdToken
    And param primaryPersonId = 7372
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 7372
    And assert response.primaryPerson.email == "tornado@storm.com"
