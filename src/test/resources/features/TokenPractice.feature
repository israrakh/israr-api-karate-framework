Feature: API Test Security

  Background: Setup API URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Generate token with valid username and valid password
    And path "/api/token"
    And request
      """
      {
       "username": "supervisor",
       "password": "tek_supervisor"
      }
      """
    When method post
    Then status 200
    And print response
    And assert response.username == "SUPERVISOR"

  Scenario: Verify token with invalid username and valid password
    And path "/api/token"
    And request
      """
      {
           "username": "invalid_user",
           "password": "tek_supervisor"
          }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: Validate token with valid username and invalid password
    And path "/api/token"
    And request
      """
         {
               "username": "supervisor",
               "password": "wrongpassword"
              }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"
