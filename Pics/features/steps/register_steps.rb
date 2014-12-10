Given(/^I have no account in the application$/) do
    puts "I have no account in the application"
end


When(/^I navigate to the login page$/) do
    visit   "http://localhost:4567/login.html"
    page.driver.browser.manage.window.maximize
    expect(page).to have_text "Please enter your login credentials"
end


When(/^I use the Register new account link$/) do
    click_link('Register new account')    
end

When(/^I submit the register form with empty fields$/) do
    click_button "Sign\ up"  
end

When(/^I submit the register form with invalid email$/) do
    fill_in "username", :with => "TestValues"
    fill_in "email", :with => "testmailInvalid"
    click_button "Sign\ up" 
end

When(/^I enter my new account credentials$/) do
    fill_in "username", :with => "test_new"
    fill_in "email", :with => "goodmail@test"
    click_button "Sign\ up" 
    sleep 5    
end

When(/^I submit the next values username: "(.*?)" and e\-mail "(.*?)" to register form$/) do |username, email|
    fill_in "username", :with => username
    fill_in "email", :with => email
    click_button "Sign\ up" 
end

Then(/^I should see the Register page$/) do
    expect(page).to have_text "Register a New Account "
end

Then(/^I should see User name field is required$/) do
    find_field('username')['required'].should == 'true'    
    #find('input', :name => 'username')    
    #find('input', :name => 'username')['title'].should == msge
end

Then(/^I should see e-mail field is required$/) do
    find_field('email')['required'].should == 'true'    
end

Then(/^I should see "(.*?)" message on register$/) do |msge|
    expect(page).to have_text msge
end