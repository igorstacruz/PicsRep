@login_session
Feature: Login Page
    As a user I should be able to sign-in or sign-up to the application

    Scenario: Wrong user enters the application

        Given I have an account in the application
        When I navigate to the login page
        And I enter wrong account credentials
        Then I should see wrong user password message

    Scenario: Already registered user enters the application

        Given I have an account in the application
        When I navigate to the login page
        And I enter my account credentials
        Then I should see the home page

     Scenario: Session closed shold show login page when set home url

        Given I have an account in the application
        When I navigate to the login page
        And I enter my account credentials
        Then I should see the home page
        When I logout from home
        And I navigate to the home page
        Then I should see please enter your login credentials 


    Scenario: Session open shold show home page when set home url

        Given I have an account in the application
        When I navigate to the login page
        And I enter my account credentials
        Then I should see the home page
        When I navigate to the home page
        Then I should see Add a new Pic text    



   

   