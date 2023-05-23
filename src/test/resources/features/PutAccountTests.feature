@Regression
Feature: Update Account Properties

  Background: Setup API
    Given url "https://tek-insurance-api.azurewebsites.net/"
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token

  Scenario: Verify User Can Update The Car Properties
    Given path "/api/accounts/update-account-car"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = 7372
    And request
      """
      {
      "make": "Benz",
      "model": "S-Class",
      "year": "2023",
      "licensePlate": "KingAfg7"
      }
      """
    When method put
    Then status 200
    And print response
    And assert response.make == "Benz"
    And assert response.year == 2023
