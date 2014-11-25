@image
Feature: Home Page
    As a user I should be able to verify that all isworking as expected on Home page

  Background: Login
    Given I login the application as "admin" with password "admin123"

	Scenario: Verify that all the components are displayed

	  When I login the application with a valid user account
	  Then I should see all the labels, fields and buttons displayed

	Scenario: Verify that an image is saves succesfully

	  When I login the application with a valid user account
	  And I try to save a new image from the following path "C:/Pics3/Pics/features/images_test/gym.jpg"
	  Then I should see a message saying that the image was saved

	Scenario: Verify that an image is not saved when leave some fields empties
	  When I login the application with a valid user account
	  And I try to save a new image leaving all the fields empties
	  Then I should see a validation message and the image should not be saved

	  When I set the image path "C:/Pics3/Pics/features/images_test/gym.jpg" and leave the image name empty
	  Then I should see a validation message and the image should not be saved

	  When I set the image name "C:/Pics3/Pics/features/images_test/gym.jpg" and leave the image path empty
	  Then I should see a validation message and the image should not be saved