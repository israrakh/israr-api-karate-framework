@Smoke
Feature: Create Account Test

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token

  Scenario: Create an Account and then Delete it
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    * request
      """
      {
       "id": 0,
       "email": "postman77@karate.com",
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
    * assert response.email == "postman77@karate.com"
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
