When(/^I navigate to Delete Image page$/) do 
  within(:xpath, "//div[@class='container']") do
    find(:xpath, "//a[@href='/delete_image']").click
  end
end

When(/^I try to delete an image called "(.*?)"$/) do |image_name|
  within(:xpath, "//div[@class='jumbotron']") do
    within('#imagecode') do
      find('option', :text => image_name, :match => :prefer_exact).click
    end
    click_button 'deleteimage'
  end

end



Then(/^I should see all the labels, fields and buttons displayed in delete image page$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Delete an Image")
    find('p',:text => "Select he image that you want to delete!")    
    find('p',:text => "Select the image name")
    find('#imagecode')
    find('#deleteimage',:text => "Delete Image")

  end
  puts "All the labels, fields and buttons are displayed correctly"
    #expect(page).to have_content "Fill your login credetials"
end

Then(/^I should see that the image was deleted and return to the Home page$/) do 
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Add a new Pic")
  end
  puts "The was deleted successfully"
end

Then(/^I should see that the image deleted before "(.*?)" is not displayed anymore$/) do |image_name|
  step 'I navigate to Delete Image page'
  expect(page).not_to have_content(image_name)
  puts "The was deleted successfully"
end

