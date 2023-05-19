@Smoke @Regression
Feature: Get Account API

  Background: Test Setup
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verifying existed account email address is correct
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And header Authorization  = "Bearer " + generatedToken
    And param primaryPersonId = 6871
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == "afgisr7@gmail.com"
