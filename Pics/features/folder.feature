@folder
Feature: Folder Page
    As a user I should be able to verify that all is working as expected on Folder page

  Background: Login
    Given I login the application as "tester" with password "tester123"

	Scenario: Verify that all the components are displayed

	  When I navigate to Create Folder page
	  Then I should see all the labels, fields and buttons displayed in folder page

	Scenario: Verify that a new folder is created succesfully

	  When I navigate to Create Folder page
	  And I try to save a new folder with the following name "folder1"
	  Then I should see that the folder "tester/folder1" was saved and return to the Home page
	  
	  When I navigate to Create Folder page
	  And I try to save a new folder with the following name "folder2"
	  Then I should see that the folder "tester/folder2" was saved and return to the Home page

	  When I navigate to Create Folder page
	  And I try to save a new folder with the following name "folder1/folder11"
	  Then I should see that the folder "tester/folder1/folder11" was saved and return to the Home page

	Scenario: Verify negative cases for the New Folder form
	  When I navigate to Create Folder page
	  And I try to save a new folder leaving the folder name field empty
	  Then I should see a validation message and the new folder should not be saved

	  