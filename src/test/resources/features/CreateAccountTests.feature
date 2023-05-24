
Feature: Create Account Test

  Background: Setup Test URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify user can create an account
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    * request
      """
      {"email": "afghan777@gmai.com",
      "firstName": "Israr",
      "lastName": "Afg",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "SDET",
      "dateOfBirth": "2002-07-07",
      "new": true}
      """
    When method post
    Then status 201
    And print response
    * assert response.email == "afghan777@gmai.com"
