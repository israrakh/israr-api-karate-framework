#End 2 End Account Testing
#Create an Account
# Add Address
# Add Phone
# Add Car
# Get Account
@Regression
Feature: End To End Account Testing

  Scenario: Verify User can create an account and adding some properties to it
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    And path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Karate",
      "lastName": "Postman",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Software Developer",
      "dateOfBirth": "2002-07-11",
      "new": true
      }
      """
    When method post
    Then status 201
    And print response
    * assert response.email == autoEmail
    * def id = response.id
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "500 Postman road",
      "city": "Alexanderia",
      "state": "Virginia",
      "postalCode": "89023",
      "countryCode": "+1",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-phone"
    * def randomPhoneNum = dataGenerator.getRandomPhoneNumber()
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      {
      "phoneNumber": "#(randomPhoneNum)",
      "phoneExtension": "2255",
      "phoneTime": "Any Time",
      "phoneType": "Home"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == randomPhoneNum
    Given path "/api/accounts/add-account-car"
    * def carPlate = dataGenerator.getLicensePlate()
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      {
      "make": "BMW",
      "model": "M4",
      "year": "2022",
      "licensePlate": "#(carPlate)"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.make == "BMW"
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    When method get
    Then status 200
    And print response
		And assert response.primaryPerson.email == autoEmail