@delete_image
Feature: Delete Image Page
    As a user I should be able to verify that all is working as expected on Delete Image page

  Background: Login
    Given I login the application as "tester" with password "tester123"

	Scenario: Verify that all the components are displayed in Delete Image screen

	  When I navigate to Delete Image page
	  Then I should see all the labels, fields and buttons displayed in delete image page

	Scenario: Verify that a new folder is created succesfully

	  When I navigate to Delete Image page
	  And I try to delete an image called "truck.jpg"
	  Then I should see that the image was deleted and return to the Home page
	  And I should see that the image deleted before "truck.jpg" is not displayed anymore

	  When I navigate to Delete Image page
	  And I try to delete an image called "gym.jpg"
	  Then I should see that the image was deleted and return to the Home page
	  And I should see that the image deleted before "gym.jpg" is not displayed anymore

	  When I navigate to Delete Image page
	  And I try to delete an image called "futbol.jpg"
	  Then I should see that the image was deleted and return to the Home page
	  And I should see that the image deleted before "futbol.jpg" is not displayed anymore

	  When I navigate to Delete Image page
	  And I try to delete an image called "images.jpg"
	  Then I should see that the image was deleted and return to the Home page
	  And I should see that the image deleted before "images.jpg" is not displayed anymore
	  