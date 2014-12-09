
When(/^I navigate to Search by tag$/) do
    visit  "http://localhost:4567/searchByTag"
end

Then(/^I should see search by tag title$/) do
    expect(page).to have_text "Search by Tag"
end

Then(/^I should be able to see Select the tag to view your images$/) do
    expect(page).to have_text "Select the tag to view your images"
end

Then(/^I should be able to see View Image tag button$/) do
    find("#viewimagetag")
end

When(/^I click on View Image tag button$/) do
    find("#viewimagetag").click
end

Then(/^I should be able to see Dropdown options$/) do
    find("#tagid")
end

When(/^I select viaje tag$/) do
    find('#tagid').find(:xpath, 'option[2]').select_option
end

Then(/^I should be able to see gym image$/) do
    all(:xpath, "//img[@src='../images/gym.jpg']" )
end

