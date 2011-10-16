When /^I go to the home page$/ do
  visit root_path
end

Then /^I see instructions for starting a session$/ do
  page.should have_content("Enter a password")
end

When /^I set a new session password$/ do
  fill_in "password", :with => "1234"
  click_button "Set password"
end

Then /^I see options for encoding QR codes$/ do
  page.should have_button "Encode"
end

When /^I clear the session password$/ do
  click_button "Clear password"
end
