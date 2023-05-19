Feature: Random Account Creation

  Background: Setup test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def email = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
            "email": "#(email)",
            "firstName": "Kabul",
            "lastName": "Jan",
            "title": "Mr.",
            "gender": "OTHER",
            "maritalStatus": "SINGLE",
            "employmentStatus": "Atracting foriegners",
            "dateOfBirth": "1800-01-01",
            "new": true
           }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == email
