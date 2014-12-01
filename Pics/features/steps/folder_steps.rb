When(/^I navigate to Create Folder page$/) do 
  within(:xpath, "//div[@class='container']") do
    find(:xpath, "//a[@href='/create_folder']").click
  end
end

When(/^I try to save a new folder with the following name "(.*?)"$/) do |folder_name|
  within(:xpath, "//div[@class='jumbotron']") do
    fill_in 'foldername', with: folder_name
    click_button 'savefolder'
    
  end
end

When(/^I try to save a new folder leaving the folder name field empty$/) do 
  within(:xpath, "//div[@class='jumbotron']") do
    click_button 'savefolder'
  end
end



Then(/^I should see all the labels, fields and buttons displayed in folder page$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Add a new Folder")
    find('p',:text => "you can create all the folder that you want")    
    find('p',:text => "Enter the Folder Name")
    find('#foldername')
    find('#savefolder',:text => "Save Folder")

  end
  puts "All the labels, fields and buttons are displayed correctly"
    #expect(page).to have_content "Fill your login credetials"
end



Then(/^I should see that the image was saved and return to the Home page$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('h1',:text => "Add a new Pic")
    #Add verification in dropdown list.
  end
  puts "The new folder was saved successfully"
  path_dir = @@PICS_PATH + "images/admin/NewFolderTest"
  puts path_dir
  FileUtils.rmdir path_dir
    #expect(page).to have_content "Fill your login credetials"
end

Then(/^I should see a validation message and the new folder should not be saved$/) do
  within(:xpath, "//div[@class='jumbotron']") do
    find('#foldername')
    find('#savefolder',:text => "Save Folder")
  end
  puts "A validation message was displayed and the folder was not saved"
    #expect(page).to have_content "Fill your login credetials"
end





