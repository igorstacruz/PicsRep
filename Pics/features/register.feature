Feature: Login Page
    As a user I should be able to sign-in or sign-up to the application

    Scenario: Register New User on the application

        Given I have no account in the application
        When I navigate to the login page
        And I use the Register new account link
        Then I should see the Register page

        When I enter my new account credentials
        Then I should bee login in the app
        And I the new account should be saved into the DB        
