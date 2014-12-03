@delete_image
Feature: Delete Image Page
    As a user I should be able to verify that all is working as expected on Delete Image page

  Background: Login
    Given I login the  as "admin" with password "admin123"

	Scenario: Verify that all the components are displayed

	  When I navapplicationigate to Delete Image page
	  Then I should see all the labels, fields and buttons displayed in folder page

	Scenario: Verify that a new folder is created succesfully

	  When I navigate to Create Folder page
	  And I try to save a new folder with the following name "NewFolderTest"
	  Then I should see that the image was saved and return to the Home page

	Scenario: Verify negative cases for the New Folder form
	  When I navigate to Create Folder page
	  And I try to save a new folder leaving the folder name field empty
	  Then I should see a validation message and the new folder should not be saved

	  