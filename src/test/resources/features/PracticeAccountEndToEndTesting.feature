Feature: Doing End To End Testing

  Background: Setup API
    Given url "https://tek-insurance-api.azurewebsites.net/"

  Scenario: Create an Account and add some properties to the current Account
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def createdToken = response.token
    Given path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def email = dataGenerator.getEmail()
    And header Authorization = "Bearer " + createdToken
    And request
      """
      {
      "email": "#(email)",
      "firstName": "Dragons",
      "lastName": "Postman",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "SDET",
      "dateOfBirth": "2001-09-07",
      "new": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == email
    * def id = response.id
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + createdToken
    And param primaryPersonId = id
    And request
      """
      {
      "phoneNumber": "7578942525",
      "phoneExtension": "2525",
      "phoneTime": "Any Time",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == "7578942525"
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + createdToken
    And param primaryPersonId = id
    And request
      """
      {
      "make": "Toyota",
      "model": "Camry-TRD",
      "year": "2023",
      "licensePlate": "Afg-Boy"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.model == "Camry-TRD"
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + createdToken
    And param primaryPersonId = id
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "990, Spongibob road",
      "city": "Los Angeles",
      "state": "California",
      "postalCode": "78965",
      "countryCode": "+1",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.city == "Los Angeles"
    And assert response.addressLine1 == "990, Spongibob road"
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + createdToken
    And param primaryPersonId = id
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == email
