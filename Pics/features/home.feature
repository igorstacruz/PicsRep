@image
Feature: Home Page
    As a user I should be able to verify that all isworking as expected on Home page

  Background: Login
    Given I login the application as "tester" with password "tester123"

	Scenario: Verify that all the components are displayed

	  When I login the application with a valid user account
	  Then I should see all the labels, fields and buttons displayed

	Scenario: Verify that an image is not saved when leave some fields empties
	  
	  When I login the application with a valid user account
	  And I try to save a new image leaving all the fields empties
	  Then I should see a validation message and the image should not be saved

	  When I set the image path "images/gym.jpg" and leave the image name empty
	  Then I should see a validation message and the image should not be saved

	  When I set the image name "images/gym.jpg" and leave the image path empty
	  Then I should see a validation message and the image should not be saved

	Scenario: Verify that an image is saves succesfully

	  When I login the application with a valid user account
	  And I try to save a new image from "images/gym.jpg" in the following folder "tester"
	  Then I should see a message saying that the image was saved

	  When I login the application with a valid user account
	  And I try to save a new image from "images/futbol.jpg" in the following folder "tester/folder1"
	  Then I should see a message saying that the image was saved

	  When I login the application with a valid user account
	  And I try to save a new image from "images/images.jpg" in the following folder "tester/folder2"
	  Then I should see a message saying that the image was saved

	  When I login the application with a valid user account
	  And I try to save a new image from "images/truck.jpg" in the following folder "tester/folder1/folder11"
	  Then I should see a message saying that the image was saved

