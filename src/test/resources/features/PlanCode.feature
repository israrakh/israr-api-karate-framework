@Regression
Feature: API Plan Code Test

  Background: Setup
    Given url "https://tek-insurance-api.azurewebsites.net"
    And def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token

  Scenario: Verify plan code API
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And response[0].planExpired == false
	