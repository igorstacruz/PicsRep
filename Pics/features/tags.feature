
@tags
Feature: Home Page and Tags
    As a user I should be able to verify that all is working as expected on Home page after add tags

  Background: Login
    Given I login the application as "tester" with password "tester123"

	Scenario: Verify that an image is saves succesfully with tags

	  When I login the application with a valid user account
	  Then I should see the field for tags on screen

	  When I login the application with a valid user account	  
	  And I try to save a new image with tags from "images/gym.jpg" in the following folder "tester" and tags "Tag1"
	  Then I should see a message saying that the image was saved