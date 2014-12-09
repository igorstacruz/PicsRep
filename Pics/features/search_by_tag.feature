@search_by_tag
Feature: Search  by Tage
    As a user I should be able to search pics by tag

Scenario: All UI components to search by tag page
          Given I have an account in the application
          When I navigate to the login page
          And I enter my account credentials
          Then I should see the home page
          When I navigate to Search by tag
          Then I should see search by tag title
          And I should be able to see Select the tag to view your images
          And I should be able to see View Image tag button
          And I should be able to see Dropdown options
                      

Scenario: Search an image(s) by tag
          Given I have an account in the application
          When I navigate to the login page
          And I enter my account credentials
          Then I should see the home page
          When I navigate to Search by tag
          Then I should see search by tag title
          When I select viaje tag
          And I click on View Image tag button
          Then I should be able to see gym image



   

   