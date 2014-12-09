When(/^I navigate to Galery Image page$/) do 
  within(:xpath, "//div[@class='container']") do
    find(:xpath, "//a[@href='/image_folder']").click
  end
end

When(/^I select the following folder "(.*?)"$/) do |folder_name|
  within(:xpath, "//div[@class='jumbotron']") do
      find('option', :text => folder_name, :match => :prefer_exact).click
    click_button 'viewimage'
  end

end

Then(/^I should see all the labels, fields and buttons displayed in galery image by folder page$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Image Galery")
    find('p',:text => "This is your Image Galery by folder")
    find('p',:text => "Select the folder to view your images")
    find('#folderid')
    find('#viewimage',:text => "View image")

  end
  puts "All the labels, fields and buttons are displayed correctly"
    #expect(page).to have_content "Fill your login credetials"
end

Then(/^I should see all the images for the root folder of the user$/) do
  find(:xpath, "//img[@src='./images/tester/gym.jpg']")
    
  puts "The images displayed in the root folder of the user are correct"
end

Then(/^I should see the following all the images stored in the folder called Folder1$/) do
  find(:xpath, "//img[@src='./images/tester/folder1/futbol.jpg']")
    
  puts "The images displayed in 'Folder1' are correct"
end

Then(/^I should see the following all the images stored in the folder called Folder2$/) do
  find(:xpath, "//img[@src='./images/tester/folder2/images.jpg']")
    
  puts "The images displayed in 'Folder2' are correct"
end

Then(/^I should see the following all the images stored in the folder called Folder11$/) do
  find(:xpath, "//img[@src='./images/tester/folder1/folder11/truck.jpg']")
    
  puts "The images displayed in 'Folder11' are correct"
end