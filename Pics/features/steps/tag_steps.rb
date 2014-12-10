
When(/^I try to save a new image with tags from "(.*?)" in the following folder "(.*?)" and tags "(.*?)"$/) do |image_path, folder_name, tags|
  img_path = @@PICS_PATH + image_path
  within(:xpath, "//div[@class='jumbotron']") do
    fill_in 'imagepath', with: img_path
    fill_in 'imagetag', with: tags    
    within('#folderid') do
      find('option', :text => folder_name, :match => :prefer_exact).click
    end
    attach_file('files', img_path)
    click_button 'saveimage'
  end

end

Then(/^I should see the field for tags on screen$/) do
    find('p',:text => "Enter tags for the image")
    find('#imagetag')
end

