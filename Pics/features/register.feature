@register
Feature: Register Page
    As a user I should be able to register a new account

    Scenario: Try to Register New User on the application setting invalid or empty fields
        Given I have no account in the application
        When I navigate to the login page        
        When I use the Register new account link
        Then I should see the Register page

        When I submit the register form with empty fields
        Then I should see User name field is required
        And I should see e-mail field is required
		And I should see the Register page 
		
        When I submit the register form with invalid email
		And I should see the Register page

    Scenario: Register New User on the application
        Given I have no account in the application
        When I navigate to the login page
        And I use the Register new account link
        And I enter my new account credentials
        Then I should see the home page   

    Scenario: Try to sing up an already register user
        Given I have an account in the application
        When I navigate to the login page
        And I use the Register new account link
        And I submit the next values username: "tester" and e-mail "test@test.com" to register form
        Then I should see "User Name: tester are already in use" message on register
        And I should see the Register page        

    
