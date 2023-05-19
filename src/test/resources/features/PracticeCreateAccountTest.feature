Feature: Create Account Test

  Background: Setup API URL
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def generatedToken = callonce read('GenerateToken.feature')
    * print generatedToken
    * def createdToken = generatedToken.response.token

  Scenario: Verify user can create an account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + createdToken
    And request
      """
      {
       "email": "afghanistan09@yahoo.com",
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
    And assert response.email == "afghanistan09@yahoo.com"
    # Deleting the current account
    * def id = response.id
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + createdToken
    And param primaryPersonId = id 
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"