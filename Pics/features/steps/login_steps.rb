Given(/^I have an account in the application$/) do
    puts "I have my account: user/password"
end

When(/^I navigate to the login page$/) do
    visit  "http://localhost:4567/login.html"
    page.driver.browser.manage.window.maximize
end

When(/^I enter wrong account credentials$/) do 
    fill_in "username", :with => "Wrong"
    fill_in "password", :with => "Wrong"
    click_button "Login"
end

Then(/^I should see wrong user password message$/) do
    expect(page).to have_text "Usuario o Password incorrectos"
end

When(/^I enter my account credentials$/) do 
    fill_in "username", :with => "Fernando"
    fill_in "password", :with => "Fernando"
    click_button "Login"
end

Then(/^I should see the home page$/) do
    expect(page).to have_text "Add a new Pic"
end

When(/^I Close all pages$/) do 
    page.driver.browser.quit

end    

When(/^I logout from home$/) do
    click_link 'LogOut'
end 

When(/^I navigate to the home page$/) do
    sleep 5
    visit  "http://localhost:4567/home"
end

Then(/^I should see please enter your login credentials$/) do
    expect(page).to have_text "Please enter your login credentials"
end

Then(/^I should see Add a new Pic text$/) do
    sleep 5
    expect(page).to have_text "Add a new Pic"
end

