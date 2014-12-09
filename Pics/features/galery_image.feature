@galery_image
Feature: Galery Images bu Folder
    As a user I should be able to verify that all is working as expected on Galery Image by Foler page

  Background: Login
    Given I login the application as "tester" with password "tester123"

	Scenario: Verify that all the components are displayed in Galery Image by Foler screen

	  When I navigate to Galery Image page
	  Then I should see all the labels, fields and buttons displayed in galery image by folder page

	Scenario: Verify that the iamges for specific folder are dispalyed correctly

	  When I navigate to Galery Image page
	  Then I should see all the images for the root folder of the user

	  When I select the following folder "tester/folder1"
	  Then I should see the following all the images stored in the folder called Folder1

	  When I select the following folder "tester/folder2"
	  Then I should see the following all the images stored in the folder called Folder2

	  When I select the following folder "tester/folder1/folder11"
	  Then I should see the following all the images stored in the folder called Folder11

	  