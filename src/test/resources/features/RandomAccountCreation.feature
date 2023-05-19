@Regression
Feature: Create Random Account

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
            "email": "#(autoEmail)",
            "firstName": "Postman",
            "lastName": "Karate",
            "title": "Mr.",
            "gender": "MALE",
            "maritalStatus": "SINGLE",
            "employmentStatus": "SDET",
            "dateOfBirth": "2003-07-07",
            "new": true
           }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
