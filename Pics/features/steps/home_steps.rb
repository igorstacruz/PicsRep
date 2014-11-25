Given(/^I login the application as "(.*?)" with password "(.*?)"$/) do |user, password|
	visit   "http://localhost:4567/login"
	fill_in 'username', with: user
  fill_in 'password', with: password
  click_button 'login'
end

When(/^I login the application with a valid user account$/) do
  
end

When(/^I try to save a new image from the following path "(.*?)"$/) do |image_path|
  
  within(:xpath, "//div[@class='jumbotron']") do
    fill_in 'imagepath', with: image_path
    attach_file('files', image_path)
    click_button 'saveimage'
  end

end

When(/^I try to save a new image leaving all the fields empties$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    click_button 'saveimage'
  end
end

When(/^I set the image path "(.*?)" and leave the image name empty$/) do |image_path|
  within(:xpath, "//div[@class='jumbotron']") do
    fill_in 'imagepath', with: image_path
    click_button 'saveimage'
  end

end

When(/^I set the image name "(.*?)" and leave the image path empty$/) do |image_path|
  within(:xpath, "//div[@class='jumbotron']") do
    fill_in 'imagepath', with: ""
    attach_file('files', image_path)
    click_button 'saveimage'
  end

end




Then(/^I should see all the labels, fields and buttons displayed$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Add a new Pic")
    find('p',:text => "Remember, choose a 'jpg' pic with up 2 Mb of size")
    find('#imagepath')
    find('p',:text => "Vista Previa")
    find('#files')
    find('#saveimage',:text => "Save image")

  end
  puts "All the labels, fields and buttons are displayed correctly"
    #expect(page).to have_content "Fill your login credetials"
end

Then(/^I should see a message saying that the image was saved$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('p',:text => "Image Saved")
  end
  puts "The image was saved successfully"
    #expect(page).to have_content "Fill your login credetials"
end

Then(/^I should see a validation message and the image should not be saved$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('p',:text => "...")
  end
  puts "A validation message was displayed and the image was not saved"
    #expect(page).to have_content "Fill your login credetials"
end






